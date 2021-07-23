using UnityEngine;

public class NavmeshTest : MonoBehaviour
{
    private void OnDrawGizmos()
    {
        GetComponentInChildren<Renderer>();
        Gizmos.color = Color.red;
        Bounds bounds = GetComponent<BoxCollider>().bounds;
        Gizmos.DrawWireCube(bounds.center, bounds.size);
    }
}
