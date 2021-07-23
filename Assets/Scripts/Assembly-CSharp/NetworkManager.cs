using UnityEngine;

public class NetworkManager : MonoBehaviour
{
    public static NetworkManager instance;

    public static float Clock { get; set; }

    public static float CountDown { get; set; }

    private void Update()
    {
        Clock += Time.deltaTime;
    }

    public int GetSpawnPosition(int id)
    {
        return id;
    }

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Debug.Log("Instance already exists, destroying object");
            Object.Destroy(this);
        }
    }

    private void Start()
    {
    }

    public void StartServer(int port)
    {
        Server.Start(40, port);
    }

    private void OnApplicationQuit()
    {
        Server.Stop();
    }

    public void DestroyPlayer(GameObject g)
    {
        Object.Destroy(g);
    }
}
