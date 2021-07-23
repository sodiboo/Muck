using UnityEngine;

public class MobType : ScriptableObject
{
	public enum MobBehaviour
	{
		Neutral = 0,
		Enemy = 1,
		EnemyMeleeAndRanged = 2,
		Dragon = 3,
	}

	public enum Weakness
	{
		Sharp = 0,
		Blunt = 1,
		Water = 2,
		Fire = 3,
		Lightning = 4,
	}

	public new string name;
	public GameObject mobPrefab;
	public MobBehaviour behaviour;
	public bool ranged;
	public float rangedCooldown;
	public float startAttackDistance;
	public float startRangedAttackDistance;
	public float maxAttackDistance;
	public float speed;
	public float spawnTime;
	public float minAttackAngle;
	public float sharpDefense;
	public float defense;
	public float knockbackThreshold;
	public bool ignoreBuilds;
	public float followPlayerDistance;
	public float followPlayerAccuracy;
	public bool onlyRangedInRangedPattern;
	public Weakness[] weaknesses;
	public bool boss;
}
