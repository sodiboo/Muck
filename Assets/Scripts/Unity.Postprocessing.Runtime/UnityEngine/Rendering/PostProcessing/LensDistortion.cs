using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class LensDistortion : PostProcessEffectSettings
	{
		public FloatParameter intensity;
		public FloatParameter intensityX;
		public FloatParameter intensityY;
		public FloatParameter centerX;
		public FloatParameter centerY;
		public FloatParameter scale;
	}
}
