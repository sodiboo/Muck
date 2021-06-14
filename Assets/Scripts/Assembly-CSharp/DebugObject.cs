using System;
using UnityEngine;

// Token: 0x02000021 RID: 33
public class DebugObject : MonoBehaviour
{
	// Token: 0x060000B4 RID: 180 RVA: 0x00009EC0 File Offset: 0x000080C0
	private void Update()
	{
		if (!base.transform.parent)
		{
			return;
		}
		base.transform.rotation = Quaternion.identity;
		base.transform.position = base.transform.parent.position + this.offset;
	}

	// Token: 0x060000B5 RID: 181 RVA: 0x00009F18 File Offset: 0x00008118
	private void OnGUI()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		if (!this.cam)
		{
			this.cam = PlayerMovement.Instance.playerCam.GetComponentInChildren<Camera>();
			return;
		}
		Vector3 vector = this.cam.WorldToViewportPoint(base.transform.position);
		if (vector.x >= 0f && vector.x <= 1f && vector.y >= 0f && vector.y <= 1f && vector.z > 0f)
		{
			Vector3 vector2 = Camera.main.WorldToScreenPoint(base.gameObject.transform.position);
			if (Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) > 30f)
			{
				return;
			}
			Vector2 vector3 = GUI.skin.label.CalcSize(new GUIContent(this.text));
			GUI.Label(new Rect(vector2.x, (float)Screen.height - vector2.y, vector3.x, vector3.y), this.text);
		}
	}

	// Token: 0x040000B7 RID: 183
	public string text;

	// Token: 0x040000B8 RID: 184
	public Vector3 offset = new Vector3(0f, 1.5f, 0f);

	// Token: 0x040000B9 RID: 185
	private Camera cam;
}
