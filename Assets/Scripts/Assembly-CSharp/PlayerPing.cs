using TMPro;
using UnityEngine;

public class PlayerPing : MonoBehaviour
{
    private float desiredScale;

    private float localScale;

    public TextMeshProUGUI pingText;

    private void Awake()
    {
        desiredScale = 1f;
        base.transform.localScale = Vector3.zero;
        Invoke("HidePing", 5f);
    }

    public void SetPing(string username, string item)
    {
        pingText.text = username + "\n<size=75>" + item;
    }

    private void Update()
    {
        localScale = Mathf.Lerp(localScale, desiredScale, Time.deltaTime * 10f);
        float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
        if (num < 7f)
        {
            num = 7f;
        }
        if (num > 100f)
        {
            num = 100f;
        }
        base.transform.localScale = localScale * num * Vector3.one;
    }

    private void HidePing()
    {
        desiredScale = 0f;
    }
}
