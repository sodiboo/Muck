using System;
using UnityEngine;

public class UpdatableData : ScriptableObject
{
	public event Action OnValuesUpdated;

	public bool autoUpdate;
}
