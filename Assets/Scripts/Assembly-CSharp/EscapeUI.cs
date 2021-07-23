using UnityEngine;
using UnityEngine.UI;

public class EscapeUI : MonoBehaviour
{
    public Button backBtn;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            backBtn.onClick.Invoke();
            UiSfx.Instance.PlayClick();
        }
    }
}
