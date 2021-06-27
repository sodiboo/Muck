using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PowerupUI : MonoBehaviour
{
	private void Awake()
	{
		PowerupUI.Instance = this;
		this.powerups = new Dictionary<int, GameObject>();
		this.gridLayout = base.GetComponent<GridLayout>();
	}

	public void AddPowerup(int powerupId)
	{
		if (this.powerups.ContainsKey(powerupId))
		{
			TextMeshProUGUI componentInChildren = this.powerups[powerupId].GetComponentInChildren<TextMeshProUGUI>();
			int num = int.Parse(componentInChildren.text);
			num++;
			componentInChildren.text = string.Concat(num);
			return;
		}
		GameObject gameObject = Instantiate<GameObject>(this.uiPrefab, base.transform);
		Powerup powerup = ItemManager.Instance.allPowerups[powerupId];
		gameObject.GetComponent<Image>().sprite = powerup.sprite;
		gameObject.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = string.Concat(1);
		gameObject.GetComponent<PowerupInfo>().powerup = powerup;
		this.powerups.Add(powerupId, gameObject);
	}

	public GameObject uiPrefab;

	private GridLayout gridLayout;

	private Dictionary<int, GameObject> powerups;

	public static PowerupUI Instance;
}
