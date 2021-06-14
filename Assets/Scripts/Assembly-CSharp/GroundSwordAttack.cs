using UnityEngine;

public class GroundSwordAttack : MonoBehaviour
{
	public Rigidbody rb;
	public float speed;
	public LayerMask whatIsGround;
	public Transform rollRock;
	public GameObject rollPrefab;
	public InventoryItem projectile;
}
