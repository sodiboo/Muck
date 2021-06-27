using System;
using UnityEngine;

public class ServerCommunication : MonoBehaviour
{
	private void Awake()
	{
		InvokeRepeating(nameof(QuickUpdate), this.updateFrequency, this.updateFrequency);
		InvokeRepeating(nameof(SlowUpdate), this.slowUpdateFrequency, this.slowUpdateFrequency);
		InvokeRepeating(nameof(SlowerUpdate), this.slowerUpdateFrequency, this.slowerUpdateFrequency);
	}

	private void QuickUpdate()
	{
		if (Vector3.Distance(this.root.position, this.lastSentPosition) > this.posThreshold)
		{
			ClientSend.PlayerPosition(this.root.position);
			this.lastSentPosition = this.root.position;
		}
	}

	private void SlowUpdate()
	{
		float y = this.cam.eulerAngles.y;
		float num = this.cam.eulerAngles.x;
		if (num >= 270f)
		{
			num -= 360f;
		}
		float num2 = Mathf.Abs(this.lastSentRotationY - y);
		if (Mathf.Abs(this.lastSentRotationX - num) > this.rotThreshold || num2 > this.rotThreshold)
		{
			ClientSend.PlayerRotation(y, num);
			this.lastSentRotationY = y;
			this.lastSentRotationX = num;
		}
	}

	private void SlowerUpdate()
	{
		int num = Mathf.Abs(this.playerStatus.HpAndShield() - this.lastSentHp);
		if (num == 0)
		{
			return;
		}
		MonoBehaviour.print("nope");
		if ((float)num > this.hpThreshold || this.playerStatus.IsFullyHealed())
		{
			MonoBehaviour.print("sent update");
			ClientSend.PlayerHp(this.playerStatus.HpAndShield(), this.playerStatus.MaxHpAndShield());
			this.lastSentHp = this.playerStatus.HpAndShield();
		}
	}

	public Transform root;

	public Transform cam;

	public PlayerStatus playerStatus;

	private int lastSentHp;

	private float hpThreshold = 1f;

	private float posThreshold = 0.075f;

	private float rotThreshold = 6f;

	private Vector3 lastSentPosition;

	private float lastSentRotationY;

	private float lastSentRotationX;

	private float lastSentXZ;

	private float lastSentBlendX;

	private float lastSentBlendY;

	private static readonly float updatesPerSecond = 12f;

	private static readonly float slowUpdatesPerSecond = 8f;

	private static readonly float slowerUpdatesPerSecond = 2f;

	private float updateFrequency = 1f / ServerCommunication.updatesPerSecond;

	private float slowUpdateFrequency = 1f / ServerCommunication.slowUpdatesPerSecond;

	private float slowerUpdateFrequency = 1f / ServerCommunication.slowerUpdatesPerSecond;
}
