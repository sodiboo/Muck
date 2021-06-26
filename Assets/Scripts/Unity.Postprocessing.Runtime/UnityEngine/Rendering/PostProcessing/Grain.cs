using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class Grain : PostProcessEffectSettings
	{
		public BoolParameter colored;
		public FloatParameter intensity;
		public FloatParameter size;
		public FloatParameter lumContrib;
	}
}
