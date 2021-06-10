
using UnityEngine;

namespace MilkShake
{
	// Token: 0x02000005 RID: 5
	[CreateAssetMenu(fileName = "New Shake Preset", menuName = "MilkShake/Shake Preset")]
	public class ShakePreset : ScriptableObject, IShakeParameters
	{
		// Token: 0x17000014 RID: 20
		// (get) Token: 0x06000031 RID: 49 RVA: 0x000025EE File Offset: 0x000007EE
		// (set) Token: 0x06000032 RID: 50 RVA: 0x000025F6 File Offset: 0x000007F6
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

		// Token: 0x17000015 RID: 21
		// (get) Token: 0x06000033 RID: 51 RVA: 0x000025FF File Offset: 0x000007FF
		// (set) Token: 0x06000034 RID: 52 RVA: 0x00002607 File Offset: 0x00000807
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

		// Token: 0x17000016 RID: 22
		// (get) Token: 0x06000035 RID: 53 RVA: 0x00002610 File Offset: 0x00000810
		// (set) Token: 0x06000036 RID: 54 RVA: 0x00002618 File Offset: 0x00000818
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

		// Token: 0x17000017 RID: 23
		// (get) Token: 0x06000037 RID: 55 RVA: 0x00002621 File Offset: 0x00000821
		// (set) Token: 0x06000038 RID: 56 RVA: 0x00002629 File Offset: 0x00000829
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

		// Token: 0x17000018 RID: 24
		// (get) Token: 0x06000039 RID: 57 RVA: 0x00002632 File Offset: 0x00000832
		// (set) Token: 0x0600003A RID: 58 RVA: 0x0000263A File Offset: 0x0000083A
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

		// Token: 0x17000019 RID: 25
		// (get) Token: 0x0600003B RID: 59 RVA: 0x00002643 File Offset: 0x00000843
		// (set) Token: 0x0600003C RID: 60 RVA: 0x0000264B File Offset: 0x0000084B
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

		// Token: 0x1700001A RID: 26
		// (get) Token: 0x0600003D RID: 61 RVA: 0x00002654 File Offset: 0x00000854
		// (set) Token: 0x0600003E RID: 62 RVA: 0x0000265C File Offset: 0x0000085C
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

		// Token: 0x04000019 RID: 25
		[Header("Shake Type")]
		[SerializeField]
		private ShakeType shakeType;

		// Token: 0x0400001A RID: 26
		[Header("Shake Strength")]
		[SerializeField]
		private float strength;

		// Token: 0x0400001B RID: 27
		[SerializeField]
		private float roughness;

		// Token: 0x0400001C RID: 28
		[Header("Fade")]
		[SerializeField]
		private float fadeIn;

		// Token: 0x0400001D RID: 29
		[SerializeField]
		private float fadeOut;

		// Token: 0x0400001E RID: 30
		[Header("Shake Influence")]
		[SerializeField]
		private Vector3 positionInfluence;

		// Token: 0x0400001F RID: 31
		[SerializeField]
		private Vector3 rotationInfluence;
	}
}
