using System;
using UnityEngine;

public class Item : MonoBehaviour
{
	public InventoryItem item { get; set; }

	public Powerup powerup { get; set; }

	private void Awake()
	{
		this.outlineMat = base.GetComponent<MeshRenderer>().material;
		Invoke(nameof(ReadyToPickup), this.pickupDelay);
		if (LocalClient.serverOwner)
		{
			Invoke(nameof(DespawnItem), 300f);
		}
	}

	private void Start()
	{
		if (this.item && this.item.tag == InventoryItem.ItemTag.Gem)
		{
			Debug.LogError("gem dropped");
			Map.Instance.AddMarker(base.transform, Map.MarkerType.Gem, this.item.sprite.texture, Color.white, "", 1f);
		}
	}

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

	private void ReadyToPickup()
	{
		this.readyToPickUp = true;
	}

	private void DespawnItem()
	{
		if (this.item != null && this.item.important)
		{
			return;
		}
		ItemManager.Instance.PickupItem(this.objectID);
		ServerSend.PickupItem(-1, this.objectID);
	}

	public float pickupDelay = 0.85f;

	public int objectID;

	private bool pickedUp;

	private bool readyToPickUp;

	private Material outlineMat;

	public GameObject powerupParticles;
}
