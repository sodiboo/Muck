using UnityEngine;

public class ServerCommunication : MonoBehaviour
{
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

    private float updateFrequency = 1f / updatesPerSecond;

    private float slowUpdateFrequency = 1f / slowUpdatesPerSecond;

    private float slowerUpdateFrequency = 1f / slowerUpdatesPerSecond;

    private void Awake()
    {
        InvokeRepeating(nameof(QuickUpdate), updateFrequency, updateFrequency);
        InvokeRepeating(nameof(SlowUpdate), slowUpdateFrequency, slowUpdateFrequency);
        InvokeRepeating(nameof(SlowerUpdate), slowerUpdateFrequency, slowerUpdateFrequency);
    }

    private void QuickUpdate()
    {
        if (Vector3.Distance(root.position, lastSentPosition) > posThreshold)
        {
            ClientSend.PlayerPosition(root.position);
            lastSentPosition = root.position;
        }
    }

    private void SlowUpdate()
    {
        float y = cam.eulerAngles.y;
        float num = cam.eulerAngles.x;
        if (num >= 270f)
        {
            num -= 360f;
        }
        float num2 = Mathf.Abs(lastSentRotationY - y);
        if (Mathf.Abs(lastSentRotationX - num) > rotThreshold || num2 > rotThreshold)
        {
            ClientSend.PlayerRotation(y, num);
            lastSentRotationY = y;
            lastSentRotationX = num;
        }
    }

    private void SlowerUpdate()
    {
        int num = Mathf.Abs(playerStatus.HpAndShield() - lastSentHp);
        if (num != 0)
        {
            MonoBehaviour.print("nope");
            if ((float)num > hpThreshold || playerStatus.IsFullyHealed())
            {
                MonoBehaviour.print("sent update");
                ClientSend.PlayerHp(playerStatus.HpAndShield(), playerStatus.MaxHpAndShield());
                lastSentHp = playerStatus.HpAndShield();
            }
        }
    }
}
