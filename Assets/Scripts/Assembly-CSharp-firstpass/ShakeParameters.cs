using System;
using UnityEngine;

namespace MilkShake
{
	// Token: 0x02000004 RID: 4
	[Serializable]
	public class ShakeParameters : IShakeParameters
	{
		// Token: 0x06000021 RID: 33 RVA: 0x00002506 File Offset: 0x00000706
		public ShakeParameters()
		{
		}

		// Token: 0x06000022 RID: 34 RVA: 0x00002510 File Offset: 0x00000710
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

		// Token: 0x1700000D RID: 13
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

		// Token: 0x1700000E RID: 14
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

		// Token: 0x1700000F RID: 15
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

		// Token: 0x17000010 RID: 16
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

		// Token: 0x17000011 RID: 17
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

		// Token: 0x17000012 RID: 18
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

		// Token: 0x17000013 RID: 19
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

		// Token: 0x04000012 RID: 18
		[Header("Shake Type")]
		[SerializeField]
		private ShakeType shakeType;

		// Token: 0x04000013 RID: 19
		[Header("Shake Strength")]
		[SerializeField]
		private float strength;

		// Token: 0x04000014 RID: 20
		[SerializeField]
		private float roughness;

		// Token: 0x04000015 RID: 21
		[Header("Fade")]
		[SerializeField]
		private float fadeIn;

		// Token: 0x04000016 RID: 22
		[SerializeField]
		private float fadeOut;

		// Token: 0x04000017 RID: 23
		[Header("Shake Influence")]
		[SerializeField]
		private Vector3 positionInfluence;

		// Token: 0x04000018 RID: 24
		[SerializeField]
		private Vector3 rotationInfluence;
	}
}
