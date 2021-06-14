using System;
using TMPro;
using UnityEngine;

// Token: 0x02000030 RID: 48
public class GameoverUI : MonoBehaviour
{
	// Token: 0x06000109 RID: 265 RVA: 0x0000B874 File Offset: 0x00009A74
	private void Awake()
	{
		int winnerId = GameManager.instance.winnerId;
		if (winnerId == -2)
		{
			this.daysText.text = "Survived for " + GameManager.instance.currentDay + " days.";
			return;
		}
		if (winnerId == -1)
		{
			this.daysText.text = "Draw...";
			return;
		}
		string username = GameManager.players[winnerId].username;
		this.daysText.text = username + " won the game!";
	}

	// Token: 0x0400010F RID: 271
	public TextMeshProUGUI daysText;
}
