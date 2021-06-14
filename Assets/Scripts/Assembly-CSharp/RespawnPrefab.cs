using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200007C RID: 124
public class RespawnPrefab : MonoBehaviour
{
	// Token: 0x17000022 RID: 34
	// (get) Token: 0x060002B4 RID: 692 RVA: 0x00003FB4 File Offset: 0x000021B4
	// (set) Token: 0x060002B5 RID: 693 RVA: 0x00003FBC File Offset: 0x000021BC
	public int playerId { get; set; }

	// Token: 0x060002B6 RID: 694 RVA: 0x00003FC5 File Offset: 0x000021C5
	public void Set(int id, bool active, string username)
	{
		this.playerId = id;
		this.overlay.gameObject.SetActive(!active);
		this.button.enabled = active;
		this.nameText.text = username;
	}

	// Token: 0x060002B7 RID: 695 RVA: 0x00003FFA File Offset: 0x000021FA
	public void RespawnPlayer()
	{
		Debug.LogError("requesting revive");
		RespawnTotemUI.Instance.RequestRevive(this.playerId);
	}

	// Token: 0x040002C9 RID: 713
	public RawImage overlay;

	// Token: 0x040002CA RID: 714
	public Button button;

	// Token: 0x040002CB RID: 715
	public TextMeshProUGUI nameText;
}
