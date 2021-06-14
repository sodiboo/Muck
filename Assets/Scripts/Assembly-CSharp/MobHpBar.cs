using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000057 RID: 87
public class MobHpBar : MonoBehaviour
{
	// Token: 0x060001CB RID: 459 RVA: 0x0000ED08 File Offset: 0x0000CF08
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

	// Token: 0x060001CC RID: 460 RVA: 0x00003586 File Offset: 0x00001786
	public void RemoveMob()
	{
		base.gameObject.SetActive(false);
		this.buffIcon.SetActive(false);
		this.attachedObject = null;
		this.mob = null;
	}

	// Token: 0x060001CD RID: 461 RVA: 0x0000EE1C File Offset: 0x0000D01C
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

	// Token: 0x040001DE RID: 478
	public GameObject attachedObject;

	// Token: 0x040001DF RID: 479
	private HitableMob mob;

	// Token: 0x040001E0 RID: 480
	private Vector3 offsetPos;

	// Token: 0x040001E1 RID: 481
	public GameObject buffIcon;

	// Token: 0x040001E2 RID: 482
	public Image hpBar;
}
