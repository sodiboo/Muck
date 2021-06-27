using System;
using UnityEngine;

// Token: 0x0200000B RID: 11
public class BuildDoor : MonoBehaviour
{
	// Token: 0x04000048 RID: 72
	public BuildDoor.Door[] doors;

	// Token: 0x0200013D RID: 317
	[Serializable]
	public class Door
	{
		// Token: 0x060008E3 RID: 2275 RVA: 0x0002C217 File Offset: 0x0002A417
		public void SetId(int id)
		{
			this.hitable.SetId(id);
			this.doorInteractable.SetId(id);
			ResourceManager.Instance.AddObject(id, this.hitable.gameObject);
		}

		// Token: 0x04000881 RID: 2177
		public Hitable hitable;

		// Token: 0x04000882 RID: 2178
		public DoorInteractable doorInteractable;
	}
}
