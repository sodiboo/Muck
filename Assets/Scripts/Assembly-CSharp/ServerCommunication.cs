using System;
using UnityEngine;

// Token: 0x020000C6 RID: 198
public class ServerCommunication : MonoBehaviour
{
	// Token: 0x06000500 RID: 1280 RVA: 0x0001B08C File Offset: 0x0001928C
	private void Awake()
	{
		base.InvokeRepeating("QuickUpdate", this.updateFrequency, this.updateFrequency);
		base.InvokeRepeating("SlowUpdate", this.slowUpdateFrequency, this.slowUpdateFrequency);
		base.InvokeRepeating("SlowerUpdate", this.slowerUpdateFrequency, this.slowerUpdateFrequency);
	}

	// Token: 0x06000501 RID: 1281 RVA: 0x0001B0E0 File Offset: 0x000192E0
	private void QuickUpdate()
	{
		if (Vector3.Distance(this.root.position, this.lastSentPosition) > this.posThreshold)
		{
			ClientSend.PlayerPosition(this.root.position);
			this.lastSentPosition = this.root.position;
		}
	}

	// Token: 0x06000502 RID: 1282 RVA: 0x0001B12C File Offset: 0x0001932C
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

	// Token: 0x06000503 RID: 1283 RVA: 0x0001B1AC File Offset: 0x000193AC
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

	// Token: 0x040004A3 RID: 1187
	public Transform root;

	// Token: 0x040004A4 RID: 1188
	public Transform cam;

	// Token: 0x040004A5 RID: 1189
	public PlayerStatus playerStatus;

	// Token: 0x040004A6 RID: 1190
	private int lastSentHp;

	// Token: 0x040004A7 RID: 1191
	private float hpThreshold = 1f;

	// Token: 0x040004A8 RID: 1192
	private float posThreshold = 0.075f;

	// Token: 0x040004A9 RID: 1193
	private float rotThreshold = 6f;

	// Token: 0x040004AA RID: 1194
	private Vector3 lastSentPosition;

	// Token: 0x040004AB RID: 1195
	private float lastSentRotationY;

	// Token: 0x040004AC RID: 1196
	private float lastSentRotationX;

	// Token: 0x040004AD RID: 1197
	private float lastSentXZ;

	// Token: 0x040004AE RID: 1198
	private float lastSentBlendX;

	// Token: 0x040004AF RID: 1199
	private float lastSentBlendY;

	// Token: 0x040004B0 RID: 1200
	private static readonly float updatesPerSecond = 12f;

	// Token: 0x040004B1 RID: 1201
	private static readonly float slowUpdatesPerSecond = 8f;

	// Token: 0x040004B2 RID: 1202
	private static readonly float slowerUpdatesPerSecond = 2f;

	// Token: 0x040004B3 RID: 1203
	private float updateFrequency = 1f / ServerCommunication.updatesPerSecond;

	// Token: 0x040004B4 RID: 1204
	private float slowUpdateFrequency = 1f / ServerCommunication.slowUpdatesPerSecond;

	// Token: 0x040004B5 RID: 1205
	private float slowerUpdateFrequency = 1f / ServerCommunication.slowerUpdatesPerSecond;
}
