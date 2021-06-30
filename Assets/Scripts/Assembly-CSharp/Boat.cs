using System;
using System.Collections.Generic;
using UnityEngine;

public class Boat : MonoBehaviour
{
	public float waterHeight { get; set; }

	private void Start()
	{
		this.rb = base.GetComponentInChildren<Rigidbody>();
		this.guardians = new List<ShrineGuardian>();
		this.rand = new ConsistentRandom(GameManager.GetSeed());
		Boat.Instance = this;
		InvokeRepeating(nameof(CheckFound), 0.5f, 1f);
		this.boatPing = Instantiate<GameObject>(this.objectivePing, base.transform.position, Quaternion.identity).GetComponent<ObjectivePing>();
		this.boatPing.SetText("?");
		this.boatPing.gameObject.SetActive(false);
		for (int i = 0; i < this.holes.Length; i++)
		{
			if (this.rand.NextDouble() > 0.5)
			{
				Destroy(this.holes[i]);
			}
			else
			{
				Vector3 position = this.holes[i].transform.position;
				float y = position.y;
				RaycastHit raycastHit;
				if (Physics.Raycast(position + Vector3.up * 10f, Vector3.down, out raycastHit, 50f, GameManager.instance.whatIsGround) && raycastHit.point.y > y)
				{
					Destroy(this.holes[i]);
				}
			}
		}
		this.repairs = base.gameObject.GetComponentsInChildren(typeof(RepairInteract), true);
		foreach (RepairInteract repairInteract in this.repairs)
		{
			int nextId = ResourceManager.Instance.GetNextId();
			repairInteract.SetId(nextId);
			ResourceManager.Instance.AddObject(nextId, repairInteract.gameObject);
		}
		if (LocalClient.serverOwner)
		{
			InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
		}
		foreach (RepairInteract repairInteract2 in this.repairs)
		{
		}
		base.gameObject.name = "Boat";
	}

	private void SlowUpdate()
	{
		if (this.CheckBoatFullyRepaired())
		{
			this.SendBoatFinished();
			base.CancelInvoke("SlowUpdate");
		}
	}

	private void SendMarkShip()
	{
		this.MarkShip();
		ClientSend.SendShipStatus(Boat.BoatPackets.MarkShip, -1);
	}

	private void SendShipFound()
	{
		this.FindShip();
		ClientSend.SendShipStatus(Boat.BoatPackets.FindShip, -1);
	}

	private void SendMarkGems()
	{
		this.MarkGems();
		ClientSend.SendShipStatus(Boat.BoatPackets.MarkGems, -1);
	}

	private void SendBoatFinished()
	{
		int nextId = ResourceManager.Instance.GetNextId();
		this.BoatFinished(nextId);
		ClientSend.SendShipStatus(Boat.BoatPackets.FinishBoat, nextId);
	}

	public void UpdateShipStatus(Boat.BoatPackets p, int interactId)
	{
		switch (p)
		{
		case Boat.BoatPackets.MarkShip:
			this.MarkShip();
			return;
		case Boat.BoatPackets.FindShip:
			this.FindShip();
			return;
		case Boat.BoatPackets.MarkGems:
			this.MarkGems();
			return;
		case Boat.BoatPackets.FinishBoat:
			this.BoatFinished(interactId);
			return;
		default:
			return;
		}
	}

	public void LeaveIsland()
	{
		if (this.status == Boat.BoatStatus.LeftIsland)
		{
			return;
		}
		this.status = Boat.BoatStatus.LeftIsland;
		GameManager.instance.boatLeft = true;
		this.sinking = true;
		Destroy(this.wheelInteract.gameObject);
		Destroy(this.wheelPing.gameObject);
		PlayerStatus.Instance.EnterOcean();
	}

	private void FixedUpdate()
	{
		if (this.sinking)
		{
			this.MoveBoat();
		}
	}

	private void MoveBoat()
	{
		float d = 2f;
		Vector3 b = Vector3.up * d * Time.deltaTime;
		World.Instance.water.position += b;
		float y = World.Instance.water.position.y;
		if (this.rb.position.y < y - this.heightUnderWater)
		{
			if (!this.waterSfx.activeInHierarchy)
			{
				this.waterSfx.SetActive(true);
			}
			this.rb.MovePosition(new Vector3(base.transform.position.x, y - this.heightUnderWater, base.transform.position.z));
		}
		if (y > 85f)
		{
			this.sinking = false;
			if (LocalClient.serverOwner)
			{
				float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
				int nextId = MobManager.Instance.GetNextId();
				MobSpawner.Instance.ServerSpawnNewMob(nextId, this.dragonBoss.id, this.dragonSpawnPos.position, 1f, bossMultiplier, Mob.BossType.None, -1);
				List<Mob> list = new List<Mob>();
				foreach (Mob item in MobManager.Instance.mobs.Values)
				{
					list.Add(item);
				}
				for (int i = 0; i < list.Count; i++)
				{
					list[i].hitable.Hit(list[i].hitable.maxHp, 1f, 2, list[i].transform.position);
				}
			}
		}
	}

