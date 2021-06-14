using System;
using UnityEngine;

namespace MilkShake
{

	public interface IShakeParameters
	{

		// (get) Token: 0x06000001 RID: 1
		// (set) Token: 0x06000002 RID: 2
		ShakeType ShakeType { get; set; }


		// (get) Token: 0x06000003 RID: 3
		// (set) Token: 0x06000004 RID: 4
		float Strength { get; set; }


		// (get) Token: 0x06000005 RID: 5
		// (set) Token: 0x06000006 RID: 6
		float Roughness { get; set; }


		// (get) Token: 0x06000007 RID: 7
		// (set) Token: 0x06000008 RID: 8
		float FadeIn { get; set; }


		// (get) Token: 0x06000009 RID: 9
		// (set) Token: 0x0600000A RID: 10
		float FadeOut { get; set; }


		// (get) Token: 0x0600000B RID: 11
		// (set) Token: 0x0600000C RID: 12
		Vector3 PositionInfluence { get; set; }


		// (get) Token: 0x0600000D RID: 13
		// (set) Token: 0x0600000E RID: 14
		Vector3 RotationInfluence { get; set; }
	}
}
