using System;
using UnityEngine;

// Token: 0x020000A9 RID: 169
public class DontAttackUntilPlayerSpotted : MonoBehaviour
{
	// Token: 0x060003E7 RID: 999 RVA: 0x00016424 File Offset: 0x00014624
	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
	Destroy(base.gameObject.GetComponent<MobServer>());
		base.GetComponent<MobServer>().enabled = false;
		this.neutral = base.gameObject.AddComponent<MobServerNeutral>();
		this.neutral.mobZoneId = this.mobZoneId;
		Mesh sharedMesh = base.GetComponentInChildren<SkinnedMeshRenderer>().sharedMesh;
		this.headOffset = Vector3.up * sharedMesh.bounds.extents.y * 1.5f;
		base.InvokeRepeating("CheckForPlayers", 0.5f, 0.5f);
	}

	// Token: 0x060003E8 RID: 1000 RVA: 0x000164CC File Offset: 0x000146CC
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

	// Token: 0x060003E9 RID: 1001 RVA: 0x0001668C File Offset: 0x0001488C
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

	// Token: 0x040003E0 RID: 992
	private Mob mob;

	// Token: 0x040003E1 RID: 993
	private Vector3 headOffset;

	// Token: 0x040003E2 RID: 994
	public int mobZoneId;

	// Token: 0x040003E3 RID: 995
	private MobServerNeutral neutral;
}
