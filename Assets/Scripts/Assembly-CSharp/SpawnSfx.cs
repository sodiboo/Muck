using UnityEngine;

public class SpawnSfx : MonoBehaviour
{
    public GameObject startCharge;

    public Transform pos;

    public void SpawnSound()
    {
        Object.Instantiate(startCharge, pos.position, startCharge.transform.rotation);
    }
}
