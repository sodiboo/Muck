using UnityEngine;

public class SpawnFxAtPosition : MonoBehaviour
{
    public GameObject[] fx;

    public Transform[] positions;

    public void SpawnFx(int n)
    {
        Object.Instantiate(fx[n], positions[n].position, fx[n].transform.rotation);
    }
}
