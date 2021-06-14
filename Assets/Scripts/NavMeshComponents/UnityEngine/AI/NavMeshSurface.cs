using UnityEngine;

namespace UnityEngine.AI
{
	public class NavMeshSurface : MonoBehaviour
	{
		[SerializeField]
		private int m_AgentTypeID;
		[SerializeField]
		private CollectObjects m_CollectObjects;
		[SerializeField]
		private Vector3 m_Size;
		[SerializeField]
		private Vector3 m_Center;
		[SerializeField]
		private LayerMask m_LayerMask;
		[SerializeField]
		private NavMeshCollectGeometry m_UseGeometry;
		[SerializeField]
		private int m_DefaultArea;
		[SerializeField]
		private bool m_IgnoreNavMeshAgent;
		[SerializeField]
		private bool m_IgnoreNavMeshObstacle;
		[SerializeField]
		private bool m_OverrideTileSize;
		[SerializeField]
		private int m_TileSize;
		[SerializeField]
		private bool m_OverrideVoxelSize;
		[SerializeField]
		private float m_VoxelSize;
		[SerializeField]
		private bool m_BuildHeightMesh;
		[SerializeField]
		private NavMeshData m_NavMeshData;
	}
}
