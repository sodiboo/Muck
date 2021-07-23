using System;
using UnityEngine;

public class UpdatableData : ScriptableObject
{
    public bool autoUpdate;

    public event Action OnValuesUpdated;
}
