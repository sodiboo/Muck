using System;
using UnityEngine;

namespace MilkShake
{

	[CreateAssetMenu(fileName = "New Shake Preset", menuName = "MilkShake/Shake Preset")]
	public class ShakePreset : ScriptableObject, IShakeParameters
	{

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
