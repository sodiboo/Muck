using System;
using UnityEngine;

public class NetworkManager : MonoBehaviour
{
	public static float Clock { get; set; }

	public static float CountDown { get; set; }

	private void Update()
	{
		NetworkManager.Clock += Time.deltaTime;
	}

	public int GetSpawnPosition(int id)
	{
		return id;
	}

	private void Awake()
	{
		if (NetworkManager.instance == null)
		{
			NetworkManager.instance = this;
			return;
		}
		if (NetworkManager.instance != this)
		{
			Debug.Log("Instance already exists, destroying object");
			Destroy(this);
		}
	}

	private void Start()
	{
	}

	public void StartServer(int port)
	{
		Server.Start(40, port);
	}

	private void OnApplicationQuit()
	{
		Server.Stop();
	}

	public void DestroyPlayer(GameObject g)
	{
		Destroy(g);
	}

	public static NetworkManager instance;
}
