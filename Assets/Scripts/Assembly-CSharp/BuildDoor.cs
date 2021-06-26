using UnityEngine;
using System;

public class BuildDoor : MonoBehaviour
{
	[Serializable]
	public class Door
	{
		public Hitable hitable;
		public DoorInteractable doorInteractable;
	}

	public Door[] doors;
}
