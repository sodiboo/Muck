using System;
using UnityEngine;

namespace TMPro
{
	[Serializable]
	public class TMP_GlyphPairAdjustmentRecord
	{
		public TMP_GlyphPairAdjustmentRecord(TMP_GlyphAdjustmentRecord firstAdjustmentRecord, TMP_GlyphAdjustmentRecord secondAdjustmentRecord)
		{
		}

		[SerializeField]
		internal TMP_GlyphAdjustmentRecord m_FirstAdjustmentRecord;
		[SerializeField]
		internal TMP_GlyphAdjustmentRecord m_SecondAdjustmentRecord;
		[SerializeField]
		internal FontFeatureLookupFlags m_FeatureLookupFlags;
	}
}
