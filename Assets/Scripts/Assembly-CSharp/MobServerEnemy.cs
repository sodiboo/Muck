using UnityEngine;

public class MobServerEnemy : MobServer
{
	protected void Start()
	{
		base.StartRoutines();
		this.groundMask = 1 << LayerMask.NameToLayer("Ground");
	}

	protected override void Behaviour()
	{
		this.TryAttack();
	}

	public override void TookDamage()
	{
	}

	private void TryAttack()
	{
		if (!this.mob.target)
		{
			return;
		}
		if (this.mob.IsAttacking())
		{
			return;
		}
		if (!this.serverReadyToAttack)
		{
			return;
		}
		if (this.mob.targetPlayerId != -1 && GameManager.players[this.mob.targetPlayerId].dead)
		{
			this.mob.target = null;
			return;
		}
		this.AttackBehaviour();
	}

	protected virtual void AttackBehaviour()
	{
		if (Vector3.Distance(this.mob.target.position, base.transform.position) <= this.mob.mobType.startAttackDistance)
		{
			if (Mathf.Abs(Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(this.mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up)) > this.mob.mobType.minAttackAngle)
			{
				return;
			}
			int num = Random.Range(0, this.mob.attackAnimations.Length);
			this.mob.Attack(this.mob.targetPlayerId, num);
			ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num);
			this.serverReadyToAttack = false;
			Invoke(nameof(GetReady), this.mob.attackTimes[num] + Random.Range(0f, this.mob.attackCooldown));
		}
	}

	protected void GetReady()
	{
		this.serverReadyToAttack = true;
	}

	protected override Vector3 FindNextPosition()
	{
		float num = 15f * this.mob.mobType.followPlayerDistance;
		if (this.mob.target != null)
		{
			num = Vector3.Distance(this.mob.transform.position, this.mob.target.transform.position);
		}
		if (num < 10f * this.mob.mobType.followPlayerDistance)
		{
			Invoke(nameof(SyncFindNextPosition), this.findPositionInterval[0]);
		}
		else if (num < 25f * this.mob.mobType.followPlayerDistance)
		{
			Invoke(nameof(SyncFindNextPosition), this.findPositionInterval[1]);
		}
		else
		{
			Invoke(nameof(SyncFindNextPosition), this.findPositionInterval[2]);
		}
		if ((this.mob.IsAttacking() && this.mob.stopOnAttack) || this.mob.knocked || !this.mob.ready)
		{
			return Vector3.zero;
		}
		Vector3 vector = Vector3.zero;
		Transform transform = null;
		int targetPlayerId = -1;
		float num2 = float.PositiveInfinity;
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.dead)
			{
				float num3 = Vector3.Distance(playerManager.transform.position, base.transform.position);
				if (num3 < num2)
				{
					num2 = num3;
					Vector3 position = playerManager.transform.position;
					Vector3 vector2 = Vector3.zero;
					if (num3 > 12f)
					{
						vector2 = new Vector3(Random.Range(-1f, 1f), 0f, Random.Range(-1f, 1f));
						vector2 *= num3 * (1f - this.mob.mobType.followPlayerAccuracy);
					}
					vector = position + vector2;
					transform = playerManager.transform;
					targetPlayerId = playerManager.id;
				}
			}
		}
		foreach (PlayerManager playerManager2 in GameManager.players.Values)
		{
			if (playerManager2 && !playerManager2.dead)
			{
				float num4 = Vector3.Distance(playerManager2.transform.position, base.transform.position);
				if (num4 < num2)
				{
					num2 = num4;
					Vector3 position2 = playerManager2.transform.position;
					Vector3 vector3 = Vector3.zero;
					if (num4 > 12f)
					{
						vector3 = new Vector3(Random.Range(-1f, 1f), 0f, Random.Range(-1f, 1f));
						vector3 *= num4 * (1f - this.mob.mobType.followPlayerAccuracy);
					}
					vector = position2 + vector3;
					transform = playerManager2.transform;
					targetPlayerId = playerManager2.id;
				}
			}
		}
		bool flag = false;
		foreach (PlayerManager playerManager3 in GameManager.players.Values)
		{
			if (playerManager3 && !playerManager3.dead)
			{
				Vector3 normalized = (playerManager3.transform.position - this.mob.transform.position).normalized;
				RaycastHit raycastHit;
				if (Physics.Raycast(this.mob.transform.position, normalized, out raycastHit, 2000f, MobManager.Instance.whatIsRaycastable) && raycastHit.transform.gameObject.layer == LayerMask.NameToLayer("Player"))
				{
					flag = true;
					break;
				}
			}
		}
		if (!flag && !this.mob.mobType.ignoreBuilds)
		{
			foreach (GameObject gameObject in ResourceManager.Instance.builds.Values)
			{
				if (!(gameObject == null) && Vector3.Distance(base.transform.position, gameObject.transform.position) < num2)
				{
					vector = gameObject.transform.position;
					transform = gameObject.transform;
					targetPlayerId = -1;
					break;
				}
			}
		}
		if (!transform)
		{
			return Vector3.zero;
		}
		Vector3.Distance(this.mob.agent.destination, transform.position);
		Vector3.Distance(transform.position, this.mob.transform.position);
		if (vector == Vector3.zero)
		{
			this.mob.target = null;
			return Vector3.zero;
		}
		this.mob.target = transform;
		this.mob.targetPlayerId = targetPlayerId;
		return vector;
	}

	public LayerMask groundMask;

	protected bool serverReadyToAttack = true;
}
