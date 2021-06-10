
using MilkShake;
using UnityEngine;

// Token: 0x02000030 RID: 48
public class HandheldCamera : MonoBehaviour
{
	// Token: 0x06000120 RID: 288 RVA: 0x00007B04 File Offset: 0x00005D04
	private void Start()
	{
		this.shaker = base.GetComponent<Shaker>();
		this.shaker.Shake(this.cameraShake, null);
	}

	// Token: 0x04000110 RID: 272
	public ShakePreset cameraShake;

	// Token: 0x04000111 RID: 273
	private Shaker shaker;
}
