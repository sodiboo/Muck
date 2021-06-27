using System;
using UnityEngine;

[ExecuteInEditMode]
public class MoveToPosition : MonoBehaviour
{
	public void LateUpdate()
	{
		base.transform.position = this.target.position;
	}

	public Transform target;
}
