using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000036 RID: 54
	[Serializable]
	public sealed class Vignette2 : PostProcessEffectSettings
	{
		// Token: 0x040000D3 RID: 211
		[Tooltip("Use the \"Classic\" mode for parametric controls. Use the \"Masked\" mode to use your own texture mask.")]
		public VignetteModeParameter mode = new VignetteModeParameter
		{
			value = VignetteMode.Classic
		};

		// Token: 0x040000D4 RID: 212
		[Tooltip("Vignette color.")]
		public ColorParameter color = new ColorParameter
		{
			value = new Color(0f, 0f, 0f, 1f)
		};

		// Token: 0x040000D5 RID: 213
		[Tooltip("Sets the vignette center point (screen center is [0.5, 0.5]).")]
		public Vector2Parameter center = new Vector2Parameter
		{
			value = new Vector2(0.5f, 0.5f)
		};

		// Token: 0x040000D6 RID: 214
		[Range(0f, 1f)]
		[Tooltip("Amount of vignetting on screen.")]
		public FloatParameter intensity = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x040000D7 RID: 215
		[Range(0.01f, 1f)]
		[Tooltip("Smoothness of the vignette borders.")]
		public FloatParameter smoothness = new FloatParameter
		{
			value = 0.2f
		};

		// Token: 0x040000D8 RID: 216
		[Range(0f, 1f)]
		[Tooltip("Lower values will make a square-ish vignette.")]
		public FloatParameter roundness = new FloatParameter
		{
			value = 1f
		};

		// Token: 0x040000D9 RID: 217
		[Tooltip("Set to true to mark the vignette to be perfectly round. False will make its shape dependent on the current aspect ratio.")]
		public BoolParameter rounded = new BoolParameter
		{
			value = false
		};

		// Token: 0x040000DA RID: 218
		[Tooltip("A black and white mask to use as a vignette.")]
		public TextureParameter mask = new TextureParameter
		{
			value = null
		};

		// Token: 0x040000DB RID: 219
		[Range(0f, 1f)]
		[Tooltip("Mask opacity.")]
		public FloatParameter opacity = new FloatParameter
		{
			value = 1f
		};
	}
}
