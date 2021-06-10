
using UnityEngine;

// Token: 0x020000B5 RID: 181
public class StartPlayer : MonoBehaviour
{
	// Token: 0x060005D5 RID: 1493 RVA: 0x0001E188 File Offset: 0x0001C388
	private void Start()
	{
		for (int i = base.transform.childCount - 1; i >= 0; i--)
		{
			base.transform.GetChild(i).parent = null;
		}
	Destroy(base.gameObject);
	}
}