	public void BoatFinished(int interactId)
	{
		this.wheel.SetActive(true);
		this.wheelPing = Instantiate<GameObject>(this.objectivePing, this.wheel.transform.position, Quaternion.identity).GetComponent<ObjectivePing>();
		this.wheelPing.SetText("");
		this.wheelInteract = this.wheel.AddComponent<FinishGameInteract>();
		this.wheelInteract.SetId(interactId);
		ResourceManager.Instance.AddObject(interactId, this.wheelInteract.gameObject);
	}

	public bool CheckBoatFullyRepaired()
	{
		Component[] array = this.repairs;
		for (int i = 0; i < array.Length; i++)
		{
			if (!(array[i] == null))
			{
				return false;
			}
		}
		return true;
	}

	public void CheckForMap()
	{
		if (this.status == Boat.BoatStatus.Hidden)
		{
			foreach (InventoryCell inventoryCell in InventoryUI.Instance.cells)
			{
				if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.id == this.mapItem.id)
				{
					this.SendMarkShip();
				}
			}
		}
		if (!this.gemsDiscovered)
		{
			foreach (InventoryCell inventoryCell2 in InventoryUI.Instance.cells)
			{
				if (!(inventoryCell2.currentItem == null) && inventoryCell2.currentItem.id == this.gemMap.id)
				{
					this.SendMarkGems();
				}
			}
		}
	}

	private void MarkGems()
	{
		this.gemsDiscovered = true;
		foreach (ShrineGuardian shrineGuardian in this.guardians)
		{
			if (shrineGuardian != null)
			{
				Map.Instance.AddMarker(shrineGuardian.transform, Map.MarkerType.Gem, this.gemTexture, Guardian.TypeToColor(shrineGuardian.type), "?", 1f);
				Map.Instance.AddMarker(shrineGuardian.transform, Map.MarkerType.Gem, this.gemTexture, Guardian.TypeToColor(shrineGuardian.type), "?", 1f);
			}
		}
		ChatBox.Instance.AppendMessage(string.Format("<color=orange>Guardians <color=white>have been located  (\"{0}\" to open map)", InputManager.map));
	}

	private void CheckFound()
	{
		if (this.status != Boat.BoatStatus.Hidden && this.status != Boat.BoatStatus.Marked)
		{
			return;
		}
		if (!PlayerMovement.Instance)
		{
			return;
		}
		if (Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) < 40f)
		{
			this.SendShipFound();
		}
	}

	public void FindShip()
	{
		this.status = Boat.BoatStatus.Found;
		Destroy(this.boatPing.gameObject);
		Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, this.boatTexture, Color.white, "Shipwreck", 1f);
		ChatBox.Instance.AppendMessage(string.Format("<color=orange>Broken Ship <color=white>has been located (\"{0}\" to open map)", InputManager.map));
		Map.Instance.RemoveMarker(this.boatMapMarker);
	}

	public void MarkShip()
	{
		this.status = Boat.BoatStatus.Marked;
		this.boatPing.gameObject.SetActive(true);
		ChatBox.Instance.AppendMessage(string.Format("Something has been marked on your map...  (\"{0}\" to open map)", InputManager.map));
		boatMapMarker = Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, null, Color.white, "", 1f);
	}

	public Boat.BoatStatus status;

	public static Boat Instance;

	public InventoryItem mapItem;

	public InventoryItem gemMap;

	public GameObject objectivePing;

	public ObjectivePing boatPing;

	private ConsistentRandom rand;

	public SpawnChestsInLocations chestSpawner;

	public GameObject[] holes;

	public Texture gemTexture;

	public Texture boatTexture;

	private bool gemsDiscovered;

	public List<ShrineGuardian> guardians;

	public CountPlayersOnBoat countPlayers;

	private float heightUnderWater = 3f;

	private Rigidbody rb;

	public Transform dragonSpawnPos;

	public Camera cinematicCamera;

	public MobType dragonBoss;

	public Transform rbTransform;

	public GameObject waterSfx;

	public Transform dragonLandingPosition;

	public Transform[] landingNodes;

	public GameObject wheel;

	private bool sinking;

	private float amp = 20f;

	private FinishGameInteract wheelInteract;

	public ObjectivePing wheelPing;

	private Component[] repairs;

	public Map.MapMarker boatMapMarker;

	public enum BoatStatus
	{
		Hidden,
		Marked,
		Found,
		LeftIsland
	}

	public enum BoatPackets
	{
		MarkShip,
		FindShip,
		MarkGems,
		FinishBoat
	}
}
