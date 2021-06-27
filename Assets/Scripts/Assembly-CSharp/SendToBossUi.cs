using System;
using UnityEngine;

public class SendToBossUi : MonoBehaviour
{
	private void Awake()
	{
		Mob component = base.GetComponent<Mob>();
		if (this.forceUI)
		{
			BossUI.Instance.SetBoss(component);
		}
	}

	public bool forceUI;
}
