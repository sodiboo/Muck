using System;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;

public class Car : MonoBehaviour
{
    public const float Scale = 2;



    public Rigidbody rb { get; set; }




    public float steering { get; set; }




    public float throttle { get; set; }




    public bool breaking { get; set; }




    public float speed { get; private set; }




    public float steerAngle { get; set; }


    private void Awake()
    {
        rb = base.GetComponent<Rigidbody>();
        if (autoValues)
        {
            suspensionLength = 0.3f;
            suspensionForce = 10f * rb.mass;
            suspensionDamping = 4f * rb.mass;
        }
        var componentsInChildren = base.gameObject.GetComponentsInChildren<AntiRoll>();
        for (var i = 0; i < componentsInChildren.Length; i++)
        {
            componentsInChildren[i].antiRoll = antiRoll;
        }
        if (centerOfMass)
        {
            rb.centerOfMass = centerOfMass.localPosition;
        }
        InitWheels();
        suspensionLength *= Scale;
        restHeight *= Scale;
        foreach (var sus in wheelPositions)
        {
            sus.restLength *= Scale;
            sus.springTravel *= Scale;
        }
    }


    private void Update()
    {
        MoveWheels();
        Audio();
        CheckGrounded();
        Steering();
    }


    private void FixedUpdate()
    {
        if (!CounterMovement())
        {
            Movement();
        }
    }

    private void OnDisable()
    {
        if (OtherInput.Instance.currentCar == this) OtherInput.Instance.currentCar = null;
    }


    private void Audio()
    {
        accelerate.volume = Mathf.Lerp(accelerate.volume, Mathf.Abs(throttle) + Mathf.Abs(speed / 80f), Time.deltaTime * 6f);
        deaccelerate.volume = Mathf.Lerp(deaccelerate.volume, speed / 40f - throttle * 0.5f, Time.deltaTime * 4f);
        accelerate.pitch = Mathf.Lerp(accelerate.pitch, 0.65f + Mathf.Clamp(Mathf.Abs(speed / 160f), 0f, 1f), Time.deltaTime * 5f);
        if (!grounded)
        {
            accelerate.pitch = Mathf.Lerp(accelerate.pitch, 1.5f, Time.deltaTime * 8f);
        }
        deaccelerate.pitch = Mathf.Lerp(deaccelerate.pitch, 0.5f + speed / 40f, Time.deltaTime * 2f);
    }




    public Vector3 acceleration { get; private set; }

    private bool CounterMovement() => rb.isKinematic
    = wheelPositions.All(sus => sus.grounded)
    && throttle == 0f
    && steering == 0f
    && rb.velocity.magnitude < 1f;


    private void Movement()
    {
        drifting = false;
        var vector = XZVector(rb.velocity);
        var vector2 = base.transform.InverseTransformDirection(XZVector(rb.velocity));
        acceleration = (lastVelocity - vector2) / Time.fixedDeltaTime;
        dir = Mathf.Sign(base.transform.InverseTransformDirection(vector).z);
        speed = vector.magnitude * 3.6f * dir;
        var num = Mathf.Abs(rb.angularVelocity.y);
        foreach (var suspension in wheelPositions)
        {
            if (suspension.grounded)
            {
                var vector3 = XZVector(rb.GetPointVelocity(suspension.hitPos));
                base.transform.InverseTransformDirection(vector3);
                var a = Vector3.Project(vector3, suspension.transform.right);
                var d = 1f;
                var num2 = 1f;
                if (suspension.terrain)
                {
                    num2 = 0.6f;
                    d = 0.75f;
                }
                var f = Mathf.Atan2(vector2.x, vector2.z);
                if (breaking)
                {
                    num2 -= 0.6f;
                }
                var num3 = driftThreshold;
                if (num > 1f)
                {
                    num3 -= 0.2f;
                }
                if (Mathf.Abs(f) > num3)
                {
                    var num4 = Mathf.Clamp(Mathf.Abs(f) * 2.4f - num3, 0f, 1f);
                    num2 = Mathf.Clamp(1f - num4, 0.05f, 1f);
                    var magnitude = rb.velocity.magnitude;
                    drifting = true;
                    if (magnitude < 8f)
                    {
                        num2 += (8f - magnitude) / 8f;
                    }
                    if (num < yawGripThreshold)
                    {
                        var num5 = (yawGripThreshold - num) / yawGripThreshold;
                        num2 += num5 * yawGripMultiplier;
                    }
                    if (Mathf.Abs(throttle) < 0.3f)
                    {
                        num2 += 0.1f;
                    }
                    num2 = Mathf.Clamp(num2, 0f, 1f);
                }
                var d2 = 1f;
                if (drifting)
                {
                    d2 = driftMultiplier;
                }
                if (breaking)
                {
                    rb.AddForceAtPosition(suspension.transform.forward * C_breaking * Mathf.Sign(-speed) * d, suspension.hitPos);
                }
                rb.AddForceAtPosition(suspension.transform.forward * throttle * engineForce * d2 * d, suspension.hitPos);
                var a2 = a * rb.mass * d * num2;
                rb.AddForceAtPosition(-a2, suspension.hitPos);
                rb.AddForceAtPosition(suspension.transform.forward * a2.magnitude * 0.25f, suspension.hitPos);
                var num6 = Mathf.Clamp(1f - num2, 0f, 1f);
                if (Mathf.Sign(dir) != Mathf.Sign(throttle) && speed > 2f)
                {
                    num6 = Mathf.Clamp(num6 + 0.5f, 0f, 1f);
                }
                suspension.traction = num6;
                var force = -C_drag * vector;
                rb.AddForce(force);
                var force2 = -C_rollFriction * vector;
                rb.AddForce(force2);
            }
        }
        StandStill();
        lastVelocity = vector2;
    }


