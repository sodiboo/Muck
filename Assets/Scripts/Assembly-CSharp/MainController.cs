using UnityEngine;

public class MainController : MonoBehaviour
{
    public enum MainState
    {
        None,
        Lobby,
        Loading,
        Playing,
        EndScreen
    }

    public static bool isHost;

    public static MainState state;
}
