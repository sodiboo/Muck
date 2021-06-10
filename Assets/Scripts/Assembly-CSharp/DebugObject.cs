
using UnityEngine;

// Token: 0x0200001B RID: 27
public class DebugObject : MonoBehaviour
{
	// Token: 0x060000A8 RID: 168 RVA: 0x00005574 File Offset: 0x00003774
	private void Update()
	{
		if (!base.transform.parent)
		{
			return;
		}
		base.transform.rotation = Quaternion.identity;
		base.transform.position = base.transform.parent.position + this.offset;
	}

	// Token: 0x060000A9 RID: 169 RVA: 0x000055CC File Offset: 0x000037CC
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

	// Token: 0x040000A3 RID: 163
	public string text;

	// Token: 0x040000A4 RID: 164
	public Vector3 offset = new Vector3(0f, 1.5f, 0f);

	// Token: 0x040000A5 RID: 165
	private Camera cam;
}
