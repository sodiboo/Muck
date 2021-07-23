using UnityEngine;

public class GameManager : MonoBehaviour
{
	public GameObject localPlayerPrefab;
	public GameObject playerPrefab;
	public GameObject playerRagdoll;
	public MapGenerator mapGenerator;
	public GenerateNavmesh generateNavmesh;
	public GameObject resourceGen;
	public DayUi dayUi;
	public GameObject gameoverUi;
	public ExtraUI extraUi;
	public bool boatLeft;
	public GameObject lobbyCamera;
	public GameObject testGame;
	public GameObject zone;
	public GameObject gravePrefab;
	public int winnerId;
	public LayerMask whatIsGround;
	public LayerMask whatIsGroundAndObject;
	public bool powerupsPickedup;
	public bool damageTaken;
	public bool onlyRock;
	public int nStatsPlayers;
}
