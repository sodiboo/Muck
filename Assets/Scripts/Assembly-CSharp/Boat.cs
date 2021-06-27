using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000006 RID: 6
public class Boat : MonoBehaviour
{
	// Token: 0x17000004 RID: 4
	// (get) Token: 0x06000013 RID: 19 RVA: 0x000025F7 File Offset: 0x000007F7
	// (set) Token: 0x06000014 RID: 20 RVA: 0x000025FF File Offset: 0x000007FF
	public float waterHeight { get; set; }

	// Token: 0x06000015 RID: 21 RVA: 0x00002608 File Offset: 0x00000808
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

	// Token: 0x06000016 RID: 22 RVA: 0x000027FE File Offset: 0x000009FE
	private void SlowUpdate()
	{
		if (this.CheckBoatFullyRepaired())
		{
			this.SendBoatFinished();
			base.CancelInvoke("SlowUpdate");
		}
	}

	// Token: 0x06000017 RID: 23 RVA: 0x00002819 File Offset: 0x00000A19
	private void SendMarkShip()
	{
		this.MarkShip();
		ClientSend.SendShipStatus(Boat.BoatPackets.MarkShip, -1);
	}

	// Token: 0x06000018 RID: 24 RVA: 0x00002828 File Offset: 0x00000A28
	private void SendShipFound()
	{
		this.FindShip();
		ClientSend.SendShipStatus(Boat.BoatPackets.FindShip, -1);
	}

	// Token: 0x06000019 RID: 25 RVA: 0x00002837 File Offset: 0x00000A37
	private void SendMarkGems()
	{
		this.MarkGems();
		ClientSend.SendShipStatus(Boat.BoatPackets.MarkGems, -1);
	}

	// Token: 0x0600001A RID: 26 RVA: 0x00002848 File Offset: 0x00000A48
	private void SendBoatFinished()
	{
		int nextId = ResourceManager.Instance.GetNextId();
		this.BoatFinished(nextId);
		ClientSend.SendShipStatus(Boat.BoatPackets.FinishBoat, nextId);
	}

	// Token: 0x0600001B RID: 27 RVA: 0x0000286E File Offset: 0x00000A6E
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

	// Token: 0x0600001C RID: 28 RVA: 0x000028A4 File Offset: 0x00000AA4
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

	// Token: 0x0600001D RID: 29 RVA: 0x000028FE File Offset: 0x00000AFE
	private void FixedUpdate()
	{
		if (this.sinking)
		{
			this.MoveBoat();
		}
	}

	// Token: 0x0600001E RID: 30 RVA: 0x00002910 File Offset: 0x00000B10
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

	// Token: 0x0600001F RID: 31 RVA: 0x00002AF0 File Offset: 0x00000CF0
	public void BoatFinished(int interactId)
	{
		this.wheel.SetActive(true);
		this.wheelPing = Instantiate<GameObject>(this.objectivePing, this.wheel.transform.position, Quaternion.identity).GetComponent<ObjectivePing>();
		this.wheelPing.SetText("");
		this.wheelInteract = this.wheel.AddComponent<FinishGameInteract>();
		this.wheelInteract.SetId(interactId);
		ResourceManager.Instance.AddObject(interactId, this.wheelInteract.gameObject);
	}

	// Token: 0x06000020 RID: 32 RVA: 0x00002B78 File Offset: 0x00000D78
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

	// Token: 0x06000021 RID: 33 RVA: 0x00002BA8 File Offset: 0x00000DA8
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

