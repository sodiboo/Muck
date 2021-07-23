using System;
using UnityEngine;

namespace TMPro
{
	[Serializable]
	public class TMP_Style
	{
		internal TMP_Style(string styleName, string styleOpeningDefinition, string styleClosingDefinition)
		{
		}

		[SerializeField]
		private string m_Name;
		[SerializeField]
		private int m_HashCode;
		[SerializeField]
		private string m_OpeningDefinition;
		[SerializeField]
		private string m_ClosingDefinition;
		[SerializeField]
		private int[] m_OpeningTagArray;
		[SerializeField]
		private int[] m_ClosingTagArray;
	}
}
