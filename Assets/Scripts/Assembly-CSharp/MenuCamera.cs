using UnityEngine;

public class MenuCamera : MonoBehaviour
{
    public Transform startPos;

    public Transform lobbyPos;

    private Transform desiredPos;

    private void Awake()
    {
        desiredPos = startPos;
        Time.timeScale = 1f;
    }

    private void Start()
    {
        NetworkController.Instance.loading = false;
    }

    public void Lobby()
    {
        desiredPos = lobbyPos;
    }

    public void Menu()
    {
        desiredPos = startPos;
    }

    private void Update()
    {
        base.transform.position = Vector3.Lerp(base.transform.position, desiredPos.position, Time.deltaTime * 5f);
        base.transform.rotation = Quaternion.Lerp(base.transform.rotation, desiredPos.rotation, Time.deltaTime * 5f);
    }
}
