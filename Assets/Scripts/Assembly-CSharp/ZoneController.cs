using UnityEngine;

public class ZoneController : MonoBehaviour
{
    private int baseDamage = 1;

    private float threshold = 1.5f;

    private float updateRate = 0.5f;

    private bool inZone;

    public Transform audio;

    public AudioSource transition;

    public AudioSource damageAudio;

    private float maxScale;

    public static ZoneController Instance;

    public LayerMask whatIsGround;

    private int currentDay;

    private float desiredZoneScale;

    private float zoneSpeed = 5f;

    private void Awake()
    {
        Instance = this;
        maxScale = base.transform.localScale.x;
        desiredZoneScale = maxScale;
        InvokeRepeating("SlowUpdate", updateRate, updateRate);
    }

    private void Start()
    {
        AdjustZoneHeight();
    }

    private void AdjustZoneHeight()
    {
        if (Physics.Raycast(base.transform.position + Vector3.up * 500f, Vector3.down, out var hitInfo, 1000f, whatIsGround))
        {
            Vector3 position = base.transform.position;
            position.y = hitInfo.point.y;
            base.transform.position = position;
        }
    }

    public void NextDay(int day)
    {
        int gameLength = (int)GameManager.gameSettings.gameLength;
        currentDay = day;
        desiredZoneScale = 1f - (float)currentDay / (float)gameLength;
        desiredZoneScale = Mathf.Clamp(desiredZoneScale, 0f, 1f);
        desiredZoneScale *= maxScale;
    }

    private void SlowUpdate()
    {
        if (!PlayerMovement.Instance || PlayerStatus.Instance.IsPlayerDead())
        {
            return;
        }
        Vector3 position = PlayerMovement.Instance.transform.position;
        if (Vector3.Distance(Vector3.zero, position) > base.transform.localScale.x)
        {
            PlayerStatus.Instance.DealDamage(baseDamage * GameManager.instance.currentDay + 1);
            audio.transform.position = position;
            damageAudio.Play();
            if (!inZone)
            {
                transition.Play();
                inZone = true;
                PPController.Instance.SetChromaticAberration(1f);
                ZoneVignette.Instance.SetVignette(on: true);
            }
        }
        else if (inZone)
        {
            transition.Play();
            inZone = false;
            ZoneVignette.Instance.SetVignette(on: false);
            PPController.Instance.SetChromaticAberration(0f);
        }
    }

    private void Update()
    {
        if (!PlayerMovement.Instance)
        {
            return;
        }
        Vector3 position = PlayerMovement.Instance.transform.position;
        if (!inZone)
        {
            Vector3 normalized = (position - Vector3.zero).normalized;
            audio.transform.position = Vector3.zero + normalized * base.transform.localScale.x;
        }
        else
        {
            audio.transform.position = position;
        }
        if (base.transform.localScale.x > desiredZoneScale && base.transform.localScale.x > 0f)
        {
            if (base.transform.localScale.x < 40f)
            {
                zoneSpeed = 1f;
            }
            base.transform.localScale -= Vector3.one * zoneSpeed * Time.deltaTime;
        }
    }
}
