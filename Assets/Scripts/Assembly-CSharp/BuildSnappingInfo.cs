using UnityEngine;

[ExecuteInEditMode]
public class BuildSnappingInfo : MonoBehaviour
{
    public Vector3[] position;

    public bool half;

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Vector3[] array = position;
        foreach (Vector3 vector in array)
        {
            Gizmos.DrawCube(base.transform.position + vector * 1f, Vector3.one * 0.1f);
        }
    }
}
