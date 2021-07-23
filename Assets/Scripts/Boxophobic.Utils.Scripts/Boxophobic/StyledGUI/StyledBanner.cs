using UnityEngine;

namespace Boxophobic.StyledGUI
{
	public class StyledBanner : PropertyAttribute
	{
		public StyledBanner(string title)
		{
		}

		public float colorR;
		public float colorG;
		public float colorB;
		public string title;
		public string helpURL;
	}
}
