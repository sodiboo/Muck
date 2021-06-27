using System;
using UnityEngine;

namespace MilkShake
{
	[Serializable]
	public class ShakeParameters : IShakeParameters
	{
		public ShakeParameters()
		{
		}

		public ShakeParameters(IShakeParameters original)
		{
			this.shakeType = original.ShakeType;
			this.strength = original.Strength;
			this.roughness = original.Roughness;
			this.fadeIn = original.FadeIn;
			this.fadeOut = original.FadeOut;
			this.positionInfluence = original.PositionInfluence;
			this.rotationInfluence = original.RotationInfluence;
		}

		public ShakeType ShakeType
		{
			get
			{
				return this.shakeType;
			}
			set
			{
				this.shakeType = value;
			}
		}

		public float Strength
		{
			get
			{
				return this.strength;
			}
			set
			{
				this.strength = value;
			}
		}

		public float Roughness
		{
			get
			{
				return this.roughness;
			}
			set
			{
				this.roughness = value;
			}
		}

		public float FadeIn
		{
			get
			{
				return this.fadeIn;
			}
			set
			{
				this.fadeIn = value;
			}
		}

		public float FadeOut
		{
			get
			{
				return this.fadeOut;
			}
			set
			{
				this.fadeOut = value;
			}
		}

		public Vector3 PositionInfluence
		{
			get
			{
				return this.positionInfluence;
			}
			set
			{
				this.positionInfluence = value;
			}
		}

		public Vector3 RotationInfluence
		{
			get
			{
				return this.rotationInfluence;
			}
			set
			{
				this.rotationInfluence = value;
			}
		}

		[Header("Shake Type")]
		[SerializeField]
		private ShakeType shakeType;

		[Header("Shake Strength")]
		[SerializeField]
		private float strength;

		[SerializeField]
		private float roughness;

		[Header("Fade")]
		[SerializeField]
		private float fadeIn;

		[SerializeField]
		private float fadeOut;

		[Header("Shake Influence")]
		[SerializeField]
		private Vector3 positionInfluence;

		[SerializeField]
		private Vector3 rotationInfluence;
	}
}
