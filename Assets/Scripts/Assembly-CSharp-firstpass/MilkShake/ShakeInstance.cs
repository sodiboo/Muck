using System;

namespace MilkShake
{
	[Serializable]
	public class ShakeInstance
	{
		public ShakeInstance(Nullable<int> seed)
		{
		}

		public ShakeParameters ShakeParameters;
		public float StrengthScale;
		public float RoughnessScale;
		public bool RemoveWhenStopped;
	}
}
