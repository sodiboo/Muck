
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000006 RID: 6
public class BossUI : MonoBehaviour
{
	// Token: 0x06000011 RID: 17 RVA: 0x000024FF File Offset: 0x000006FF
	private void Awake()
	{
		BossUI.Instance = this;
		this.layout.transform.localScale = Vector3.zero;
		this.desiredScale = Vector3.zero;
	}

	// Token: 0x06000012 RID: 18 RVA: 0x00002528 File Offset: 0x00000728
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
		textMeshProUGUI2.text += this.currentBoss.mobType.name;
		this.currentHp = 0f;
		this.desiredScale = Vector3.one;
		this.hitableMob = b.GetComponent<HitableMob>();
		this.layout.gameObject.SetActive(true);
		this.layout.localScale = Vector3.zero;
	}

	// Token: 0x06000013 RID: 19 RVA: 0x000025E8 File Offset: 0x000007E8
	private void Update()
	{
		if (this.currentBoss == null)
		{
			if (this.layout.gameObject.activeInHierarchy)
			{
				this.layout.gameObject.SetActive(false);
				if (DayCycle.time < 0.5f)
				{
					MusicController.Instance.StopSong();
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

	// Token: 0x04000010 RID: 16
	public TextMeshProUGUI bossName;

	// Token: 0x04000011 RID: 17
	public TextMeshProUGUI hpText;

	// Token: 0x04000012 RID: 18
	public RawImage hpBar;

	// Token: 0x04000013 RID: 19
	public Mob currentBoss;

	// Token: 0x04000014 RID: 20
	private HitableMob hitableMob;

	// Token: 0x04000015 RID: 21
	private int desiredHp;

	// Token: 0x04000016 RID: 22
	public Transform layout;

	// Token: 0x04000017 RID: 23
	private Vector3 desiredScale;

	// Token: 0x04000018 RID: 24
	public static BossUI Instance;

	// Token: 0x04000019 RID: 25
	private float currentHp;
}
