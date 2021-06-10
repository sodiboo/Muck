using System;
using TMPro;
using UnityEngine;

// Token: 0x02000042 RID: 66
public class LobbySettings : MonoBehaviour
{
	// Token: 0x06000182 RID: 386 RVA: 0x00009D68 File Offset: 0x00007F68
	private void Awake()
	{
		LobbySettings.Instance = this;
	}

	// Token: 0x06000183 RID: 387 RVA: 0x00009D70 File Offset: 0x00007F70
	private void Start()
	{
		this.difficultySetting.AddSettings(1, Enum.GetNames(typeof(GameSettings.Difficulty)));
		this.friendlyFireSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.FriendlyFire)));
		this.gamemodeSetting.AddSettings(0, Enum.GetNames(typeof(GameSettings.GameMode)));
	}

	// Token: 0x04000187 RID: 391
	public UiSettings difficultySetting;

	// Token: 0x04000188 RID: 392
	public UiSettings friendlyFireSetting;

	// Token: 0x04000189 RID: 393
	public UiSettings gamemodeSetting;

	// Token: 0x0400018A RID: 394
	public TMP_InputField seed;

	// Token: 0x0400018B RID: 395
	public GameObject startButton;

	// Token: 0x0400018C RID: 396
	public static LobbySettings Instance;
}
