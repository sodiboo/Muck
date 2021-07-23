using System;
using UnityEngine;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class Spline
	{
		public Spline(AnimationCurve curve, float zeroValue, bool loop, Vector2 bounds)
		{
		}

		public AnimationCurve curve;
		[SerializeField]
		private bool m_Loop;
		[SerializeField]
		private float m_ZeroValue;
		[SerializeField]
		private float m_Range;
		public float[] cachedData;
	}
}
