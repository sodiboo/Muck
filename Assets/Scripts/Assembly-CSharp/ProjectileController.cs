using System;
using UnityEngine;

// Token: 0x02000072 RID: 114
public class ProjectileController : MonoBehaviour
{
	// Token: 0x06000278 RID: 632 RVA: 0x00003D7E File Offset: 0x00001F7E
	private void Awake()
	{
		ProjectileController.Instance = this;
	}

	// Token: 0x06000279 RID: 633 RVA: 0x00010FE8 File Offset: 0x0000F1E8
	public void SpawnProjectileFromPlayer(Vector3 spawnPos, Vector3 direction, float force, int arrowId, int fromPlayer)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[arrowId];
		InventoryUI.Instance.arrows.UpdateCell();
		GameObject gameObject =Instantiate<GameObject>(inventoryItem.prefab);
		gameObject.GetComponent<Renderer>().material = inventoryItem.material;
		gameObject.transform.position = spawnPos;
		gameObject.transform.rotation = Quaternion.LookRotation(direction);
		gameObject.GetComponent<Rigidbody>().AddForce(direction * force);
		Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), GameManager.players[fromPlayer].GetCollider(), true);
		gameObject.GetComponent<Arrow>().otherPlayersArrow = true;
	}

	// Token: 0x0600027A RID: 634 RVA: 0x0001108C File Offset: 0x0000F28C
	public void SpawnMobProjectile(Vector3 spawnPos, Vector3 direction, float force, int itemId, int mobObjectId)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
		GameObject gameObject =Instantiate<GameObject>(inventoryItem.prefab, spawnPos, Quaternion.LookRotation(direction));
		int attackDamage = inventoryItem.attackDamage;
		float projectileSpeed = inventoryItem.bowComponent.projectileSpeed;
		gameObject.transform.rotation = Quaternion.LookRotation(direction);
		Rigidbody component = gameObject.GetComponent<Rigidbody>();
		component.AddForce(direction * force * projectileSpeed);
		component.angularVelocity = inventoryItem.rotationOffset;
		MonoBehaviour.print(string.Concat(new object[]
		{
			"mob id: ",
			mobObjectId,
			", in mob manager: ",
			MobManager.Instance.mobs.ContainsKey(mobObjectId).ToString()
		}));
		if (MobManager.Instance.mobs.ContainsKey(mobObjectId))
		{
			Collider component2 = gameObject.GetComponent<Collider>();
			Collider[] componentsInChildren = MobManager.Instance.mobs[mobObjectId].gameObject.transform.root.GetComponentsInChildren<Collider>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				Physics.IgnoreCollision(componentsInChildren[i], component2, true);
			}
			MonoBehaviour.print("removing collision with mob: " + MobManager.Instance.mobs[mobObjectId]);
		}
		float multiplier = MobManager.Instance.mobs[mobObjectId].multiplier;
		gameObject.GetComponent<EnemyProjectile>().DisableCollider(0.1f);
		gameObject.GetComponent<EnemyProjectile>().damage = (int)((float)attackDamage * multiplier);
		MonoBehaviour.print("setting damage to: " + (float)attackDamage * multiplier);
	}

	// Token: 0x04000288 RID: 648
	public static ProjectileController Instance;
}
