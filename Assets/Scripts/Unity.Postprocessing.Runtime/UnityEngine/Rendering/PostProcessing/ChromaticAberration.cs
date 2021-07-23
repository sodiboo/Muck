using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class ChromaticAberration : PostProcessEffectSettings
	{
		public TextureParameter spectralLut;
		public FloatParameter intensity;
		public BoolParameter fastMode;
	}
}
