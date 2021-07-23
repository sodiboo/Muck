using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class Vignette : PostProcessEffectSettings
	{
		public VignetteModeParameter mode;
		public ColorParameter color;
		public Vector2Parameter center;
		public FloatParameter intensity;
		public FloatParameter smoothness;
		public FloatParameter roundness;
		public BoolParameter rounded;
		public TextureParameter mask;
		public FloatParameter opacity;
	}
}
