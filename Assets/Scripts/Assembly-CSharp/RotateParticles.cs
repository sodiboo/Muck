using UnityEngine;

[ExecuteInEditMode]
public class RotateParticles : MonoBehaviour
{
    public Transform parent;

    private void Update()
    {
        base.transform.rotation = parent.rotation;
    }
}
