using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000027 RID: 39
public class EnemyHpBarsManager : MonoBehaviour
{
	// Token: 0x060000CF RID: 207 RVA: 0x0000A658 File Offset: 0x00008858
	private void Awake()
	{
		this.onMobs = new List<GameObject>();
		this.hpBars = new MobHpBar[this.nHpBars];
		for (int i = 0; i < this.nHpBars; i++)
		{
			this.hpBars[i] =Instantiate<GameObject>(this.hpBarPrefab).GetComponent<MobHpBar>();
			this.hpBars[i].gameObject.SetActive(false);
		}
	}

	// Token: 0x060000D0 RID: 208 RVA: 0x0000A6C0 File Offset: 0x000088C0
	private void Update()
	{
		if (!this.camera)
		{
			if (!PlayerMovement.Instance)
			{
				return;
			}
			this.camera = PlayerMovement.Instance.playerCam;
		}
		float radius = 4f;
		RaycastHit[] array = Physics.SphereCastAll(this.camera.position, radius, this.camera.forward, 100f, this.whatIsEnemy);
		for (int i = 0; i < this.hpBars.Length; i++)
		{
			if (this.hpBars[i].attachedObject != null)
			{
				bool flag = false;
				foreach (RaycastHit raycastHit in array)
				{
					if (raycastHit.transform.gameObject == this.hpBars[i].attachedObject)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					this.hpBars[i].RemoveMob();
				}
			}
		}
		foreach (RaycastHit hit in array)
		{
			if (!hit.transform.CompareTag("NoHpBar"))
			{
				bool flag2 = false;
				for (int k = 0; k < this.nHpBars; k++)
				{
					if (this.hpBars[k].attachedObject == hit.transform.gameObject)
					{
						flag2 = true;
						break;
					}
				}
				if (!flag2)
				{
					MobHpBar mobHpBar = this.FindAvailableHpBar(hit);
					if (!(mobHpBar == null))
					{
						mobHpBar.SetMob(hit.transform.gameObject);
					}
				}
			}
		}
	}

	// Token: 0x060000D1 RID: 209 RVA: 0x0000A84C File Offset: 0x00008A4C
	private MobHpBar FindAvailableHpBar(RaycastHit hit)
	{
		foreach (MobHpBar mobHpBar in this.hpBars)
		{
			if (!mobHpBar.gameObject.activeInHierarchy)
			{
				return mobHpBar;
			}
		}
		return null;
	}

	// Token: 0x040000D6 RID: 214
	public GameObject hpBarPrefab;

	// Token: 0x040000D7 RID: 215
	private int nHpBars = 5;

	// Token: 0x040000D8 RID: 216
	private MobHpBar[] hpBars;

	// Token: 0x040000D9 RID: 217
	private float[] distances;

	// Token: 0x040000DA RID: 218
	private List<GameObject> onMobs;

	// Token: 0x040000DB RID: 219
	private Transform camera;

	// Token: 0x040000DC RID: 220
	public LayerMask whatIsEnemy;
}
