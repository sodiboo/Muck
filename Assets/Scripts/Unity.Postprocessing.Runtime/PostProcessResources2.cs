using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000058 RID: 88
	public sealed class PostProcessResources2 : ScriptableObject
	{
		// Token: 0x0400017D RID: 381
		public Texture2D[] blueNoise64;

		// Token: 0x0400017E RID: 382
		public Texture2D[] blueNoise256;

		// Token: 0x0400017F RID: 383
		public PostProcessResources.SMAALuts smaaLuts;

		// Token: 0x04000180 RID: 384
		public PostProcessResources.Shaders shaders;

		// Token: 0x04000181 RID: 385
		public PostProcessResources.ComputeShaders computeShaders;

		// Token: 0x02000083 RID: 131
		[Serializable]
		public sealed class Shaders
		{
			// Token: 0x0600023D RID: 573 RVA: 0x00010BC0 File Offset: 0x0000EDC0
			public PostProcessResources.Shaders Clone()
			{
				return (PostProcessResources.Shaders)base.MemberwiseClone();
			}

			// Token: 0x040002BC RID: 700
			public Shader bloom;

			// Token: 0x040002BD RID: 701
			public Shader copy;

			// Token: 0x040002BE RID: 702
			public Shader copyStd;

			// Token: 0x040002BF RID: 703
			public Shader copyStdFromTexArray;

			// Token: 0x040002C0 RID: 704
			public Shader copyStdFromDoubleWide;

			// Token: 0x040002C1 RID: 705
			public Shader discardAlpha;

			// Token: 0x040002C2 RID: 706
			public Shader depthOfField;

			// Token: 0x040002C3 RID: 707
			public Shader finalPass;

			// Token: 0x040002C4 RID: 708
			public Shader grainBaker;

			// Token: 0x040002C5 RID: 709
			public Shader motionBlur;

			// Token: 0x040002C6 RID: 710
			public Shader temporalAntialiasing;

			// Token: 0x040002C7 RID: 711
			public Shader subpixelMorphologicalAntialiasing;

			// Token: 0x040002C8 RID: 712
			public Shader texture2dLerp;

			// Token: 0x040002C9 RID: 713
			public Shader uber;

			// Token: 0x040002CA RID: 714
			public Shader lut2DBaker;

			// Token: 0x040002CB RID: 715
			public Shader lightMeter;

			// Token: 0x040002CC RID: 716
			public Shader gammaHistogram;

			// Token: 0x040002CD RID: 717
			public Shader waveform;

			// Token: 0x040002CE RID: 718
			public Shader vectorscope;

			// Token: 0x040002CF RID: 719
			public Shader debugOverlays;

			// Token: 0x040002D0 RID: 720
			public Shader deferredFog;

			// Token: 0x040002D1 RID: 721
			public Shader scalableAO;

			// Token: 0x040002D2 RID: 722
			public Shader multiScaleAO;

			// Token: 0x040002D3 RID: 723
			public Shader screenSpaceReflections;
		}

		// Token: 0x02000084 RID: 132
		[Serializable]
		public sealed class ComputeShaders
		{
			// Token: 0x0600023F RID: 575 RVA: 0x00010BCD File Offset: 0x0000EDCD
			public PostProcessResources.ComputeShaders Clone()
			{
				return (PostProcessResources.ComputeShaders)base.MemberwiseClone();
			}

			// Token: 0x040002D4 RID: 724
			public ComputeShader autoExposure;

			// Token: 0x040002D5 RID: 725
			public ComputeShader exposureHistogram;

			// Token: 0x040002D6 RID: 726
			public ComputeShader lut3DBaker;

			// Token: 0x040002D7 RID: 727
			public ComputeShader texture3dLerp;

			// Token: 0x040002D8 RID: 728
			public ComputeShader gammaHistogram;

			// Token: 0x040002D9 RID: 729
			public ComputeShader waveform;

			// Token: 0x040002DA RID: 730
			public ComputeShader vectorscope;

			// Token: 0x040002DB RID: 731
			public ComputeShader multiScaleAODownsample1;

			// Token: 0x040002DC RID: 732
			public ComputeShader multiScaleAODownsample2;

			// Token: 0x040002DD RID: 733
			public ComputeShader multiScaleAORender;

			// Token: 0x040002DE RID: 734
			public ComputeShader multiScaleAOUpsample;

			// Token: 0x040002DF RID: 735
			public ComputeShader gaussianDownsample;
		}

		// Token: 0x02000085 RID: 133
		[Serializable]
		public sealed class SMAALuts
		{
			// Token: 0x040002E0 RID: 736
			public Texture2D area;

			// Token: 0x040002E1 RID: 737
			public Texture2D search;
		}
	}
}
