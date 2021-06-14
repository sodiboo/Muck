using UnityEngine;

public class PlayerStatus : MonoBehaviour
{
	public float hp;
	public int maxHp;
	public float shield;
	public int maxShield;
	public GameObject playerRagdoll;
	public InventoryItem[] armor;
	public float currentSpeedArmorMultiplier;
	public float currentChunkArmorMultiplier;
}
