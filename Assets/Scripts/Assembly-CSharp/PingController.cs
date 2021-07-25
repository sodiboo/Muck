using UnityEngine;

public class PingController : MonoBehaviour
{
    public LayerMask whatIsPingable;

    public GameObject pingPrefab;

    private float pingCooldown = 1f;

    private bool readyToPing;

    public static PingController Instance;

    private void Awake()
    {
        Instance = this;
        readyToPing = true;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(2))
        {
            LocalPing();
        }
    }

    private void LocalPing()
    {
        if (readyToPing)
        {
            readyToPing = false;
            Invoke(nameof(PingCooldown), pingCooldown);
            Vector3 vector = FindPingPos();
            if (!(vector == Vector3.zero))
            {
                MakePing(vector, GameManager.players[LocalClient.instance.myId].username, "");
                ClientSend.PlayerPing(vector);
            }
        }
    }

    private Vector3 FindPingPos()
    {
        Transform playerCam = PlayerMovement.Instance.playerCam;
        if (Physics.Raycast(playerCam.position, playerCam.forward, out var hitInfo, 1500f))
        {
            Vector3 vector = Vector3.zero;
            if (hitInfo.collider.gameObject.layer == LayerMask.NameToLayer("Ground"))
            {
                vector = Vector3.one;
            }
            return hitInfo.point + vector;
        }
        return Vector3.zero;
    }

    public void MakePing(Vector3 pos, string name, string pingedName)
    {
        Object.Instantiate(pingPrefab, pos, Quaternion.identity).GetComponent<PlayerPing>().SetPing(name, pingedName);
    }

    private void PingCooldown()
    {
        readyToPing = true;
    }
}
