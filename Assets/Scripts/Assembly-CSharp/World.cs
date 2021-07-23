using UnityEngine;

public class World : MonoBehaviour
{
    public Transform worldMesh;

    public Transform water;

    public static World Instance;

    private void Awake()
    {
        Instance = this;
    }
}
