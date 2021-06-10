
using TMPro;
using UnityEngine;

// Token: 0x02000028 RID: 40
public class GameoverUI : MonoBehaviour
{
	// Token: 0x060000F5 RID: 245 RVA: 0x00006F54 File Offset: 0x00005154
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

	// Token: 0x040000EC RID: 236
	public TextMeshProUGUI daysText;
}
