
using UnityEngine;

// Token: 0x0200000C RID: 12
public class CameraLookAt : MonoBehaviour
{
	// Token: 0x06000034 RID: 52 RVA: 0x00003924 File Offset: 0x00001B24
	private void Update()
	{
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6.4f);
	}

	// Token: 0x04000036 RID: 54
	public Transform target;
}
