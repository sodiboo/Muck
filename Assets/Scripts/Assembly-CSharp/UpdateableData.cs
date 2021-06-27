using System;
using UnityEngine;

public class UpdateableData : ScriptableObject
{
	public event Action OnValuesUpdate;

	public bool autoUpdate;
}
