using UnityEngine;

public class ContinousHitbox : MonoBehaviour
{
    public HitboxDamage hitbox;

    public float resetTime = 0.1f;

    private void Awake()
    {
        InvokeRepeating(nameof(ResetHitbox), resetTime, resetTime);
    }

    private void ResetHitbox()
    {
        hitbox.Reset();
    }
}
