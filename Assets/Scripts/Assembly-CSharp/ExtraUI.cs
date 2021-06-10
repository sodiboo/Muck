
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000024 RID: 36
public class ExtraUI : MonoBehaviour
{
	// Token: 0x060000D1 RID: 209 RVA: 0x00006221 File Offset: 0x00004421
	private void Awake()
	{
		this.IdToHpBar = new Dictionary<int, RawImage>();
		base.InvokeRepeating("SlowUpdate", 0f, 1f);
	}

	// Token: 0x060000D2 RID: 210 RVA: 0x00006243 File Offset: 0x00004443
	private void SlowUpdate()
	{
		this.UpdateClock();
		this.UpdateMoney();
		this.UpdateAllHpBars();
	}

	// Token: 0x060000D3 RID: 211 RVA: 0x00006258 File Offset: 0x00004458
	public void InitPlayerStatus(int id, string name)
	{
		GameObject gameObject =Instantiate(this.playerStatusPrefab, this.playerStatusParent);
		RawImage component = gameObject.transform.GetChild(1).GetChild(1).GetChild(0).GetComponent<RawImage>();
		this.IdToHpBar.Add(id, component);
		Vector2 sizeDelta = this.playerStatusParent.sizeDelta;
		sizeDelta.y += 40f;
		this.playerStatusParent.sizeDelta = sizeDelta;
		gameObject.transform.GetComponentInChildren<TextMeshProUGUI>().text = name;
	}

	// Token: 0x060000D4 RID: 212 RVA: 0x000062D9 File Offset: 0x000044D9
	private void UpdateClock()
	{
		this.clockText.text = this.TimeToClock();
	}

	// Token: 0x060000D5 RID: 213 RVA: 0x000062EC File Offset: 0x000044EC
	private void UpdateMoney()
	{
		this.money.text = string.Concat(InventoryUI.Instance.GetMoney());
	}

	// Token: 0x060000D6 RID: 214 RVA: 0x00006310 File Offset: 0x00004510
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

	// Token: 0x060000D7 RID: 215 RVA: 0x00006378 File Offset: 0x00004578
	public void UpdateDay(int day)
	{
		this.dayText.text = string.Concat(day);
	}

	// Token: 0x060000D8 RID: 216 RVA: 0x00006390 File Offset: 0x00004590
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

	// Token: 0x060000D9 RID: 217 RVA: 0x00006464 File Offset: 0x00004664
	private string TimeToClock()
	{
		float time = DayCycle.time;
		int num = (12 + (int)(time * 24f)) % 24;
		string arg = "00";
		return num + ":" + arg;
	}

	// Token: 0x040000D0 RID: 208
	public TextMeshProUGUI money;

	// Token: 0x040000D1 RID: 209
	public TextMeshProUGUI clockText;

	// Token: 0x040000D2 RID: 210
	public TextMeshProUGUI dayText;

	// Token: 0x040000D3 RID: 211
	private Dictionary<int, RawImage> IdToHpBar;

	// Token: 0x040000D4 RID: 212
	public GameObject playerStatusPrefab;

	// Token: 0x040000D5 RID: 213
	public RectTransform playerStatusParent;
}
