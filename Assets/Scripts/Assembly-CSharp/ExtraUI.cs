using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;


public class ExtraUI : MonoBehaviour
{

	private void Awake()
	{
		this.IdToHpBar = new Dictionary<int, RawImage>();
		base.InvokeRepeating(nameof(SlowUpdate), 0f, 1f);
	}


	private void SlowUpdate()
	{
		this.UpdateClock();
		this.UpdateMoney();
		this.UpdateAllHpBars();
	}


	public void InitPlayerStatus(int id, string name)
	{
		GameObject gameObject = Instantiate<GameObject>(this.playerStatusPrefab, this.playerStatusParent);
		RawImage component = gameObject.transform.GetChild(1).GetChild(1).GetChild(0).GetComponent<RawImage>();
		this.IdToHpBar.Add(id, component);
		Vector2 sizeDelta = this.playerStatusParent.sizeDelta;
		sizeDelta.y += 40f;
		this.playerStatusParent.sizeDelta = sizeDelta;
		gameObject.transform.GetComponentInChildren<TextMeshProUGUI>().text = name;
	}


	private void UpdateClock()
	{
		this.clockText.text = this.TimeToClock();
	}


	private void UpdateMoney()
	{
		this.money.text = string.Concat(InventoryUI.Instance.GetMoney());
	}


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


	public void UpdateDay(int day)
	{
		this.dayText.text = string.Concat(day);
	}


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


	private string TimeToClock()
	{
		float time = DayCycle.time;
		int num = (12 + (int)(time * 24f)) % 24;
		string arg = "00";
		return num + ":" + arg;
	}


	public TextMeshProUGUI money;


	public TextMeshProUGUI clockText;


	public TextMeshProUGUI dayText;


	private Dictionary<int, RawImage> IdToHpBar;


	public GameObject playerStatusPrefab;


	public RectTransform playerStatusParent;
}
