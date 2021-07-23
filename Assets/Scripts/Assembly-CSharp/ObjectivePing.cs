using TMPro;
using UnityEngine;

public class ObjectivePing : MonoBehaviour
{
    public TextMeshProUGUI text;

    private float defaultScale = 0.4f;

    private void Awake()
    {
        base.transform.parent = null;
    }

    public void SetText(string s)
    {
        text.text = s;
    }

    private void Update()
    {
        if ((bool)PlayerMovement.Instance)
        {
            float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
            if (num < 5f)
            {
                num = 0f;
            }
            if (num > 5000f)
            {
                num = 5000f;
            }
            base.transform.localScale = defaultScale * num * Vector3.one;
        }
    }
}
