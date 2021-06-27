using System;
using UnityEngine;

// Token: 0x02000124 RID: 292
public class TestScroll : MonoBehaviour
{
	// Token: 0x06000871 RID: 2161 RVA: 0x0002A4F0 File Offset: 0x000286F0
	private void Awake()
	{
		TestScroll.Instance = this;
		Invoke(nameof(GetReady), 4f);
	}

	// Token: 0x06000872 RID: 2162 RVA: 0x0002A508 File Offset: 0x00028708
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000873 RID: 2163 RVA: 0x0002A511 File Offset: 0x00028711
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

	// Token: 0x04000803 RID: 2051
	public NoiseData noise;

	// Token: 0x04000804 RID: 2052
	public TerrainData terrain;

	// Token: 0x04000805 RID: 2053
	public bool ready;

	// Token: 0x04000806 RID: 2054
	public static TestScroll Instance;
}
