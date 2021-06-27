using System;
using TMPro;
using UnityEngine;

// Token: 0x0200005E RID: 94
public class LobbySettings : MonoBehaviour
{
	// Token: 0x0600021F RID: 543 RVA: 0x0000CE70 File Offset: 0x0000B070
	private void Awake()
	{
		LobbySettings.Instance = this;
	}

	// Token: 0x06000220 RID: 544 RVA: 0x0000CE78 File Offset: 0x0000B078
	private void Start()
	{
		this.difficultySetting.AddSettings(1, Enum.GetNames(typeof(GameSettings.Difficulty)));
		this.friendlyFireSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.FriendlyFire)));
		this.gamemodeSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.GameMode)));
	}

	// Token: 0x0400023F RID: 575
	public UiSettings difficultySetting;

	// Token: 0x04000240 RID: 576
	public UiSettings friendlyFireSetting;

	// Token: 0x04000241 RID: 577
	public UiSettings gamemodeSetting;

	// Token: 0x04000242 RID: 578
	public TMP_InputField seed;

	// Token: 0x04000243 RID: 579
	public GameObject startButton;

	// Token: 0x04000244 RID: 580
	public static LobbySettings Instance;
}
