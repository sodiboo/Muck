using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000089 RID: 137
public class RespawnPrefab : MonoBehaviour
{
	// Token: 0x17000028 RID: 40
	// (get) Token: 0x0600034D RID: 845 RVA: 0x000120A6 File Offset: 0x000102A6
	// (set) Token: 0x0600034E RID: 846 RVA: 0x000120AE File Offset: 0x000102AE
	public int playerId { get; set; }

	// Token: 0x0600034F RID: 847 RVA: 0x000120B7 File Offset: 0x000102B7
	public void Set(int id, bool active, string username)
	{
		this.playerId = id;
		this.overlay.gameObject.SetActive(!active);
		this.button.enabled = active;
		this.nameText.text = username;
	}

	// Token: 0x06000350 RID: 848 RVA: 0x000120EC File Offset: 0x000102EC
	public void RespawnPlayer()
	{
		Debug.LogError("requesting revive");
		RespawnTotemUI.Instance.RequestRevive(this.playerId);
	}

	// Token: 0x04000351 RID: 849
	public RawImage overlay;

	// Token: 0x04000352 RID: 850
	public Button button;

	// Token: 0x04000353 RID: 851
	public TextMeshProUGUI nameText;
}
