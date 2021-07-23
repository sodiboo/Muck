using UnityEngine;
using UnityEngine.UI;

public class MobHpBar : MonoBehaviour
{
    public GameObject attachedObject;

    private HitableMob mob;

    private Vector3 offsetPos;

    public GameObject buffIcon;

    public Image hpBar;

    public void SetMob(GameObject mob)
    {
        buffIcon.SetActive(value: false);
        base.gameObject.SetActive(value: true);
        attachedObject = mob;
        Bounds bounds = mob.GetComponent<Collider>().bounds;
        this.mob = mob.transform.root.GetComponent<HitableMob>();
        new Vector3((float)this.mob.hp / (float)this.mob.maxHp, 1f, 1f);
        Vector3 vector = bounds.center - mob.transform.position;
        offsetPos = new Vector3(0f, bounds.extents.y + 0.5f, 0f) + vector;
        SendToBossUi component = mob.transform.root.GetComponent<SendToBossUi>();
        if ((bool)component)
        {
            BossUI.Instance.SetBoss(component.GetComponent<Mob>());
        }
        Mob component2 = mob.transform.root.GetComponent<Mob>();
        if ((bool)component2 && component2.IsBuff())
        {
            buffIcon.SetActive(value: true);
        }
    }

    public void RemoveMob()
    {
        base.gameObject.SetActive(value: false);
        buffIcon.SetActive(value: false);
        attachedObject = null;
        mob = null;
    }

    private void Update()
    {
        if (!mob)
        {
            base.gameObject.SetActive(value: false);
            return;
        }
        base.transform.position = attachedObject.transform.position + offsetPos;
        float x = (float)mob.hp / (float)mob.maxHp;
        Vector3 b = new Vector3(x, 1f, 1f);
        hpBar.transform.localScale = Vector3.Lerp(hpBar.transform.localScale, b, Time.deltaTime * 10f);
    }
}
