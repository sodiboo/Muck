using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.AI
{
	public class NavMeshModifierVolume : MonoBehaviour
	{
		[SerializeField]
		private Vector3 m_Size;
		[SerializeField]
		private Vector3 m_Center;
		[SerializeField]
		private int m_Area;
		[SerializeField]
		private List<int> m_AffectedAgents;
	}
}
