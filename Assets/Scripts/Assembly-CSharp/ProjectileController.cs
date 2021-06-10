
using UnityEngine;

// Token: 0x02000061 RID: 97
public class ProjectileController : MonoBehaviour
{
	// Token: 0x06000248 RID: 584 RVA: 0x0000CB0D File Offset: 0x0000AD0D
	private void Awake()
	{
		ProjectileController.Instance = this;
	}

	// Token: 0x06000249 RID: 585 RVA: 0x0000CB18 File Offset: 0x0000AD18
	public void SpawnProjectileFromPlayer(Vector3 spawnPos, Vector3 direction, float force, int arrowId, int fromPlayer)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[arrowId];
		InventoryUI.Instance.arrows.UpdateCell();
		GameObject gameObject =Instantiate(inventoryItem.prefab);
		gameObject.GetComponent<Renderer>().material = inventoryItem.material;
		gameObject.transform.position = spawnPos;
		gameObject.transform.rotation = Quaternion.LookRotation(direction);
		gameObject.GetComponent<Rigidbody>().AddForce(direction * force);
		Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), GameManager.players[fromPlayer].GetCollider(), true);
		gameObject.GetComponent<Arrow>().otherPlayersArrow = true;
	}

	// Token: 0x0600024A RID: 586 RVA: 0x0000CBBC File Offset: 0x0000ADBC
	public void SpawnMobProjectile(Vector3 spawnPos, Vector3 direction, float force, int itemId, int mobObjectId)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
		GameObject gameObject =Instantiate(inventoryItem.prefab, spawnPos, Quaternion.LookRotation(direction));
		int attackDamage = inventoryItem.attackDamage;
		float projectileSpeed = inventoryItem.projectileSpeed;
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
			Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), MobManager.Instance.mobs[mobObjectId].GetComponent<Collider>(), true);
			MonoBehaviour.print("removing collision with mob: " + MobManager.Instance.mobs[mobObjectId]);
		}
		float multiplier = MobManager.Instance.mobs[mobObjectId].multiplier;
		gameObject.GetComponent<EnemyProjectile>().DisableCollider(0.1f);
		gameObject.GetComponent<EnemyProjectile>().damage = (int)((float)attackDamage * multiplier);
		MonoBehaviour.print("setting damage to: " + (float)attackDamage * multiplier);
	}

	// Token: 0x04000237 RID: 567
	public static ProjectileController Instance;
}
