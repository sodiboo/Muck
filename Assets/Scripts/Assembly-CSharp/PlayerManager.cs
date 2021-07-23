using System;
using TMPro;
using UnityEngine;

public class PlayerManager : MonoBehaviour, IComparable
{
    public int id;

    public string username;

    public bool dead;

    public Color color;

    public OnlinePlayer onlinePlayer;

    public int kills;

    public int deaths;

    public int ping;

    public bool disconnected;

    public bool loaded;

    public TextMeshProUGUI nameText;

    public HitableActor hitable;

    private Collider collider;

    public Transform spectateOrbit;

    public int graveId { get; set; }

    private void Awake()
    {
        hitable = GetComponent<HitableActor>();
        collider = GetComponent<Collider>();
    }

    public void DamagePlayer(int hpLeft)
    {
        if ((bool)onlinePlayer)
        {
            SetDesiredHpRatio((float)hpLeft / 100f);
        }
        else
        {
            PlayerStatus.Instance.Damage(hpLeft);
        }
    }

    public void SetHpRatio(float hpRatio)
    {
        if ((bool)onlinePlayer)
        {
            SetDesiredHpRatio(hpRatio);
        }
    }

    public void RemoveGrave()
    {
        if (graveId != -1)
        {
            ResourceManager.Instance.RemoveInteractItem(graveId);
            graveId = -1;
        }
    }

    public void SetArmor(int armorSlot, int itemId)
    {
        if ((bool)onlinePlayer)
        {
            if (itemId == -1)
            {
                onlinePlayer.armor[armorSlot].gameObject.SetActive(value: false);
                onlinePlayer.armor[armorSlot].material = null;
            }
            else
            {
                onlinePlayer.armor[armorSlot].gameObject.SetActive(value: true);
                InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
                onlinePlayer.armor[armorSlot].material = inventoryItem.material;
            }
        }
    }

    private void Start()
    {
        if ((bool)nameText)
        {
            nameText.text = "";
            TextMeshProUGUI textMeshProUGUI = nameText;
            textMeshProUGUI.text = textMeshProUGUI.text + "\n<size=100%>" + username;
        }
        hitable.SetId(id);
    }

    public void SetDesiredPosition(Vector3 position)
    {
        if ((bool)onlinePlayer)
        {
            onlinePlayer.desiredPos = position;
        }
    }

    public void SetDesiredRotation(float orientationY, float orientationX)
    {
        if ((bool)onlinePlayer)
        {
            onlinePlayer.orientationY = orientationY;
            onlinePlayer.orientationX = orientationX;
        }
    }

    public void SetDesiredHpRatio(float ratio)
    {
        onlinePlayer.hpRatio = ratio;
    }

    public int CompareTo(object obj)
    {
        return 0;
    }

    public Collider GetCollider()
    {
        return collider;
    }
}
