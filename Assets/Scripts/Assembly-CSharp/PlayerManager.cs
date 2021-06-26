using UnityEngine;
using TMPro;

public class PlayerManager : MonoBehaviour
{
	public int id;
	public string username;
	public bool dead;
	public Color color;
	public OnlinePlayer onlinePlayer;
	public int kills;
	public int deaths;
	public int ping;
	public bool disconnected;
	public bool loaded;
	public TextMeshProUGUI nameText;
	public HitableActor hitable;
	public Transform spectateOrbit;
}
