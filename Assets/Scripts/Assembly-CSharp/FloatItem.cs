
using UnityEngine;

// Token: 0x02000025 RID: 37
public class FloatItem : MonoBehaviour
{
	// Token: 0x060000DB RID: 219 RVA: 0x0000649B File Offset: 0x0000469B
	private void Start()
	{
		this.PositionItem();
		this.yPos = base.transform.position.y;
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x060000DC RID: 220 RVA: 0x000064DC File Offset: 0x000046DC
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		base.transform.Rotate(Vector3.up, 20f * Time.deltaTime);
		float b = Mathf.PingPong(Time.time * 0.5f, this.maxOffset) - this.maxOffset / 2f;
		this.yOffset = Mathf.Lerp(this.yOffset, b, Time.deltaTime * 2f);
		base.transform.position = new Vector3(base.transform.position.x, this.yPos + this.yOffset, base.transform.position.z);
	}

	// Token: 0x060000DD RID: 221 RVA: 0x000065B0 File Offset: 0x000047B0
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

	// Token: 0x040000D6 RID: 214
	private LayerMask whatIsGround;

	// Token: 0x040000D7 RID: 215
	private float floatHeight = 2f;

	// Token: 0x040000D8 RID: 216
	private Vector3 desiredScale;

	// Token: 0x040000D9 RID: 217
	private float yPos;

	// Token: 0x040000DA RID: 218
	private float yOffset;

	// Token: 0x040000DB RID: 219
	public float maxOffset = 0.5f;
}
