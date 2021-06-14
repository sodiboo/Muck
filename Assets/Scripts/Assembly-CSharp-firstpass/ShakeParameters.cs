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


		// (get) Token: 0x06000023 RID: 35 RVA: 0x00002577 File Offset: 0x00000777
		// (set) Token: 0x06000024 RID: 36 RVA: 0x0000257F File Offset: 0x0000077F
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


		// (get) Token: 0x06000025 RID: 37 RVA: 0x00002588 File Offset: 0x00000788
		// (set) Token: 0x06000026 RID: 38 RVA: 0x00002590 File Offset: 0x00000790
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


		// (get) Token: 0x06000027 RID: 39 RVA: 0x00002599 File Offset: 0x00000799
		// (set) Token: 0x06000028 RID: 40 RVA: 0x000025A1 File Offset: 0x000007A1
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


		// (get) Token: 0x06000029 RID: 41 RVA: 0x000025AA File Offset: 0x000007AA
		// (set) Token: 0x0600002A RID: 42 RVA: 0x000025B2 File Offset: 0x000007B2
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


		// (get) Token: 0x0600002B RID: 43 RVA: 0x000025BB File Offset: 0x000007BB
		// (set) Token: 0x0600002C RID: 44 RVA: 0x000025C3 File Offset: 0x000007C3
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


		// (get) Token: 0x0600002D RID: 45 RVA: 0x000025CC File Offset: 0x000007CC
		// (set) Token: 0x0600002E RID: 46 RVA: 0x000025D4 File Offset: 0x000007D4
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


		// (get) Token: 0x0600002F RID: 47 RVA: 0x000025DD File Offset: 0x000007DD
		// (set) Token: 0x06000030 RID: 48 RVA: 0x000025E5 File Offset: 0x000007E5
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
