using TMPro;
using UnityEngine;

public class RespawnTotemUI : MonoBehaviour
{
    public GameObject namePrefab;

    public Transform nameContainer;

    public GameObject root;

    public TextMeshProUGUI respawnPrice;

    public int basePrice = 50;

    public static RespawnTotemUI Instance;

    public bool active { get; set; }

    private void Awake()
    {
        Instance = this;
    }

    public void Show()
    {
        root.SetActive(value: true);
        respawnPrice.text = string.Concat(GetRevivePrice());
        Refresh();
        active = true;
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }

    public void Hide()
    {
        root.SetActive(value: false);
        active = false;
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    public void RequestRevive(int playerId)
    {
        Debug.LogError("trying");
        if (InventoryUI.Instance.GetMoney() >= GetRevivePrice())
        {
            PlayerManager playerManager = GameManager.players[playerId];
            if (!(playerManager == null) && !playerManager.disconnected && playerManager.dead)
            {
                Debug.LogError("sendinging revie");
                ClientSend.RevivePlayer(playerId);
            }
        }
    }

    public int GetRevivePrice()
    {
        GameSettings gameSettings = GameManager.gameSettings;
        float num = 1f;
        if (gameSettings.difficulty == GameSettings.Difficulty.Gamer)
        {
            num = 1.2f;
        }
        else if (gameSettings.difficulty == GameSettings.Difficulty.Easy)
        {
            num = 0.8f;
        }
        float num2 = 5f;
        float min = num;
        float value = num * (1f + (float)(GameManager.instance.currentDay - 2) / num2);
        value = Mathf.Clamp(value, min, 100f);
        return (int)((float)basePrice * value);
    }

    public void Refresh()
    {
        for (int num = nameContainer.childCount - 1; num >= 0; num--)
        {
            Object.Destroy(nameContainer.GetChild(num).gameObject);
        }
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if (!(value == null) && !(value == null) && !value.disconnected && value.dead)
            {
                Object.Instantiate(namePrefab, nameContainer).GetComponent<RespawnPrefab>().Set(value.id, InventoryUI.Instance.GetMoney() >= GetRevivePrice(), value.username);
            }
        }
    }
}
