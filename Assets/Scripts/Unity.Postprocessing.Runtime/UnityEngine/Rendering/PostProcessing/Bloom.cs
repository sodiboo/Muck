using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class Bloom : PostProcessEffectSettings
	{
		public FloatParameter intensity;
		public FloatParameter threshold;
		public FloatParameter softKnee;
		public FloatParameter clamp;
		public FloatParameter diffusion;
		public FloatParameter anamorphicRatio;
		public ColorParameter color;
		public BoolParameter fastMode;
		public TextureParameter dirtTexture;
		public FloatParameter dirtIntensity;
	}
}
