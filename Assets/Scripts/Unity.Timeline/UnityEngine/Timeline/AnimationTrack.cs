using System;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class AnimationTrack : TrackAsset
	{
		[SerializeField]
		private TimelineClip.ClipExtrapolation m_InfiniteClipPreExtrapolation;
		[SerializeField]
		private TimelineClip.ClipExtrapolation m_InfiniteClipPostExtrapolation;
		[SerializeField]
		private Vector3 m_InfiniteClipOffsetPosition;
		[SerializeField]
		private Vector3 m_InfiniteClipOffsetEulerAngles;
		[SerializeField]
		private double m_InfiniteClipTimeOffset;
		[SerializeField]
		private bool m_InfiniteClipRemoveOffset;
		[SerializeField]
		private bool m_InfiniteClipApplyFootIK;
		[SerializeField]
		private AnimationPlayableAsset.LoopMode mInfiniteClipLoop;
		[SerializeField]
		private MatchTargetFields m_MatchTargetFields;
		[SerializeField]
		private Vector3 m_Position;
		[SerializeField]
		private Vector3 m_EulerAngles;
		[SerializeField]
		private AvatarMask m_AvatarMask;
		[SerializeField]
		private bool m_ApplyAvatarMask;
		[SerializeField]
		private TrackOffset m_TrackOffset;
		[SerializeField]
		private AnimationClip m_InfiniteClip;
		[SerializeField]
		private Quaternion m_OpenClipOffsetRotation;
		[SerializeField]
		private Quaternion m_Rotation;
		[SerializeField]
		private bool m_ApplyOffsets;
	}
}
