using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200002A RID: 42
public class ExtraUI : MonoBehaviour
{
	// Token: 0x060000DD RID: 221 RVA: 0x00002C05 File Offset: 0x00000E05
	private void Awake()
	{
		this.IdToHpBar = new Dictionary<int, RawImage>();
		base.InvokeRepeating("SlowUpdate", 0f, 1f);
	}

	// Token: 0x060000DE RID: 222 RVA: 0x00002C27 File Offset: 0x00000E27
	private void SlowUpdate()
	{
		this.UpdateClock();
		this.UpdateMoney();
		this.UpdateAllHpBars();
	}

	// Token: 0x060000DF RID: 223 RVA: 0x0000A9F8 File Offset: 0x00008BF8
	public void InitPlayerStatus(int id, string name)
	{
		GameObject gameObject =Instantiate<GameObject>(this.playerStatusPrefab, this.playerStatusParent);
		RawImage component = gameObject.transform.GetChild(1).GetChild(1).GetChild(0).GetComponent<RawImage>();
		this.IdToHpBar.Add(id, component);
		Vector2 sizeDelta = this.playerStatusParent.sizeDelta;
		sizeDelta.y += 40f;
		this.playerStatusParent.sizeDelta = sizeDelta;
		gameObject.transform.GetComponentInChildren<TextMeshProUGUI>().text = name;
	}

	// Token: 0x060000E0 RID: 224 RVA: 0x00002C3B File Offset: 0x00000E3B
	private void UpdateClock()
	{
		this.clockText.text = this.TimeToClock();
	}

	// Token: 0x060000E1 RID: 225 RVA: 0x00002C4E File Offset: 0x00000E4E
	private void UpdateMoney()
	{
		this.money.text = string.Concat(InventoryUI.Instance.GetMoney());
	}

	// Token: 0x060000E2 RID: 226 RVA: 0x0000AA7C File Offset: 0x00008C7C
	private void UpdateAllHpBars()
	{
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (!(playerManager == null))
			{
				this.UpdatePlayerHp(playerManager.id);
			}
		}
	}

	// Token: 0x060000E3 RID: 227 RVA: 0x00002C6F File Offset: 0x00000E6F
	public void UpdateDay(int day)
	{
		this.dayText.text = string.Concat(day);
	}

	// Token: 0x060000E4 RID: 228 RVA: 0x0000AAE4 File Offset: 0x00008CE4
	private void UpdatePlayerHp(int id)
	{
		if (!this.IdToHpBar.ContainsKey(id))
		{
			return;
		}
		Component component = this.IdToHpBar[id];
		float num = 0f;
		if (id == LocalClient.instance.myId)
		{
			num = (float)PlayerStatus.Instance.HpAndShield() / (float)PlayerStatus.Instance.MaxHpAndShield();
		}
		else if (GameManager.players[id] != null)
		{
			num = GameManager.players[id].onlinePlayer.hpRatio;
			num = Mathf.Clamp(num, 0f, 1f);
			if (GameManager.players[id].dead || GameManager.players[id].disconnected)
			{
				num = 0f;
			}
		}
		component.transform.localScale = new Vector3(num, 1f, 1f);
	}

	// Token: 0x060000E5 RID: 229 RVA: 0x0000ABB8 File Offset: 0x00008DB8
	private string TimeToClock()
	{
		float time = DayCycle.time;
		int num = (12 + (int)(time * 24f)) % 24;
		string arg = "00";
		return num + ":" + arg;
	}

	// Token: 0x040000E5 RID: 229
	public TextMeshProUGUI money;

	// Token: 0x040000E6 RID: 230
	public TextMeshProUGUI clockText;

	// Token: 0x040000E7 RID: 231
	public TextMeshProUGUI dayText;

	// Token: 0x040000E8 RID: 232
	private Dictionary<int, RawImage> IdToHpBar;

	// Token: 0x040000E9 RID: 233
	public GameObject playerStatusPrefab;

	// Token: 0x040000EA RID: 234
	public RectTransform playerStatusParent;
}
