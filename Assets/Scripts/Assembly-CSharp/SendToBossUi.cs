using UnityEngine;

public class SendToBossUi : MonoBehaviour
{
    public bool forceUI;

    private void Awake()
    {
        Mob component = GetComponent<Mob>();
        if (forceUI)
        {
            BossUI.Instance.SetBoss(component);
        }
    }
}
