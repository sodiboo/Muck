using UnityEngine;

public class Player
{
	public Player(int id, string username, Color color)
	{
	}

	public int id;
	public string username;
	public bool ready;
	public bool joined;
	public bool loading;
	public Color color;
	public Vector3 pos;
	public float yOrientation;
	public float xOrientation;
	public bool running;
	public bool dead;
	public float lastPingTime;
	public int[] powerups;
	public int[] armor;
	public int totalArmor;
	public int currentHp;
}
