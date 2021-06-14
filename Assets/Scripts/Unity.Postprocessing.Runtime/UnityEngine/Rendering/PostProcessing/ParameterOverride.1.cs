using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class ParameterOverride<T> : ParameterOverride
	{
		public T value;
	}
}
