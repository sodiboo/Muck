using System;
using UnityEngine;

namespace TMPro
{
	[Serializable]
	public struct TMP_GlyphValueRecord
	{
		public TMP_GlyphValueRecord(float xPlacement, float yPlacement, float xAdvance, float yAdvance) : this()
		{
		}

		[SerializeField]
		internal float m_XPlacement;
		[SerializeField]
		internal float m_YPlacement;
		[SerializeField]
		internal float m_XAdvance;
		[SerializeField]
		internal float m_YAdvance;
	}
}
