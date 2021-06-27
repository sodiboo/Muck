using System.Linq;
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


	public Vector3[] worldPos => position.Select(pos => transform.position + transform.rotation * pos).ToArray();


	public bool half;
}
