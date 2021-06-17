using System;
using UnityEngine;


public class GroundSwordAttack : MonoBehaviour
{

	private void Start()
	{
		Debug.LogError("Spawned");
		Vector3 forward = base.transform.forward;
		forward.y = 0f;
		this.rb.velocity = forward.normalized * this.projectile.bowComponent.projectileSpeed;
		this.rb.angularVelocity = Vector3.zero;
		this.rollAxis = Vector3.Cross(this.rb.velocity, Vector3.up);
		Debug.DrawLine(base.transform.position, base.transform.position + forward * 10f, Color.red, 10f);
		base.GetComponent<Collider>().enabled = true;
		if (this.child)
		{
			return;
		}
		int num = 25;
		Collider component = base.GetComponent<Collider>();
		for (int i = 0; i < 2; i++)
		{
			Transform transform = Instantiate<GameObject>(this.rollPrefab, base.transform.position, base.transform.rotation).transform;
			transform.GetComponent<GroundSwordAttack>().child = true;
			transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num * 2 * i) - (float)num, transform.eulerAngles.z);
			Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
		}
		for (int j = 0; j < 2; j++)
		{
			Transform transform2 = Instantiate<GameObject>(this.rollPrefab, base.transform.position, base.transform.rotation).transform;
			transform2.GetComponent<GroundSwordAttack>().child = true;
			transform2.eulerAngles = new Vector3(transform2.eulerAngles.x, transform2.eulerAngles.y + (float)(num * 4 * j) - (float)(num * 2), transform2.eulerAngles.z);
			Physics.IgnoreCollision(component, transform2.GetComponent<Collider>());
		}
	}


	private void Update()
	{
		this.rb.velocity = base.transform.forward * this.projectile.bowComponent.projectileSpeed;
		this.KeepRockGrounded();
		this.SpinRock();
	}


	private void KeepRockGrounded()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 50f, Vector3.down, out raycastHit, 100f, this.whatIsGround))
		{
			Vector3 position = this.rb.position;
			position.y = raycastHit.point.y;
			this.rb.MovePosition(position);
		}
	}


	private void SpinRock()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 2f, Vector3.down, out raycastHit, 4f, this.whatIsGround))
		{
			float x = Vector3.SignedAngle(Vector3.up, raycastHit.normal, base.transform.right);
			Vector3 eulerAngles = this.rollRock.transform.rotation.eulerAngles;
			this.rollRock.transform.rotation = Quaternion.Lerp(this.rollRock.rotation, Quaternion.Euler(new Vector3(x, eulerAngles.y, eulerAngles.z)), Time.deltaTime * 15f);
		}
	}


	public Rigidbody rb;


	public float speed = 60f;


	public LayerMask whatIsGround;


	public Transform rollRock;


	public GameObject rollPrefab;


	public InventoryItem projectile;


	private bool child;


	private Vector3 rollAxis;


	private float rollSpeed = 10f;
}
