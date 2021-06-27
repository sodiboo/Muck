using System;
using UnityEngine;

public class World : MonoBehaviour
{
	private void Awake()
	{
		World.Instance = this;
	}

	public Transform worldMesh;

	public Transform water;

	public static World Instance;
}
