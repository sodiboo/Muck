using System;
using System.Collections.Generic;
using UnityEngine;

public class CountPlayersOnBoat : MonoBehaviour
{
	private void OnTriggerEnter(Collider other)
	{
		GameObject gameObject = other.gameObject;
		if (gameObject.layer != LayerMask.NameToLayer("Player"))
		{
			return;
		}
		PlayerManager component = gameObject.GetComponent<PlayerManager>();
		if (!component)
		{
			return;
		}
		this.players.Add(component);
	}

	private void OnTriggerExit(Collider other)
	{
		GameObject gameObject = other.gameObject;
		if (gameObject.layer != LayerMask.NameToLayer("Player"))
		{
			return;
		}
		PlayerManager component = gameObject.GetComponent<PlayerManager>();
		if (!component)
		{
			return;
		}
		this.players.Remove(component);
	}

	public List<PlayerManager> players;
}
