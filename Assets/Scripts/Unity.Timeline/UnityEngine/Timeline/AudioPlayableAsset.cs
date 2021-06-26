using System;
using UnityEngine.Playables;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class AudioPlayableAsset : PlayableAsset
	{
		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

		[SerializeField]
		private AudioClip m_Clip;
		[SerializeField]
		private bool m_Loop;
		[SerializeField]
		private float m_bufferingTime;
		[SerializeField]
		private AudioClipProperties m_ClipProperties;
	}
}
