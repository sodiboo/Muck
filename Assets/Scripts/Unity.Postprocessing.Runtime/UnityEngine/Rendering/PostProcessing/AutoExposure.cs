using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class AutoExposure : PostProcessEffectSettings
	{
		public Vector2Parameter filtering;
		public FloatParameter minLuminance;
		public FloatParameter maxLuminance;
		public FloatParameter keyValue;
		public EyeAdaptationParameter eyeAdaptation;
		public FloatParameter speedUp;
		public FloatParameter speedDown;
	}
}
