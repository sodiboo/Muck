using System;
using UnityEngine;

// Token: 0x0200002C RID: 44
public class FloatItem : MonoBehaviour
{
	// Token: 0x060000EC RID: 236 RVA: 0x00002C9B File Offset: 0x00000E9B
	private void Start()
	{
		this.PositionItem();
		this.yPos = base.transform.position.y;
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x060000ED RID: 237 RVA: 0x0000AD98 File Offset: 0x00008F98
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		base.transform.Rotate(Vector3.up, 20f * Time.deltaTime);
		float b = Mathf.PingPong(Time.time * 0.5f, this.maxOffset) - this.maxOffset / 2f;
		this.yOffset = Mathf.Lerp(this.yOffset, b, Time.deltaTime * 2f);
		base.transform.position = new Vector3(base.transform.position.x, this.yPos + this.yOffset, base.transform.position.z);
	}

	// Token: 0x060000EE RID: 238 RVA: 0x0000AE6C File Offset: 0x0000906C
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

	// Token: 0x040000F3 RID: 243
	private LayerMask whatIsGround;

	// Token: 0x040000F4 RID: 244
	private float floatHeight = 2f;

	// Token: 0x040000F5 RID: 245
	private Vector3 desiredScale;

	// Token: 0x040000F6 RID: 246
	private float yPos;

	// Token: 0x040000F7 RID: 247
	private float yOffset;

	// Token: 0x040000F8 RID: 248
	public float maxOffset = 0.5f;
}
