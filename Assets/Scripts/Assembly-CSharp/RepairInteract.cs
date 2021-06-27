using System;
using UnityEngine;
using UnityEngine.Rendering;

public class RepairInteract : MonoBehaviour, Interactable, SharedObject
{
	private void Start()
	{
		float num = 1f;
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		num += (float)playersInLobby * 0.15f;
		num = Mathf.Clamp(num, 1f, 2f);
		for (int i = 0; i < this.requirements.Length; i++)
		{
			this.requirements[i] = Instantiate<InventoryItem>(this.requirements[i]);
			this.requirements[i].amount = (int)((float)this.amounts[i] * num);
		}
		this.render = base.GetComponent<MeshRenderer>();
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	private void SlowUpdate()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	public void Interact()
	{
		if (!InventoryUI.Instance.CanRepair(this.requirements))
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	public void LocalExecute()
	{
		InventoryUI.Instance.Repair(this.requirements);
	}

	public void AllExecute()
	{
		Instantiate<GameObject>(this.repairFx, base.transform.position, Quaternion.identity);
		if (this.replace)
		{
			if (this.fixedObject)
			{
				this.fixedObject.SetActive(true);
			}
			base.gameObject.SetActive(false);
		}
		else
		{
			this.render = base.GetComponent<MeshRenderer>();
			this.render.material = this.fixedMaterial;
			this.render.shadowCastingMode = ShadowCastingMode.On;
			base.gameObject.layer = LayerMask.NameToLayer("Object");
			Collider[] components = base.GetComponents<Collider>();
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].isTrigger)
				{
					Destroy(components[i]);
				}
				else
				{
					components[i].enabled = true;
				}
			}
		}
		GameObject[] array = this.toActive;
		for (int j = 0; j < array.Length; j++)
		{
			array[j].SetActive(true);
		}
		array = this.toInactive;
		for (int j = 0; j < array.Length; j++)
		{
			array[j].SetActive(false);
		}
		Destroy(this);
	}

	public void ServerExecute(int fromClient = -1)
	{
	}

	public void RemoveObject()
	{
	}

	public string GetName()
	{
		string text = this.name;
		text += "<size=75%>";
		foreach (InventoryItem inventoryItem in this.requirements)
		{
			text += string.Format("\n{0} ({1})", inventoryItem.name, inventoryItem.amount);
		}
		return text;
	}

	public bool IsStarted()
	{
		return false;
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	public new string name;

	private int id;

	public bool replace;

	public GameObject fixedObject;

	public GameObject repairFx;

	public Material outlineMat;

	private Material defaultMat;

	private MeshRenderer render;

	public GameObject[] toActive;

	public GameObject[] toInactive;

	public Material fixedMaterial;

	public InventoryItem[] requirements;

	public int[] amounts;
}
