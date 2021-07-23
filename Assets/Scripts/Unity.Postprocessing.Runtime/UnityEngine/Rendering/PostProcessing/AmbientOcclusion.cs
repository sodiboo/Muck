using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class AmbientOcclusion : PostProcessEffectSettings
	{
		public AmbientOcclusionModeParameter mode;
		public FloatParameter intensity;
		public ColorParameter color;
		public BoolParameter ambientOnly;
		public FloatParameter noiseFilterTolerance;
		public FloatParameter blurTolerance;
		public FloatParameter upsampleTolerance;
		public FloatParameter thicknessModifier;
		public FloatParameter directLightingStrength;
		public FloatParameter radius;
		public AmbientOcclusionQualityParameter quality;
	}
}
