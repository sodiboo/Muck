using System;

namespace UnityEngine.Rendering.PostProcessing
{
	public class TrackballAttribute : Attribute
	{
		public enum Mode
		{
			None = 0,
			Lift = 1,
			Gamma = 2,
			Gain = 3,
		}

		public TrackballAttribute(TrackballAttribute.Mode mode)
		{
		}

	}
}
