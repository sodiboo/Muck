using System;
using UnityEngine;

public class ShaderInteractor : MonoBehaviour
{
	private void Update()
	{
		Shader.SetGlobalVector("_PositionMoving", base.transform.position);
	}
}
