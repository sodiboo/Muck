using System;
using UnityEngine;

public class UpdateableData : ScriptableObject
{
    public bool autoUpdate;

    public event Action OnValuesUpdate;
}
