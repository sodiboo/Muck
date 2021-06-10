
using UnityEngine;

// Token: 0x020000FA RID: 250
public class TutorialArrow : MonoBehaviour
{
	// Token: 0x06000751 RID: 1873 RVA: 0x0002462C File Offset: 0x0002282C
	private void Update()
	{
		base.transform.Rotate(Vector3.forward, 22f * Time.deltaTime);
		float d = 1f + Mathf.PingPong(Time.time * 0.25f, 0.3f) - 0.15f;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, Vector3.one * d, Time.deltaTime * 2f);
	}
}
