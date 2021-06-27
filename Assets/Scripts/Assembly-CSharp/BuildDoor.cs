using System;
using UnityEngine;

public class BuildDoor : MonoBehaviour
{
	public BuildDoor.Door[] doors;

	[Serializable]
	public class Door
	{
		public void SetId(int id)
		{
			this.hitable.SetId(id);
			this.doorInteractable.SetId(id);
			ResourceManager.Instance.AddObject(id, this.hitable.gameObject);
		}

		public Hitable hitable;

		public DoorInteractable doorInteractable;
	}
}
