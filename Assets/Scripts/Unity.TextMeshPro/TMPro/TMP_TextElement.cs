using System;
using UnityEngine;

namespace TMPro
{
	[Serializable]
	public class TMP_TextElement
	{
		[SerializeField]
		protected TextElementType m_ElementType;
		[SerializeField]
		internal uint m_Unicode;
		[SerializeField]
		internal uint m_GlyphIndex;
		[SerializeField]
		internal float m_Scale;
	}
}
