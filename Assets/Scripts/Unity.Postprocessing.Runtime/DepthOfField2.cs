using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x0200001F RID: 31
	[Serializable]
	public sealed class DepthOfField2 : PostProcessEffectSettings
	{
		// Token: 0x0600003D RID: 61 RVA: 0x00004D0E File Offset: 0x00002F0E
		public override bool IsEnabledAndSupported(PostProcessRenderContext context)
		{
			return this.enabled.value && SystemInfo.graphicsShaderLevel >= 35;
		}

		// Token: 0x0400007C RID: 124
		[Min(0.1f)]
		[Tooltip("Distance to the point of focus.")]
		public FloatParameter focusDistance = new FloatParameter
		{
			value = 10f
		};

		// Token: 0x0400007D RID: 125
		[Range(0.05f, 32f)]
		[Tooltip("Ratio of aperture (known as f-stop or f-number). The smaller the value is, the shallower the depth of field is.")]
		public FloatParameter aperture = new FloatParameter
		{
			value = 5.6f
		};

		// Token: 0x0400007E RID: 126
		[Range(1f, 300f)]
		[Tooltip("Distance between the lens and the film. The larger the value is, the shallower the depth of field is.")]
		public FloatParameter focalLength = new FloatParameter
		{
			value = 50f
		};

		// Token: 0x0400007F RID: 127
		[DisplayName("Max Blur Size")]
		[Tooltip("Convolution kernel size of the bokeh filter, which determines the maximum radius of bokeh. It also affects performances (the larger the kernel is, the longer the GPU time is required).")]
		public KernelSizeParameter kernelSize = new KernelSizeParameter
		{
			value = KernelSize.Medium
		};
	}
}
