using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000065 RID: 101
public class MobHpBar : MonoBehaviour
{
	// Token: 0x06000240 RID: 576 RVA: 0x0000D4B8 File Offset: 0x0000B6B8
	public void SetMob(GameObject mob)
	{
		this.buffIcon.SetActive(false);
		base.gameObject.SetActive(true);
		this.attachedObject = mob;
		Bounds bounds = mob.GetComponent<Collider>().bounds;
		this.mob = mob.transform.root.GetComponent<HitableMob>();
		new Vector3((float)this.mob.hp / (float)this.mob.maxHp, 1f, 1f);
		Vector3 b = bounds.center - mob.transform.position;
		this.offsetPos = new Vector3(0f, bounds.extents.y + 0.5f, 0f) + b;
		SendToBossUi component = mob.transform.root.GetComponent<SendToBossUi>();
		if (component)
		{
			BossUI.Instance.SetBoss(component.GetComponent<Mob>());
		}
		Mob component2 = mob.transform.root.GetComponent<Mob>();
		if (component2 && component2.IsBuff())
		{
			this.buffIcon.SetActive(true);
		}
	}

	// Token: 0x06000241 RID: 577 RVA: 0x0000D5CA File Offset: 0x0000B7CA
	public void RemoveMob()
	{
		base.gameObject.SetActive(false);
		this.buffIcon.SetActive(false);
		this.attachedObject = null;
		this.mob = null;
	}

	// Token: 0x06000242 RID: 578 RVA: 0x0000D5F4 File Offset: 0x0000B7F4
	private void Update()
	{
		if (!this.mob)
		{
			base.gameObject.SetActive(false);
			return;
		}
		base.transform.position = this.attachedObject.transform.position + this.offsetPos;
		float x = (float)this.mob.hp / (float)this.mob.maxHp;
		Vector3 b = new Vector3(x, 1f, 1f);
		this.hpBar.transform.localScale = Vector3.Lerp(this.hpBar.transform.localScale, b, Time.deltaTime * 10f);
	}

	// Token: 0x0400025B RID: 603
	public GameObject attachedObject;

	// Token: 0x0400025C RID: 604
	private HitableMob mob;

	// Token: 0x0400025D RID: 605
	private Vector3 offsetPos;

	// Token: 0x0400025E RID: 606
	public GameObject buffIcon;

	// Token: 0x0400025F RID: 607
	public Image hpBar;
}
