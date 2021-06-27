using System;
using UnityEngine;

// Token: 0x02000044 RID: 68
public class GroundRollAttack : MonoBehaviour
{
	// Token: 0x06000193 RID: 403 RVA: 0x000097BC File Offset: 0x000079BC
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

	// Token: 0x06000194 RID: 404 RVA: 0x00009911 File Offset: 0x00007B11
	private void Update()
	{
		this.KeepRockGrounded();
		this.SpinRock();
	}

	// Token: 0x06000195 RID: 405 RVA: 0x00009920 File Offset: 0x00007B20
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

	// Token: 0x06000196 RID: 406 RVA: 0x00009995 File Offset: 0x00007B95
	private void SpinRock()
	{
		this.rollRock.transform.Rotate(this.rollAxis * this.rollSpeed * Time.deltaTime);
	}

	// Token: 0x04000181 RID: 385
	public Rigidbody rb;

	// Token: 0x04000182 RID: 386
	public float speed = 60f;

	// Token: 0x04000183 RID: 387
	public LayerMask whatIsGround;

	// Token: 0x04000184 RID: 388
	public Transform rollRock;

	// Token: 0x04000185 RID: 389
	public GameObject rollPrefab;

	// Token: 0x04000186 RID: 390
	private bool child;

	// Token: 0x04000187 RID: 391
	private Vector3 rollAxis;

	// Token: 0x04000188 RID: 392
	private float rollSpeed = 10f;
}
