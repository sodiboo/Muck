using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PowerupUI : MonoBehaviour
{
    public GameObject uiPrefab;

    private GridLayout gridLayout;

    private Dictionary<int, GameObject> powerups;

    public static PowerupUI Instance;

    private void Awake()
    {
        Instance = this;
        powerups = new Dictionary<int, GameObject>();
        gridLayout = GetComponent<GridLayout>();
    }

    public void AddPowerup(int powerupId)
    {
        if (powerups.ContainsKey(powerupId))
        {
            TextMeshProUGUI componentInChildren = powerups[powerupId].GetComponentInChildren<TextMeshProUGUI>();
            int num = int.Parse(componentInChildren.text);
            num++;
            componentInChildren.text = string.Concat(num);
        }
        else
        {
            GameObject gameObject = Object.Instantiate(uiPrefab, base.transform);
            Powerup powerup = ItemManager.Instance.allPowerups[powerupId];
            gameObject.GetComponent<Image>().sprite = powerup.sprite;
            gameObject.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = string.Concat(1);
            gameObject.GetComponent<PowerupInfo>().powerup = powerup;
            powerups.Add(powerupId, gameObject);
        }
    }
}
