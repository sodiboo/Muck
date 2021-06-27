using System;
using UnityEngine;
using UnityEngine.UI;

public class MobHpBar : MonoBehaviour
{
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

	public void RemoveMob()
	{
		base.gameObject.SetActive(false);
		this.buffIcon.SetActive(false);
		this.attachedObject = null;
		this.mob = null;
	}

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

	public GameObject attachedObject;

	private HitableMob mob;

	private Vector3 offsetPos;

	public GameObject buffIcon;

	public Image hpBar;
}
