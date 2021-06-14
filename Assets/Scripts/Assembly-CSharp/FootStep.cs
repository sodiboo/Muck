using System;
using UnityEngine;

// Token: 0x0200002D RID: 45
public class FootStep : MonoBehaviour
{
	// Token: 0x060000F0 RID: 240 RVA: 0x00002CF8 File Offset: 0x00000EF8
	private void Start()
	{
		this.FindGroundType();
	}

	// Token: 0x060000F1 RID: 241 RVA: 0x0000AEFC File Offset: 0x000090FC
	private void FindGroundType()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, Vector3.down, out raycastHit, 5f, this.whatIsGround) && raycastHit.collider.gameObject.CompareTag("Build"))
		{
			this.randomSfx.sounds = this.woodSfx;
		}
		this.randomSfx.Randomize(0f);
	}

	// Token: 0x040000F9 RID: 249
	public LayerMask whatIsGround;

	// Token: 0x040000FA RID: 250
	public RandomSfx randomSfx;

	// Token: 0x040000FB RID: 251
	public AudioClip[] woodSfx;
}
