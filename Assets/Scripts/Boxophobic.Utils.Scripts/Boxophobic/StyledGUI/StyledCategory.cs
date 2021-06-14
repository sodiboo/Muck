using UnityEngine;

namespace Boxophobic.StyledGUI
{
	public class StyledCategory : PropertyAttribute
	{
		public StyledCategory(string category)
		{
		}

		public string category;
		public int top;
		public int down;
	}
}
