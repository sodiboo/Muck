using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002F RID: 47
public class EnemyHpBarsManager : MonoBehaviour
{
	// Token: 0x06000115 RID: 277 RVA: 0x00007290 File Offset: 0x00005490
	private void Awake()
	{
		this.onMobs = new List<GameObject>();
		this.hpBars = new MobHpBar[this.nHpBars];
		for (int i = 0; i < this.nHpBars; i++)
		{
			this.hpBars[i] = Instantiate<GameObject>(this.hpBarPrefab).GetComponent<MobHpBar>();
			this.hpBars[i].gameObject.SetActive(false);
		}
	}

	// Token: 0x06000116 RID: 278 RVA: 0x000072F8 File Offset: 0x000054F8
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

	// Token: 0x06000117 RID: 279 RVA: 0x00007484 File Offset: 0x00005684
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

	// Token: 0x0400011C RID: 284
	public GameObject hpBarPrefab;

	// Token: 0x0400011D RID: 285
	private int nHpBars = 5;

	// Token: 0x0400011E RID: 286
	private MobHpBar[] hpBars;

	// Token: 0x0400011F RID: 287
	private float[] distances;

	// Token: 0x04000120 RID: 288
	private List<GameObject> onMobs;

	// Token: 0x04000121 RID: 289
	private Transform camera;

	// Token: 0x04000122 RID: 290
	public LayerMask whatIsEnemy;
}
