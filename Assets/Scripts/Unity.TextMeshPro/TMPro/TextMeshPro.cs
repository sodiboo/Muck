using UnityEngine;

namespace TMPro
{
	public class TextMeshPro : TMP_Text
	{
		[SerializeField]
		private bool m_hasFontAssetChanged;
		[SerializeField]
		private Renderer m_renderer;
		[SerializeField]
		private MaskingTypes m_maskType;
		[SerializeField]
		internal int _SortingLayerID;
		[SerializeField]
		internal int _SortingOrder;
	}
}
