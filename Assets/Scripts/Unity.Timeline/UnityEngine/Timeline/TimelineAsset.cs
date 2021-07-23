using System;
using UnityEngine.Playables;
using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class TimelineAsset : PlayableAsset
	{
		[Serializable]
		public class EditorSettings
		{
			[SerializeField]
			private float m_Framerate;
		}

		public enum DurationMode
		{
			BasedOnClips = 0,
			FixedLength = 1,
		}

		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

		[SerializeField]
		private int m_Version;
		[SerializeField]
		private List<ScriptableObject> m_Tracks;
		[SerializeField]
		private double m_FixedDuration;
		[SerializeField]
		private EditorSettings m_EditorSettings;
		[SerializeField]
		private DurationMode m_DurationMode;
		[SerializeField]
		private MarkerTrack m_MarkerTrack;
	}
}
