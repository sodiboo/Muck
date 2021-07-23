using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class StatPrefab : MonoBehaviour
{
    public TextMeshProUGUI statName;

    public TextMeshProUGUI statValue;

    public void SetStat(KeyValuePair<string, int> s)
    {
        statName.text = s.Key + " |";
        statValue.text = string.Concat(s.Value);
    }
}
