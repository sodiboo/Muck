using System;
using UnityEngine;

// Token: 0x0200003A RID: 58
public class GroundRollAttack : MonoBehaviour
{
	// Token: 0x0600013A RID: 314 RVA: 0x0000C28C File Offset: 0x0000A48C
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
			Transform transform =Instantiate<GameObject>(this.rollPrefab, base.transform.position, base.transform.rotation).transform;
			transform.GetComponent<GroundRollAttack>().child = true;
			transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num2 * 2 * i) - (float)num2, transform.eulerAngles.z);
			Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
		}
	}

	// Token: 0x0600013B RID: 315 RVA: 0x00002F7D File Offset: 0x0000117D
	private void Update()
	{
		this.KeepRockGrounded();
		this.SpinRock();
	}

	// Token: 0x0600013C RID: 316 RVA: 0x0000C3E4 File Offset: 0x0000A5E4
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

	// Token: 0x0600013D RID: 317 RVA: 0x00002F8B File Offset: 0x0000118B
	private void SpinRock()
	{
		this.rollRock.transform.Rotate(this.rollAxis * this.rollSpeed * Time.deltaTime);
	}

	// Token: 0x04000131 RID: 305
	public Rigidbody rb;

	// Token: 0x04000132 RID: 306
	public float speed = 60f;

	// Token: 0x04000133 RID: 307
	public LayerMask whatIsGround;

	// Token: 0x04000134 RID: 308
	public Transform rollRock;

	// Token: 0x04000135 RID: 309
	public GameObject rollPrefab;

	// Token: 0x04000136 RID: 310
	private bool child;

	// Token: 0x04000137 RID: 311
	private Vector3 rollAxis;

	// Token: 0x04000138 RID: 312
	private float rollSpeed = 10f;
}
