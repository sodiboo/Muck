using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class LoadingScreen : MonoBehaviour
{
	public TextMeshProUGUI text;
	public RawImage loadingBar;
	public RawImage background;
	public CanvasGroup canvasGroup;
	public Transform loadingParent;
	public GameObject loadingPlayerPrefab;
	public bool[] players;
	public CanvasGroup loadBar;
	public CanvasGroup playerStatuses;
	public GameObject[] loadingObject;
	public bool loadingInGame;
}
