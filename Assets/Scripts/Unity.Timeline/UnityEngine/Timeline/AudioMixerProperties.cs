using System;
using UnityEngine.Playables;

namespace UnityEngine.Timeline
{
	[Serializable]
	internal class AudioMixerProperties : PlayableBehaviour
	{
		public float volume;
		public float stereoPan;
		public float spatialBlend;
	}
}
