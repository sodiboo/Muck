using UnityEngine;

namespace UnityEngine.Rendering.PostProcessing
{
	public class PostProcessDebug : MonoBehaviour
	{
		public PostProcessLayer postProcessLayer;
		public bool lightMeter;
		public bool histogram;
		public bool waveform;
		public bool vectorscope;
		public DebugOverlay debugOverlay;
	}
}
