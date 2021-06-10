
using UnityEngine;

// Token: 0x02000097 RID: 151
public class ServerCommunication : MonoBehaviour
{
	// Token: 0x06000489 RID: 1161 RVA: 0x00016F60 File Offset: 0x00015160
	private void Awake()
	{
		base.InvokeRepeating("QuickUpdate", this.updateFrequency, this.updateFrequency);
		base.InvokeRepeating("SlowUpdate", this.slowUpdateFrequency, this.slowUpdateFrequency);
		base.InvokeRepeating("SlowerUpdate", this.slowerUpdateFrequency, this.slowerUpdateFrequency);
	}

	// Token: 0x0600048A RID: 1162 RVA: 0x00016FB4 File Offset: 0x000151B4
	private void QuickUpdate()
	{
		if (Vector3.Distance(this.root.position, this.lastSentPosition) > this.posThreshold)
		{
			ClientSend.PlayerPosition(this.root.position);
			this.lastSentPosition = this.root.position;
		}
	}

	// Token: 0x0600048B RID: 1163 RVA: 0x00017000 File Offset: 0x00015200
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

	// Token: 0x0600048C RID: 1164 RVA: 0x00017080 File Offset: 0x00015280
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

	// Token: 0x040003D2 RID: 978
	public Transform root;

	// Token: 0x040003D3 RID: 979
	public Transform cam;

	// Token: 0x040003D4 RID: 980
	public PlayerStatus playerStatus;

	// Token: 0x040003D5 RID: 981
	private int lastSentHp;

	// Token: 0x040003D6 RID: 982
	private float hpThreshold = 1f;

	// Token: 0x040003D7 RID: 983
	private float posThreshold = 0.075f;

	// Token: 0x040003D8 RID: 984
	private float rotThreshold = 6f;

	// Token: 0x040003D9 RID: 985
	private Vector3 lastSentPosition;

	// Token: 0x040003DA RID: 986
	private float lastSentRotationY;

	// Token: 0x040003DB RID: 987
	private float lastSentRotationX;

	// Token: 0x040003DC RID: 988
	private float lastSentXZ;

	// Token: 0x040003DD RID: 989
	private float lastSentBlendX;

	// Token: 0x040003DE RID: 990
	private float lastSentBlendY;

	// Token: 0x040003DF RID: 991
	private static readonly float updatesPerSecond = 12f;

	// Token: 0x040003E0 RID: 992
	private static readonly float slowUpdatesPerSecond = 8f;

	// Token: 0x040003E1 RID: 993
	private static readonly float slowerUpdatesPerSecond = 2f;

	// Token: 0x040003E2 RID: 994
	private float updateFrequency = 1f / ServerCommunication.updatesPerSecond;

	// Token: 0x040003E3 RID: 995
	private float slowUpdateFrequency = 1f / ServerCommunication.slowUpdatesPerSecond;

	// Token: 0x040003E4 RID: 996
	private float slowerUpdateFrequency = 1f / ServerCommunication.slowerUpdatesPerSecond;
}
