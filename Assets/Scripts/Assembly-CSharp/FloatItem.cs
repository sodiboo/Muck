using System;
using UnityEngine;

// Token: 0x02000037 RID: 55
public class FloatItem : MonoBehaviour
{
	// Token: 0x06000142 RID: 322 RVA: 0x00007DE2 File Offset: 0x00005FE2
	private void Start()
	{
		this.PositionItem();
		this.yPos = base.transform.position.y;
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x06000143 RID: 323 RVA: 0x00007E24 File Offset: 0x00006024
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		base.transform.Rotate(Vector3.up, 20f * Time.deltaTime);
		float b = Mathf.PingPong(Time.time * 0.5f, this.maxOffset) - this.maxOffset / 2f;
		this.yOffset = Mathf.Lerp(this.yOffset, b, Time.deltaTime * 2f);
		base.transform.position = new Vector3(base.transform.position.x, this.yPos + this.yOffset, base.transform.position.z);
	}

	// Token: 0x06000144 RID: 324 RVA: 0x00007EF8 File Offset: 0x000060F8
	private void PositionItem()
	{
		this.whatIsGround = LayerMask.GetMask(new string[]
		{
			"Ground"
		});
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 20f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + Vector3.up * this.floatHeight;
		}
	}

	// Token: 0x0400013E RID: 318
	private LayerMask whatIsGround;

	// Token: 0x0400013F RID: 319
	private float floatHeight = 2f;

	// Token: 0x04000140 RID: 320
	private Vector3 desiredScale;

	// Token: 0x04000141 RID: 321
	private float yPos;

	// Token: 0x04000142 RID: 322
	private float yOffset;

	// Token: 0x04000143 RID: 323
	public float maxOffset = 0.5f;
}
