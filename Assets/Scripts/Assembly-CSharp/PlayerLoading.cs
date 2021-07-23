using TMPro;
using UnityEngine;

public class PlayerLoading : MonoBehaviour
{
    public new TextMeshProUGUI name;

    public TextMeshProUGUI status;

    public void SetStatus(string name, string status)
    {
        this.name.text = name;
        this.status.text = status;
    }

    public void ChangeStatus(string status)
    {
        this.status.text = status;
    }
}
