using System;
using UnityEngine;

public class DestroyObject : MonoBehaviour
{
	private void Start()
	{
		Invoke(nameof(DestroySelf), this.time);
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	public float time;
}
