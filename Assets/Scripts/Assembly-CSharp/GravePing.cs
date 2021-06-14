using System;
using TMPro;
using UnityEngine;

// Token: 0x02000037 RID: 55
public class GravePing : MonoBehaviour
{
	// Token: 0x06000132 RID: 306 RVA: 0x00002F01 File Offset: 0x00001101
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.grave = base.transform.root.GetComponentInChildren<GraveInteract>();
	}

	// Token: 0x06000133 RID: 307 RVA: 0x00002F30 File Offset: 0x00001130
	public void SetPing(string name)
	{
		this.pingText.text = string.Format("Revive {0} ({1}", this.grave.username, this.grave.timeLeft);
	}

	// Token: 0x06000134 RID: 308 RVA: 0x0000C0BC File Offset: 0x0000A2BC
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

	// Token: 0x0400012D RID: 301
	public TextMeshProUGUI pingText;

	// Token: 0x0400012E RID: 302
	private float defaultScale = 0.4f;

	// Token: 0x0400012F RID: 303
	private GraveInteract grave;

	// Token: 0x04000130 RID: 304
	private GameObject child;
}
