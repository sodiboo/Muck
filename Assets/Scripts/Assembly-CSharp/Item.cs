using System;
using UnityEngine;

// Token: 0x02000053 RID: 83
public class Item : MonoBehaviour
{
	// Token: 0x17000013 RID: 19
	// (get) Token: 0x060001D1 RID: 465 RVA: 0x0000B64B File Offset: 0x0000984B
	// (set) Token: 0x060001D2 RID: 466 RVA: 0x0000B653 File Offset: 0x00009853
	public InventoryItem item { get; set; }

	// Token: 0x17000014 RID: 20
	// (get) Token: 0x060001D3 RID: 467 RVA: 0x0000B65C File Offset: 0x0000985C
	// (set) Token: 0x060001D4 RID: 468 RVA: 0x0000B664 File Offset: 0x00009864
	public Powerup powerup { get; set; }

	// Token: 0x060001D5 RID: 469 RVA: 0x0000B66D File Offset: 0x0000986D
	private void Awake()
	{
		this.outlineMat = base.GetComponent<MeshRenderer>().material;
		Invoke(nameof(ReadyToPickup), this.pickupDelay);
		if (LocalClient.serverOwner)
		{
			Invoke(nameof(DespawnItem), 300f);
		}
	}

	// Token: 0x060001D6 RID: 470 RVA: 0x0000B6A8 File Offset: 0x000098A8
	private void Start()
	{
		if (this.item && this.item.tag == InventoryItem.ItemTag.Gem)
		{
			Debug.LogError("gem dropped");
			Map.Instance.AddMarker(base.transform, Map.MarkerType.Gem, this.item.sprite.texture, Color.white, "", 1f);
		}
	}

	// Token: 0x060001D7 RID: 471 RVA: 0x0000B70C File Offset: 0x0000990C
	public void UpdateMesh()
	{
		if (this.powerup)
		{
			this.outlineMat.mainTexture = this.powerup.material.mainTexture;
			this.outlineMat.SetColor("_Color", this.powerup.material.color);
			base.GetComponent<MeshFilter>().mesh = this.powerup.mesh;
			Renderer component = Instantiate<GameObject>(this.powerupParticles, base.transform).GetComponent<ParticleSystem>().GetComponent<Renderer>();
			Material material = component.material;
			material.color = this.powerup.GetOutlineColor();
			material.SetColor("_EmissionColor", this.powerup.GetOutlineColor() * 3f);
			component.material = material;
			base.gameObject.AddComponent<FloatItem>();
			base.GetComponent<Rigidbody>().isKinematic = true;
		}
		if (this.item)
		{
			this.outlineMat.mainTexture = this.item.material.mainTexture;
			if (this.item.material.HasProperty("_Color"))
			{
				this.outlineMat.SetColor("_Color", this.item.material.color);
			}
			base.GetComponent<MeshFilter>().mesh = this.item.mesh;
		}
		this.outlineMat.SetFloat("_OutlineWidth", 0.06f);
		this.FindOutlineColor();
	}

	// Token: 0x060001D8 RID: 472 RVA: 0x0000B87C File Offset: 0x00009A7C
	private void FindOutlineColor()
	{
		if (this.powerup)
		{
			this.outlineMat.SetColor("_OutlineColor", this.powerup.GetOutlineColor());
			return;
		}
		if (this.item)
		{
			this.outlineMat.SetColor("_OutlineColor", this.item.GetOutlineColor());
		}
	}

	// Token: 0x060001D9 RID: 473 RVA: 0x0000B8DC File Offset: 0x00009ADC
	private void OnTriggerStay(Collider other)
	{
		if (this.pickedUp || !this.readyToPickUp || InventoryUI.Instance.pickupCooldown)
		{
			return;
		}
		if (other.gameObject.layer != LayerMask.NameToLayer("Player"))
		{
			return;
		}
		if (!other.gameObject.CompareTag("Local"))
		{
			return;
		}
		if (this.item && !InventoryUI.Instance.CanPickup(this.item))
		{
			return;
		}
		this.pickedUp = true;
		ClientSend.PickupItem(this.objectID);
		InventoryUI.Instance.CheckInventoryAlmostFull();
	}

	// Token: 0x060001DA RID: 474 RVA: 0x0000B96D File Offset: 0x00009B6D
	private void ReadyToPickup()
	{
		this.readyToPickUp = true;
	}

	// Token: 0x060001DB RID: 475 RVA: 0x0000B976 File Offset: 0x00009B76
	private void DespawnItem()
	{
		if (this.item != null && this.item.important)
		{
			return;
		}
		ItemManager.Instance.PickupItem(this.objectID);
		ServerSend.PickupItem(-1, this.objectID);
	}

	// Token: 0x040001EB RID: 491
	public float pickupDelay = 0.85f;

	// Token: 0x040001EC RID: 492
	public int objectID;

	// Token: 0x040001EF RID: 495
	private bool pickedUp;

	// Token: 0x040001F0 RID: 496
	private bool readyToPickUp;

	// Token: 0x040001F1 RID: 497
	private Material outlineMat;

	// Token: 0x040001F2 RID: 498
	public GameObject powerupParticles;
}
