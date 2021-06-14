using System;
using UnityEngine.Playables;
using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class TrackAsset : PlayableAsset
	{
		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

		[SerializeField]
		private int m_Version;
		[SerializeField]
		internal AnimationClip m_AnimClip;
		[SerializeField]
		private bool m_Locked;
		[SerializeField]
		private bool m_Muted;
		[SerializeField]
		private string m_CustomPlayableFullTypename;
		[SerializeField]
		private AnimationClip m_Curves;
		[SerializeField]
		private PlayableAsset m_Parent;
		[SerializeField]
		private List<ScriptableObject> m_Children;
		[SerializeField]
		protected List<TimelineClip> m_Clips;
		[SerializeField]
		private MarkerList m_Markers;
	}
}
