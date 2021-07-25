using UnityEngine;

public class Item : MonoBehaviour
{
    public float pickupDelay = 0.85f;

    public int objectID;

    private bool pickedUp;

    private bool readyToPickUp;

    private Material outlineMat;

    public GameObject powerupParticles;

    public InventoryItem item { get; set; }

    public Powerup powerup { get; set; }

    private void Awake()
    {
        outlineMat = GetComponent<MeshRenderer>().material;
        Invoke(nameof(ReadyToPickup), pickupDelay);
        if (LocalClient.serverOwner)
        {
            Invoke(nameof(DespawnItem), 300f);
        }
    }

    private void Start()
    {
        if ((bool)item && item.tag == InventoryItem.ItemTag.Gem)
        {
            Map.Instance.AddMarker(base.transform, Map.MarkerType.Gem, item.sprite.texture, Color.white);
        }
    }

    public void UpdateMesh()
    {
        if ((bool)powerup)
        {
            outlineMat.mainTexture = powerup.material.mainTexture;
            outlineMat.SetColor("_Color", powerup.material.color);
            GetComponent<MeshFilter>().mesh = powerup.mesh;
            Renderer component = Object.Instantiate(powerupParticles, base.transform).GetComponent<ParticleSystem>().GetComponent<Renderer>();
            Material material = component.material;
            material.color = powerup.GetOutlineColor();
            material.SetColor("_EmissionColor", powerup.GetOutlineColor() * 3f);
            component.material = material;
            base.gameObject.AddComponent<FloatItem>();
            GetComponent<Rigidbody>().isKinematic = true;
        }
        if ((bool)item)
        {
            outlineMat.mainTexture = item.material.mainTexture;
            if (item.material.HasProperty("_Color"))
            {
                outlineMat.SetColor("_Color", item.material.color);
            }
            GetComponent<MeshFilter>().mesh = item.mesh;
        }
        outlineMat.SetFloat("_OutlineWidth", 0.06f);
        FindOutlineColor();
    }

    private void FindOutlineColor()
    {
        if ((bool)powerup)
        {
            outlineMat.SetColor("_OutlineColor", powerup.GetOutlineColor());
        }
        else if ((bool)item)
        {
            outlineMat.SetColor("_OutlineColor", item.GetOutlineColor());
        }
    }

    private void OnTriggerStay(Collider other)
    {
        if (!pickedUp && readyToPickUp && !InventoryUI.Instance.pickupCooldown && other.gameObject.layer == LayerMask.NameToLayer("Player") && other.gameObject.CompareTag("Local") && (!item || InventoryUI.Instance.CanPickup(item)))
        {
            pickedUp = true;
            ClientSend.PickupItem(objectID);
            InventoryUI.Instance.CheckInventoryAlmostFull();
        }
    }

    private void ReadyToPickup()
    {
        readyToPickUp = true;
    }

    private void DespawnItem()
    {
        if (!(item != null) || !item.important)
        {
            ItemManager.Instance.PickupItem(objectID);
            ServerSend.PickupItem(-1, objectID);
        }
    }
}
