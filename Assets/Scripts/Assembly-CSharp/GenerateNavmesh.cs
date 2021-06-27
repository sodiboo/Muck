using System;
using UnityEngine;
using UnityEngine.AI;

public class GenerateNavmesh : MonoBehaviour
{
	public void GenerateNavMesh()
	{
		this.surface.BuildNavMesh();
	}

	public NavMeshSurface surface;
}
