using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class BossUI : MonoBehaviour
{
    public TextMeshProUGUI bossName;

    public TextMeshProUGUI hpText;

    public RawImage hpBar;

    public Mob currentBoss;

    private HitableMob hitableMob;

    private int desiredHp;

    public Transform layout;

    private Vector3 desiredScale;

    public static BossUI Instance;

    private float currentHp;

    private void Awake()
    {
        Instance = this;
        layout.transform.localScale = Vector3.zero;
        desiredScale = Vector3.zero;
    }

    public void SetBoss(Mob b)
    {
        if (!(currentBoss != null))
        {
            currentBoss = b;
            bossName.text = "";
            if (b.IsBuff())
            {
                bossName.text += "Buff ";
            }
            bossName.text += b.GetComponent<Hitable>().entityName;
            currentHp = 0f;
            desiredScale = Vector3.one;
            hitableMob = b.GetComponent<HitableMob>();
            layout.gameObject.SetActive(value: true);
            layout.localScale = Vector3.zero;
        }
    }

    private void Update()
    {
        if (currentBoss == null)
        {
            if (layout.gameObject.activeInHierarchy)
            {
                layout.gameObject.SetActive(value: false);
                if (DayCycle.time < 0.5f)
                {
                    MusicController.Instance.StopSong();
                }
            }
        }
        else
        {
            currentHp = Mathf.Lerp(currentHp, hitableMob.hp, Time.deltaTime * 10f);
            hpText.text = Mathf.RoundToInt(currentHp) + " / " + hitableMob.maxHp;
            float x = (float)hitableMob.hp / (float)hitableMob.maxHp;
            hpBar.transform.localScale = new Vector3(x, 1f, 1f);
            layout.transform.localScale = Vector3.Lerp(layout.transform.localScale, desiredScale, Time.deltaTime * 10f);
        }
    }
}
