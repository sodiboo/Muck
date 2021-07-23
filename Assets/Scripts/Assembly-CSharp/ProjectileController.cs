using UnityEngine;

public class ProjectileController : MonoBehaviour
{
    public static ProjectileController Instance;

    private void Awake()
    {
        Instance = this;
    }

    public void SpawnProjectileFromPlayer(Vector3 spawnPos, Vector3 direction, float force, int arrowId, int fromPlayer)
    {
        InventoryItem inventoryItem = ItemManager.Instance.allItems[arrowId];
        InventoryUI.Instance.arrows.UpdateCell();
        GameObject obj = Object.Instantiate(inventoryItem.prefab);
        obj.GetComponent<Renderer>().material = inventoryItem.material;
        obj.transform.position = spawnPos;
        obj.transform.rotation = Quaternion.LookRotation(direction);
        obj.GetComponent<Rigidbody>().AddForce(direction * force);
        Physics.IgnoreCollision(obj.GetComponent<Collider>(), GameManager.players[fromPlayer].GetCollider(), ignore: true);
        obj.GetComponent<Arrow>().otherPlayersArrow = true;
    }

    public void SpawnMobProjectile(Vector3 spawnPos, Vector3 direction, float force, int itemId, int mobObjectId)
    {
        InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
        GameObject gameObject = Object.Instantiate(inventoryItem.prefab, spawnPos, Quaternion.LookRotation(direction));
        int attackDamage = inventoryItem.attackDamage;
        float projectileSpeed = inventoryItem.bowComponent.projectileSpeed;
        float colliderDisabledTime = inventoryItem.bowComponent.colliderDisabledTime;
        gameObject.transform.rotation = Quaternion.LookRotation(direction);
        Rigidbody component = gameObject.GetComponent<Rigidbody>();
        if ((bool)component)
        {
            component.AddForce(direction * force * projectileSpeed);
            component.angularVelocity = inventoryItem.rotationOffset;
        }
        MonoBehaviour.print("mob id: " + mobObjectId + ", in mob manager: " + MobManager.Instance.mobs.ContainsKey(mobObjectId).ToString());
        if (MobManager.Instance.mobs.ContainsKey(mobObjectId))
        {
            Collider component2 = gameObject.GetComponent<Collider>();
            if (component2 != null)
            {
                Collider[] componentsInChildren = MobManager.Instance.mobs[mobObjectId].gameObject.transform.root.GetComponentsInChildren<Collider>();
                for (int i = 0; i < componentsInChildren.Length; i++)
                {
                    Physics.IgnoreCollision(componentsInChildren[i], component2, ignore: true);
                }
            }
        }
        float multiplier = MobManager.Instance.mobs[mobObjectId].multiplier;
        gameObject.GetComponent<EnemyProjectile>().DisableCollider(colliderDisabledTime);
        gameObject.GetComponent<EnemyProjectile>().damage = (int)((float)attackDamage * multiplier);
        MonoBehaviour.print("setting damage to: " + (float)attackDamage * multiplier);
    }
}
