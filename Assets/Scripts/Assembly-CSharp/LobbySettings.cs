using System;
using TMPro;
using UnityEngine;

// Token: 0x0200004F RID: 79
public class LobbySettings : MonoBehaviour
{
	// Token: 0x060001AA RID: 426 RVA: 0x00003410 File Offset: 0x00001610
	private void Awake()
	{
		LobbySettings.Instance = this;
	}

	// Token: 0x060001AB RID: 427 RVA: 0x0000E838 File Offset: 0x0000CA38
	private void Start()
	{
		this.difficultySetting.AddSettings(1, Enum.GetNames(typeof(GameSettings.Difficulty)));
		this.friendlyFireSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.FriendlyFire)));
		this.gamemodeSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.GameMode)));
	}

	// Token: 0x040001BC RID: 444
	public UiSettings difficultySetting;

	// Token: 0x040001BD RID: 445
	public UiSettings friendlyFireSetting;

	// Token: 0x040001BE RID: 446
	public UiSettings gamemodeSetting;

	// Token: 0x040001BF RID: 447
	public TMP_InputField seed;

	// Token: 0x040001C0 RID: 448
	public GameObject startButton;

	// Token: 0x040001C1 RID: 449
	public static LobbySettings Instance;
}
