using UnityEngine;

public class RepairInteract : MonoBehaviour
{
	public new string name;
	public bool replace;
	public GameObject fixedObject;
	public GameObject repairFx;
	public Material outlineMat;
	public GameObject[] toActive;
	public GameObject[] toInactive;
	public Material fixedMaterial;
	public InventoryItem[] requirements;
	public int[] amounts;
	public bool dontIncreaseWithPlayers;
}
