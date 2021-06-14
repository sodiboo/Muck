using System;
using UnityEngine;


public class SendToBossUi : MonoBehaviour
{

	private void Awake()
	{
		base.GetComponent<Mob>();
	}
}
