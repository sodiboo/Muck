using UnityEngine;


public class Suspension : MonoBehaviour
{
    
    private void Start()
    {
        car = base.transform.parent.GetComponent<Car>();
        bodyRb = car.GetComponent<Rigidbody>();
        smokeEmitting = smokeFx.emission;
        spinEmitting = spinFx.emission;
    }

    
    private void FixedUpdate() => NewSuspension();

    
    private void Update()
    {
        DebugTraction();
        if (rearWheel)
        {
            return;
        }
        wheelAngleVelocity = Mathf.Lerp(wheelAngleVelocity, steeringAngle, steerTime * Time.deltaTime);
        base.transform.localRotation = Quaternion.Euler(Vector3.up * wheelAngleVelocity);
    }

    
    private void DebugTraction()
    {
    }

    
    
    
    public bool terrain { get; set; }

    
    private void NewSuspension()
    {
        minLength = restLength - springTravel;
        maxLength = restLength + springTravel;
        var suspensionLength = car.suspensionLength;
        RaycastHit raycastHit;
        if (Physics.Raycast(new Ray(base.transform.position, -base.transform.up), out raycastHit, maxLength + suspensionLength, car.suspensionLayers, QueryTriggerInteraction.Ignore))
        {
            lastLength = springLength;
            springLength = raycastHit.distance - suspensionLength;
            springLength = Mathf.Clamp(springLength, minLength, maxLength);
            springVelocity = (lastLength - springLength) / Time.fixedDeltaTime;
            springForce = springStiffness * (restLength - springLength);
            damperForce = damperStiffness * springVelocity;
            var force = (springForce + damperForce) * base.transform.up;
            bodyRb.AddForceAtPosition(force, raycastHit.point);
            terrain = raycastHit.collider.gameObject.CompareTag("Terrain");
            hitPos = raycastHit.point;
            hitNormal = raycastHit.normal;
            hitHeight = raycastHit.distance;
            grounded = true;
            return;
        }
        grounded = false;
        hitHeight = car.suspensionLength + car.restHeight;
    }

    
    private void LateUpdate()
    {
        if (!showFx)
        {
            return;
        }
        if (traction > 0.05f && hitPos != Vector3.zero && grounded)
        {
            smokeEmitting.enabled = true;
            if (Skidmarks.Instance)
            {
                lastSkid = Skidmarks.Instance.AddSkidMark(hitPos + bodyRb.velocity * Time.fixedDeltaTime, hitNormal, traction * 0.9f, lastSkid);
            }
        }
        else
        {
            smokeEmitting.enabled = false;
            lastSkid = -1;
        }
        if (skidSfx)
        {
            var num = 1f;
            if (bodyRb.velocity.magnitude < 2f)
            {
                num = 0f;
            }
            skidSfx.volume = traction * num;
            skidSfx.pitch = 0.3f + 0.4f * Mathf.Clamp(traction * 0.5f, 0f, 1f);
        }
        if (!rearWheel)
        {
            return;
        }
        if (traction > 0.15f && grounded)
        {
            spinEmitting.enabled = true;
            spinEmitting.rateOverTime = Mathf.Clamp(traction * 60f, 20f, 400f);
            return;
        }
        spinEmitting.enabled = false;
    }

    
    private Car car;

    
    private Rigidbody bodyRb;

    
    public Transform wheelObject;

    
    public bool rearWheel;

    
    private int lastSkid;

    
    [HideInInspector]
    public bool skidding;

    
    [HideInInspector]
    public float grip;

    
    public bool showFx = true;

    
    public AudioSource skidSfx;

    
    public ParticleSystem smokeFx;

    
    public ParticleSystem spinFx;

    
    private ParticleSystem.EmissionModule smokeEmitting;

    
    private ParticleSystem.EmissionModule spinEmitting;

    
    public float wheelAngleVelocity;

    
    public float steeringAngle;

    
    public float traction;

    
    private readonly float steerTime = 15f;

    
    public bool spinning;

    
    public LayerMask whatIsGround;

    
    public Vector3 hitPos;

    
    public Vector3 hitNormal;

    
    public float hitHeight;

    
    public bool grounded;

    
    public float lastCompression;

    
    public float restLength;

    
    public float springTravel;

    
    public float springStiffness;

    
    public float damperStiffness;

    
    private float minLength;

    
    private float maxLength;

    
    private float lastLength;

    
    private float springLength;

    
    private float springVelocity;

    
    private float springForce;

    
    private float damperForce;
}
