using System;
using UnityEngine;

public class SpectatorCamera : MonoBehaviour
{
	private void OnEnable()
	{
		this.ready = false;
		Invoke(nameof(GetReady), 1f);
	}

	public static SpectatorCamera Instance { get; private set; }

	private void Awake()
	{
		SpectatorCamera.Instance = this;
	}

	private void Update()
	{
		if (Input.GetMouseButtonDown(0))
		{
			this.targetId++;
			this.target = null;
			this.targetName = "";
		}
		if (!this.ready)
		{
			return;
		}
		if (!this.target || !this.target.gameObject.activeInHierarchy)
		{
			return;
		}
		if (!this.target)
		{
			return;
		}
		Transform child = this.target.GetChild(0);
		base.transform.position = this.target.position - child.forward * 5f + Vector3.up * 2f;
		base.transform.LookAt(this.target);
	}

	public void SetTarget(Transform target, string name)
	{
		this.target = target;
	}

	private void GetReady()
	{
		this.ready = true;
	}

	public Transform target;

	private bool ready;

	private int targetId;

	private string targetName;
}
