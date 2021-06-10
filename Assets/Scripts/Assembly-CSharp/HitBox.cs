using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000031 RID: 49
public class HitBox : MonoBehaviour
{
	// Token: 0x06000122 RID: 290 RVA: 0x00007B38 File Offset: 0x00005D38
	public void UseHitbox()
	{
		if (Hotbar.Instance.currentItem == null)
		{
			return;
		}
		RaycastHit[] array = Physics.SphereCastAll(this.playerCam.position + this.playerCam.forward * 0.1f, 3f, this.playerCam.forward, 1.2f, this.whatIsHittable);
		Array.Sort<RaycastHit>(array, (RaycastHit x, RaycastHit y) => x.distance.CompareTo(y.distance));
		if (array.Length < 1)
		{
			return;
		}
		InventoryItem currentItem = Hotbar.Instance.currentItem;
		bool falling = !PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f;
		PowerupCalculations.DamageResult damageMultiplier = PowerupCalculations.Instance.GetDamageMultiplier(falling, -1f);
		float damageMultiplier2 = damageMultiplier.damageMultiplier;
		bool crit = damageMultiplier.crit;
		float lifesteal = damageMultiplier.lifesteal;
		float sharpness = currentItem.sharpness;
		bool flag = false;
		int num = 0;
		float num2 = 1f;
		float num3 = 1f;
		if (crit)
		{
			num3 = 2f;
		}
		Vector3 pos = Vector3.zero;
		bool flag2 = array[0].transform.CompareTag("Build");
		foreach (RaycastHit raycastHit in array)
		{
			Collider collider = raycastHit.collider;
			Hitable component = collider.transform.root.GetComponent<Hitable>();
			if (!(component == null) && (collider.gameObject.layer != LayerMask.NameToLayer("Player") || component.GetId() != LocalClient.instance.myId))
			{
				if (!flag2 && raycastHit.transform.CompareTag("Build"))
				{
					return;
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
				}
				HitEffect hitEffect = HitEffect.Normal;
				if (damageMultiplier.sniped)
				{
					hitEffect = HitEffect.Big;
				}
				else if (crit)
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
				if (!flag)
				{
					pos = raycastHit.collider.ClosestPoint(PlayerMovement.Instance.playerCam.position);
					num = num4;
				}
				flag = true;
			}
		}
		if (flag)
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

	// Token: 0x06000123 RID: 291 RVA: 0x00007EA4 File Offset: 0x000060A4
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
				if (UnityEngine.Random.Range(0f, 1f) < num)
				{
					inventoryItem = ItemManager.Instance.GetItemByName("Rock");
				}
			}
		}
		else
		{
			original = this.sand;
			if (UnityEngine.Random.Range(0f, 1f) < num2)
			{
				inventoryItem = ItemManager.Instance.GetItemByName("Flint");
			}
		}
	Instantiate(original, vector, Quaternion.LookRotation(Vector3.up));
		if (inventoryItem != null)
		{
			ClientSend.DropItemAtPosition(inventoryItem.id, 1, vector);
		}
	}

	// Token: 0x06000124 RID: 292 RVA: 0x00007F6C File Offset: 0x0000616C
	private void OnDrawGizmos()
	{
		foreach (Vector3 center in this.hitPoints)
		{
			Gizmos.DrawWireSphere(center, 1.5f);
		}
	}

	// Token: 0x04000112 RID: 274
	public Transform playerCam;

	// Token: 0x04000113 RID: 275
	public LayerMask whatIsHittable;

	// Token: 0x04000114 RID: 276
	private List<Vector3> hitPoints = new List<Vector3>();

	// Token: 0x04000115 RID: 277
	public GameObject dirt;

	// Token: 0x04000116 RID: 278
	public GameObject sand;
}
