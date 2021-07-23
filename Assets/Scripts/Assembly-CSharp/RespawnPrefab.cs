using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class RespawnPrefab : MonoBehaviour
{
    public RawImage overlay;

    public Button button;

    public TextMeshProUGUI nameText;

    public int playerId { get; set; }

    public void Set(int id, bool active, string username)
    {
        playerId = id;
        overlay.gameObject.SetActive(!active);
        button.enabled = active;
        nameText.text = username;
    }

    public void RespawnPlayer()
    {
        Debug.LogError("requesting revive");
        RespawnTotemUI.Instance.RequestRevive(playerId);
    }
}
