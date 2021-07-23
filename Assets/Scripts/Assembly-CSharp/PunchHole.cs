using UnityEngine;

public class PunchHole : MonoBehaviour
{
    public LayerMask whatIsGround;

    public Transform ground;

    private void Update()
    {
        if (Input.GetMouseButtonDown(0) && Physics.Raycast(base.transform.position, base.transform.forward, out var hitInfo, 1000f, whatIsGround))
        {
            int triangleIndex = hitInfo.triangleIndex;
            ground = hitInfo.transform;
            int[] triangles = base.transform.GetComponent<MeshFilter>().mesh.triangles;
            Vector3[] vertices = base.transform.GetComponent<MeshFilter>().mesh.vertices;
            Vector3 vector = vertices[triangles[triangleIndex * 3]];
            Vector3 vector2 = vertices[triangles[triangleIndex * 3 + 1]];
            Vector3 vector3 = vertices[triangles[triangleIndex * 3 + 2]];
            float num = Vector3.Distance(vector, vector2);
            float num2 = Vector3.Distance(vector, vector3);
            float num3 = Vector3.Distance(vector2, vector3);
            Vector3 v;
            Vector3 v2;
            if (num > num2 && num > num3)
            {
                v = vector;
                v2 = vector2;
            }
            else if (num2 > num && num2 > num3)
            {
                v = vector;
                v2 = vector3;
            }
            else
            {
                v = vector2;
                v2 = vector3;
            }
            findVertex(v);
            findVertex(v2);
        }
    }

    private int findVertex(Vector3 v)
    {
        Vector3[] vertices = ground.GetComponent<MeshFilter>().mesh.vertices;
        for (int i = 0; i < vertices.Length; i++)
        {
            if (vertices[i] == v)
            {
                return i;
            }
        }
        return -1;
    }

    private int findTriangle(Vector3 v1, Vector3 v2, int notTriIndex)
    {
        int[] triangles = ground.GetComponent<MeshFilter>().mesh.triangles;
        _ = base.transform.GetComponent<MeshFilter>().mesh.vertices;
        int num = 0;
        while (num < triangles.Length)
        {
            if (num / 3 != notTriIndex)
            {
                return -1;
            }
        }
        return -1;
    }
}
