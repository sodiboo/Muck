using System;
using UnityEngine;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class TextureParameter : ParameterOverride<Texture>
	{
		public TextureParameterDefault defaultState;
	}
}
