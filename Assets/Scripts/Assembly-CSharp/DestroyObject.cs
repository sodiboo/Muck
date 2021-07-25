using UnityEngine;

public class DestroyObject : MonoBehaviour
{
    public float time;

    private void Start()
    {
        Invoke(nameof(DestroySelf), time);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }
}
