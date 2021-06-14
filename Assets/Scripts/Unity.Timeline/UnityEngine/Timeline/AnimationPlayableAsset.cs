using System;
using UnityEngine.Playables;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class AnimationPlayableAsset : PlayableAsset
	{
		public enum LoopMode
		{
			UseSourceAsset = 0,
			On = 1,
			Off = 2,
		}

		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

		[SerializeField]
		private AnimationClip m_Clip;
		[SerializeField]
		private Vector3 m_Position;
		[SerializeField]
		private Vector3 m_EulerAngles;
		[SerializeField]
		private bool m_UseTrackMatchFields;
		[SerializeField]
		private MatchTargetFields m_MatchTargetFields;
		[SerializeField]
		private bool m_RemoveStartOffset;
		[SerializeField]
		private bool m_ApplyFootIK;
		[SerializeField]
		private LoopMode m_Loop;
		[SerializeField]
		private int m_Version;
		[SerializeField]
		private Quaternion m_Rotation;
	}
}
