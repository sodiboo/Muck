using UnityEngine;

public class Hitable : MonoBehaviour
{
	public string entityName;
	public bool canHitMoreThanOnce;
	public LootDrop dropTable;
	public int hp;
	public int maxHp;
	public GameObject destroyFx;
	public GameObject hitFx;
	public GameObject numberFx;
}
