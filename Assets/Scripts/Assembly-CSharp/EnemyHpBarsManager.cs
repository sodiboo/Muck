using System;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHpBarsManager : MonoBehaviour
{
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

	public GameObject hpBarPrefab;

	private int nHpBars = 5;

	private MobHpBar[] hpBars;

	private float[] distances;

	private List<GameObject> onMobs;

	private Transform camera;

	public LayerMask whatIsEnemy;
}
