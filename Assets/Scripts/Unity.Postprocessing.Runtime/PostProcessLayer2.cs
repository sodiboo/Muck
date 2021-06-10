using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Scripting;
using UnityEngine.XR;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000054 RID: 84
	[ExecuteAlways]
	[DisallowMultipleComponent]
	[ImageEffectAllowedInSceneView]
	[RequireComponent(typeof(Camera))]
	public sealed class PostProcessLayer2 : MonoBehaviour
	{
		// Token: 0x04000131 RID: 305
		public Transform volumeTrigger;

		// Token: 0x04000132 RID: 306
		public LayerMask volumeLayer;

		// Token: 0x04000133 RID: 307
		public bool stopNaNPropagation = true;

		// Token: 0x04000134 RID: 308
		public bool finalBlitToCameraTarget;

		// Token: 0x04000135 RID: 309
		public PostProcessLayer.Antialiasing antialiasingMode;

		// Token: 0x04000136 RID: 310
		public TemporalAntialiasing temporalAntialiasing;

		// Token: 0x04000137 RID: 311
		public SubpixelMorphologicalAntialiasing subpixelMorphologicalAntialiasing;

		// Token: 0x04000138 RID: 312
		public FastApproximateAntialiasing fastApproximateAntialiasing;

		// Token: 0x04000139 RID: 313
		public Fog fog;

		// Token: 0x0400013B RID: 315
		public PostProcessDebugLayer debugLayer;

		// Token: 0x0400013C RID: 316
		[SerializeField]
		private PostProcessResources m_Resources;

		// Token: 0x0400013D RID: 317
		[NonSerialized]
		private PostProcessResources m_OldResources;

		// Token: 0x0400013E RID: 318
		[Preserve]
		[SerializeField]
		private bool m_ShowToolkit;

		// Token: 0x0400013F RID: 319
		[Preserve]
		[SerializeField]
		private bool m_ShowCustomSorter;

		// Token: 0x04000140 RID: 320
		public bool breakBeforeColorGrading;

		// Token: 0x04000141 RID: 321
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_BeforeTransparentBundles;

		// Token: 0x04000142 RID: 322
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_BeforeStackBundles;

		// Token: 0x04000143 RID: 323
		[SerializeField]
		private List<PostProcessLayer.SerializedBundleRef> m_AfterStackBundles;

		// Token: 0x04000147 RID: 327
		private Dictionary<Type, PostProcessBundle> m_Bundles;

		// Token: 0x04000148 RID: 328
		private PropertySheetFactory m_PropertySheetFactory;

		// Token: 0x04000149 RID: 329
		private CommandBuffer m_LegacyCmdBufferBeforeReflections;

		// Token: 0x0400014A RID: 330
		private CommandBuffer m_LegacyCmdBufferBeforeLighting;

		// Token: 0x0400014B RID: 331
		private CommandBuffer m_LegacyCmdBufferOpaque;

		// Token: 0x0400014C RID: 332
		private CommandBuffer m_LegacyCmdBuffer;

		// Token: 0x0400014D RID: 333
		private Camera m_Camera;

		// Token: 0x0400014E RID: 334
		private PostProcessRenderContext m_CurrentContext;

		// Token: 0x04000150 RID: 336
		private bool m_SettingsUpdateNeeded = true;

		// Token: 0x04000151 RID: 337
		private bool m_IsRenderingInSceneView;

		// Token: 0x04000153 RID: 339
		private bool m_NaNKilled;

		// Token: 0x04000154 RID: 340
		private readonly List<PostProcessEffectRenderer> m_ActiveEffects = new List<PostProcessEffectRenderer>();

		// Token: 0x04000155 RID: 341
		private readonly List<RenderTargetIdentifier> m_Targets = new List<RenderTargetIdentifier>();

		// Token: 0x02000079 RID: 121
		public enum Antialiasing
		{
			// Token: 0x040002A6 RID: 678
			None,
			// Token: 0x040002A7 RID: 679
			FastApproximateAntialiasing,
			// Token: 0x040002A8 RID: 680
			SubpixelMorphologicalAntialiasing,
			// Token: 0x040002A9 RID: 681
			TemporalAntialiasing
		}

		// Token: 0x0200007A RID: 122
		[Serializable]
		public sealed class SerializedBundleRef
		{
			// Token: 0x040002AA RID: 682
			public string assemblyQualifiedName;

			// Token: 0x040002AB RID: 683
			public PostProcessBundle bundle;
		}
	}
}
