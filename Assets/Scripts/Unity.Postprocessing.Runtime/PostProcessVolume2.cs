using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000059 RID: 89
	[ExecuteAlways]
	public sealed class PostProcessVolume2 : MonoBehaviour
	{

		// Token: 0x04000182 RID: 386
		public PostProcessProfile sharedProfile;

		// Token: 0x04000183 RID: 387
		[Tooltip("Check this box to mark this volume as global. This volume's Profile will be applied to the whole Scene.")]
		public bool isGlobal;

		// Token: 0x04000184 RID: 388
		[Min(0f)]
		[Tooltip("The distance (from the attached Collider) to start blending from. A value of 0 means there will be no blending and the Volume overrides will be applied immediatly upon entry to the attached Collider.")]
		public float blendDistance;

		// Token: 0x04000185 RID: 389
		[Range(0f, 1f)]
		[Tooltip("The total weight of this Volume in the Scene. A value of 0 signifies that it will have no effect, 1 signifies full effect.")]
		public float weight = 1f;

		// Token: 0x04000186 RID: 390
		[Tooltip("The volume priority in the stack. A higher value means higher priority. Negative values are supported.")]
		public float priority;

		// Token: 0x04000187 RID: 391
		private int m_PreviousLayer;

		// Token: 0x04000188 RID: 392
		private float m_PreviousPriority;

		// Token: 0x04000189 RID: 393
		private List<Collider> m_TempColliders;

		// Token: 0x0400018A RID: 394
		private PostProcessProfile m_InternalProfile;
	}
}
