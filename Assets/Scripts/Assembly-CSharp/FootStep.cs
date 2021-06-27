using System;
using UnityEngine;

// Token: 0x02000038 RID: 56
public class FootStep : MonoBehaviour
{
	// Token: 0x06000146 RID: 326 RVA: 0x00007FA5 File Offset: 0x000061A5
	private void Start()
	{
		this.FindGroundType();
	}

	// Token: 0x06000147 RID: 327 RVA: 0x00007FB0 File Offset: 0x000061B0
	private void FindGroundType()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, Vector3.down, out raycastHit, 5f, this.whatIsGround) && raycastHit.collider.gameObject.CompareTag("Build"))
		{
			this.randomSfx.sounds = this.woodSfx;
		}
		this.randomSfx.Randomize(0f);
	}

	// Token: 0x04000144 RID: 324
	public LayerMask whatIsGround;

	// Token: 0x04000145 RID: 325
	public RandomSfx randomSfx;

	// Token: 0x04000146 RID: 326
	public AudioClip[] woodSfx;
}
