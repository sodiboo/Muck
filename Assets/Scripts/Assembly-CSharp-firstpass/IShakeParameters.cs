using System;
using UnityEngine;

namespace MilkShake
{
	public interface IShakeParameters
	{
		ShakeType ShakeType { get; set; }

		float Strength { get; set; }

		float Roughness { get; set; }

		float FadeIn { get; set; }

		float FadeOut { get; set; }

		Vector3 PositionInfluence { get; set; }

		Vector3 RotationInfluence { get; set; }
	}
}
