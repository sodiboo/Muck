using System;
using UnityEngine;

public class SpawnObjectTimed : MonoBehaviour
{
	private void Awake()
	{
		Invoke(nameof(SpawnObject), this.time);
	}

	private void SpawnObject()
	{
		Instantiate<GameObject>(this.objectToSpawn, base.transform.position, this.objectToSpawn.transform.rotation);
		Destroy(this);
	}

	public float time;

	public GameObject objectToSpawn;
}
