using UnityEngine;

[ExecuteInEditMode]
public class TestShieldHp : MonoBehaviour
{
    public int maxShield;

    public int maxHp;

    public int hp;

    public int shield;

    private int total;

    private float maxHpScale;

    private float maxShieldScale;

    private float hpRatio;

    private float shieldRatio;

    public RectTransform hpBar;

    public RectTransform shieldBar;

    private void Awake()
    {
        UpdateBar();
    }

    private void UpdateBar()
    {
        total = maxShield + maxHp;
        maxHpScale = (float)maxHp / (float)total;
        maxShieldScale = (float)maxShield / (float)total;
        if (maxHp == 0)
        {
            hpRatio = 0f;
        }
        else
        {
            hpRatio = (float)hp / (float)maxHp;
        }
        if (maxShield == 0)
        {
            shieldRatio = 0f;
        }
        else
        {
            shieldRatio = (float)shield / (float)maxShield;
        }
        hpBar.transform.localScale = new Vector3(maxHpScale * hpRatio, 1f, 1f);
        shieldBar.transform.localScale = new Vector3(maxShieldScale * shieldRatio, 1f, 1f);
    }

    private void Update()
    {
        UpdateBar();
    }
}
