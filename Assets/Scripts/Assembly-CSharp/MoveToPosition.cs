using UnityEngine;

[ExecuteInEditMode]
public class MoveToPosition : MonoBehaviour
{
    public Transform target;

    public void LateUpdate()
    {
        base.transform.position = target.position;
    }
}
