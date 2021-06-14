using System;
using UnityEngine;


[ExecuteInEditMode]
public class BuildSnappingInfo : MonoBehaviour
{

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		foreach (Vector3 a in this.position)
		{
			Gizmos.DrawCube(base.transform.position + a * 1f, Vector3.one * 0.1f);
		}
	}


	public Vector3[] position;


	public bool half;
}
