using System;
using UnityEngine;

// Token: 0x02000148 RID: 328
public class TestScroll : MonoBehaviour
{
	// Token: 0x060007E9 RID: 2025 RVA: 0x00007308 File Offset: 0x00005508
	private void Awake()
	{
		TestScroll.Instance = this;
		base.Invoke("GetReady", 4f);
	}

	// Token: 0x060007EA RID: 2026 RVA: 0x00007320 File Offset: 0x00005520
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x060007EB RID: 2027 RVA: 0x00007329 File Offset: 0x00005529
	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		if (this.terrain.heightMultiplier > 300f)
		{
			return;
		}
		this.terrain.heightMultiplier += 20f * Time.deltaTime;
	}

	// Token: 0x04000824 RID: 2084
	public NoiseData noise;

	// Token: 0x04000825 RID: 2085
	public TerrainData terrain;

	// Token: 0x04000826 RID: 2086
	public bool ready;

	// Token: 0x04000827 RID: 2087
	public static TestScroll Instance;
}
