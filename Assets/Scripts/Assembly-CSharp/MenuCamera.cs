
using UnityEngine;

// Token: 0x02000047 RID: 71
public class MenuCamera : MonoBehaviour
{
	// Token: 0x06000196 RID: 406 RVA: 0x0000A219 File Offset: 0x00008419
	private void Awake()
	{
		this.desiredPos = this.startPos;
	}

	// Token: 0x06000197 RID: 407 RVA: 0x0000A227 File Offset: 0x00008427
	public void Lobby()
	{
		this.desiredPos = this.lobbyPos;
	}

	// Token: 0x06000198 RID: 408 RVA: 0x0000A219 File Offset: 0x00008419
	public void Menu()
	{
		this.desiredPos = this.startPos;
	}

	// Token: 0x06000199 RID: 409 RVA: 0x0000A238 File Offset: 0x00008438
	private void Update()
	{
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredPos.position, Time.deltaTime * 5f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, this.desiredPos.rotation, Time.deltaTime * 5f);
	}

	// Token: 0x0400019A RID: 410
	public Transform startPos;

	// Token: 0x0400019B RID: 411
	public Transform lobbyPos;

	// Token: 0x0400019C RID: 412
	private Transform desiredPos;
}
