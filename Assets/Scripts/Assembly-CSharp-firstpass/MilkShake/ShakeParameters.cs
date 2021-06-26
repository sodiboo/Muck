using System;
using UnityEngine;

namespace MilkShake
{
	[Serializable]
	public class ShakeParameters
	{
		[SerializeField]
		private ShakeType shakeType;
		[SerializeField]
		private float strength;
		[SerializeField]
		private float roughness;
		[SerializeField]
		private float fadeIn;
		[SerializeField]
		private float fadeOut;
		[SerializeField]
		private Vector3 positionInfluence;
		[SerializeField]
		private Vector3 rotationInfluence;
	}
}
