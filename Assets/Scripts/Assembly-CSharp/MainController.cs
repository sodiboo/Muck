using System;
using UnityEngine;

public class MainController : MonoBehaviour
{
	public static bool isHost;

	public static MainController.MainState state;

	public enum MainState
	{
		None,
		Lobby,
		Loading,
		Playing,
		EndScreen
	}
}
