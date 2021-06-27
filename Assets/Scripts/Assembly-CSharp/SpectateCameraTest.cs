using System;
using UnityEngine;

// Token: 0x02000117 RID: 279
public class SpectateCameraTest : MonoBehaviour
{
	// Token: 0x06000809 RID: 2057 RVA: 0x00028810 File Offset: 0x00026A10
	private void Start()
	{
		base.transform.parent = this.target;
		base.transform.localRotation = Quaternion.identity;
		base.transform.localPosition = new Vector3(0f, 0f, -6f);
	}

	// Token: 0x0600080A RID: 2058 RVA: 0x00028860 File Offset: 0x00026A60
	private void Update()
	{
		Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
		this.desiredSpectateRotation += new Vector3(vector.y, -vector.x, 0f) * 1.5f;
		this.target.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(this.desiredSpectateRotation), Time.deltaTime * 10f);
	}

	// Token: 0x040007AC RID: 1964
	public Transform target;

	// Token: 0x040007AD RID: 1965
	private Vector3 desiredSpectateRotation;
}
