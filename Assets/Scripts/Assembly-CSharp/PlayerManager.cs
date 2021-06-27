using System;
using TMPro;
using UnityEngine;

public class PlayerManager : MonoBehaviour, IComparable
{
	public int graveId { get; set; }

	private void Awake()
	{
		this.hitable = base.GetComponent<HitableActor>();
		this.collider = base.GetComponent<Collider>();
	}

	public void DamagePlayer(int hpLeft)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio((float)hpLeft / 100f);
			return;
		}
		PlayerStatus.Instance.Damage(hpLeft, false);
	}

	public void SetHpRatio(float hpRatio)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio(hpRatio);
		}
	}

	public void RemoveGrave()
	{
		if (this.graveId == -1)
		{
			return;
		}
		ResourceManager.Instance.RemoveInteractItem(this.graveId);
		this.graveId = -1;
	}

	public void SetArmor(int armorSlot, int itemId)
	{
		if (this.onlinePlayer)
		{
			if (itemId == -1)
			{
				this.onlinePlayer.armor[armorSlot].gameObject.SetActive(false);
				this.onlinePlayer.armor[armorSlot].material = null;
				return;
			}
			this.onlinePlayer.armor[armorSlot].gameObject.SetActive(true);
			InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
			this.onlinePlayer.armor[armorSlot].material = inventoryItem.material;
		}
	}

	private void Start()
	{
		if (this.nameText)
		{
			this.nameText.text = "";
			TextMeshProUGUI textMeshProUGUI = this.nameText;
			textMeshProUGUI.text = textMeshProUGUI.text + "\n<size=100%>" + this.username;
		}
		this.hitable.SetId(this.id);
	}

	public void SetDesiredPosition(Vector3 position)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.desiredPos = position;
		}
	}

	public void SetDesiredRotation(float orientationY, float orientationX)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.orientationY = orientationY;
			this.onlinePlayer.orientationX = orientationX;
		}
	}

	public void SetDesiredHpRatio(float ratio)
	{
		this.onlinePlayer.hpRatio = ratio;
	}

	public int CompareTo(object obj)
	{
		return 0;
	}

	public Collider GetCollider()
	{
		return this.collider;
	}

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
}
