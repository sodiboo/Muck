using System;
using UnityEngine;

public class LocalPlayer : MonoBehaviour
{
	public void SwitchUserInterface(bool b)
	{
		GameObject[] array = this.objects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(b);
		}
	}

	public GameObject[] objects;
}
