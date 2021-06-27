using System;
using UnityEngine;

[CreateAssetMenu]
public class ItemFuel : ScriptableObject
{
	public int maxUses = 1;

	public int currentUses;

	public float speedMultiplier = 1f;
}
