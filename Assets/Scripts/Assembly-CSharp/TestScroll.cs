
using UnityEngine;

// Token: 0x020000F4 RID: 244
public class TestScroll : MonoBehaviour
{
	// Token: 0x0600072D RID: 1837 RVA: 0x00023C10 File Offset: 0x00021E10
	private void Awake()
	{
		TestScroll.Instance = this;
		base.Invoke("GetReady", 4f);
	}

	// Token: 0x0600072E RID: 1838 RVA: 0x00023C28 File Offset: 0x00021E28
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x0600072F RID: 1839 RVA: 0x00023C31 File Offset: 0x00021E31
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

	// Token: 0x040006BE RID: 1726
	public NoiseData noise;

	// Token: 0x040006BF RID: 1727
	public TerrainData terrain;

	// Token: 0x040006C0 RID: 1728
	public bool ready;

	// Token: 0x040006C1 RID: 1729
	public static TestScroll Instance;
}
