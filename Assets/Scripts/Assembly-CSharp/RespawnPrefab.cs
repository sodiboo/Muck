
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000067 RID: 103
public class RespawnPrefab : MonoBehaviour
{
	// Token: 0x1700001E RID: 30
	// (get) Token: 0x0600027F RID: 639 RVA: 0x0000DD6E File Offset: 0x0000BF6E
	// (set) Token: 0x06000280 RID: 640 RVA: 0x0000DD76 File Offset: 0x0000BF76
	public int playerId { get; set; }

	// Token: 0x06000281 RID: 641 RVA: 0x0000DD7F File Offset: 0x0000BF7F
	public void Set(int id, bool active, string username)
	{
		this.playerId = id;
		this.overlay.gameObject.SetActive(!active);
		this.button.enabled = active;
		this.nameText.text = username;
	}

	// Token: 0x06000282 RID: 642 RVA: 0x0000DDB4 File Offset: 0x0000BFB4
	public void RespawnPlayer()
	{
		Debug.LogError("requesting revive");
		RespawnTotemUI.Instance.RequestRevive(this.playerId);
	}

	// Token: 0x0400026B RID: 619
	public RawImage overlay;

	// Token: 0x0400026C RID: 620
	public Button button;

	// Token: 0x0400026D RID: 621
	public TextMeshProUGUI nameText;
}
