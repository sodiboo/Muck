using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.AI
{
	public class NavMeshModifier : MonoBehaviour
	{
		[SerializeField]
		private bool m_OverrideArea;
		[SerializeField]
		private int m_Area;
		[SerializeField]
		private bool m_IgnoreFromBuild;
		[SerializeField]
		private List<int> m_AffectedAgents;
	}
}
