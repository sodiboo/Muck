using UnityEngine;

public class SpectateCameraTest : MonoBehaviour
{
    public Transform target;

    private Vector3 desiredSpectateRotation;

    private void Start()
    {
        base.transform.parent = target;
        base.transform.localRotation = Quaternion.identity;
        base.transform.localPosition = new Vector3(0f, 0f, -6f);
    }

    private void Update()
    {
        Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
        desiredSpectateRotation += new Vector3(vector.y, 0f - vector.x, 0f) * 1.5f;
        target.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(desiredSpectateRotation), Time.deltaTime * 10f);
    }
}
