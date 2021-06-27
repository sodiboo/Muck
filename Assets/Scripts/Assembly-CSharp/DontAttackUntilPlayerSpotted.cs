using System;
using UnityEngine;

public class DontAttackUntilPlayerSpotted : MonoBehaviour
{
	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
		Destroy(base.gameObject.GetComponent<MobServer>());
		base.GetComponent<MobServer>().enabled = false;
		this.neutral = base.gameObject.AddComponent<MobServerNeutral>();
		this.neutral.mobZoneId = this.mobZoneId;
		Mesh sharedMesh = base.GetComponentInChildren<SkinnedMeshRenderer>().sharedMesh;
		this.headOffset = Vector3.up * sharedMesh.bounds.extents.y * 1.5f;
		InvokeRepeating(nameof(CheckForPlayers), 0.5f, 0.5f);
	}

	private void CheckForPlayers()
	{
		Vector3 forward = base.transform.forward;
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager)
			{
				float num = Vector3.Distance(base.transform.position, playerManager.transform.position);
				if (num < 5f)
				{
					this.FoundPlayer();
				}
				if (num < 40f)
				{
					Vector3 vector = playerManager.transform.position - base.transform.position;
					if (Mathf.Abs(Vector3.SignedAngle(VectorExtensions.XZVector(vector), VectorExtensions.XZVector(forward), Vector3.up)) < 55f)
					{
						Debug.DrawLine(base.transform.position + this.headOffset, base.transform.position + this.headOffset + vector * num, Color.black, 2f);
						RaycastHit raycastHit;
						if (Physics.Raycast(base.transform.position + this.headOffset, vector, out raycastHit, num, GameManager.instance.whatIsGroundAndObject))
						{
							if (raycastHit.collider.gameObject.layer == LayerMask.NameToLayer("Player"))
							{
								this.FoundPlayer();
							}
						}
						else
						{
							this.FoundPlayer();
						}
					}
				}
				if (this.mob.hitable.hp < this.mob.hitable.maxHp)
				{
					this.FoundPlayer();
				}
			}
		}
	}

	private void FoundPlayer()
	{
		this.mob.ready = true;
		Destroy(this.neutral);
		if (this.mob.mobType.behaviour == MobType.MobBehaviour.Enemy)
		{
			base.gameObject.AddComponent<MobServerEnemy>();
		}
		else
		{
			base.gameObject.AddComponent<MobServerEnemyMeleeAndRanged>();
		}
		Destroy(this);
	}

	private Mob mob;

	private Vector3 headOffset;

	public int mobZoneId;

	private MobServerNeutral neutral;
}
