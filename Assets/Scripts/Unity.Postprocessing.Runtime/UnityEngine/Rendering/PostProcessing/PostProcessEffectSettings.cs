using System;
using UnityEngine;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class PostProcessEffectSettings : ScriptableObject
	{
		public bool active;
		public BoolParameter enabled;
	}
}
