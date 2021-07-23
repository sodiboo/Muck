using UnityEngine;

public class LootContainerInteract : MonoBehaviour, Interactable, SharedObject
{
    public LootDrop lootTable;

    public int price;

    private int basePrice;

    private int id;

    private static int totalId = 69420;

    private bool ready = true;

    private bool opened;

    public Animator animator;

    public float white;

    public float blue;

    public float gold;

    public bool testPowerup;

    public Powerup powerupToTest;

    private void Start()
    {
        if (testPowerup)
        {
            TestSpawn();
        }
        ready = true;
        basePrice = price;
    }

    private void OnEnable()
    {
        if (opened)
        {
            OpenContainer();
        }
    }

    private void TestSpawn()
    {
        id = totalId++;
        ResourceManager.Instance.AddObject(id, base.gameObject);
    }

    public void Interact()
    {
        if (InventoryUI.Instance.GetMoney() >= price && ready)
        {
            ready = false;
            InventoryUI.Instance.UseMoney(price);
            ClientSend.PickupInteract(id);
        }
    }

    private void GetReady()
    {
        ready = true;
    }

    public void LocalExecute()
    {
        AchievementManager.Instance.OpenChest();
    }

    public void AllExecute()
    {
        OpenContainer();
    }

    public void ServerExecute(int fromClient)
    {
        if (LocalClient.serverOwner)
        {
            Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(white, blue, gold);
            if (testPowerup && powerupToTest != null)
            {
                randomPowerup = powerupToTest;
            }
            int nextId = ItemManager.Instance.GetNextId();
            ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
            ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
        }
    }

    public void RemoveObject()
    {
    }

    public void OpenContainer()
    {
        opened = true;
        if (base.gameObject.activeInHierarchy)
        {
            animator.Play("OpenChest");
            Object.Destroy(base.gameObject);
        }
    }

    public string GetName()
    {
        price = (int)((float)basePrice * GameManager.instance.ChestPriceMultiplier());
        if (price < 1)
        {
            return "Open chest";
        }
        return $"{price} Gold\n<size=75%>open chest";
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
        return id;
    }
}
