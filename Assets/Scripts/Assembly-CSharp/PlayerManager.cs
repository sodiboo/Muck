using System;
using TMPro;
using UnityEngine;

// Token: 0x020000BD RID: 189
public class PlayerManager : MonoBehaviour, IComparable
{
	// Token: 0x1700003C RID: 60
	// (get) Token: 0x06000578 RID: 1400 RVA: 0x0001C49D File Offset: 0x0001A69D
	// (set) Token: 0x06000579 RID: 1401 RVA: 0x0001C4A5 File Offset: 0x0001A6A5
	public int graveId { get; set; }

	// Token: 0x0600057A RID: 1402 RVA: 0x0001C4AE File Offset: 0x0001A6AE
	private void Awake()
	{
		this.hitable = base.GetComponent<HitableActor>();
		this.collider = base.GetComponent<Collider>();
	}

	// Token: 0x0600057B RID: 1403 RVA: 0x0001C4C8 File Offset: 0x0001A6C8
	public void DamagePlayer(int hpLeft)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio((float)hpLeft / 100f);
			return;
		}
		PlayerStatus.Instance.Damage(hpLeft, false);
	}

	// Token: 0x0600057C RID: 1404 RVA: 0x0001C4F2 File Offset: 0x0001A6F2
	public void SetHpRatio(float hpRatio)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio(hpRatio);
		}
	}

	// Token: 0x0600057D RID: 1405 RVA: 0x0001C508 File Offset: 0x0001A708
	public void RemoveGrave()
	{
		if (this.graveId == -1)
		{
			return;
		}
		ResourceManager.Instance.RemoveInteractItem(this.graveId);
		this.graveId = -1;
	}

	// Token: 0x0600057E RID: 1406 RVA: 0x0001C52C File Offset: 0x0001A72C
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

	// Token: 0x0600057F RID: 1407 RVA: 0x0001C5B8 File Offset: 0x0001A7B8
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

	// Token: 0x06000580 RID: 1408 RVA: 0x0001C614 File Offset: 0x0001A814
	public void SetDesiredPosition(Vector3 position)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.desiredPos = position;
		}
	}

	// Token: 0x06000581 RID: 1409 RVA: 0x0001C62F File Offset: 0x0001A82F
	public void SetDesiredRotation(float orientationY, float orientationX)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.orientationY = orientationY;
			this.onlinePlayer.orientationX = orientationX;
		}
	}

	// Token: 0x06000582 RID: 1410 RVA: 0x0001C656 File Offset: 0x0001A856
	public void SetDesiredHpRatio(float ratio)
	{
		this.onlinePlayer.hpRatio = ratio;
	}

	// Token: 0x06000583 RID: 1411 RVA: 0x00007C91 File Offset: 0x00005E91
	public int CompareTo(object obj)
	{
		return 0;
	}

	// Token: 0x06000584 RID: 1412 RVA: 0x0001C664 File Offset: 0x0001A864
	public Collider GetCollider()
	{
		return this.collider;
	}

	// Token: 0x040004D2 RID: 1234
	public int id;

	// Token: 0x040004D3 RID: 1235
	public string username;

	// Token: 0x040004D4 RID: 1236
	public bool dead;

	// Token: 0x040004D5 RID: 1237
	public Color color;

	// Token: 0x040004D6 RID: 1238
	public OnlinePlayer onlinePlayer;

	// Token: 0x040004D7 RID: 1239
	public int kills;

	// Token: 0x040004D8 RID: 1240
	public int deaths;

	// Token: 0x040004D9 RID: 1241
	public int ping;

	// Token: 0x040004DA RID: 1242
	public bool disconnected;

	// Token: 0x040004DB RID: 1243
	public bool loaded;

	// Token: 0x040004DD RID: 1245
	public TextMeshProUGUI nameText;

	// Token: 0x040004DE RID: 1246
	public HitableActor hitable;

	// Token: 0x040004DF RID: 1247
	private Collider collider;

	// Token: 0x040004E0 RID: 1248
	public Transform spectateOrbit;
}
