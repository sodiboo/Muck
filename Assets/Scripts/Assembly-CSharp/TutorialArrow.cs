using System;
using UnityEngine;

// Token: 0x02000150 RID: 336
public class TutorialArrow : MonoBehaviour
{
	// Token: 0x0600080E RID: 2062 RVA: 0x0002790C File Offset: 0x00025B0C
	private void Update()
	{
		base.transform.Rotate(Vector3.forward, 22f * Time.deltaTime);
		float d = 1f + Mathf.PingPong(Time.time * 0.25f, 0.3f) - 0.15f;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, Vector3.one * d, Time.deltaTime * 2f);
	}
}
