using UnityEngine;

namespace Boxophobic.StyledGUI
{
	public class StyledRangeOptions : PropertyAttribute
	{
		public StyledRangeOptions(float min, float max, string displayLabel, string[] options)
		{
		}

		public float min;
		public float max;
		public string displayLabel;
		public string[] options;
	}
}
