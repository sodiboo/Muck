
using UnityEngine;

// Token: 0x02000093 RID: 147
public class LocalPlayer : MonoBehaviour
{
	// Token: 0x06000463 RID: 1123 RVA: 0x00016850 File Offset: 0x00014A50
	public void SwitchUserInterface(bool b)
	{
		GameObject[] array = this.objects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(b);
		}
	}

	// Token: 0x040003A1 RID: 929
	public GameObject[] objects;
}
