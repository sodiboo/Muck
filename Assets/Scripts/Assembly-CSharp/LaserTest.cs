using UnityEngine;

public class LaserTest : MonoBehaviour
{
    public ParticleSystem ps;

    public ParticleSystem psSwirl;

    public LineRenderer lr;

    public Transform targetParticles;

    public LayerMask whatIsHittable;

    public Hitable hitable;

    public Transform hitParticles;

    private float damageUpdateRate = 0.1f;

    public GameObject damageFx;

    public GameObject sfx;

    private ParticleSystem.ShapeModule shape;

    private ParticleSystem.VelocityOverLifetimeModule vel;

    private Mob mob;

    public Transform target;

    private Vector3 currentPos;

    private bool hitSomething;

    private void Awake()
    {
        lr.positionCount = 2;
        shape = ps.shape;
        vel = psSwirl.velocityOverLifetime;
        mob = base.transform.root.GetComponent<Mob>();
    }

    private void OnEnable()
    {
        currentPos = base.transform.position;
        target = mob.target;
        if (target == null)
        {
            base.gameObject.SetActive(value: false);
            return;
        }
        CancelInvoke("StopLaser");
        Invoke("StopLaser", 2.1f);
        hitParticles.gameObject.SetActive(value: true);
        InvokeRepeating("DamageEffect", damageUpdateRate, damageUpdateRate);
    }

    private void StopLaser()
    {
        target = base.transform;
        hitParticles.gameObject.SetActive(value: false);
        CancelInvoke("DamageEffect");
    }

    private void LateUpdate()
    {
        if (hitable == null)
        {
            Debug.LogError("Stopping");
            base.gameObject.SetActive(value: false);
            sfx.SetActive(value: false);
            StopLaser();
            return;
        }
        currentPos = Vector3.Lerp(currentPos, target.position, Time.deltaTime * 15f);
        float maxDistance = Vector3.Distance(base.transform.position, currentPos);
        if (Physics.Raycast(base.transform.position, base.transform.forward, out var hitInfo, maxDistance, whatIsHittable))
        {
            currentPos = hitInfo.point - base.transform.forward * 0.2f;
            hitSomething = true;
        }
        targetParticles.transform.position = currentPos;
        base.transform.LookAt(target);
        float num = Vector3.Distance(base.transform.position, currentPos);
        shape.position = new Vector3(shape.position.x, shape.position.y, num / 2f);
        shape.scale = new Vector3(shape.scale.x, shape.scale.y, num);
        vel.z = num / 2f;
        lr.SetPosition(0, Vector3.zero);
        lr.SetPosition(1, Vector3.forward * num / base.transform.root.localScale.x);
        hitParticles.transform.position = currentPos;
        hitParticles.transform.rotation = Quaternion.LookRotation(hitInfo.normal);
    }

    private void DamageEffect()
    {
        Object.Instantiate(damageFx, hitParticles.transform.position, hitParticles.transform.rotation);
    }
}
