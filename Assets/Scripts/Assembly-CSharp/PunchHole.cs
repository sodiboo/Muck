using System;
using UnityEngine;

public class PunchHole : MonoBehaviour
{
	private void Update()
	{
		RaycastHit raycastHit;
		if (Input.GetMouseButtonDown(0) && Physics.Raycast(base.transform.position, base.transform.forward, out raycastHit, 1000f, this.whatIsGround))
		{
			int triangleIndex = raycastHit.triangleIndex;
			this.ground = raycastHit.transform;
			int[] triangles = base.transform.GetComponent<MeshFilter>().mesh.triangles;
			Vector3[] vertices = base.transform.GetComponent<MeshFilter>().mesh.vertices;
			Vector3 vector = vertices[triangles[triangleIndex * 3]];
			Vector3 vector2 = vertices[triangles[triangleIndex * 3 + 1]];
			Vector3 vector3 = vertices[triangles[triangleIndex * 3 + 2]];
			float num = Vector3.Distance(vector, vector2);
			float num2 = Vector3.Distance(vector, vector3);
			float num3 = Vector3.Distance(vector2, vector3);
			Vector3 v;
			Vector3 v2;
			if (num > num2 && num > num3)
			{
				v = vector;
				v2 = vector2;
			}
			else if (num2 > num && num2 > num3)
			{
				v = vector;
				v2 = vector3;
			}
			else
			{
				v = vector2;
				v2 = vector3;
			}
			this.findVertex(v);
			this.findVertex(v2);
		}
	}

	private int findVertex(Vector3 v)
	{
		Vector3[] vertices = this.ground.GetComponent<MeshFilter>().mesh.vertices;
		for (int i = 0; i < vertices.Length; i++)
		{
			if (vertices[i] == v)
			{
				return i;
			}
		}
		return -1;
	}

	private int findTriangle(Vector3 v1, Vector3 v2, int notTriIndex)
	{
		int[] triangles = this.ground.GetComponent<MeshFilter>().mesh.triangles;
		Vector3[] vertices = base.transform.GetComponent<MeshFilter>().mesh.vertices;
		int i = 0;
		while (i < triangles.Length)
		{
			if (i / 3 != notTriIndex)
			{
				return -1;
			}
		}
		return -1;
	}

	public LayerMask whatIsGround;

	public Transform ground;
}
