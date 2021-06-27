using System;
using UnityEngine;

namespace MilkShake
{
	// Token: 0x02000006 RID: 6
	public struct ShakeResult
	{
		// Token: 0x06000040 RID: 64 RVA: 0x00002670 File Offset: 0x00000870
		public static ShakeResult operator +(ShakeResult a, ShakeResult b)
		{
			return new ShakeResult
			{
				PositionShake = a.PositionShake + b.PositionShake,
				RotationShake = a.RotationShake + b.RotationShake
			};
		}

		// Token: 0x04000020 RID: 32
		public Vector3 PositionShake;

		// Token: 0x04000021 RID: 33
		public Vector3 RotationShake;
	}
}
