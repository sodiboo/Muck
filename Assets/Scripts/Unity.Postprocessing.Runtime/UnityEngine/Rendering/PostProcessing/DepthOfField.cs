using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class DepthOfField : PostProcessEffectSettings
	{
		public FloatParameter focusDistance;
		public FloatParameter aperture;
		public FloatParameter focalLength;
		public KernelSizeParameter kernelSize;
	}
}
