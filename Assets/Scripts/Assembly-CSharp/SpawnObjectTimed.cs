using UnityEngine;

public class SpawnObjectTimed : MonoBehaviour
{
    public float time;

    public GameObject objectToSpawn;

    private void Awake()
    {
        Invoke("SpawnObject", time);
    }

    private void SpawnObject()
    {
        Object.Instantiate(objectToSpawn, base.transform.position, objectToSpawn.transform.rotation);
        Object.Destroy(this);
    }
}
