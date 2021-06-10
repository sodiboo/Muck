
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000049 RID: 73
public class MobHpBar : MonoBehaviour
{
	// Token: 0x060001A2 RID: 418 RVA: 0x0000A360 File Offset: 0x00008560
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

	// Token: 0x060001A3 RID: 419 RVA: 0x0000A472 File Offset: 0x00008672
	public void RemoveMob()
	{
		base.gameObject.SetActive(false);
		this.buffIcon.SetActive(false);
		this.attachedObject = null;
		this.mob = null;
	}

	// Token: 0x060001A4 RID: 420 RVA: 0x0000A49C File Offset: 0x0000869C
	private void Update()
	{
		if (!this.mob)
		{
			base.gameObject.SetActive(false);
			return;
		}
		base.transform.position = this.mob.transform.position + this.offsetPos;
		float x = (float)this.mob.hp / (float)this.mob.maxHp;
		Vector3 b = new Vector3(x, 1f, 1f);
		this.hpBar.transform.localScale = Vector3.Lerp(this.hpBar.transform.localScale, b, Time.deltaTime * 10f);
	}

	// Token: 0x040001A2 RID: 418
	public GameObject attachedObject;

	// Token: 0x040001A3 RID: 419
	private HitableMob mob;

	// Token: 0x040001A4 RID: 420
	private Vector3 offsetPos;

	// Token: 0x040001A5 RID: 421
	public GameObject buffIcon;

	// Token: 0x040001A6 RID: 422
	public Image hpBar;
}
