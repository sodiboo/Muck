using System;
using TMPro;
using UnityEngine;

// Token: 0x02000096 RID: 150
public class PlayerManager : MonoBehaviour, IComparable
{
	// Token: 0x17000030 RID: 48
	// (get) Token: 0x0600047B RID: 1147 RVA: 0x00016D8D File Offset: 0x00014F8D
	// (set) Token: 0x0600047C RID: 1148 RVA: 0x00016D95 File Offset: 0x00014F95
	public int graveId { get; set; }

	// Token: 0x0600047D RID: 1149 RVA: 0x00016D9E File Offset: 0x00014F9E
	private void Awake()
	{
		this.hitable = base.GetComponent<HitableActor>();
		this.collider = base.GetComponent<Collider>();
	}

	// Token: 0x0600047E RID: 1150 RVA: 0x00016DB8 File Offset: 0x00014FB8
	public void DamagePlayer(int hpLeft)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio((float)hpLeft / 100f);
			return;
		}
		PlayerStatus.Instance.Damage(hpLeft);
	}

	// Token: 0x0600047F RID: 1151 RVA: 0x00016DE1 File Offset: 0x00014FE1
	public void SetHpRatio(float hpRatio)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio(hpRatio);
		}
	}

	// Token: 0x06000480 RID: 1152 RVA: 0x00016DF7 File Offset: 0x00014FF7
	public void RemoveGrave()
	{
		if (this.graveId == -1)
		{
			return;
		}
		ResourceManager.Instance.RemoveInteractItem(this.graveId);
		this.graveId = -1;
	}

	// Token: 0x06000481 RID: 1153 RVA: 0x00016E1C File Offset: 0x0001501C
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

	// Token: 0x06000482 RID: 1154 RVA: 0x00016EA8 File Offset: 0x000150A8
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

	// Token: 0x06000483 RID: 1155 RVA: 0x00016F04 File Offset: 0x00015104
	public void SetDesiredPosition(Vector3 position)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.desiredPos = position;
		}
	}

	// Token: 0x06000484 RID: 1156 RVA: 0x00016F1F File Offset: 0x0001511F
	public void SetDesiredRotation(float orientationY, float orientationX)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.orientationY = orientationY;
			this.onlinePlayer.orientationX = orientationX;
		}
	}

	// Token: 0x06000485 RID: 1157 RVA: 0x00016F46 File Offset: 0x00015146
	public void SetDesiredHpRatio(float ratio)
	{
		this.onlinePlayer.hpRatio = ratio;
	}

	// Token: 0x06000486 RID: 1158 RVA: 0x00016F54 File Offset: 0x00015154
	public int CompareTo(object obj)
	{
		return 0;
	}

	// Token: 0x06000487 RID: 1159 RVA: 0x00016F57 File Offset: 0x00015157
	public Collider GetCollider()
	{
		return this.collider;
	}

	// Token: 0x040003C3 RID: 963
	public int id;

	// Token: 0x040003C4 RID: 964
	public string username;

	// Token: 0x040003C5 RID: 965
	public bool dead;

	// Token: 0x040003C6 RID: 966
	public Color color;

	// Token: 0x040003C7 RID: 967
	public OnlinePlayer onlinePlayer;

	// Token: 0x040003C8 RID: 968
	public int kills;

	// Token: 0x040003C9 RID: 969
	public int deaths;

	// Token: 0x040003CA RID: 970
	public int ping;

	// Token: 0x040003CB RID: 971
	public bool disconnected;

	// Token: 0x040003CC RID: 972
	public bool loaded;

	// Token: 0x040003CE RID: 974
	public TextMeshProUGUI nameText;

	// Token: 0x040003CF RID: 975
	public HitableActor hitable;

	// Token: 0x040003D0 RID: 976
	private Collider collider;

	// Token: 0x040003D1 RID: 977
	public Transform spectateOrbit;
}
