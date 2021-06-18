using System;
using UnityEngine;


public class Item : MonoBehaviour
{



	public InventoryItem item { get; set; }




	public Powerup powerup { get; set; }


	private void Awake()
	{
		this.outlineMat = base.GetComponent<MeshRenderer>().material;
		base.Invoke(nameof(ReadyToPickup), this.pickupDelay);
		if (LocalClient.serverOwner)
		{
			base.Invoke(nameof(DespawnItem), 300f);
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
			if (item.type == InventoryItem.ItemType.Car) {
				var scale = Vector3.one;
				scale.Scale(item.prefab.transform.localScale);
				scale.Scale(item.prefab.transform.GetChild(0).localScale);
				transform.localScale = scale;
			}
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
