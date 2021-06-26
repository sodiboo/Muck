using UnityEngine;

namespace UnityEngine.AI
{
	public class NavMeshLink : MonoBehaviour
	{
		[SerializeField]
		private int m_AgentTypeID;
		[SerializeField]
		private Vector3 m_StartPoint;
		[SerializeField]
		private Vector3 m_EndPoint;
		[SerializeField]
		private float m_Width;
		[SerializeField]
		private int m_CostModifier;
		[SerializeField]
		private bool m_Bidirectional;
		[SerializeField]
		private bool m_AutoUpdatePosition;
		[SerializeField]
		private int m_Area;
	}
}
