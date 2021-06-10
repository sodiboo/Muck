
using UnityEngine;

// Token: 0x02000098 RID: 152
public class SpectatorCamera : MonoBehaviour
{
	// Token: 0x0600048F RID: 1167 RVA: 0x00017187 File Offset: 0x00015387
	private void OnEnable()
	{
		this.ready = false;
		base.Invoke("GetReady", 1f);
	}

	// Token: 0x17000031 RID: 49
	// (get) Token: 0x06000490 RID: 1168 RVA: 0x000171A0 File Offset: 0x000153A0
	// (set) Token: 0x06000491 RID: 1169 RVA: 0x000171A7 File Offset: 0x000153A7
	public static SpectatorCamera Instance { get; private set; }

	// Token: 0x06000492 RID: 1170 RVA: 0x000171AF File Offset: 0x000153AF
	private void Awake()
	{
		SpectatorCamera.Instance = this;
	}

	// Token: 0x06000493 RID: 1171 RVA: 0x000171B8 File Offset: 0x000153B8
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

	// Token: 0x06000494 RID: 1172 RVA: 0x00017281 File Offset: 0x00015481
	public void SetTarget(Transform target, string name)
	{
		this.target = target;
	}

	// Token: 0x06000495 RID: 1173 RVA: 0x0001728A File Offset: 0x0001548A
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x040003E5 RID: 997
	public Transform target;

	// Token: 0x040003E6 RID: 998
	private bool ready;

	// Token: 0x040003E8 RID: 1000
	private int targetId;

	// Token: 0x040003E9 RID: 1001
	private string targetName;
}