	// Token: 0x06000022 RID: 34 RVA: 0x00002CA0 File Offset: 0x00000EA0
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
		ChatBox.Instance.AppendMessage(-1, string.Format("<color=orange>Guardians <color=white>have been located  (\"{0}\" to open map)", InputManager.map), "");
	}

	// Token: 0x06000023 RID: 35 RVA: 0x00002D7C File Offset: 0x00000F7C
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

	// Token: 0x06000024 RID: 36 RVA: 0x00002DD4 File Offset: 0x00000FD4
	public void FindShip()
	{
		this.status = Boat.BoatStatus.Found;
		Destroy(this.boatPing.gameObject);
		Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, this.boatTexture, Color.white, "Shipwreck", 1f);
		ChatBox.Instance.AppendMessage(-1, string.Format("<color=orange>Broken Ship <color=white>has been located (\"{0}\" to open map)", InputManager.map), "");
		Map.Instance.RemoveMarker(this.boatMapMarker);
	}

	// Token: 0x06000025 RID: 37 RVA: 0x00002E54 File Offset: 0x00001054
	public void MarkShip()
	{
		this.status = Boat.BoatStatus.Marked;
		this.boatPing.gameObject.SetActive(true);
		ChatBox.Instance.AppendMessage(-1, string.Format("Something has been marked on your map...  (\"{0}\" to open map)", InputManager.map), "");
		Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, null, Color.white, "", 1f);
	}

	// Token: 0x04000011 RID: 17
	public Boat.BoatStatus status;

	// Token: 0x04000012 RID: 18
	public static Boat Instance;

	// Token: 0x04000013 RID: 19
	public InventoryItem mapItem;

	// Token: 0x04000014 RID: 20
	public InventoryItem gemMap;

	// Token: 0x04000015 RID: 21
	public GameObject objectivePing;

	// Token: 0x04000016 RID: 22
	public ObjectivePing boatPing;

	// Token: 0x04000017 RID: 23
	private ConsistentRandom rand;

	// Token: 0x04000018 RID: 24
	public SpawnChestsInLocations chestSpawner;

	// Token: 0x04000019 RID: 25
	public GameObject[] holes;

	// Token: 0x0400001A RID: 26
	public Texture gemTexture;

	// Token: 0x0400001B RID: 27
	public Texture boatTexture;

	// Token: 0x0400001C RID: 28
	private bool gemsDiscovered;

	// Token: 0x0400001D RID: 29
	public List<ShrineGuardian> guardians;

	// Token: 0x0400001E RID: 30
	public CountPlayersOnBoat countPlayers;

	// Token: 0x04000020 RID: 32
	private float heightUnderWater = 3f;

	// Token: 0x04000021 RID: 33
	private Rigidbody rb;

	// Token: 0x04000022 RID: 34
	public Transform dragonSpawnPos;

	// Token: 0x04000023 RID: 35
	public Camera cinematicCamera;

	// Token: 0x04000024 RID: 36
	public MobType dragonBoss;

	// Token: 0x04000025 RID: 37
	public Transform rbTransform;

	// Token: 0x04000026 RID: 38
	public GameObject waterSfx;

	// Token: 0x04000027 RID: 39
	public Transform dragonLandingPosition;

	// Token: 0x04000028 RID: 40
	public Transform[] landingNodes;

	// Token: 0x04000029 RID: 41
	public GameObject wheel;

	// Token: 0x0400002A RID: 42
	private bool sinking;

	// Token: 0x0400002B RID: 43
	private float amp = 20f;

	// Token: 0x0400002C RID: 44
	private FinishGameInteract wheelInteract;

	// Token: 0x0400002D RID: 45
	public ObjectivePing wheelPing;

	// Token: 0x0400002E RID: 46
	private Component[] repairs;

	// Token: 0x0400002F RID: 47
	public Map.MapMarker boatMapMarker;

	// Token: 0x0200013A RID: 314
	public enum BoatStatus
	{
		// Token: 0x04000874 RID: 2164
		Hidden,
		// Token: 0x04000875 RID: 2165
		Marked,
		// Token: 0x04000876 RID: 2166
		Found,
		// Token: 0x04000877 RID: 2167
		LeftIsland
	}

	// Token: 0x0200013B RID: 315
	public enum BoatPackets
	{
		// Token: 0x04000879 RID: 2169
		MarkShip,
		// Token: 0x0400087A RID: 2170
		FindShip,
		// Token: 0x0400087B RID: 2171
		MarkGems,
		// Token: 0x0400087C RID: 2172
		FinishBoat
	}
}
