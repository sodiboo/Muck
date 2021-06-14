using System;
using UnityEngine;

// Token: 0x02000046 RID: 70
public class Item : MonoBehaviour
{
	// Token: 0x1700000D RID: 13
	// (get) Token: 0x06000167 RID: 359 RVA: 0x00003144 File Offset: 0x00001344
	// (set) Token: 0x06000168 RID: 360 RVA: 0x0000314C File Offset: 0x0000134C
	public InventoryItem item { get; set; }

	// Token: 0x1700000E RID: 14
	// (get) Token: 0x06000169 RID: 361 RVA: 0x00003155 File Offset: 0x00001355
	// (set) Token: 0x0600016A RID: 362 RVA: 0x0000315D File Offset: 0x0000135D
	public Powerup powerup { get; set; }

	// Token: 0x0600016B RID: 363 RVA: 0x00003166 File Offset: 0x00001366
	private void Awake()
	{
		this.outlineMat = base.GetComponent<MeshRenderer>().material;
		base.Invoke("ReadyToPickup", this.pickupDelay);
		if (LocalClient.serverOwner)
		{
			base.Invoke("DespawnItem", 300f);
		}
	}

	// Token: 0x0600016C RID: 364 RVA: 0x0000D788 File Offset: 0x0000B988
	public void UpdateMesh()
	{
		if (this.powerup)
		{
			this.outlineMat.mainTexture = this.powerup.material.mainTexture;
			this.outlineMat.SetColor("_Color", this.powerup.material.color);
			base.GetComponent<MeshFilter>().mesh = this.powerup.mesh;
			Renderer component =Instantiate<GameObject>(this.powerupParticles, base.transform).GetComponent<ParticleSystem>().GetComponent<Renderer>();
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

	// Token: 0x0600016D RID: 365 RVA: 0x0000D8F8 File Offset: 0x0000BAF8
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

	// Token: 0x0600016E RID: 366 RVA: 0x0000D958 File Offset: 0x0000BB58
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

	// Token: 0x0600016F RID: 367 RVA: 0x000031A1 File Offset: 0x000013A1
	private void ReadyToPickup()
	{
		this.readyToPickUp = true;
	}

	// Token: 0x06000170 RID: 368 RVA: 0x000031AA File Offset: 0x000013AA
	private void DespawnItem()
	{
		ItemManager.Instance.PickupItem(this.objectID);
		ServerSend.PickupItem(-1, this.objectID);
	}

	// Token: 0x04000179 RID: 377
	public float pickupDelay = 0.85f;

	// Token: 0x0400017A RID: 378
	public int objectID;

	// Token: 0x0400017D RID: 381
	private bool pickedUp;

	// Token: 0x0400017E RID: 382
	private bool readyToPickUp;

	// Token: 0x0400017F RID: 383
	private Material outlineMat;

	// Token: 0x04000180 RID: 384
	public GameObject powerupParticles;
}
