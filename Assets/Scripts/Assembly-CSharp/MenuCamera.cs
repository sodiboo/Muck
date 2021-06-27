using System;
using UnityEngine;

// Token: 0x02000063 RID: 99
public class MenuCamera : MonoBehaviour
{
	// Token: 0x06000233 RID: 563 RVA: 0x0000D34C File Offset: 0x0000B54C
	private void Awake()
	{
		this.desiredPos = this.startPos;
		Time.timeScale = 1f;
	}

	// Token: 0x06000234 RID: 564 RVA: 0x0000D364 File Offset: 0x0000B564
	private void Start()
	{
		NetworkController.Instance.loading = false;
	}

	// Token: 0x06000235 RID: 565 RVA: 0x0000D371 File Offset: 0x0000B571
	public void Lobby()
	{
		this.desiredPos = this.lobbyPos;
	}

	// Token: 0x06000236 RID: 566 RVA: 0x0000D37F File Offset: 0x0000B57F
	public void Menu()
	{
		this.desiredPos = this.startPos;
	}

	// Token: 0x06000237 RID: 567 RVA: 0x0000D390 File Offset: 0x0000B590
	private void Update()
	{
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredPos.position, Time.deltaTime * 5f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, this.desiredPos.rotation, Time.deltaTime * 5f);
	}

	// Token: 0x04000253 RID: 595
	public Transform startPos;

	// Token: 0x04000254 RID: 596
	public Transform lobbyPos;

	// Token: 0x04000255 RID: 597
	private Transform desiredPos;
}
