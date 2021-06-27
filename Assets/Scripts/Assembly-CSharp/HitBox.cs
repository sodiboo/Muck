using System;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class HitBox : MonoBehaviour
{
	public void UseHitbox()
	{
		this.alreadyHit.Clear();
		this.alreadyHit = new List<Hitable>();
		if (Hotbar.Instance.currentItem == null)
		{
			return;
		}
		float maxDistance = 1.2f + PlayerStatus.Instance.currentChunkArmorMultiplier;
		RaycastHit[] array = Physics.SphereCastAll(this.playerCam.position + this.playerCam.forward * 0.1f, 3f, this.playerCam.forward, maxDistance, this.whatIsHittable);
		Array.Sort<RaycastHit>(array, (RaycastHit x, RaycastHit y) => x.distance.CompareTo(y.distance));
		if (array.Length < 1)
		{
			return;
		}
		InventoryItem currentItem = Hotbar.Instance.currentItem;
		bool falling = !PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f;
		PowerupCalculations.DamageResult damageMultiplier = PowerupCalculations.Instance.GetDamageMultiplier(falling, -1f);
		float damageMultiplier2 = damageMultiplier.damageMultiplier;
		bool flag = damageMultiplier.crit;
		float lifesteal = damageMultiplier.lifesteal;
		float sharpness = currentItem.sharpness;
		bool flag2 = false;
		int num = 0;
		float num2 = 1f;
		float num3 = 1f;
		if (flag)
		{
			num3 = 2f;
		}
		Vector3 pos = Vector3.zero;
		bool flag3 = array[0].transform.CompareTag("Build");
		foreach (RaycastHit raycastHit in array)
		{
			Collider collider = raycastHit.collider;
			Hitable component = collider.transform.root.GetComponent<Hitable>();
			if (!(component == null) && (collider.gameObject.layer != LayerMask.NameToLayer("Player") || component.GetId() != LocalClient.instance.myId))
			{
				if (!flag3 && raycastHit.transform.CompareTag("Build"))
				{
					return;
				}
				if (!this.alreadyHit.Contains(component))
				{
					if (!component.canHitMoreThanOnce)
					{
						this.alreadyHit.Add(component);
					}
					int num4 = 0;
					if (collider.gameObject.layer == LayerMask.NameToLayer("Object"))
					{
						HitableResource hitableResource = (HitableResource)component;
						if ((currentItem.type == hitableResource.compatibleItem && currentItem.tier >= hitableResource.minTier) || hitableResource.compatibleItem == InventoryItem.ItemType.Item)
						{
							float resourceMultiplier = PowerupInventory.Instance.GetResourceMultiplier(null);
							num4 = (int)((float)currentItem.resourceDamage * damageMultiplier2 * resourceMultiplier * num2);
							CameraShaker.Instance.DamageShake(0.1f * num3);
						}
					}
					else
					{
						CameraShaker.Instance.DamageShake(0.4f);
						int num5 = currentItem.attackDamage;
						if (currentItem.tag == InventoryItem.ItemTag.Arrow)
						{
							num5 = 1;
						}
						num4 = (int)((float)num5 * damageMultiplier2 * num2);
						Mob component2 = component.GetComponent<Mob>();
						if (component2 && currentItem.attackTypes != null && component2.mobType.weaknesses != null)
						{
							foreach (MobType.Weakness weakness in component2.mobType.weaknesses)
							{
								MobType.Weakness[] attackTypes = currentItem.attackTypes;
								for (int k = 0; k < attackTypes.Length; k++)
								{
									if (attackTypes[k] == weakness)
									{
										flag = true;
										num4 *= 2;
									}
								}
							}
						}
					}
					HitEffect hitEffect = HitEffect.Normal;
					if (damageMultiplier.sniped)
					{
						hitEffect = HitEffect.Big;
					}
					else if (flag)
					{
						hitEffect = HitEffect.Crit;
					}
					else if (damageMultiplier.falling)
					{
						hitEffect = HitEffect.Falling;
					}
					component.Hit(num4, sharpness, (int)hitEffect, raycastHit.collider.ClosestPoint(PlayerMovement.Instance.playerCam.position));
					num2 *= 0.5f;
					PlayerStatus.Instance.Heal(Mathf.CeilToInt((float)num4 * lifesteal));
					if (flag)
					{
						PowerupInventory.Instance.StartJuice();
					}
					if (!flag2)
					{
						pos = raycastHit.collider.ClosestPoint(PlayerMovement.Instance.playerCam.position);
						num = num4;
					}
					flag2 = true;
				}
			}
		}
		if (flag2)
		{
			if (damageMultiplier.sniped)
			{
				PowerupCalculations.Instance.HitEffect(PowerupCalculations.Instance.sniperSfx);
			}
			if (damageMultiplier2 > 0f && damageMultiplier.hammerMultiplier > 0f)
			{
				int num6 = 0;
				PowerupCalculations.Instance.SpawnOnHitEffect(num6, true, pos, (int)((float)num * damageMultiplier.hammerMultiplier));
				ClientSend.SpawnEffect(num6, pos);
			}
		}
	}

	private void ShovelHitGround(Collider other)
	{
		Vector3 vector = other.ClosestPoint(base.transform.position);
		TextureData.TerrainType terrainType = WorldUtility.WorldHeightToBiome(vector.y);
		GameObject original = this.dirt;
		InventoryItem inventoryItem = null;
		float num = 0.5f;
		float num2 = 0.15f;
		if (terrainType != TextureData.TerrainType.Sand)
		{
			if (terrainType == TextureData.TerrainType.Grass)
			{
				original = this.dirt;
				if (Random.Range(0f, 1f) < num)
				{
					inventoryItem = ItemManager.Instance.GetItemByName("Rock");
				}
			}
		}
		else
		{
			original = this.sand;
			if (Random.Range(0f, 1f) < num2)
			{
				inventoryItem = ItemManager.Instance.GetItemByName("Flint");
			}
		}
		Instantiate<GameObject>(original, vector, Quaternion.LookRotation(Vector3.up));
		if (inventoryItem != null)
		{
			ClientSend.DropItemAtPosition(inventoryItem.id, 1, vector);
		}
	}

	private void OnDrawGizmos()
	{
		foreach (Vector3 center in this.hitPoints)
		{
			Gizmos.DrawWireSphere(center, 1.5f);
		}
	}

	public Transform playerCam;

	public LayerMask whatIsHittable;

	private List<Vector3> hitPoints = new List<Vector3>();

	private List<Hitable> alreadyHit = new List<Hitable>();

	public GameObject dirt;

	public GameObject sand;
}
