using System;
using UnityEngine;

// Token: 0x020000BF RID: 191
public class SpectatorCamera : MonoBehaviour
{
	// Token: 0x0600058C RID: 1420 RVA: 0x0001C893 File Offset: 0x0001AA93
	private void OnEnable()
	{
		this.ready = false;
		Invoke(nameof(GetReady), 1f);
	}

	// Token: 0x1700003D RID: 61
	// (get) Token: 0x0600058D RID: 1421 RVA: 0x0001C8AC File Offset: 0x0001AAAC
	// (set) Token: 0x0600058E RID: 1422 RVA: 0x0001C8B3 File Offset: 0x0001AAB3
	public static SpectatorCamera Instance { get; private set; }

	// Token: 0x0600058F RID: 1423 RVA: 0x0001C8BB File Offset: 0x0001AABB
	private void Awake()
	{
		SpectatorCamera.Instance = this;
	}

	// Token: 0x06000590 RID: 1424 RVA: 0x0001C8C4 File Offset: 0x0001AAC4
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

	// Token: 0x06000591 RID: 1425 RVA: 0x0001C98D File Offset: 0x0001AB8D
	public void SetTarget(Transform target, string name)
	{
		this.target = target;
	}

	// Token: 0x06000592 RID: 1426 RVA: 0x0001C996 File Offset: 0x0001AB96
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x040004F4 RID: 1268
	public Transform target;

	// Token: 0x040004F5 RID: 1269
	private bool ready;

	// Token: 0x040004F7 RID: 1271
	private int targetId;

	// Token: 0x040004F8 RID: 1272
	private string targetName;
}
