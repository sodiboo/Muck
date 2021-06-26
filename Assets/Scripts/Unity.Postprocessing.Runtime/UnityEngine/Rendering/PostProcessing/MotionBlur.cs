using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class MotionBlur : PostProcessEffectSettings
	{
		public FloatParameter shutterAngle;
		public IntParameter sampleCount;
	}
}
