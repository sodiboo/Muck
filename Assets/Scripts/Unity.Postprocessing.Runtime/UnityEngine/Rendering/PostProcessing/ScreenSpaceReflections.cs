using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class ScreenSpaceReflections : PostProcessEffectSettings
	{
		public ScreenSpaceReflectionPresetParameter preset;
		public IntParameter maximumIterationCount;
		public ScreenSpaceReflectionResolutionParameter resolution;
		public FloatParameter thickness;
		public FloatParameter maximumMarchDistance;
		public FloatParameter distanceFade;
		public FloatParameter vignette;
	}
}
