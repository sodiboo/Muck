using System;
using TMPro;
using UnityEngine;

// Token: 0x020000C5 RID: 197
public class PlayerManager : MonoBehaviour, IComparable
{
	// Token: 0x17000038 RID: 56
	// (get) Token: 0x060004F2 RID: 1266 RVA: 0x0000545A File Offset: 0x0000365A
	// (set) Token: 0x060004F3 RID: 1267 RVA: 0x00005462 File Offset: 0x00003662
	public int graveId { get; set; }

	// Token: 0x060004F4 RID: 1268 RVA: 0x0000546B File Offset: 0x0000366B
	private void Awake()
	{
		this.hitable = base.GetComponent<HitableActor>();
		this.collider = base.GetComponent<Collider>();
	}

	// Token: 0x060004F5 RID: 1269 RVA: 0x00005485 File Offset: 0x00003685
	public void DamagePlayer(int hpLeft)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio((float)hpLeft / 100f);
			return;
		}
		PlayerStatus.Instance.Damage(hpLeft, false);
	}

	// Token: 0x060004F6 RID: 1270 RVA: 0x000054AF File Offset: 0x000036AF
	public void SetHpRatio(float hpRatio)
	{
		if (this.onlinePlayer)
		{
			this.SetDesiredHpRatio(hpRatio);
		}
	}

	// Token: 0x060004F7 RID: 1271 RVA: 0x000054C5 File Offset: 0x000036C5
	public void RemoveGrave()
	{
		if (this.graveId == -1)
		{
			return;
		}
		ResourceManager.Instance.RemoveInteractItem(this.graveId);
		this.graveId = -1;
	}

	// Token: 0x060004F8 RID: 1272 RVA: 0x0001AFA4 File Offset: 0x000191A4
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

	// Token: 0x060004F9 RID: 1273 RVA: 0x0001B030 File Offset: 0x00019230
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

	// Token: 0x060004FA RID: 1274 RVA: 0x000054E9 File Offset: 0x000036E9
	public void SetDesiredPosition(Vector3 position)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.desiredPos = position;
		}
	}

	// Token: 0x060004FB RID: 1275 RVA: 0x00005504 File Offset: 0x00003704
	public void SetDesiredRotation(float orientationY, float orientationX)
	{
		if (this.onlinePlayer)
		{
			this.onlinePlayer.orientationY = orientationY;
			this.onlinePlayer.orientationX = orientationX;
		}
	}

	// Token: 0x060004FC RID: 1276 RVA: 0x0000552B File Offset: 0x0000372B
	public void SetDesiredHpRatio(float ratio)
	{
		this.onlinePlayer.hpRatio = ratio;
	}

	// Token: 0x060004FD RID: 1277 RVA: 0x00002EB3 File Offset: 0x000010B3
	public int CompareTo(object obj)
	{
		return 0;
	}

	// Token: 0x060004FE RID: 1278 RVA: 0x00005539 File Offset: 0x00003739
	public Collider GetCollider()
	{
		return this.collider;
	}

	// Token: 0x04000494 RID: 1172
	public int id;

	// Token: 0x04000495 RID: 1173
	public string username;

	// Token: 0x04000496 RID: 1174
	public bool dead;

	// Token: 0x04000497 RID: 1175
	public Color color;

	// Token: 0x04000498 RID: 1176
	public OnlinePlayer onlinePlayer;

	// Token: 0x04000499 RID: 1177
	public int kills;

	// Token: 0x0400049A RID: 1178
	public int deaths;

	// Token: 0x0400049B RID: 1179
	public int ping;

	// Token: 0x0400049C RID: 1180
	public bool disconnected;

	// Token: 0x0400049D RID: 1181
	public bool loaded;

	// Token: 0x0400049F RID: 1183
	public TextMeshProUGUI nameText;

	// Token: 0x040004A0 RID: 1184
	public HitableActor hitable;

	// Token: 0x040004A1 RID: 1185
	private Collider collider;

	// Token: 0x040004A2 RID: 1186
	public Transform spectateOrbit;
}
