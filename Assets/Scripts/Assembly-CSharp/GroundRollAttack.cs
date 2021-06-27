using System;
using UnityEngine;

public class GroundRollAttack : MonoBehaviour
{
	private void Start()
	{
		Vector3 forward = base.transform.forward;
		forward.y = 0f;
		this.rb.velocity = forward * this.speed;
		this.rollAxis = Vector3.Cross(this.rb.velocity, Vector3.up);
		Debug.DrawLine(base.transform.position, base.transform.position + forward * 10f, Color.red, 10f);
		Debug.LogError("collider: " + base.GetComponent<Collider>());
		base.GetComponent<Collider>().enabled = true;
		if (this.child)
		{
			return;
		}
		int num = 2;
		int num2 = 25;
		Collider component = base.GetComponent<Collider>();
		for (int i = 0; i < num; i++)
		{
			Transform transform = Instantiate<GameObject>(this.rollPrefab, base.transform.position, base.transform.rotation).transform;
			transform.GetComponent<GroundRollAttack>().child = true;
			transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num2 * 2 * i) - (float)num2, transform.eulerAngles.z);
			Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
		}
	}

	private void Update()
	{
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
		this.rollRock.transform.Rotate(this.rollAxis * this.rollSpeed * Time.deltaTime);
	}

	public Rigidbody rb;

	public float speed = 60f;

	public LayerMask whatIsGround;

	public Transform rollRock;

	public GameObject rollPrefab;

	private bool child;

	private Vector3 rollAxis;

	private float rollSpeed = 10f;
}
