using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000028 RID: 40
	[Serializable]
	public sealed class MotionBlur2 : PostProcessEffectSettings
	{
		// Token: 0x04000098 RID: 152
		[Range(0f, 360f)]
		[Tooltip("The angle of rotary shutter. Larger values give longer exposure.")]
		public FloatParameter shutterAngle = new FloatParameter
		{
			value = 270f
		};

		// Token: 0x04000099 RID: 153
		[Range(4f, 32f)]
		[Tooltip("The amount of sample points. This affects quality and performance.")]
		public IntParameter sampleCount = new IntParameter
		{
			value = 10
		};
	}
}
