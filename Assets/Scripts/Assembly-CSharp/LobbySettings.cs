using System;
using TMPro;
using UnityEngine;

public class LobbySettings : MonoBehaviour
{
    public UiSettings difficultySetting;

    public UiSettings friendlyFireSetting;

    public UiSettings gamemodeSetting;

    public TMP_InputField seed;

    public GameObject startButton;

    public static LobbySettings Instance;

    private void Awake()
    {
        Instance = this;
    }

    private void Start()
    {
        difficultySetting.AddSettings(1, Enum.GetNames(typeof(GameSettings.Difficulty)));
        friendlyFireSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.FriendlyFire)));
        gamemodeSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.GameMode)));
    }
}
