using System;
using UnityEngine;

public class TestRotate : MonoBehaviour
{
	private void Update()
	{
		base.transform.Rotate(Vector3.right, 20f * Time.deltaTime);
	}
}
