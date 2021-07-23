using System;
using UnityEngine.TextCore.LowLevel;

namespace TMPro
{
	[Serializable]
	public struct GlyphValueRecord_Legacy
	{
		internal GlyphValueRecord_Legacy(GlyphValueRecord valueRecord) : this()
		{
		}

		public float xPlacement;
		public float yPlacement;
		public float xAdvance;
		public float yAdvance;
	}
}
