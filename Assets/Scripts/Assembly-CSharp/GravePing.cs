
using TMPro;
using UnityEngine;

// Token: 0x0200002E RID: 46
public class GravePing : MonoBehaviour
{
	// Token: 0x06000117 RID: 279 RVA: 0x0000782F File Offset: 0x00005A2F
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
	}

	// Token: 0x06000118 RID: 280 RVA: 0x00007848 File Offset: 0x00005A48
	public void SetPing(string name)
	{
		this.pingText.text = "Revive " + name;
	}

	// Token: 0x06000119 RID: 281 RVA: 0x00007860 File Offset: 0x00005A60
	private void Update()
	{
		if (DayCycle.time <= 0.5f)
		{
			this.child.SetActive(true);
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

	// Token: 0x04000105 RID: 261
	public TextMeshProUGUI pingText;

	// Token: 0x04000106 RID: 262
	private float defaultScale = 0.6f;

	// Token: 0x04000107 RID: 263
	private GameObject child;
}
