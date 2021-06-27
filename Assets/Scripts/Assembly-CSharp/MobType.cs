using System;
using UnityEngine;

[CreateAssetMenu]
public class MobType : ScriptableObject
{
	public int id { get; set; }

	public new string name;

	public GameObject mobPrefab;

	public MobType.MobBehaviour behaviour;

	public bool ranged;

	public float rangedCooldown = 6f;

	public float startAttackDistance = 1f;

	public float startRangedAttackDistance = 5f;

	public float maxAttackDistance = 1f;

	public float speed;

	public float spawnTime = 1f;

	public float minAttackAngle = 20f;

	public float sharpDefense;

	public float defense;

	public float knockbackThreshold = 0.2f;

	public bool ignoreBuilds;

	public float followPlayerDistance = 1f;

	public float followPlayerAccuracy = 0.15f;

	public bool onlyRangedInRangedPattern;

	public MobType.Weakness[] weaknesses;

	public bool boss;

	public enum MobBehaviour
	{
		Neutral,
		Enemy,
		EnemyMeleeAndRanged,
		Dragon
	}

	[Serializable]
	public enum Weakness
	{
		Sharp,
		Blunt,
		Water,
		Fire,
		Lightning
	}
}
