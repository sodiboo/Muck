using System;
using UnityEngine;

[ExecuteInEditMode]
public class RotateParticles : MonoBehaviour
{
	private void Update()
	{
		base.transform.rotation = this.parent.rotation;
	}

	public Transform parent;
}
