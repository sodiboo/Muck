using System;
using System.Collections;
using UnityEngine;

public class GenerateAllResources : MonoBehaviour
{
	private void Awake()
	{
		base.StartCoroutine(this.GenerateResources());
	}

	private IEnumerator GenerateResources()
	{
		for (int i = 0; i < this.spawnersFirst.Length; i++)
		{
			this.spawnersFirst[i].SetActive(true);
		}
		yield return 3000;
		for (int j = 0; j < this.spawners.Length; j++)
		{
			this.spawners[j].SetActive(true);
		}
		yield break;
	}

	public GameObject[] spawnersFirst;

	public GameObject[] spawners;

	public static int seedOffset;
}
