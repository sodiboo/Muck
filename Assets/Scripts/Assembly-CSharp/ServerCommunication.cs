using System;
using UnityEngine;

// Token: 0x020000BE RID: 190
public class ServerCommunication : MonoBehaviour
{
	// Token: 0x06000586 RID: 1414 RVA: 0x0001C66C File Offset: 0x0001A86C
	private void Awake()
	{
		InvokeRepeating(nameof(QuickUpdate), this.updateFrequency, this.updateFrequency);
		InvokeRepeating(nameof(SlowUpdate), this.slowUpdateFrequency, this.slowUpdateFrequency);
		InvokeRepeating(nameof(SlowerUpdate), this.slowerUpdateFrequency, this.slowerUpdateFrequency);
	}

	// Token: 0x06000587 RID: 1415 RVA: 0x0001C6C0 File Offset: 0x0001A8C0
	private void QuickUpdate()
	{
		if (Vector3.Distance(this.root.position, this.lastSentPosition) > this.posThreshold)
		{
			ClientSend.PlayerPosition(this.root.position);
			this.lastSentPosition = this.root.position;
		}
	}

	// Token: 0x06000588 RID: 1416 RVA: 0x0001C70C File Offset: 0x0001A90C
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

	// Token: 0x06000589 RID: 1417 RVA: 0x0001C78C File Offset: 0x0001A98C
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

	// Token: 0x040004E1 RID: 1249
	public Transform root;

	// Token: 0x040004E2 RID: 1250
	public Transform cam;

	// Token: 0x040004E3 RID: 1251
	public PlayerStatus playerStatus;

	// Token: 0x040004E4 RID: 1252
	private int lastSentHp;

	// Token: 0x040004E5 RID: 1253
	private float hpThreshold = 1f;

	// Token: 0x040004E6 RID: 1254
	private float posThreshold = 0.075f;

	// Token: 0x040004E7 RID: 1255
	private float rotThreshold = 6f;

	// Token: 0x040004E8 RID: 1256
	private Vector3 lastSentPosition;

	// Token: 0x040004E9 RID: 1257
	private float lastSentRotationY;

	// Token: 0x040004EA RID: 1258
	private float lastSentRotationX;

	// Token: 0x040004EB RID: 1259
	private float lastSentXZ;

	// Token: 0x040004EC RID: 1260
	private float lastSentBlendX;

	// Token: 0x040004ED RID: 1261
	private float lastSentBlendY;

	// Token: 0x040004EE RID: 1262
	private static readonly float updatesPerSecond = 12f;

	// Token: 0x040004EF RID: 1263
	private static readonly float slowUpdatesPerSecond = 8f;

	// Token: 0x040004F0 RID: 1264
	private static readonly float slowerUpdatesPerSecond = 2f;

	// Token: 0x040004F1 RID: 1265
	private float updateFrequency = 1f / ServerCommunication.updatesPerSecond;

	// Token: 0x040004F2 RID: 1266
	private float slowUpdateFrequency = 1f / ServerCommunication.slowUpdatesPerSecond;

	// Token: 0x040004F3 RID: 1267
	private float slowerUpdateFrequency = 1f / ServerCommunication.slowerUpdatesPerSecond;
}
