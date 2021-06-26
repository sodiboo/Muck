using System;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class AudioTrack : TrackAsset
	{
		[SerializeField]
		private AudioMixerProperties m_TrackProperties;
	}
}
