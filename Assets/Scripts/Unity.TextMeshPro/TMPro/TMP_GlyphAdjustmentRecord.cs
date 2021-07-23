using System;
using UnityEngine;

namespace TMPro
{
	[Serializable]
	public struct TMP_GlyphAdjustmentRecord
	{
		public TMP_GlyphAdjustmentRecord(uint glyphIndex, TMP_GlyphValueRecord glyphValueRecord) : this()
		{
		}

		[SerializeField]
		internal uint m_GlyphIndex;
		[SerializeField]
		internal TMP_GlyphValueRecord m_GlyphValueRecord;
	}
}
