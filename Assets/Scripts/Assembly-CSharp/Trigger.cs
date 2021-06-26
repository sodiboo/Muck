using UnityEngine;
using UnityEngine.Video;

public abstract class Trigger : MonoBehaviour
{
    public static bool show;
    Renderer renderer;
    private void Awake()
    {
        renderer = GetComponent<Renderer>();
    }
    private void Update()
    {
        renderer.enabled = Hotbar.Instance.currentItem
        && (Hotbar.Instance.currentItem.tag == InventoryItem.ItemTag.Trigger
        || (Hotbar.Instance.currentItem.tag == InventoryItem.ItemTag.Precision
        && Input.GetKey(InputManager.precisionRotate)));
    }
}
