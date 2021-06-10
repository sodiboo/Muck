
using UnityEngine;

// Token: 0x0200002F RID: 47
public class GroundRollAttack : MonoBehaviour
{
	// Token: 0x0600011B RID: 283 RVA: 0x00007900 File Offset: 0x00005B00
	private void Start()
	{
		Vector3 forward = base.transform.forward;
		forward.y = 0f;
		this.rb.velocity = forward * this.speed;
		this.rollAxis = Vector3.Cross(this.rb.velocity, Vector3.up);
		Debug.DrawLine(base.transform.position, base.transform.position + forward * 10f, Color.red, 10f);
		if (this.child)
		{
			return;
		}
		int num = 2;
		int num2 = 25;
		Collider component = base.GetComponent<Collider>();
		for (int i = 0; i < num; i++)
		{
			Transform transform =Instantiate(this.rollPrefab, base.transform.position, base.transform.rotation).transform;
			transform.GetComponent<GroundRollAttack>().child = true;
			transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num2 * 2 * i) - (float)num2, transform.eulerAngles.z);
			Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
		}
	}

	// Token: 0x0600011C RID: 284 RVA: 0x00007A34 File Offset: 0x00005C34
	private void Update()
	{
		this.KeepRockGrounded();
		this.SpinRock();
	}

	// Token: 0x0600011D RID: 285 RVA: 0x00007A44 File Offset: 0x00005C44
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

	// Token: 0x0600011E RID: 286 RVA: 0x00007AB9 File Offset: 0x00005CB9
	private void SpinRock()
	{
		this.rollRock.transform.Rotate(this.rollAxis * this.rollSpeed * Time.deltaTime);
	}

	// Token: 0x04000108 RID: 264
	public Rigidbody rb;

	// Token: 0x04000109 RID: 265
	public float speed = 60f;

	// Token: 0x0400010A RID: 266
	public LayerMask whatIsGround;

	// Token: 0x0400010B RID: 267
	public Transform rollRock;

	// Token: 0x0400010C RID: 268
	public GameObject rollPrefab;

	// Token: 0x0400010D RID: 269
	private bool child;

	// Token: 0x0400010E RID: 270
	private Vector3 rollAxis;

	// Token: 0x0400010F RID: 271
	private float rollSpeed = 10f;
}
