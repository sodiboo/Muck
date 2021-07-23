using UnityEngine;

public class PlayerStatus : MonoBehaviour
{
	public float hp;
	public int maxHp;
	public float shield;
	public int maxShield;
	public GameObject playerRagdoll;
	public GameObject drownParticles;
	public AudioSource underwaterAudio;
	public GameObject leafParticles;
	public GameObject windParticles;
	public InventoryItem[] armor;
	public float currentSpeedArmorMultiplier;
	public float currentChunkArmorMultiplier;
}
