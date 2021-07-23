using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class HitableInspector : MonoBehaviour
{
    public LayerMask whatIsObject;

    private GameObject child;

    public TextMeshProUGUI hp;

    public TextMeshProUGUI info;

    public Image hpBar;

    public Image maxBar;

    public Image overlay;

    private Vector3 desiredPosition;

    private float speed = 2f;

    private Hitable currentResource;

    private bool show;

    private Vector3 offsetPos = Vector3.zero;

    private float maxResourceDistance = 15f;

    private float maxMobDistance = 100f;

    private float ratio;

    private void Awake()
    {
        child = base.transform.GetChild(0).gameObject;
        hpBar.CrossFadeAlpha(0f, 0f, ignoreTimeScale: true);
        hpBar.CrossFadeAlpha(0f, 0f, ignoreTimeScale: true);
    }

    private void Update()
    {
        if (!PlayerMovement.Instance)
        {
            return;
        }
        Transform playerCam = PlayerMovement.Instance.playerCam;
        if (Physics.Raycast(playerCam.position, playerCam.forward, out var hitInfo, maxMobDistance, whatIsObject))
        {
            Hitable component = hitInfo.collider.gameObject.GetComponent<Hitable>();
            bool flag = true;
            if (component != null && component.gameObject.layer != LayerMask.NameToLayer("Enemy") && hitInfo.distance > maxResourceDistance)
            {
                flag = false;
                currentResource = null;
            }
            if (currentResource != component && component != null && flag)
            {
                currentResource = component;
                show = true;
                maxBar.CrossFadeAlpha(1f, 0.25f, ignoreTimeScale: true);
                hpBar.CrossFadeAlpha(1f, 0.25f, ignoreTimeScale: true);
                info.CrossFadeAlpha(1f, 0.25f, ignoreTimeScale: true);
                overlay.CrossFadeAlpha(1f, 0.25f, ignoreTimeScale: true);
                hpBar.transform.localScale = new Vector3((float)currentResource.hp / (float)currentResource.maxHp, 1f, 1f);
                info.text = component.entityName;
            }
            if ((bool)currentResource)
            {
                float y = hitInfo.collider.ClosestPoint(hitInfo.collider.transform.position + Vector3.up * 10f).y;
                float num = hitInfo.transform.position.y + 2f;
                if (y < num)
                {
                    offsetPos.y = y + 1f;
                }
                else
                {
                    offsetPos.y = num + 1f;
                }
                if (currentResource.gameObject.layer == LayerMask.NameToLayer("Enemy"))
                {
                    offsetPos.y = y + 0.4f;
                }
                ratio = (float)currentResource.hp / (float)currentResource.maxHp;
                Vector3 position = currentResource.transform.position;
                position.y = offsetPos.y;
                base.transform.position = position;
            }
            else
            {
                show = false;
                maxBar.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                hpBar.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                overlay.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                info.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
            }
        }
        else
        {
            if ((bool)currentResource || show)
            {
                show = false;
                maxBar.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                hpBar.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                info.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
                overlay.CrossFadeAlpha(0f, 0.25f, ignoreTimeScale: true);
            }
            currentResource = null;
        }
        hpBar.transform.localScale = Vector3.Lerp(hpBar.transform.localScale, new Vector3(ratio, 1f, 1f), Time.deltaTime * 4f);
    }
}
