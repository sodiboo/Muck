using System;
using UnityEngine;

public class Billboard : MonoBehaviour
{
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
	}

	private void Update()
	{
		if (!this.t)
		{
			if (this.t == null || !this.t.gameObject.activeInHierarchy)
			{
				if (PlayerMovement.Instance)
				{
					this.t = PlayerMovement.Instance.playerCam;
					return;
				}
				if (Camera.main)
				{
					this.t = Camera.main.transform;
				}
			}
			return;
		}
		base.transform.LookAt(this.t);
		if (!this.xz)
		{
			base.transform.rotation = Quaternion.Euler(0f, base.transform.rotation.eulerAngles.y + 180f, 0f);
		}
		if (!this.affectScale)
		{
			return;
		}
		base.transform.localScale = this.defaultScale;
	}

	private Vector3 defaultScale;

	public bool xz;

	public bool affectScale;

	private Transform t;
}
