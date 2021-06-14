using UnityEngine;
using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering.PostProcessing
{
	public class PostProcessLayer : MonoBehaviour
	{
		[Serializable]
		public class SerializedBundleRef
		{
			public string assemblyQualifiedName;
		}

		public enum Antialiasing
		{
			None = 0,
			FastApproximateAntialiasing = 1,
			SubpixelMorphologicalAntialiasing = 2,
			TemporalAntialiasing = 3,
		}

		public Transform volumeTrigger;
		public LayerMask volumeLayer;
		public bool stopNaNPropagation;
		public bool finalBlitToCameraTarget;
		public Antialiasing antialiasingMode;
		public TemporalAntialiasing temporalAntialiasing;
		public SubpixelMorphologicalAntialiasing subpixelMorphologicalAntialiasing;
		public FastApproximateAntialiasing fastApproximateAntialiasing;
		public Fog fog;
		public PostProcessDebugLayer debugLayer;
		[SerializeField]
		private PostProcessResources m_Resources;
		[SerializeField]
		private bool m_ShowToolkit;
		[SerializeField]
		private bool m_ShowCustomSorter;
		public bool breakBeforeColorGrading;
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_BeforeTransparentBundles;
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_BeforeStackBundles;
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_AfterStackBundles;
	}
}
