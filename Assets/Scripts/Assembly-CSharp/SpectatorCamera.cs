using System;
using UnityEngine;

// Token: 0x020000C7 RID: 199
public class SpectatorCamera : MonoBehaviour
{
	// Token: 0x06000506 RID: 1286 RVA: 0x00005561 File Offset: 0x00003761
	private void OnEnable()
	{
		this.ready = false;
		base.Invoke("GetReady", 1f);
	}

	// Token: 0x17000039 RID: 57
	// (get) Token: 0x06000507 RID: 1287 RVA: 0x0000557A File Offset: 0x0000377A
	// (set) Token: 0x06000508 RID: 1288 RVA: 0x00005581 File Offset: 0x00003781
	public static SpectatorCamera Instance { get; private set; }

	// Token: 0x06000509 RID: 1289 RVA: 0x00005589 File Offset: 0x00003789
	private void Awake()
	{
		SpectatorCamera.Instance = this;
	}

	// Token: 0x0600050A RID: 1290 RVA: 0x0001B294 File Offset: 0x00019494
	private void Update()
	{
		if (Input.GetMouseButtonDown(0))
		{
			this.targetId++;
			this.target = null;
			this.targetName = "";
		}
		if (!this.ready)
		{
			return;
		}
		if (!this.target || !this.target.gameObject.activeInHierarchy)
		{
			return;
		}
		if (!this.target)
		{
			return;
		}
		Transform child = this.target.GetChild(0);
		base.transform.position = this.target.position - child.forward * 5f + Vector3.up * 2f;
		base.transform.LookAt(this.target);
	}

	// Token: 0x0600050B RID: 1291 RVA: 0x00005591 File Offset: 0x00003791
	public void SetTarget(Transform target, string name)
	{
		this.target = target;
	}

	// Token: 0x0600050C RID: 1292 RVA: 0x0000559A File Offset: 0x0000379A
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x040004B6 RID: 1206
	public Transform target;

	// Token: 0x040004B7 RID: 1207
	private bool ready;

	// Token: 0x040004B9 RID: 1209
	private int targetId;

	// Token: 0x040004BA RID: 1210
	private string targetName;
}
