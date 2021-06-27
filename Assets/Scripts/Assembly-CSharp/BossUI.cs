using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000009 RID: 9
public class BossUI : MonoBehaviour
{
	// Token: 0x0600003D RID: 61 RVA: 0x000033A6 File Offset: 0x000015A6
	private void Awake()
	{
		BossUI.Instance = this;
		this.layout.transform.localScale = Vector3.zero;
		this.desiredScale = Vector3.zero;
	}

	// Token: 0x0600003E RID: 62 RVA: 0x000033D0 File Offset: 0x000015D0
	public void SetBoss(Mob b)
	{
		if (this.currentBoss != null)
		{
			return;
		}
		this.currentBoss = b;
		this.bossName.text = "";
		if (b.IsBuff())
		{
			TextMeshProUGUI textMeshProUGUI = this.bossName;
			textMeshProUGUI.text += "Buff ";
		}
		TextMeshProUGUI textMeshProUGUI2 = this.bossName;
		textMeshProUGUI2.text += b.GetComponent<Hitable>().entityName;
		Debug.LogError("hitavle entity name: " + b.GetComponent<Hitable>().entityName);
		this.currentHp = 0f;
		this.desiredScale = Vector3.one;
		this.hitableMob = b.GetComponent<HitableMob>();
		this.layout.gameObject.SetActive(true);
		this.layout.localScale = Vector3.zero;
	}

	// Token: 0x0600003F RID: 63 RVA: 0x000034A4 File Offset: 0x000016A4
	private void Update()
	{
		if (this.currentBoss == null)
		{
			if (this.layout.gameObject.activeInHierarchy)
			{
				this.layout.gameObject.SetActive(false);
				if (DayCycle.time < 0.5f)
				{
					MusicController.Instance.StopSong(-1f);
				}
			}
			return;
		}
		this.currentHp = Mathf.Lerp(this.currentHp, (float)this.hitableMob.hp, Time.deltaTime * 10f);
		this.hpText.text = Mathf.RoundToInt(this.currentHp) + " / " + this.hitableMob.maxHp;
		float x = (float)this.hitableMob.hp / (float)this.hitableMob.maxHp;
		this.hpBar.transform.localScale = new Vector3(x, 1f, 1f);
		this.layout.transform.localScale = Vector3.Lerp(this.layout.transform.localScale, this.desiredScale, Time.deltaTime * 10f);
	}

	// Token: 0x04000038 RID: 56
	public TextMeshProUGUI bossName;

	// Token: 0x04000039 RID: 57
	public TextMeshProUGUI hpText;

	// Token: 0x0400003A RID: 58
	public RawImage hpBar;

	// Token: 0x0400003B RID: 59
	public Mob currentBoss;

	// Token: 0x0400003C RID: 60
	private HitableMob hitableMob;

	// Token: 0x0400003D RID: 61
	private int desiredHp;

	// Token: 0x0400003E RID: 62
	public Transform layout;

	// Token: 0x0400003F RID: 63
	private Vector3 desiredScale;

	// Token: 0x04000040 RID: 64
	public static BossUI Instance;

	// Token: 0x04000041 RID: 65
	private float currentHp;
}
