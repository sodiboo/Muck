
using UnityEngine;

// Token: 0x020000E8 RID: 232
public class SpectateCameraTest : MonoBehaviour
{
	// Token: 0x060006C7 RID: 1735 RVA: 0x00021F70 File Offset: 0x00020170
	private void Start()
	{
		base.transform.parent = this.target;
		base.transform.localRotation = Quaternion.identity;
		base.transform.localPosition = new Vector3(0f, 0f, -6f);
	}

	// Token: 0x060006C8 RID: 1736 RVA: 0x00021FC0 File Offset: 0x000201C0
	private void Update()
	{
		Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
		this.desiredSpectateRotation += new Vector3(vector.y, -vector.x, 0f) * 1.5f;
		this.target.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(this.desiredSpectateRotation), Time.deltaTime * 10f);
	}

	// Token: 0x04000667 RID: 1639
	public Transform target;

	// Token: 0x04000668 RID: 1640
	private Vector3 desiredSpectateRotation;
}
