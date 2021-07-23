using UnityEngine;
using UnityEngine.Rendering;

public class RepairInteract : MonoBehaviour, Interactable, SharedObject
{
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

    public bool dontIncreaseWithPlayers;

    private void Start()
    {
        float num = 1f;
        int playersInLobby = GameManager.instance.GetPlayersInLobby();
        num += (float)playersInLobby * 0.15f;
        num = Mathf.Clamp(num, 1f, 2f);
        if (dontIncreaseWithPlayers)
        {
            num = 1f;
        }
        for (int i = 0; i < requirements.Length; i++)
        {
            requirements[i] = Object.Instantiate(requirements[i]);
            requirements[i].amount = (int)((float)amounts[i] * num);
        }
        render = GetComponent<MeshRenderer>();
        InvokeRepeating("SlowUpdate", 1f, 1f);
    }

    private void SlowUpdate()
    {
        if ((bool)PlayerMovement.Instance)
        {
            Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
        }
    }

    public void Interact()
    {
        if (InventoryUI.Instance.CanRepair(requirements))
        {
            ClientSend.Interact(id);
        }
    }

    public void LocalExecute()
    {
        InventoryUI.Instance.Repair(requirements);
    }

    public void AllExecute()
    {
        Object.Instantiate(repairFx, base.transform.position, Quaternion.identity);
        if (replace)
        {
            if ((bool)fixedObject)
            {
                fixedObject.SetActive(value: true);
            }
            base.gameObject.SetActive(value: false);
        }
        else
        {
            render = GetComponent<MeshRenderer>();
            render.material = fixedMaterial;
            render.shadowCastingMode = ShadowCastingMode.On;
            base.gameObject.layer = LayerMask.NameToLayer("Object");
            Collider[] components = GetComponents<Collider>();
            for (int i = 0; i < components.Length; i++)
            {
                if (components[i].isTrigger)
                {
                    Object.Destroy(components[i]);
                }
                else
                {
                    components[i].enabled = true;
                }
            }
        }
        GameObject[] array = toActive;
        for (int j = 0; j < array.Length; j++)
        {
            array[j].SetActive(value: true);
        }
        array = toInactive;
        for (int j = 0; j < array.Length; j++)
        {
            array[j].SetActive(value: false);
        }
        Object.Destroy(this);
    }

    public void ServerExecute(int fromClient = -1)
    {
    }

    public void RemoveObject()
    {
    }

    public string GetName()
    {
        string text = name;
        text += "<size=75%>";
        InventoryItem[] array = requirements;
        foreach (InventoryItem inventoryItem in array)
        {
            text += $"\n{inventoryItem.name} ({inventoryItem.amount})";
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
        return id;
    }
}
