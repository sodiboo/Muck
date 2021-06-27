using System;
using TMPro;
using UnityEngine;

public class LobbySettings : MonoBehaviour
{
	private void Awake()
	{
		LobbySettings.Instance = this;
	}

	private void Start()
	{
		this.difficultySetting.AddSettings(1, Enum.GetNames(typeof(GameSettings.Difficulty)));
		this.friendlyFireSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.FriendlyFire)));
		this.gamemodeSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.GameMode)));
	}

	public UiSettings difficultySetting;

	public UiSettings friendlyFireSetting;

	public UiSettings gamemodeSetting;

	public TMP_InputField seed;

	public GameObject startButton;

	public static LobbySettings Instance;
}
