using System;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

public class NetworkController : MonoBehaviour
{
	public bool loading { get; set; }

	private void Awake()
	{
		if (NetworkController.Instance)
		{
			Destroy(base.gameObject);
			return;
		}
		NetworkController.Instance = this;
		DontDestroyOnLoad(base.gameObject);
	}

	public void LoadGame(string[] names)
	{
		this.loading = true;
		this.playerNames = names;
		LoadingScreen.Instance.Show(1f);
		StartLoadingScene();
	}

	private void StartLoadingScene()
	{
		SceneManager.LoadScene("GameAfterLobby");
	}

	public NetworkController.NetworkType networkType;

	public GameObject steam;

	public GameObject classic;

	public Lobby lobby;

	public string[] playerNames;

	public static NetworkController Instance;

	public enum NetworkType
	{
		Steam,
		Classic
	}
}
