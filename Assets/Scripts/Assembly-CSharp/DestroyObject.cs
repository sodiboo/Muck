
using UnityEngine;

// Token: 0x0200001E RID: 30
public class DestroyObject : MonoBehaviour
{
	// Token: 0x060000B0 RID: 176 RVA: 0x000057BA File Offset: 0x000039BA
	private void Start()
	{
		base.Invoke("DestroySelf", this.time);
	}

	// Token: 0x060000B1 RID: 177 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x040000A6 RID: 166
	public float time;
}
