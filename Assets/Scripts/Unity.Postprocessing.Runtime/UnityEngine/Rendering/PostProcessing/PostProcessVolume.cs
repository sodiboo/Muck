using UnityEngine;

namespace UnityEngine.Rendering.PostProcessing
{
	public class PostProcessVolume : MonoBehaviour
	{
		public PostProcessProfile sharedProfile;
		public bool isGlobal;
		public float blendDistance;
		public float weight;
		public float priority;
	}
}
