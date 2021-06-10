using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x0200000C RID: 12
	[Serializable]
	public sealed class AmbientOcclusion2 : PostProcessEffectSettings
	{
		// Token: 0x0600000A RID: 10 RVA: 0x00002104 File Offset: 0x00000304
		public override bool IsEnabledAndSupported(PostProcessRenderContext context)
		{
			return true;
		}

		// Token: 0x04000015 RID: 21
		[Tooltip("The ambient occlusion method to use. \"Multi Scale Volumetric Obscurance\" is higher quality and faster on desktop & console platforms but requires compute shader support.")]
		public AmbientOcclusionModeParameter mode = new AmbientOcclusionModeParameter
		{
			value = AmbientOcclusionMode.MultiScaleVolumetricObscurance
		};

		// Token: 0x04000016 RID: 22
		[Range(0f, 4f)]
		[Tooltip("The degree of darkness added by ambient occlusion. Higher values produce darker areas.")]
		public FloatParameter intensity = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000017 RID: 23
		[ColorUsage(false)]
		[Tooltip("The custom color to use for the ambient occlusion. The default is black.")]
		public ColorParameter color = new ColorParameter
		{
			value = Color.black
		};

		// Token: 0x04000018 RID: 24
		[Tooltip("Check this box to mark this Volume as to only affect ambient lighting. This mode is only available with the Deferred rendering path and HDR rendering. Objects rendered with the Forward rendering path won't get any ambient occlusion.")]
		public BoolParameter ambientOnly = new BoolParameter
		{
			value = true
		};

		// Token: 0x04000019 RID: 25
		[Range(-8f, 0f)]
		public FloatParameter noiseFilterTolerance = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400001A RID: 26
		[Range(-8f, -1f)]
		public FloatParameter blurTolerance = new FloatParameter
		{
			value = -4.6f
		};

		// Token: 0x0400001B RID: 27
		[Range(-12f, -1f)]
		public FloatParameter upsampleTolerance = new FloatParameter
		{
			value = -12f
		};

		// Token: 0x0400001C RID: 28
		[Range(1f, 10f)]
		[Tooltip("This modifies the thickness of occluders. It increases the size of dark areas and also introduces a dark halo around objects.")]
		public FloatParameter thicknessModifier = new FloatParameter
		{
			value = 1f
		};

		// Token: 0x0400001D RID: 29
		[Range(0f, 1f)]
		[Tooltip("Modifies the influence of direct lighting on ambient occlusion.")]
		public FloatParameter directLightingStrength = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400001E RID: 30
		[Tooltip("The radius of sample points. This affects the size of darkened areas.")]
		public FloatParameter radius = new FloatParameter
		{
			value = 0.25f
		};

		// Token: 0x0400001F RID: 31
		[Tooltip("The number of sample points. This affects both quality and performance. For \"Lowest\", \"Low\", and \"Medium\", passes are downsampled. For \"High\" and \"Ultra\", they are not and therefore you should only \"High\" and \"Ultra\" on high-end hardware.")]
		public AmbientOcclusionQualityParameter quality = new AmbientOcclusionQualityParameter
		{
			value = AmbientOcclusionQuality.Medium
		};
	}
}
