using UnityEngine;

public class NetworkController : MonoBehaviour
{
	public enum NetworkType
	{
		Steam = 0,
		Classic = 1,
	}

	public NetworkType networkType;
	public GameObject steam;
	public GameObject classic;
	public int nPlayers;
	public string[] playerNames;
}
