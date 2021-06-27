using System;
using UnityEngine;

public class SpawnEffect : MonoBehaviour
{
	private void Awake()
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < this.maxPlayerDistance)
		{
			Instantiate<GameObject>(this.spawnEffect, base.transform.position, Quaternion.identity).GetComponent<AudioSource>().maxDistance = this.maxPlayerDistance;
		}
		Destroy(this);
	}

	public GameObject spawnEffect;

	public float maxPlayerDistance = 40f;
}
