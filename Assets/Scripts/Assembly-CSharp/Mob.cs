using UnityEngine;

public class Mob : MonoBehaviour
{
	public enum BossType
	{
		None = 0,
		BossNight = 1,
		BossShrine = 2,
	}

	public MobType mobType;
	public float attackCooldown;
	public int id;
	public bool stopOnAttack;
	public BossType bossType;
	public bool countedKill;
	public AnimationClip[] attackAnimations;
	public GameObject footstepFx;
	public float footstepFrequency;
	public bool knocked;
	public int nRangedAttacks;
}
