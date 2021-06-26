using System;
using UnityEngine.Playables;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class ControlPlayableAsset : PlayableAsset
	{
		public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
		{
			return default(Playable);
		}

		[SerializeField]
		public ExposedReference<GameObject> sourceGameObject;
		[SerializeField]
		public GameObject prefabGameObject;
		[SerializeField]
		public bool updateParticle;
		[SerializeField]
		public uint particleRandomSeed;
		[SerializeField]
		public bool updateDirector;
		[SerializeField]
		public bool updateITimeControl;
		[SerializeField]
		public bool searchHierarchy;
		[SerializeField]
		public bool active;
		[SerializeField]
		public ActivationControlPlayable.PostPlaybackState postPlayback;
	}
}
