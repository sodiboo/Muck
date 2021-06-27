using System;
using UnityEngine;

// Token: 0x02000045 RID: 69
public class GroundSwordAttack : MonoBehaviour
{
	// Token: 0x06000198 RID: 408 RVA: 0x000099E0 File Offset: 0x00007BE0
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

	// Token: 0x06000199 RID: 409 RVA: 0x00009BD8 File Offset: 0x00007DD8
	private void Update()
	{
		this.rb.velocity = base.transform.forward * this.projectile.bowComponent.projectileSpeed;
		this.KeepRockGrounded();
		this.SpinRock();
	}

	// Token: 0x0600019A RID: 410 RVA: 0x00009C14 File Offset: 0x00007E14
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

	// Token: 0x0600019B RID: 411 RVA: 0x00009C8C File Offset: 0x00007E8C
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

	// Token: 0x04000189 RID: 393
	public Rigidbody rb;

	// Token: 0x0400018A RID: 394
	public float speed = 60f;

	// Token: 0x0400018B RID: 395
	public LayerMask whatIsGround;

	// Token: 0x0400018C RID: 396
	public Transform rollRock;

	// Token: 0x0400018D RID: 397
	public GameObject rollPrefab;

	// Token: 0x0400018E RID: 398
	public InventoryItem projectile;

	// Token: 0x0400018F RID: 399
	private bool child;

	// Token: 0x04000190 RID: 400
	private Vector3 rollAxis;

	// Token: 0x04000191 RID: 401
	private float rollSpeed = 10f;
}
