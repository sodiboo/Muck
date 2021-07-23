using UnityEngine;

namespace Boxophobic.StyledGUI
{
	public class StyledButton : PropertyAttribute
	{
		public StyledButton(string Text)
		{
		}

		public string Text;
		public float Top;
		public float Down;
	}
}
