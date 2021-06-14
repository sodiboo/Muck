using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200006E RID: 110
public class PowerupUI : MonoBehaviour
{
	// Token: 0x06000267 RID: 615 RVA: 0x00003D18 File Offset: 0x00001F18
	private void Awake()
	{
		PowerupUI.Instance = this;
		this.powerups = new Dictionary<int, GameObject>();
		this.gridLayout = base.GetComponent<GridLayout>();
	}

	// Token: 0x06000268 RID: 616 RVA: 0x000107D4 File Offset: 0x0000E9D4
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
		GameObject gameObject =Instantiate<GameObject>(this.uiPrefab, base.transform);
		Powerup powerup = ItemManager.Instance.allPowerups[powerupId];
		gameObject.GetComponent<Image>().sprite = powerup.sprite;
		gameObject.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = string.Concat(1);
		gameObject.GetComponent<PowerupInfo>().powerup = powerup;
		this.powerups.Add(powerupId, gameObject);
	}

	// Token: 0x04000271 RID: 625
	public GameObject uiPrefab;

	// Token: 0x04000272 RID: 626
	private GridLayout gridLayout;

	// Token: 0x04000273 RID: 627
	private Dictionary<int, GameObject> powerups;

	// Token: 0x04000274 RID: 628
	public static PowerupUI Instance;
}
