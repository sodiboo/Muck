using System;
using UnityEngine;

// Token: 0x02000008 RID: 8
public class BuildDoor : MonoBehaviour
{
	// Token: 0x04000021 RID: 33
	public BuildDoor.Door[] doors;

	// Token: 0x02000009 RID: 9
	[Serializable]
	public class Door
	{
		// Token: 0x06000022 RID: 34 RVA: 0x00002198 File Offset: 0x00000398
		public void SetId(int id)
		{
			this.hitable.SetId(id);
			this.doorInteractable.SetId(id);
			ResourceManager.Instance.AddObject(id, this.hitable.gameObject);
		}

		// Token: 0x04000022 RID: 34
		public Hitable hitable;

		// Token: 0x04000023 RID: 35
		public DoorInteractable doorInteractable;
	}
}
