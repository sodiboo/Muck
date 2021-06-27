using System;
using UnityEngine;

// Token: 0x02000077 RID: 119
public class PlayParticlesOnEnable : MonoBehaviour
{
	// Token: 0x060002A9 RID: 681 RVA: 0x0000EF06 File Offset: 0x0000D106
	private void OnEnable()
	{
		this.ps.Play(true);
	}

	// Token: 0x040002BF RID: 703
	public ParticleSystem ps;
}
