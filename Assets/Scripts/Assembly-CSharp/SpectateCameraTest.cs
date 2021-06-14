using System;
using UnityEngine;

// Token: 0x02000137 RID: 311
public class SpectateCameraTest : MonoBehaviour
{
	// Token: 0x0600077A RID: 1914 RVA: 0x000251E4 File Offset: 0x000233E4
	private void Start()
	{
		base.transform.parent = this.target;
		base.transform.localRotation = Quaternion.identity;
		base.transform.localPosition = new Vector3(0f, 0f, -6f);
	}

	// Token: 0x0600077B RID: 1915 RVA: 0x00025234 File Offset: 0x00023434
	private void Update()
	{
		Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
		this.desiredSpectateRotation += new Vector3(vector.y, -vector.x, 0f) * 1.5f;
		this.target.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(this.desiredSpectateRotation), Time.deltaTime * 10f);
	}

	// Token: 0x040007B9 RID: 1977
	public Transform target;

	// Token: 0x040007BA RID: 1978
	private Vector3 desiredSpectateRotation;
}
