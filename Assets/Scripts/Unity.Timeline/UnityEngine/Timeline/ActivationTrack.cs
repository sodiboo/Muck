using System;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class ActivationTrack : TrackAsset
	{
		public enum PostPlaybackState
		{
			Active = 0,
			Inactive = 1,
			Revert = 2,
			LeaveAsIs = 3,
		}

		[SerializeField]
		private PostPlaybackState m_PostPlaybackState;
	}
}
