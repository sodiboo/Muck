using System;
using UnityEngine;

[CreateAssetMenu]
public class BowComponent : ScriptableObject
{
	public float projectileSpeed;

	public int nArrows;

	public int angleDelta;

	public float timeToImpact = 1.2f;

	public float attackSize = 10f;
}
