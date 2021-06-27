using System;
using UnityEngine;

public class NavmeshTest : MonoBehaviour
{
	private void OnDrawGizmos()
	{
		base.GetComponentInChildren<Renderer>();
		Gizmos.color = Color.red;
		Bounds bounds = base.GetComponent<BoxCollider>().bounds;
		Gizmos.DrawWireCube(bounds.center, bounds.size);
	}
}
