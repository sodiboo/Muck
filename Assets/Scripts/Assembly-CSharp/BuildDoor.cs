using System;
using UnityEngine;

// Token: 0x02000008 RID: 8
public class BuildDoor : MonoBehaviour
{
	// Token: 0x04000020 RID: 32
	public BuildDoor.Door[] doors;

	// Token: 0x02000107 RID: 263
	[Serializable]
	public class Door
	{
		// Token: 0x06000797 RID: 1943 RVA: 0x0002582B File Offset: 0x00023A2B
		public void SetId(int id)
		{
			this.hitable.SetId(id);
			this.doorInteractable.SetId(id);
			ResourceManager.Instance.AddObject(id, this.hitable.gameObject);
		}

		// Token: 0x04000725 RID: 1829
		public Hitable hitable;

		// Token: 0x04000726 RID: 1830
		public DoorInteractable doorInteractable;
	}
}
