using TMPro;
using UnityEngine;

public class GravePing : MonoBehaviour
{
    public TextMeshProUGUI pingText;

    private float defaultScale = 0.4f;

    private GraveInteract grave;

    private GameObject child;

    private void Awake()
    {
        child = base.transform.GetChild(0).gameObject;
        grave = base.transform.root.GetComponentInChildren<GraveInteract>();
    }

    public void SetPing(string name)
    {
        pingText.text = $"Revive {grave.username} ({grave.timeLeft}";
    }

    private void Update()
    {
        if (DayCycle.time <= 0.5f)
        {
            child.SetActive(value: true);
            string text = "";
            if (grave.timeLeft > 0f)
            {
                text = $"({(int)grave.timeLeft})";
            }
            pingText.text = "Revive " + grave.username + " " + text;
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
        else
        {
            child.SetActive(value: false);
        }
    }
}
