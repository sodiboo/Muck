using System;
using UnityEngine;

// Token: 0x0200012A RID: 298
public class TutorialArrow : MonoBehaviour
{
	// Token: 0x06000895 RID: 2197 RVA: 0x0002AF14 File Offset: 0x00029114
	private void Update()
	{
		base.transform.Rotate(Vector3.forward, 22f * Time.deltaTime);
		float d = 1f + Mathf.PingPong(Time.time * 0.25f, 0.3f) - 0.15f;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, Vector3.one * d, Time.deltaTime * 2f);
	}
}
