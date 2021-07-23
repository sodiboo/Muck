using UnityEngine;

public class UiController : MonoBehaviour
{
    public Canvas canvas;

    public static UiController Instance;

    private bool hudActive = true;

    private void Awake()
    {
        Instance = this;
    }

    public void ToggleHud()
    {
        hudActive = !hudActive;
        canvas.enabled = hudActive;
    }
}
