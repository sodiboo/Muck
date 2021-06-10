
using UnityEngine;

// Token: 0x02000026 RID: 38
public class FootStep : MonoBehaviour
{
	// Token: 0x060000DF RID: 223 RVA: 0x0000665D File Offset: 0x0000485D
	private void Start()
	{
		this.FindGroundType();
	}

	// Token: 0x060000E0 RID: 224 RVA: 0x00006668 File Offset: 0x00004868
	private void FindGroundType()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, Vector3.down, out raycastHit, 5f, this.whatIsGround) && raycastHit.collider.gameObject.CompareTag("Build"))
		{
			this.randomSfx.sounds = this.woodSfx;
		}
		this.randomSfx.Randomize(0f);
	}

	// Token: 0x040000DC RID: 220
	public LayerMask whatIsGround;

	// Token: 0x040000DD RID: 221
	public RandomSfx randomSfx;

	// Token: 0x040000DE RID: 222
	public AudioClip[] woodSfx;
}
