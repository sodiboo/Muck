using System;
using UnityEngine;

public class MenuCamera : MonoBehaviour
{
	private void Awake()
	{
		this.desiredPos = this.startPos;
		Time.timeScale = 1f;
	}

	private void Start()
	{
		NetworkController.Instance.loading = false;
	}

	public void Lobby()
	{
		this.desiredPos = this.lobbyPos;
	}

	public void Menu()
	{
		this.desiredPos = this.startPos;
	}

	private void Update()
	{
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredPos.position, Time.deltaTime * 5f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, this.desiredPos.rotation, Time.deltaTime * 5f);
	}

	public Transform startPos;

	public Transform lobbyPos;

	private Transform desiredPos;
}
