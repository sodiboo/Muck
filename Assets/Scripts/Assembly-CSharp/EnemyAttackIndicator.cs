using System;
using UnityEngine;

// Token: 0x0200002E RID: 46
public class EnemyAttackIndicator : MonoBehaviour
{
	// Token: 0x06000110 RID: 272 RVA: 0x000070B0 File Offset: 0x000052B0
	private void Awake()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + this.offset * base.transform.localScale.x;
		}
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x06000111 RID: 273 RVA: 0x00007150 File Offset: 0x00005350
	public void SetWarning(float time, float scale)
	{
		this.desiredScale = Vector3.one * scale;
		Invoke(nameof(DestroySelf), time);
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + this.offset * base.transform.localScale.x;
		}
	}

	// Token: 0x06000112 RID: 274 RVA: 0x000071EC File Offset: 0x000053EC
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		this.projector.orthographicSize = base.transform.localScale.x / 2f;
		float z = 100f * Time.deltaTime;
		base.transform.Rotate(new Vector3(0f, 0f, z), Space.Self);
	}

	// Token: 0x06000113 RID: 275 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x04000118 RID: 280
	public Vector3 offset = new Vector3(0f, -0.25f, 0f);

	// Token: 0x04000119 RID: 281
	public LayerMask whatIsGround;

	// Token: 0x0400011A RID: 282
	public Projector projector;

	// Token: 0x0400011B RID: 283
	private Vector3 desiredScale;
}
