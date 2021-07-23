using UnityEngine;

public class Dragon : MonoBehaviour
{
    public RandomSfx wingFlap;

    public GameObject roar;

    public static Dragon Instance;

    private void Awake()
    {
        Instance = this;
        base.transform.rotation = Quaternion.LookRotation(Vector3.up);
    }

    private void Start()
    {
        MusicController.Instance.FinalBoss();
    }

    public void PlayWingFlap()
    {
        wingFlap.Randomize(0f);
    }

    private void OnDestroy()
    {
        Debug.LogError("Game is over lol");
        Object.Instantiate(roar, base.transform.position, Quaternion.identity);
        if (LocalClient.serverOwner)
        {
            GameManager.instance.GameOver(-3, 8f);
            ServerSend.GameOver(-3);
        }
    }
}
