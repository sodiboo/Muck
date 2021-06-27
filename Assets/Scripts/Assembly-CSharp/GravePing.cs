using System;
using TMPro;
using UnityEngine;

// Token: 0x02000041 RID: 65
public class GravePing : MonoBehaviour
{
	// Token: 0x0600018B RID: 395 RVA: 0x0000956E File Offset: 0x0000776E
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.grave = base.transform.root.GetComponentInChildren<GraveInteract>();
	}

	// Token: 0x0600018C RID: 396 RVA: 0x0000959D File Offset: 0x0000779D
	public void SetPing(string name)
	{
		this.pingText.text = string.Format("Revive {0} ({1}", this.grave.username, this.grave.timeLeft);
	}

	// Token: 0x0600018D RID: 397 RVA: 0x000095D0 File Offset: 0x000077D0
	private void Update()
	{
		if (DayCycle.time <= 0.5f)
		{
			this.child.SetActive(true);
			string str = "";
			if (this.grave.timeLeft > 0f)
			{
				str = string.Format("({0})", (int)this.grave.timeLeft);
			}
			this.pingText.text = "Revive " + this.grave.username + " " + str;
			float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
			if (num < 5f)
			{
				num = 0f;
			}
			if (num > 5000f)
			{
				num = 5000f;
			}
			base.transform.localScale = this.defaultScale * num * Vector3.one;
			return;
		}
		this.child.SetActive(false);
	}

	// Token: 0x0400017D RID: 381
	public TextMeshProUGUI pingText;

	// Token: 0x0400017E RID: 382
	private float defaultScale = 0.4f;

	// Token: 0x0400017F RID: 383
	private GraveInteract grave;

	// Token: 0x04000180 RID: 384
	private GameObject child;
}
