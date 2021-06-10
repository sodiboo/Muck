
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200005D RID: 93
public class PowerupUI : MonoBehaviour
{
	// Token: 0x06000237 RID: 567 RVA: 0x0000C2A8 File Offset: 0x0000A4A8
	private void Awake()
	{
		PowerupUI.Instance = this;
		this.powerups = new Dictionary<int, GameObject>();
		this.gridLayout = base.GetComponent<GridLayout>();
	}

	// Token: 0x06000238 RID: 568 RVA: 0x0000C2C8 File Offset: 0x0000A4C8
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
		GameObject gameObject =Instantiate(this.uiPrefab, base.transform);
		Powerup powerup = ItemManager.Instance.allPowerups[powerupId];
		gameObject.GetComponent<Image>().sprite = powerup.sprite;
		gameObject.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = string.Concat(1);
		gameObject.GetComponent<PowerupInfo>().powerup = powerup;
		this.powerups.Add(powerupId, gameObject);
	}

	// Token: 0x04000220 RID: 544
	public GameObject uiPrefab;

	// Token: 0x04000221 RID: 545
	private GridLayout gridLayout;

	// Token: 0x04000222 RID: 546
	private Dictionary<int, GameObject> powerups;

	// Token: 0x04000223 RID: 547
	public static PowerupUI Instance;
}
