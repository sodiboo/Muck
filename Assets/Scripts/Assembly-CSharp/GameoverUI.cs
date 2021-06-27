using System;
using TMPro;
using UnityEngine;

// Token: 0x0200003A RID: 58
public class GameoverUI : MonoBehaviour
{
	// Token: 0x0600015E RID: 350 RVA: 0x000089A8 File Offset: 0x00006BA8
	private void Awake()
	{
		int winnerId = GameManager.instance.winnerId;
		if (winnerId == -3)
		{
			this.header.text = "Victory!";
			this.daysText.text = "<size=80%>Muck escaped after " + GameManager.instance.currentDay + " days!";
			return;
		}
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

	// Token: 0x04000155 RID: 341
	public TextMeshProUGUI daysText;

	// Token: 0x04000156 RID: 342
	public TextMeshProUGUI header;
}
