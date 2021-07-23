using UnityEngine;

public class CameraLookAt : MonoBehaviour
{
    public Transform target;

    private void Update()
    {
        Quaternion b = Quaternion.LookRotation(target.position - base.transform.position);
        base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6.4f);
    }
}
