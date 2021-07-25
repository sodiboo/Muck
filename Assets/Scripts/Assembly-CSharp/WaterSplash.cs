using UnityEngine;

public class WaterSplash : MonoBehaviour
{
    public GameObject splashFx;

    private Rigidbody rb;

    private Vector3 lastPos;

    private void Awake()
    {
        InvokeRepeating(nameof(SlowUpdate), 0.15f, 0.15f);
    }

    private void SlowUpdate()
    {
        float y = World.Instance.water.transform.position.y;
        Vector3 position = base.transform.position;
        if (lastPos.y < y)
        {
            if (position.y > y)
            {
                Vector3 forward = position - lastPos;
                Object.Instantiate(splashFx, base.transform.position, Quaternion.LookRotation(forward));
            }
        }
        else if (position.y < y)
        {
            Vector3 forward2 = position - lastPos;
            Object.Instantiate(splashFx, base.transform.position, Quaternion.LookRotation(forward2));
        }
        lastPos = position;
    }
}
