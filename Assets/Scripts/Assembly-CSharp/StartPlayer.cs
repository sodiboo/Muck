using System;
using UnityEngine;

public class StartPlayer : MonoBehaviour
{
	private void Start()
	{
		for (int i = base.transform.childCount - 1; i >= 0; i--)
		{
			base.transform.GetChild(i).parent = null;
		}
		Destroy(base.gameObject);
	}
}
