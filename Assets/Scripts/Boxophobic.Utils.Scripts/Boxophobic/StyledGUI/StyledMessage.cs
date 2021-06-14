using UnityEngine;

namespace Boxophobic.StyledGUI
{
	public class StyledMessage : PropertyAttribute
	{
		public StyledMessage(string Type, string Message)
		{
		}

		public string Type;
		public string Message;
		public float Top;
		public float Down;
	}
}
