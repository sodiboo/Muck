using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.TextCore;
using UnityEngine.UI;

namespace TMPro
{
	// Token: 0x02000070 RID: 112
	[DisallowMultipleComponent]
	[RequireComponent(typeof(RectTransform))]
	[RequireComponent(typeof(CanvasRenderer))]
	[ExecuteAlways]
	[HelpURL("https://docs.unity3d.com/Packages/com.unity.textmeshpro@2.1")]
	public class TextFuckPro : TMP_Text, ILayoutElement
	{
		// Token: 0x0600055B RID: 1371 RVA: 0x0002EA38 File Offset: 0x0002CC38
		protected override void Awake()
		{
		}

		// Token: 0x06000585 RID: 1413 RVA: 0x00002803 File Offset: 0x00000A03
		public void CalculateLayoutInputHorizontal()
		{
		}

		// Token: 0x06000586 RID: 1414 RVA: 0x00002803 File Offset: 0x00000A03
		public void CalculateLayoutInputVertical()
		{
		}

		// Token: 0x14000005 RID: 5
		// (add) Token: 0x0600059C RID: 1436 RVA: 0x0003854C File Offset: 0x0003674C
		// (remove) Token: 0x0600059D RID: 1437 RVA: 0x00038584 File Offset: 0x00036784
		public event Action<TMP_TextInfo> OnPreRenderText;

		// Token: 0x04000500 RID: 1280
		[SerializeField]
		private bool m_hasFontAssetChanged;

		// Token: 0x04000501 RID: 1281
		protected TMP_SubMeshUI[] m_subTextObjects = new TMP_SubMeshUI[8];

		// Token: 0x04000508 RID: 1288
		[SerializeField]
		private Material m_baseMaterial;

		// Token: 0x0400050A RID: 1290
		[SerializeField]
		private Vector4 m_maskOffset;
	}
}
