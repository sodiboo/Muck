using UnityEngine.Playables;
using UnityEngine;

namespace UnityEngine.Timeline
{
	public class ActivationControlPlayable : PlayableBehaviour
	{
		public enum PostPlaybackState
		{
			Active = 0,
			Inactive = 1,
			Revert = 2,
		}

		public GameObject gameObject;
		public PostPlaybackState postPlayback;
	}
}
