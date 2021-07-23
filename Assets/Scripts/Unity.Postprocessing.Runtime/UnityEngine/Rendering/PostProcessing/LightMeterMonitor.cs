using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class LightMeterMonitor : Monitor
	{
		public int width;
		public int height;
		public bool showCurves;
	}
}
