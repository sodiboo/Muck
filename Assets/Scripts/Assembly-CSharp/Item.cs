
using UnityEngine;

// Token: 0x02000039 RID: 57
public class Item : MonoBehaviour
{
	// Token: 0x1700000B RID: 11
	// (get) Token: 0x06000140 RID: 320 RVA: 0x00008AF3 File Offset: 0x00006CF3
	// (set) Token: 0x06000141 RID: 321 RVA: 0x00008AFB File Offset: 0x00006CFB
	public InventoryItem item { get; set; }

	// Token: 0x1700000C RID: 12
	// (get) Token: 0x06000142 RID: 322 RVA: 0x00008B04 File Offset: 0x00006D04
	// (set) Token: 0x06000143 RID: 323 RVA: 0x00008B0C File Offset: 0x00006D0C
	public Powerup powerup { get; set; }

	// Token: 0x06000144 RID: 324 RVA: 0x00008B15 File Offset: 0x00006D15
	private void Awake()
	{
		this.outlineMat = base.GetComponent<MeshRenderer>().material;
		base.Invoke("ReadyToPickup", this.pickupDelay);
		if (LocalClient.serverOwner)
		{
			base.Invoke("DespawnItem", 300f);
		}
	}

	// Token: 0x06000145 RID: 325 RVA: 0x00008B50 File Offset: 0x00006D50
	public void UpdateMesh()
	{
		if (this.powerup)
		{
			this.outlineMat.mainTexture = this.powerup.material.mainTexture;
			this.outlineMat.SetColor("_Color", this.powerup.material.color);
			base.GetComponent<MeshFilter>().mesh = this.powerup.mesh;
			Renderer component =Instantiate(this.powerupParticles, base.transform).GetComponent<ParticleSystem>().GetComponent<Renderer>();
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

	// Token: 0x06000146 RID: 326 RVA: 0x00008CC0 File Offset: 0x00006EC0
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

	// Token: 0x06000147 RID: 327 RVA: 0x00008D20 File Offset: 0x00006F20
	private void OnTriggerStay(Collider other)
	{
		if (this.pickedUp || !this.readyToPickUp)
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
	}

	// Token: 0x06000148 RID: 328 RVA: 0x00008D9B File Offset: 0x00006F9B
	private void ReadyToPickup()
	{
		this.readyToPickUp = true;
	}

	// Token: 0x06000149 RID: 329 RVA: 0x00008DA4 File Offset: 0x00006FA4
	private void DespawnItem()
	{
		ItemManager.Instance.PickupItem(this.objectID);
		ServerSend.PickupItem(-1, this.objectID);
	}

	// Token: 0x04000144 RID: 324
	public float pickupDelay = 0.85f;

	// Token: 0x04000145 RID: 325
	public int objectID;

	// Token: 0x04000148 RID: 328
	private bool pickedUp;

	// Token: 0x04000149 RID: 329
	private bool readyToPickUp;

	// Token: 0x0400014A RID: 330
	private Material outlineMat;

	// Token: 0x0400014B RID: 331
	public GameObject powerupParticles;
}
