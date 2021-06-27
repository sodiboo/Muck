using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002C RID: 44
public class DragonRainAttack : MonoBehaviour
{
	// Token: 0x06000102 RID: 258 RVA: 0x00006A9C File Offset: 0x00004C9C
	private void Awake()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		Invoke(nameof(SpawnFireBall), this.delay);
	}

	// Token: 0x06000103 RID: 259 RVA: 0x00006AB8 File Offset: 0x00004CB8
	private void SpawnFireBall()
	{
		PlayerManager randomAlivePlayer = this.GetRandomAlivePlayer();
		if (randomAlivePlayer == null)
		{
			return;
		}
		Vector3 vector = randomAlivePlayer.transform.position;
		vector += Random.insideUnitSphere * 15f + Vector3.up * this.height;
		Vector3 down = Vector3.down;
		int id = Dragon.Instance.transform.root.GetComponent<Hitable>().GetId();
		ServerSend.MobSpawnProjectile(vector, down, 0f, this.fireball.id, id);
		ProjectileController.Instance.SpawnMobProjectile(vector, down, 0f, this.fireball.id, id);
		this.balls++;
		if (this.balls >= 6)
		{
			Destroy(base.gameObject);
			return;
		}
		Invoke(nameof(SpawnFireBall), this.delay);
	}

	// Token: 0x06000104 RID: 260 RVA: 0x00006B98 File Offset: 0x00004D98
	private PlayerManager GetRandomAlivePlayer()
	{
		List<PlayerManager> list = new List<PlayerManager>();
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.dead && !playerManager.disconnected)
			{
				list.Add(playerManager);
			}
		}
		if (list.Count == 0)
		{
			return null;
		}
		return list[Random.Range(0, list.Count)];
	}

	// Token: 0x04000101 RID: 257
	public InventoryItem fireball;

	// Token: 0x04000102 RID: 258
	private float height = 120f;

	// Token: 0x04000103 RID: 259
	private int balls;

	// Token: 0x04000104 RID: 260
	private float delay = 0.5f;
}
