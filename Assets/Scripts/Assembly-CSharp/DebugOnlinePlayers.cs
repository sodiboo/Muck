using System;
using UnityEngine;

public class DebugOnlinePlayers : MonoBehaviour
{
	private void Start()
	{
		GameManager.instance.SpawnPlayer(2, "a", Color.black, new Vector3(0f, 30f, 0f), 50f);
		GameManager.instance.SpawnPlayer(3, "b", Color.black, new Vector3(5f, 30f, 2f), 150f);
	}
}
