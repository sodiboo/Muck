using System;
using UnityEngine;


public class GenerateAllResources : MonoBehaviour
{

	private void Awake()
	{
		for (int i = 0; i < this.spawners.Length; i++)
		{
			this.spawners[i].SetActive(true);
		}
	}


	public GameObject[] spawners;


	public static int seedOffset;
}
