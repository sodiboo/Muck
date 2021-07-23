using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ExtraUI : MonoBehaviour
{
    public TextMeshProUGUI money;

    public TextMeshProUGUI clockText;

    public TextMeshProUGUI dayText;

    private Dictionary<int, RawImage> IdToHpBar;

    public GameObject playerStatusPrefab;

    public RectTransform playerStatusParent;

    private void Awake()
    {
        IdToHpBar = new Dictionary<int, RawImage>();
        InvokeRepeating("SlowUpdate", 0f, 1f);
    }

    private void SlowUpdate()
    {
        UpdateClock();
        UpdateMoney();
        UpdateAllHpBars();
    }

    public void InitPlayerStatus(int id, string name, PlayerManager pm)
    {
        GameObject obj = Object.Instantiate(playerStatusPrefab, playerStatusParent);
        RawImage component = obj.transform.GetChild(1).GetChild(1).GetChild(0)
            .GetComponent<RawImage>();
        IdToHpBar.Add(id, component);
        Vector2 sizeDelta = playerStatusParent.sizeDelta;
        sizeDelta.y += 40f;
        playerStatusParent.sizeDelta = sizeDelta;
        obj.transform.GetComponentInChildren<TextMeshProUGUI>().text = name;
        float scale = 0.85f;
        if (pm.id == LocalClient.instance.myId)
        {
            scale = 1f;
        }
        Map.Instance.AddMarker(pm.transform, Map.MarkerType.Player, null, Color.white, name, scale);
    }

    private void UpdateClock()
    {
        clockText.text = TimeToClock();
    }

    private void UpdateMoney()
    {
        money.text = string.Concat(InventoryUI.Instance.GetMoney());
    }

    private void UpdateAllHpBars()
    {
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if (!(value == null))
            {
                UpdatePlayerHp(value.id);
            }
        }
        List<int> list = new List<int>();
        foreach (int key in IdToHpBar.Keys)
        {
            if (!GameManager.players.ContainsKey(key))
            {
                list.Add(key);
            }
        }
        foreach (int item in list)
        {
            GameObject obj = IdToHpBar[item].transform.parent.parent.parent.gameObject;
            IdToHpBar.Remove(item);
            Object.Destroy(obj.gameObject);
        }
    }

    public void UpdateDay(int day)
    {
        dayText.text = string.Concat(day);
    }

    private void UpdatePlayerHp(int id)
    {
        if (!IdToHpBar.ContainsKey(id))
        {
            return;
        }
        RawImage rawImage = IdToHpBar[id];
        float x = 0f;
        if (id == LocalClient.instance.myId)
        {
            x = (float)PlayerStatus.Instance.HpAndShield() / (float)PlayerStatus.Instance.MaxHpAndShield();
        }
        else if (GameManager.players[id] != null)
        {
            x = GameManager.players[id].onlinePlayer.hpRatio;
            x = Mathf.Clamp(x, 0f, 1f);
            if (GameManager.players[id].dead || GameManager.players[id].disconnected)
            {
                x = 0f;
            }
        }
        rawImage.transform.localScale = new Vector3(x, 1f, 1f);
    }

    private string TimeToClock()
    {
        float time = DayCycle.time;
        int num = (12 + (int)(time * 24f)) % 24;
        string text = "00";
        return num + ":" + text;
    }
}
