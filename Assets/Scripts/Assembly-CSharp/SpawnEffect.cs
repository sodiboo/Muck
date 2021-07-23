using UnityEngine;

public class SpawnEffect : MonoBehaviour
{
    public GameObject spawnEffect;

    public float maxPlayerDistance = 40f;

    private void Awake()
    {
        if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < maxPlayerDistance)
        {
            Object.Instantiate(spawnEffect, base.transform.position, Quaternion.identity).GetComponent<AudioSource>().maxDistance = maxPlayerDistance;
        }
        Object.Destroy(this);
    }
}
