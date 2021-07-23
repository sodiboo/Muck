using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class GameoverUI : MonoBehaviour
{
    public TextMeshProUGUI header;

    public TextMeshProUGUI nameText;

    public GameObject statPrefab;

    public List<StatPrefab> statPrefabs;

    public Transform statsParent;

    private int page;

    private void Awake()
    {
        HeaderText();
        InitStats();
        FillStats();
    }

    private void InitStats()
    {
        for (int i = 0; i < Player.allStats.Length; i++)
        {
            statPrefabs.Add(Object.Instantiate(statPrefab, statsParent).GetComponent<StatPrefab>());
        }
    }

    private void FillStats()
    {
        int num = page;
        Dictionary<string, int> obj = GameManager.instance.stats[num];
        int num2 = 0;
        foreach (KeyValuePair<string, int> item in obj)
        {
            if (num2 == 0)
            {
                nameText.text = GameManager.players[item.Value].username ?? "";
            }
            else
            {
                statPrefabs[num2 - 1].SetStat(item);
            }
            num2++;
        }
    }

    public void FlipPage(int dir)
    {
        if ((dir >= 0 || page > 0) && (dir <= 0 || page < GameManager.instance.nStatsPlayers - 1))
        {
            page += dir;
            FillStats();
        }
    }

    private void HeaderText()
    {
        int winnerId = GameManager.instance.winnerId;
        switch (winnerId)
        {
        case -3:
            header.text = "Victory!";
            return;
        case -2:
            header.text = "Defeat..";
            return;
        case -1:
            header.text = "Draw...";
            return;
        }
        string username = GameManager.players[winnerId].username;
        username = Truncate(username, 10);
        header.text = username + " won!";
    }

    public static string Truncate(string value, int maxLength)
    {
        if (string.IsNullOrEmpty(value))
        {
            return value;
        }
        if (value.Length > maxLength)
        {
            return value.Substring(0, maxLength);
        }
        return value;
    }
}
