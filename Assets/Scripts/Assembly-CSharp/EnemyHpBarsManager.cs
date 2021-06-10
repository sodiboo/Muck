
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000021 RID: 33
public class EnemyHpBarsManager : MonoBehaviour
{
	// Token: 0x060000C3 RID: 195 RVA: 0x00005E1C File Offset: 0x0000401C
	private void Awake()
	{
		this.onMobs = new List<GameObject>();
		this.hpBars = new MobHpBar[this.nHpBars];
		for (int i = 0; i < this.nHpBars; i++)
		{
			this.hpBars[i] =Instantiate(this.hpBarPrefab).GetComponent<MobHpBar>();
			this.hpBars[i].gameObject.SetActive(false);
		}
	}

	// Token: 0x060000C4 RID: 196 RVA: 0x00005E84 File Offset: 0x00004084
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

	// Token: 0x060000C5 RID: 197 RVA: 0x00006010 File Offset: 0x00004210
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

	// Token: 0x040000C2 RID: 194
	public GameObject hpBarPrefab;

	// Token: 0x040000C3 RID: 195
	private int nHpBars = 5;

	// Token: 0x040000C4 RID: 196
	private MobHpBar[] hpBars;

	// Token: 0x040000C5 RID: 197
	private float[] distances;

	// Token: 0x040000C6 RID: 198
	private List<GameObject> onMobs;

	// Token: 0x040000C7 RID: 199
	private Transform camera;

	// Token: 0x040000C8 RID: 200
	public LayerMask whatIsEnemy;
}
