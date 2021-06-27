using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200001C RID: 28
public class CountPlayersOnBoat : MonoBehaviour
{
	// Token: 0x060000A8 RID: 168 RVA: 0x0000530C File Offset: 0x0000350C
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

	// Token: 0x060000A9 RID: 169 RVA: 0x00005350 File Offset: 0x00003550
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

	// Token: 0x040000AE RID: 174
	public List<PlayerManager> players;
}
