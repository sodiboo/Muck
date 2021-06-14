using System;
using UnityEngine;

// Token: 0x02000055 RID: 85
public class MenuCamera : MonoBehaviour
{
	// Token: 0x060001BE RID: 446 RVA: 0x0000348D File Offset: 0x0000168D
	private void Awake()
	{
		this.desiredPos = this.startPos;
		Time.timeScale = 1f;
	}

	// Token: 0x060001BF RID: 447 RVA: 0x000034A5 File Offset: 0x000016A5
	private void Start()
	{
		NetworkController.Instance.loading = false;
	}

	// Token: 0x060001C0 RID: 448 RVA: 0x000034B2 File Offset: 0x000016B2
	public void Lobby()
	{
		this.desiredPos = this.lobbyPos;
	}

	// Token: 0x060001C1 RID: 449 RVA: 0x000034C0 File Offset: 0x000016C0
	public void Menu()
	{
		this.desiredPos = this.startPos;
	}

	// Token: 0x060001C2 RID: 450 RVA: 0x0000EC98 File Offset: 0x0000CE98
	private void Update()
	{
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredPos.position, Time.deltaTime * 5f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, this.desiredPos.rotation, Time.deltaTime * 5f);
	}

	// Token: 0x040001D6 RID: 470
	public Transform startPos;

	// Token: 0x040001D7 RID: 471
	public Transform lobbyPos;

	// Token: 0x040001D8 RID: 472
	private Transform desiredPos;
}
