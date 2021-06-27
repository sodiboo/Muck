using System.Collections.Generic;
using UnityEngine;

public class DragonRainAttack : MonoBehaviour
{
	private void Awake()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		Invoke(nameof(SpawnFireBall), this.delay);
	}

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

	public InventoryItem fireball;

	private float height = 120f;

	private int balls;

	private float delay = 0.5f;
}
