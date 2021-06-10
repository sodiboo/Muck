using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x02000056 RID: 86
	public sealed class PostProcessProfile2 : ScriptableObject
	{

		// Token: 0x0400015E RID: 350
		[Tooltip("A list of all settings currently stored in this profile.")]
		public List<PostProcessEffectSettings> settings = new List<PostProcessEffectSettings>();

		// Token: 0x0400015F RID: 351
		[NonSerialized]
		public bool isDirty = true;
	}
}
