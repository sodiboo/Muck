using TMPro;
using UnityEngine;

public class StatusUI : MonoBehaviour
{
    public RectTransform hpBar;

    public RectTransform shieldBar;

    public RectTransform armorBar;

    private float hpRatio;

    private float shieldRatio;

    public Transform hungerBar;

    public Transform staminaBar;

    public TextMeshProUGUI hpText;

    private float currentHp;

    private PlayerStatus playerStatus;

    private float speed = 10f;

    private void Start()
    {
        if ((bool)PlayerMovement.Instance)
        {
            playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
        }
    }

    private void Update()
    {
        if (playerStatus == null)
        {
            if (!(PlayerMovement.Instance == null))
            {
                playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
            }
            return;
        }
        currentHp = Mathf.Lerp(currentHp, PlayerStatus.Instance.hp + PlayerStatus.Instance.shield, Time.deltaTime * 3f);
        hpText.text = Mathf.Round(currentHp) + " / " + (PlayerStatus.Instance.maxHp + PlayerStatus.Instance.maxShield);
        float x = Mathf.Lerp(hpBar.localScale.x, playerStatus.GetHpRatio(), Time.deltaTime * speed);
        hpBar.localScale = new Vector3(x, 1f, 1f);
        float x2 = Mathf.Lerp(shieldBar.localScale.x, playerStatus.GetShieldRatio(), Time.deltaTime * speed);
        shieldBar.localScale = new Vector3(x2, 1f, 1f);
        float x3 = Mathf.Lerp(hungerBar.localScale.x, playerStatus.GetHungerRatio(), Time.deltaTime * speed);
        hungerBar.localScale = new Vector3(x3, 1f, 1f);
        float x4 = Mathf.Lerp(staminaBar.localScale.x, playerStatus.GetStaminaRatio(), Time.deltaTime * speed);
        staminaBar.localScale = new Vector3(x4, 1f, 1f);
        float x5 = Mathf.Lerp(armorBar.localScale.x, playerStatus.GetArmorRatio(), Time.deltaTime * speed);
        armorBar.localScale = new Vector3(x5, 1f, 1f);
    }
}
