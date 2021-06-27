using System;
using UnityEngine;

namespace MilkShake
{
	public struct ShakeResult
	{
		public static ShakeResult operator +(ShakeResult a, ShakeResult b)
		{
			return new ShakeResult
			{
				PositionShake = a.PositionShake + b.PositionShake,
				RotationShake = a.RotationShake + b.RotationShake
			};
		}

		public Vector3 PositionShake;

		public Vector3 RotationShake;
	}
}
