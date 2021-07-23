using UnityEngine;

public class BoatCamera : MonoBehaviour
{
    private Transform target;

    private Transform dragonTransform;

    private void Awake()
    {
        target = Boat.Instance.rbTransform;
        dragonTransform = Dragon.Instance.transform;
        Invoke("StopCamera", 5f);
    }

    private void StopCamera()
    {
        base.gameObject.SetActive(value: false);
    }

    private void Update()
    {
        if (base.transform != dragonTransform && dragonTransform.position.y > target.transform.position.y)
        {
            target = dragonTransform;
        }
        Quaternion b = Quaternion.LookRotation(target.position - base.transform.position);
        base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6f);
    }
}
