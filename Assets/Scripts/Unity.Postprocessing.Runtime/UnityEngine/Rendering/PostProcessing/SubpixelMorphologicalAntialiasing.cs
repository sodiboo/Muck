using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class SubpixelMorphologicalAntialiasing
	{
		public enum Quality
		{
			Low = 0,
			Medium = 1,
			High = 2,
		}

		public Quality quality;
	}
}
