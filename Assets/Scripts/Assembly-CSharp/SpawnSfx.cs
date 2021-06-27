using System;
using UnityEngine;

public class SpawnSfx : MonoBehaviour
{
	public void SpawnSound()
	{
		Instantiate<GameObject>(this.startCharge, this.pos.position, this.startCharge.transform.rotation);
	}

	public GameObject startCharge;

	public Transform pos;
}
