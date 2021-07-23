using TMPro;
using UnityEngine;

public class StatusMessage : MonoBehaviour
{
    public TextMeshProUGUI statusText;

    public GameObject status;

    private Vector3 defaultScale;

    public static StatusMessage Instance;

    private void Awake()
    {
        Instance = this;
        defaultScale = status.transform.localScale;
    }

    private void Update()
    {
        status.transform.localScale = Vector3.Lerp(status.transform.localScale, defaultScale, Time.deltaTime * 25f);
    }

    public void DisplayMessage(string message)
    {
        status.transform.parent.gameObject.SetActive(value: true);
        status.transform.localScale = Vector3.zero;
        statusText.text = message;
    }

    public void OkayDokay()
    {
        status.transform.parent.gameObject.SetActive(value: false);
    }
}
