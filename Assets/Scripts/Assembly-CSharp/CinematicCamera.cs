using UnityEngine;

public class CinematicCamera : MonoBehaviour
{
    public Transform target;

    public float speed;

    private void Update()
    {
        base.transform.LookAt(target);
        base.transform.RotateAround(target.position, Vector3.up, speed);
    }
}
