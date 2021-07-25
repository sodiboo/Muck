using System.Collections.Generic;
using UnityEngine;

public class Boat : MonoBehaviour
{
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

    public BoatStatus status;

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

    public float waterHeight { get; set; }

    private void Start()
    {
        rb = GetComponentInChildren<Rigidbody>();
        guardians = new List<ShrineGuardian>();
        rand = new ConsistentRandom(GameManager.GetSeed());
        Instance = this;
        InvokeRepeating(nameof(CheckFound), 0.5f, 1f);
        boatPing = Object.Instantiate(objectivePing, base.transform.position, Quaternion.identity).GetComponent<ObjectivePing>();
        boatPing.SetText("?");
        boatPing.gameObject.SetActive(value: false);
        for (int i = 0; i < holes.Length; i++)
        {
            if (rand.NextDouble() > 0.5)
            {
                Object.Destroy(holes[i]);
                continue;
            }
            Vector3 position = holes[i].transform.position;
            float y = position.y;
            if (Physics.Raycast(position + Vector3.up * 10f, Vector3.down, out var hitInfo, 50f, GameManager.instance.whatIsGround) && hitInfo.point.y > y)
            {
                Object.Destroy(holes[i]);
            }
        }
        repairs = base.gameObject.GetComponentsInChildren(typeof(RepairInteract), includeInactive: true);
        Component[] array = repairs;
        for (int j = 0; j < array.Length; j++)
        {
            RepairInteract repairInteract = (RepairInteract)array[j];
            int nextId = ResourceManager.Instance.GetNextId();
            repairInteract.SetId(nextId);
            ResourceManager.Instance.AddObject(nextId, repairInteract.gameObject);
        }
        if (LocalClient.serverOwner)
        {
            InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
        }
        array = repairs;
        for (int j = 0; j < array.Length; j++)
        {
            _ = (RepairInteract)array[j];
        }
        base.gameObject.name = "Boat";
    }

    private void SlowUpdate()
    {
        if (CheckBoatFullyRepaired())
        {
            SendBoatFinished();
            CancelInvoke(nameof(SlowUpdate));
        }
    }

    private void SendMarkShip()
    {
        MarkShip();
        ClientSend.SendShipStatus(BoatPackets.MarkShip);
    }

    private void SendShipFound()
    {
        Debug.LogError("Found ship. Not sending");
        FindShip();
        ClientSend.SendShipStatus(BoatPackets.FindShip);
    }

    private void SendMarkGems()
    {
        MarkGems();
        ClientSend.SendShipStatus(BoatPackets.MarkGems);
    }

    private void SendBoatFinished()
    {
        int nextId = ResourceManager.Instance.GetNextId();
        BoatFinished(nextId);
        ClientSend.SendShipStatus(BoatPackets.FinishBoat, nextId);
    }

    public void UpdateShipStatus(BoatPackets p, int interactId)
    {
        switch (p)
        {
        case BoatPackets.MarkShip:
            MarkShip();
            break;
        case BoatPackets.FindShip:
            FindShip();
            break;
        case BoatPackets.MarkGems:
            MarkGems();
            break;
        case BoatPackets.FinishBoat:
            BoatFinished(interactId);
            break;
        }
    }

    public void LeaveIsland()
    {
        if (status != BoatStatus.LeftIsland)
        {
            status = BoatStatus.LeftIsland;
            GameManager.instance.boatLeft = true;
            sinking = true;
            Object.Destroy(wheelInteract.gameObject);
            Object.Destroy(wheelPing.gameObject);
            PlayerStatus.Instance.EnterOcean();
            AchievementManager.Instance.LeaveMuck();
        }
    }

    private void FixedUpdate()
    {
        if (sinking)
        {
            MoveBoat();
        }
    }

    private void MoveBoat()
    {
        float num = 2f;
        Vector3 vector = Vector3.up * num * Time.deltaTime;
        World.Instance.water.position += vector;
        float y = World.Instance.water.position.y;
        if (rb.position.y < y - heightUnderWater)
        {
            if (!waterSfx.activeInHierarchy)
            {
                waterSfx.SetActive(value: true);
            }
            rb.MovePosition(new Vector3(base.transform.position.x, y - heightUnderWater, base.transform.position.z));
        }
        if (!(y > 85f))
        {
            return;
        }
        sinking = false;
        if (!LocalClient.serverOwner)
        {
            return;
        }
        float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
        int nextId = MobManager.Instance.GetNextId();
        MobSpawner.Instance.ServerSpawnNewMob(nextId, dragonBoss.id, dragonSpawnPos.position, 1f, bossMultiplier);
        List<Mob> list = new List<Mob>();
        foreach (Mob value in MobManager.Instance.mobs.Values)
        {
            list.Add(value);
        }
        for (int i = 0; i < list.Count; i++)
        {
            list[i].hitable.Hit(list[i].hitable.maxHp, 1f, 2, list[i].transform.position, -1);
        }
    }

    public void BoatFinished(int interactId)
    {
        wheel.SetActive(value: true);
        wheelPing = Object.Instantiate(objectivePing, wheel.transform.position, Quaternion.identity).GetComponent<ObjectivePing>();
        wheelPing.SetText("");
        wheelInteract = wheel.AddComponent<FinishGameInteract>();
        wheelInteract.SetId(interactId);
        ResourceManager.Instance.AddObject(interactId, wheelInteract.gameObject);
    }

    public bool CheckBoatFullyRepaired()
    {
        Component[] array = repairs;
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
        if (status == BoatStatus.Hidden)
        {
            foreach (InventoryCell cell in InventoryUI.Instance.cells)
            {
                if (!(cell.currentItem == null) && cell.currentItem.id == mapItem.id)
                {
                    SendMarkShip();
                }
            }
        }
        if (gemsDiscovered)
        {
            return;
        }
        foreach (InventoryCell cell2 in InventoryUI.Instance.cells)
        {
            if (!(cell2.currentItem == null) && cell2.currentItem.id == gemMap.id)
            {
                SendMarkGems();
            }
        }
    }

    private void MarkGems()
    {
        gemsDiscovered = true;
        foreach (ShrineGuardian guardian in guardians)
        {
            if (guardian != null)
            {
                Map.Instance.AddMarker(guardian.transform, Map.MarkerType.Gem, gemTexture, Guardian.TypeToColor(guardian.type), "?");
                Map.Instance.AddMarker(guardian.transform, Map.MarkerType.Gem, gemTexture, Guardian.TypeToColor(guardian.type), "?");
            }
        }
        ChatBox.Instance.AppendMessage(-1, $"<color=orange>Guardians <color=white>have been located  (\"{InputManager.map}\" to open map)", "");
    }

    private void CheckFound()
    {
        if ((status == BoatStatus.Hidden || status == BoatStatus.Marked) && (bool)PlayerMovement.Instance && Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) < 40f)
        {
            SendShipFound();
        }
    }

    public void FindShip()
    {
        status = BoatStatus.Found;
        Object.Destroy(boatPing.gameObject);
        Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, boatTexture, Color.white, "Shipwreck");
        ChatBox.Instance.AppendMessage(-1, $"<color=orange>Broken Ship <color=white>has been located (\"{InputManager.map}\" to open map)", "");
    }

    public void MarkShip()
    {
        status = BoatStatus.Marked;
        boatPing.gameObject.SetActive(value: true);
        ChatBox.Instance.AppendMessage(-1, $"Something has been marked on your map...  (\"{InputManager.map}\" to open map)", "");
        Map.Instance.AddMarker(base.transform, Map.MarkerType.Other, null, Color.white);
    }
}
