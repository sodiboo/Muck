using UnityEngine;

public class MoveCameraTowards : MonoBehaviour
{
    public float speed = 1f;

    public Transform target;

    private bool ready;

    private void Awake()
    {
        Invoke("SetReady", 1f);
    }

    private void SetReady()
    {
        ready = true;
    }

    private void Update()
    {
        if (ready)
        {
            base.transform.position = Vector3.Lerp(base.transform.position, target.position, Time.deltaTime * speed);
        }
    }
}
