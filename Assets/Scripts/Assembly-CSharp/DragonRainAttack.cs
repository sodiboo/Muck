using System.Collections.Generic;
using UnityEngine;

public class DragonRainAttack : MonoBehaviour
{
    public InventoryItem fireball;

    private float height = 120f;

    private int balls;

    private float delay = 0.5f;

    private void Awake()
    {
        if (LocalClient.serverOwner)
        {
            Invoke("SpawnFireBall", delay);
        }
    }

    private void SpawnFireBall()
    {
        PlayerManager randomAlivePlayer = GetRandomAlivePlayer();
        if (!(randomAlivePlayer == null))
        {
            Vector3 position = randomAlivePlayer.transform.position;
            position += Random.insideUnitSphere * 15f + Vector3.up * height;
            Vector3 down = Vector3.down;
            int num = -1;
            num = Dragon.Instance.transform.root.GetComponent<Hitable>().GetId();
            ServerSend.MobSpawnProjectile(position, down, 0f, fireball.id, num);
            ProjectileController.Instance.SpawnMobProjectile(position, down, 0f, fireball.id, num);
            balls++;
            if (balls >= 6)
            {
                Object.Destroy(base.gameObject);
            }
            else
            {
                Invoke("SpawnFireBall", delay);
            }
        }
    }

    private PlayerManager GetRandomAlivePlayer()
    {
        List<PlayerManager> list = new List<PlayerManager>();
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if ((bool)value && !value.dead && !value.disconnected)
            {
                list.Add(value);
            }
        }
        if (list.Count == 0)
        {
            return null;
        }
        return list[Random.Range(0, list.Count)];
    }
}
