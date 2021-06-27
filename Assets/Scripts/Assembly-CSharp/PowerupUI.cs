using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200007D RID: 125
public class PowerupUI : MonoBehaviour
{
	// Token: 0x060002F4 RID: 756 RVA: 0x00010097 File Offset: 0x0000E297
	private void Awake()
	{
		PowerupUI.Instance = this;
		this.powerups = new Dictionary<int, GameObject>();
		this.gridLayout = base.GetComponent<GridLayout>();
	}

	// Token: 0x060002F5 RID: 757 RVA: 0x000100B8 File Offset: 0x0000E2B8
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

	// Token: 0x040002F5 RID: 757
	public GameObject uiPrefab;

	// Token: 0x040002F6 RID: 758
	private GridLayout gridLayout;

	// Token: 0x040002F7 RID: 759
	private Dictionary<int, GameObject> powerups;

	// Token: 0x040002F8 RID: 760
	public static PowerupUI Instance;
}
