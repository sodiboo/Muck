using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000032 RID: 50
public class ExtraUI : MonoBehaviour
{
	// Token: 0x06000123 RID: 291 RVA: 0x000076CD File Offset: 0x000058CD
	private void Awake()
	{
		this.IdToHpBar = new Dictionary<int, RawImage>();
		InvokeRepeating(nameof(SlowUpdate), 0f, 1f);
	}

	// Token: 0x06000124 RID: 292 RVA: 0x000076EF File Offset: 0x000058EF
	private void SlowUpdate()
	{
		this.UpdateClock();
		this.UpdateMoney();
		this.UpdateAllHpBars();
	}

	// Token: 0x06000125 RID: 293 RVA: 0x00007704 File Offset: 0x00005904
	public void InitPlayerStatus(int id, string name, PlayerManager pm)
	{
		GameObject gameObject = Instantiate<GameObject>(this.playerStatusPrefab, this.playerStatusParent);
		RawImage component = gameObject.transform.GetChild(1).GetChild(1).GetChild(0).GetComponent<RawImage>();
		this.IdToHpBar.Add(id, component);
		Vector2 sizeDelta = this.playerStatusParent.sizeDelta;
		sizeDelta.y += 40f;
		this.playerStatusParent.sizeDelta = sizeDelta;
		gameObject.transform.GetComponentInChildren<TextMeshProUGUI>().text = name;
		float scale = 0.85f;
		if (pm.id == LocalClient.instance.myId)
		{
			scale = 1f;
		}
		Map.Instance.AddMarker(pm.transform, Map.MarkerType.Player, null, Color.white, name, scale);
	}

	// Token: 0x06000126 RID: 294 RVA: 0x000077BD File Offset: 0x000059BD
	private void UpdateClock()
	{
		this.clockText.text = this.TimeToClock();
	}

	// Token: 0x06000127 RID: 295 RVA: 0x000077D0 File Offset: 0x000059D0
	private void UpdateMoney()
	{
		this.money.text = string.Concat(InventoryUI.Instance.GetMoney());
	}

	// Token: 0x06000128 RID: 296 RVA: 0x000077F4 File Offset: 0x000059F4
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

	// Token: 0x06000129 RID: 297 RVA: 0x0000785C File Offset: 0x00005A5C
	public void UpdateDay(int day)
	{
		this.dayText.text = string.Concat(day);
	}

	// Token: 0x0600012A RID: 298 RVA: 0x00007874 File Offset: 0x00005A74
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

	// Token: 0x0600012B RID: 299 RVA: 0x00007948 File Offset: 0x00005B48
	private string TimeToClock()
	{
		float time = DayCycle.time;
		int num = (12 + (int)(time * 24f)) % 24;
		string arg = "00";
		return num + ":" + arg;
	}

	// Token: 0x0400012B RID: 299
	public TextMeshProUGUI money;

	// Token: 0x0400012C RID: 300
	public TextMeshProUGUI clockText;

	// Token: 0x0400012D RID: 301
	public TextMeshProUGUI dayText;

	// Token: 0x0400012E RID: 302
	private Dictionary<int, RawImage> IdToHpBar;

	// Token: 0x0400012F RID: 303
	public GameObject playerStatusPrefab;

	// Token: 0x04000130 RID: 304
	public RectTransform playerStatusParent;
}
