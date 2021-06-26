using UnityEngine;

public class EnemyProjectile : MonoBehaviour
{
	public GameObject hitFx;
	public bool collideWithPlayerAndBuildOnly;
	public bool ignoreGround;
	public Transform spawnPos;
	public float hideFxDistance;
}
