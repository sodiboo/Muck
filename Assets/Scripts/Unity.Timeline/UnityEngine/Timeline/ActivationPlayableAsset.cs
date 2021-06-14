using UnityEngine.Playables;
using UnityEngine;

namespace UnityEngine.Timeline
{
	internal class ActivationPlayableAsset : PlayableAsset
	{
		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

	}
}
