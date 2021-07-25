using Steamworks;
using UnityEngine;

public class OnlyActivateForHost : MonoBehaviour
{
    public GameObject kickBtn;

    public SteamId steamId;

    public void Kick()
    {
        using (Packet packet = new Packet((int)ServerPackets.playerKick))
        {
            ServerSend.SendTCPDataToSteamId(steamId, packet);
        }
    }

    private void OnEnable()
    {
    }
}