    private void StandStill()
    {
        if (Mathf.Abs(speed) >= 1f || !grounded || throttle != 0f)
        {
            rb.drag = 0f;
            return;
        }
        var flag = true;
        var array = wheelPositions;
        for (var i = 0; i < array.Length; i++)
        {
            if (Vector3.Angle(array[i].hitNormal, Vector3.up) > 1f)
            {
                flag = false;
                break;
            }
        }
        if (flag)
        {
            rb.drag = (1f - Mathf.Abs(speed)) * 30f;
            return;
        }
        rb.drag = 0f;
    }


    private void Steering()
    {
        foreach (var suspension in wheelPositions)
        {
            if (!suspension.rearWheel)
            {
                suspension.steeringAngle = steering * (37f - Mathf.Clamp(speed * 0.35f - 2f, 0f, 17f));
                steerAngle = suspension.steeringAngle;
            }
        }
    }


    private Vector3 XZVector(Vector3 v) => new Vector3(v.x, 0f, v.z);


    private void InitWheels()
    {
        foreach (var suspension in wheelPositions)
        {
            suspension.wheelObject = UnityEngine.Object.Instantiate<GameObject>(wheel).transform;
            suspension.wheelObject.parent = suspension.transform;
            suspension.wheelObject.transform.localPosition = Vector3.zero;
            suspension.wheelObject.transform.localRotation = Quaternion.identity;
            suspension.wheelObject.localScale = Vector3.one * suspensionLength * 2f;
        }
    }


    private void MoveWheels()
    {
        foreach (var suspension in wheelPositions)
        {
            var num = suspensionLength;
            var hitHeight = suspension.hitHeight;
            var y = Mathf.Lerp(suspension.wheelObject.transform.localPosition.y, -hitHeight + num, Time.deltaTime * 20f);
            suspension.wheelObject.transform.localPosition = new Vector3(0f, y, 0f);
            suspension.wheelObject.Rotate(Vector3.right, XZVector(rb.velocity).magnitude * 1f * dir);
            suspension.wheelObject.localScale = Vector3.one * (suspensionLength * 2f);
            suspension.transform.localScale = Vector3.one / base.transform.localScale.x;
        }
    }


    private void CheckGrounded()
    {
        grounded = false;
        var array = wheelPositions;
        for (var i = 0; i < array.Length; i++)
        {
            if (array[i].grounded)
            {
                grounded = true;
            }
        }
    }


    [Header("Misc")]
    public Transform centerOfMass;


    public Suspension[] wheelPositions;


    public GameObject wheel;


    public TextMeshProUGUI text;
    public new GameObject collider;


    [Header("Suspension Variables")]
    public bool autoValues;


    public float suspensionLength;


    public float restHeight;


    public float suspensionForce;


    public float suspensionDamping;


    [Header("Car specs")]
    public float engineForce = 5000f;


    public float steerForce = 1f;


    public float antiRoll = 5000f;


    public float stability;


    [Header("Drift specs")]
    public float driftMultiplier = 1f;


    public float driftThreshold = 0.5f;


    private readonly float C_drag = 3.5f;


    private readonly float C_rollFriction = 105f;


    private readonly float C_breaking = 3000f;


    [Header("Audio Sources")]
    public AudioSource accelerate;


    public AudioSource deaccelerate;


    private float dir;


    public Vector3 lastVelocity;


    private bool grounded;


    private readonly float yawGripThreshold = 0.6f;


    private readonly float yawGripMultiplier = 0.15f;

    public float firstPersonDistance;
    public float firstPersonHeight;
    public int suspensionLayers = (1 << 9) | (1 << 10) | (1 << 12) | (1 << 13);
    public bool drifting;

    [HideInInspector]
    public bool inUse;
}
