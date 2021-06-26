using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class PostProcessDebugLayer
	{
		[Serializable]
		public class OverlaySettings
		{
			public bool linearDepth;
			public float motionColorIntensity;
			public int motionGridSize;
			public ColorBlindnessType colorBlindnessType;
			public float colorBlindnessStrength;
		}

		public LightMeterMonitor lightMeter;
		public HistogramMonitor histogram;
		public WaveformMonitor waveform;
		public VectorscopeMonitor vectorscope;
		public OverlaySettings overlaySettings;
	}
}
