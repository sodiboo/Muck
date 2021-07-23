using System;
using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class TimelineClip
	{
		public enum BlendCurveMode
		{
			Auto = 0,
			Manual = 1,
		}

		public enum ClipExtrapolation
		{
			None = 0,
			Hold = 1,
			Loop = 2,
			PingPong = 3,
			Continue = 4,
		}

		internal TimelineClip(TrackAsset parent)
		{
		}

		[SerializeField]
		private int m_Version;
		[SerializeField]
		private double m_Start;
		[SerializeField]
		private double m_ClipIn;
		[SerializeField]
		private Object m_Asset;
		[SerializeField]
		private double m_Duration;
		[SerializeField]
		private double m_TimeScale;
		[SerializeField]
		private TrackAsset m_ParentTrack;
		[SerializeField]
		private double m_EaseInDuration;
		[SerializeField]
		private double m_EaseOutDuration;
		[SerializeField]
		private double m_BlendInDuration;
		[SerializeField]
		private double m_BlendOutDuration;
		[SerializeField]
		private AnimationCurve m_MixInCurve;
		[SerializeField]
		private AnimationCurve m_MixOutCurve;
		[SerializeField]
		private BlendCurveMode m_BlendInCurveMode;
		[SerializeField]
		private BlendCurveMode m_BlendOutCurveMode;
		[SerializeField]
		private List<string> m_ExposedParameterNames;
		[SerializeField]
		private AnimationClip m_AnimationCurves;
		[SerializeField]
		private bool m_Recordable;
		[SerializeField]
		private ClipExtrapolation m_PostExtrapolationMode;
		[SerializeField]
		private ClipExtrapolation m_PreExtrapolationMode;
		[SerializeField]
		private double m_PostExtrapolationTime;
		[SerializeField]
		private double m_PreExtrapolationTime;
		[SerializeField]
		private string m_DisplayName;
	}
}
