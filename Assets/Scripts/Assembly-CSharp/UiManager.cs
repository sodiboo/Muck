using System;
using System.Net;
using System.Net.Sockets;
using TMPro;
using UnityEngine;

public class UiManager : MonoBehaviour
{
    public static UiManager instance;

    public GameObject lobbyCam;

    public GameObject startMenu;

    public TMP_InputField usernameField;

    public TMP_InputField ipField;

    public TMP_InputField portField;

    public GameObject server;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Debug.Log("Instance already exists, destroying object");
            UnityEngine.Object.Destroy(this);
        }
    }

    private void Start()
    {
    }

    public void Host()
    {
        int port = int.Parse(portField.text);
        LocalClient.instance.port = port;
        NetworkManager.instance.StartServer(port);
        Server.ipAddress = IPAddress.Any;
        MonoBehaviour.print(string.Concat("hosting server on: ", Server.ipAddress, " on port: ", portField.text));
        ConnectTest();
    }

    public void ConnectTest()
    {
        IPAddress[] addressList = Dns.GetHostEntry(Dns.GetHostName()).AddressList;
        foreach (IPAddress iPAddress in addressList)
        {
            if (iPAddress.AddressFamily == AddressFamily.InterNetwork)
            {
                MonoBehaviour.print("ip: " + iPAddress.ToString());
                LocalClient.instance.ConnectToServer(iPAddress.ToString(), "bread");
                lobbyCam.SetActive(value: false);
                return;
            }
        }
        throw new Exception("No network adapters with an IPv4 address in the system!");
    }

    public void ConnectToServer()
    {
        LocalClient.serverOwner = false;
        LocalClient.instance.port = int.Parse(portField.text);
        LocalClient.instance.ConnectToServer(ipField.text, "bread");
        MonoBehaviour.print("connecting to ip:" + ipField.text);
        lobbyCam.SetActive(value: false);
        try
        {
            _ = Color.black;
        }
        catch (Exception message)
        {
            MonoBehaviour.print(message);
        }
    }

    public void ConnectionSuccessful()
    {
        startMenu.SetActive(value: false);
    }
}
