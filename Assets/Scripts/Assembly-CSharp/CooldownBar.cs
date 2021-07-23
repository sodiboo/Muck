using UnityEngine;

public class CooldownBar : MonoBehaviour
{
    public Transform cooldownBar;

    private float time = 1f;

    private float t;

    private float timeToReachTarget;

    public static CooldownBar Instance;

    private bool stayOnScreen;

    private void Awake()
    {
        Instance = this;
        base.gameObject.SetActive(value: false);
    }

    private void Update()
    {
        if (timeToReachTarget == 0f || t >= timeToReachTarget)
        {
            return;
        }
        t += Time.deltaTime;
        cooldownBar.transform.localScale = new Vector3(t / timeToReachTarget, 1f, 1f);
        if (t >= timeToReachTarget)
        {
            t = timeToReachTarget;
            if (!stayOnScreen)
            {
                base.transform.gameObject.SetActive(value: false);
            }
        }
    }

    public void ResetCooldown(float speedMultiplier)
    {
        t = 0f;
        cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
        timeToReachTarget = time / speedMultiplier;
        base.transform.gameObject.SetActive(value: true);
    }

    public void ResetCooldownTime(float time, bool stayOnScreen)
    {
        this.stayOnScreen = stayOnScreen;
        t = 0f;
        timeToReachTarget = time;
        cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
        base.transform.gameObject.SetActive(value: true);
    }

    public void HideBar()
    {
        t = timeToReachTarget;
        base.gameObject.SetActive(value: false);
    }
}
