using System.Collections.Generic;
using Steamworks;
using TMPro;
using UnityEngine;
using UnityEngine.Profiling;
using UnityEngine.SceneManagement;

public class DebugNet : MonoBehaviour
{
    public TextMeshProUGUI fps;

    public GameObject console;

    private bool fpsOn = true;

    private bool speedOn = true;

    private bool pingOn = true;

    private bool bandwidthOn = true;

    private float deltaTime;

    public static List<string> r = new List<string>();

    public static DebugNet Instance;

    private float byteUp;

    private float byteDown;

    private float pSent;

    private float pReceived;

    private void Start()
    {
        Instance = this;
        base.gameObject.SetActive(value: false);
        InvokeRepeating("BandWidth", 1f, 1f);
    }

    public void ToggleConsole()
    {
        base.gameObject.SetActive(!base.gameObject.activeInHierarchy);
    }

    private void Update()
    {
        Fps();
    }

    private void Fps()
    {
        if (!fpsOn && !speedOn && !pingOn && !bandwidthOn)
        {
            if (!fps.enabled)
            {
                fps.gameObject.SetActive(value: false);
            }
            return;
        }
        if (!fps.gameObject.activeInHierarchy)
        {
            fps.gameObject.SetActive(value: true);
        }
        string text = "";
        deltaTime += (Time.unscaledDeltaTime - deltaTime) * 0.1f;
        float num = deltaTime * 1000f;
        float num2 = 1f / deltaTime;
        if (fpsOn)
        {
            text += $"{num:0.0} ms ({num2:0.} fps)";
        }
        if (speedOn)
        {
            Vector3 velocity = PlayerMovement.Instance.GetVelocity();
            text = text + "\nm/s: " + $"{new Vector2(velocity.x, velocity.z).magnitude:F1}";
        }
        if (pingOn)
        {
            int ping = NetStatus.GetPing();
            string text2 = "<color=";
            if (ping < 60)
            {
                text2 += "\"green\"";
            }
            else if (ping < 100)
            {
                text2 += "\"yellow\"";
            }
            else if (ping >= 100)
            {
                text2 += "\"red\"";
            }
            text += $"\n{text2}>ping: {NetStatus.GetPing()}ms <color=\"black\">";
        }
        if (bandwidthOn)
        {
            text = text + $"\nbyte up/s:    {byteUp}" + $"\nbyte down/s : {byteDown}" + $"\npacket up/s : {pSent}" + $"\npacket down/s : {pReceived}";
        }
        text += "<size=70%>";
        foreach (string item in r)
        {
            _ = item;
        }
        int num3 = 0;
        int num4 = 0;
        GameObject[] rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
        foreach (GameObject obj in rootGameObjects)
        {
            num3++;
            if (obj.activeInHierarchy)
            {
                num4++;
            }
        }
        text += $"\ngos active: {num4} | gos total {num3}";
        text += $"\nserver ip:    {Server.ipAddress}";
        text += $"\nresources hashmap size: {ResourceManager.Instance.list.Count}";
        text += $"\nactive mobs: {MobManager.Instance.mobs.Count}";
        text += $"\nactive mobs: {MobManager.Instance.GetActiveEnemies()} /  / {GameLoop.currentMobCap}";
        text += $"\nhp multiplier: {GameManager.instance.MobHpMultiplier()}";
        text += $"\ndamage multiplier: {GameManager.instance.MobDamageMultiplier()}";
        uint num5 = Profiler.GetTotalAllocatedMemory() / 1048576u;
        uint num6 = Profiler.GetTotalReservedMemory() / 1048576u;
        _ = Profiler.GetTotalUnusedReservedMemory() / 1048576u;
        text += $"\nramTotal: {num5}mb | {num6}mb / {SystemInfo.systemMemorySize}mb";
        text += $"\nServer host: {LocalClient.instance.serverHost} ({new Friend(LocalClient.instance.serverHost.Value).Name})";
        text += $"\nMy server id: {LocalClient.instance.myId}";
        text += $"\nAm server owner: {LocalClient.serverOwner}";
        text += $"Amount of mob zones: {MobZoneManager.Instance.zones.Count}";
        text += $"\nOnly rock: {GameManager.instance.onlyRock}";
        text += $"\nDamage taken by any players: {GameManager.instance.damageTaken}";
        text += $"\nAny powerups picked up by any players: {GameManager.instance.powerupsPickedup}";
        fps.text = text;
    }

    private void BandWidth()
    {
        byteUp = ClientSend.bytesSent;
        byteDown = LocalClient.byteDown;
        pSent = ClientSend.packetsSent;
        pReceived = LocalClient.packetsReceived;
        ClientSend.bytesSent = 0;
        ClientSend.packetsSent = 0;
        LocalClient.byteDown = 0;
        LocalClient.packetsReceived = 0;
    }

    private void OpenConsole()
    {
        console.gameObject.SetActive(value: true);
    }

    private void CloseConsole()
    {
        console.gameObject.SetActive(value: false);
    }
}
