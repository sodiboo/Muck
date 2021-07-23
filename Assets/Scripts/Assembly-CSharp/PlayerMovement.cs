using System;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public GameObject playerJumpSmokeFx;

    public GameObject footstepFx;

    public Transform playerCam;

    public Transform orientation;

    private Rigidbody rb;

    public bool dead;

    private float moveSpeed = 3500f;

    private float maxWalkSpeed = 6.5f;

    private float maxRunSpeed = 13f;

    private float maxSpeed = 6.5f;

    public bool grounded;

    public LayerMask whatIsGround;

    public float extraGravity = 5f;

    private Vector3 crouchScale = new Vector3(1f, 1.05f, 1f);

    private Vector3 playerScale;

    private float slideForce = 800f;

    private float slideCounterMovement = 0.12f;

    private bool readyToJump = true;

    private float jumpCooldown = 0.25f;

    private float jumpForce = 12f;

    private int jumps = 1;

    private float x;

    private float y;

    private float mouseDeltaX;

    private float mouseDeltaY;

    private Vector3 normalVector;

    public ParticleSystem ps;

    private ParticleSystem.EmissionModule psEmission;

    private Collider playerCollider;

    private float fallSpeed;

    public GameObject playerSmokeFx;

    private PlayerStatus playerStatus;

    private float distance;

    private float swimSpeed = 50f;

    private bool pushed;

    private bool onRamp;

    private int extraJumps;

    private int resetJumpCounter;

    private int jumpCounterResetTime = 10;

    private float counterMovement = 0.14f;

    private float threshold = 0.01f;

    private int readyToCounterX;

    private int readyToCounterY;

    private bool cancelling;

    private float maxSlopeAngle = 50f;

    private bool airborne;

    private bool onGround;

    private bool surfing;

    private bool cancellingGrounded;

    private bool cancellingSurf;

    private float delay = 5f;

    private int groundCancel;

    private int wallCancel;

    private int surfCancel;

    public LayerMask whatIsHittable;

    private float vel;

    public bool jumping { get; set; }

    public bool sliding { get; set; }

    public bool crouching { get; set; }

    public bool sprinting { get; private set; }

    public static PlayerMovement Instance { get; private set; }

    private void Awake()
    {
        Instance = this;
        rb = GetComponent<Rigidbody>();
        playerStatus = GetComponent<PlayerStatus>();
    }

    private void Start()
    {
        playerScale = base.transform.localScale;
        playerCollider = GetComponent<Collider>();
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void Update()
    {
        if (!dead)
        {
            FootSteps();
            fallSpeed = rb.velocity.y;
        }
    }

    public Vector2 GetInput()
    {
        return new Vector2(x, y);
    }

    public void SetInput(Vector2 dir, bool crouching, bool jumping, bool sprinting)
    {
        x = dir.x;
        y = dir.y;
        this.crouching = crouching;
        this.jumping = jumping;
        this.sprinting = sprinting;
    }

    private void CheckInput()
    {
        if (crouching && !sliding)
        {
            StartCrouch();
        }
        if (!crouching && sliding)
        {
            StopCrouch();
        }
        if (sprinting && playerStatus.CanRun())
        {
            maxSpeed = maxRunSpeed;
        }
        else
        {
            maxSpeed = maxWalkSpeed;
        }
    }

    public void StartCrouch()
    {
        if (!sliding)
        {
            sliding = true;
            base.transform.localScale = crouchScale;
            base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y - 0.65f, base.transform.position.z);
            if (rb.velocity.magnitude > 0.5f && grounded)
            {
                rb.AddForce(orientation.transform.forward * slideForce);
            }
        }
    }

    public void StopCrouch()
    {
        sliding = false;
        base.transform.localScale = playerScale;
        base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 0.65f, base.transform.position.z);
    }

    private void FootSteps()
    {
        if (!crouching && !dead && grounded)
        {
            float num = 1f;
            float num2 = rb.velocity.magnitude;
            if (num2 > 20f)
            {
                num2 = 20f;
            }
            distance += num2 * Time.deltaTime * 50f;
            if (distance > 300f / num)
            {
                UnityEngine.Object.Instantiate(footstepFx, base.transform.position, Quaternion.identity);
                distance = 0f;
            }
        }
    }

    private void WaterMovement()
    {
        float num = 1f;
        if (jumping)
        {
            num *= 2f;
        }
        rb.AddForce(Vector3.up * rb.mass * (0f - Physics.gravity.y) * num);
        float num2 = 1f;
        if (PlayerStatus.Instance.stamina <= 0f)
        {
            num2 = 0.5f;
        }
        rb.AddForce(playerCam.transform.forward * y * swimSpeed * num2);
        rb.AddForce(orientation.transform.right * x * swimSpeed * num2);
    }

    public bool IsUnderWater()
    {
        float num = World.Instance.water.position.y;
        return base.transform.position.y < num;
    }

    public void Movement(float x, float y)
    {
        UpdateCollisionChecks();
        this.x = x;
        this.y = y;
        if (dead)
        {
            return;
        }
        CheckInput();
        if (WorldUtility.WorldHeightToBiome(base.transform.position.y + 3.2f) == TextureData.TerrainType.Water)
        {
            maxSpeed *= 0.4f;
        }
        if (IsUnderWater())
        {
            if (rb.drag <= 0f)
            {
                rb.drag = 1f;
            }
            WaterMovement();
            return;
        }
        if (rb.drag > 0f)
        {
            rb.drag = 0f;
        }
        if (!grounded)
        {
            rb.AddForce(Vector3.down * extraGravity);
        }
        Vector2 mag = FindVelRelativeToLook();
        float num = mag.x;
        float num2 = mag.y;
        CounterMovement(x, y, mag);
        RampMovement(mag);
        if (readyToJump && jumping && grounded)
        {
            Jump();
        }
        if (crouching && grounded && readyToJump)
        {
            rb.AddForce(Vector3.down * 60f);
            return;
        }
        float num3 = x;
        float num4 = y;
        float num5 = maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
        if (x > 0f && num > num5)
        {
            num3 = 0f;
        }
        if (x < 0f && num < 0f - num5)
        {
            num3 = 0f;
        }
        if (y > 0f && num2 > num5)
        {
            num4 = 0f;
        }
        if (y < 0f && num2 < 0f - num5)
        {
            num4 = 0f;
        }
        float num6 = 1f;
        float num7 = 1f;
        if (!grounded)
        {
            num6 = 0.2f;
            num7 = 0.2f;
            if (IsHoldingAgainstVerticalVel(mag))
            {
                float num8 = Mathf.Abs(mag.y * 0.025f);
                if (num8 < 0.5f)
                {
                    num8 = 0.5f;
                }
                num7 = Mathf.Abs(num8);
            }
        }
        if (grounded && crouching)
        {
            num7 = 0f;
        }
        if (surfing)
        {
            num6 = 0.6f;
            num7 = 0.3f;
        }
        float num9 = 0.01f;
        rb.AddForce(orientation.forward * num4 * moveSpeed * 0.02f * num7);
        rb.AddForce(orientation.right * num3 * moveSpeed * 0.02f * num6);
        if (!grounded)
        {
            if (num3 != 0f)
            {
                rb.AddForce(-orientation.forward * mag.y * moveSpeed * 0.02f * num9);
            }
            if (num4 != 0f)
            {
                rb.AddForce(-orientation.right * mag.x * moveSpeed * 0.02f * num9);
            }
        }
        if (!readyToJump)
        {
            resetJumpCounter++;
            if (resetJumpCounter >= jumpCounterResetTime)
            {
                ResetJump();
            }
        }
    }

    public void PushPlayer()
    {
        pushed = true;
        Invoke("ResetPush", 0.3f);
    }

    private void ResetPush()
    {
        pushed = false;
    }

    private void RampMovement(Vector2 mag)
    {
        if (grounded && onRamp && !surfing && !crouching && !jumping && resetJumpCounter >= jumpCounterResetTime && Math.Abs(x) < 0.05f && Math.Abs(y) < 0.05f && !pushed)
        {
            rb.useGravity = false;
            if (rb.velocity.y > 0f)
            {
                rb.velocity = new Vector3(rb.velocity.x, 0f, rb.velocity.z);
            }
            else if (rb.velocity.y <= 0f && Math.Abs(mag.magnitude) < 1f)
            {
                rb.velocity = Vector3.zero;
            }
        }
        else
        {
            rb.useGravity = true;
        }
    }

    private void ResetJump()
    {
        readyToJump = true;
        CancelInvoke("JumpCooldown");
    }

    public void Jump()
    {
        if ((grounded || surfing || (!grounded && jumps > 0)) && readyToJump && playerStatus.CanJump())
        {
            if (grounded)
            {
                jumps = PowerupInventory.Instance.GetExtraJumps();
            }
            rb.isKinematic = false;
            if (!grounded)
            {
                jumps--;
            }
            readyToJump = false;
            CancelInvoke("JumpCooldown");
            Invoke("JumpCooldown", 0.25f);
            resetJumpCounter = 0;
            float num = jumpForce * PowerupInventory.Instance.GetJumpMultiplier();
            rb.AddForce(Vector3.up * num * 1.5f, ForceMode.Impulse);
            rb.AddForce(normalVector * num * 0.5f, ForceMode.Impulse);
            Vector3 velocity = rb.velocity;
            if (rb.velocity.y < 0.5f)
            {
                rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
            }
            else if (rb.velocity.y > 0f)
            {
                rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
            }
            ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = UnityEngine.Object.Instantiate(playerJumpSmokeFx, base.transform.position, Quaternion.LookRotation(Vector3.up)).GetComponent<ParticleSystem>().velocityOverLifetime;
            velocityOverLifetime.x = rb.velocity.x * 2f;
            velocityOverLifetime.z = rb.velocity.z * 2f;
            playerStatus.Jump();
            AchievementManager.Instance.Jump();
        }
    }

    private void JumpCooldown()
    {
        readyToJump = true;
    }

    private void CounterMovement(float x, float y, Vector2 mag)
    {
        if (x == 0f && y == 0f && rb.velocity.magnitude < 1f && grounded && !jumping && playerStatus.CanJump())
        {
            rb.isKinematic = true;
        }
        else
        {
            rb.isKinematic = false;
        }
        if (!grounded || (jumping && playerStatus.CanJump()))
        {
            return;
        }
        if (crouching)
        {
            rb.AddForce(moveSpeed * 0.02f * -rb.velocity.normalized * slideCounterMovement);
            return;
        }
        if (Math.Abs(mag.x) > threshold && Math.Abs(x) < 0.05f && readyToCounterX > 1)
        {
            rb.AddForce(moveSpeed * orientation.transform.right * 0.02f * (0f - mag.x) * counterMovement);
        }
        if (Math.Abs(mag.y) > threshold && Math.Abs(y) < 0.05f && readyToCounterY > 1)
        {
            rb.AddForce(moveSpeed * orientation.transform.forward * 0.02f * (0f - mag.y) * counterMovement);
        }
        if (IsHoldingAgainstHorizontalVel(mag))
        {
            rb.AddForce(moveSpeed * orientation.transform.right * 0.02f * (0f - mag.x) * counterMovement * 2f);
        }
        if (IsHoldingAgainstVerticalVel(mag))
        {
            rb.AddForce(moveSpeed * orientation.transform.forward * 0.02f * (0f - mag.y) * counterMovement * 2f);
        }
        if (Mathf.Sqrt(Mathf.Pow(rb.velocity.x, 2f) + Mathf.Pow(rb.velocity.z, 2f)) > maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null))
        {
            float num = rb.velocity.y;
            Vector3 vector = rb.velocity.normalized * maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
            rb.velocity = new Vector3(vector.x, num, vector.z);
        }
        if (Math.Abs(x) < 0.05f)
        {
            readyToCounterX++;
        }
        else
        {
            readyToCounterX = 0;
        }
        if (Math.Abs(y) < 0.05f)
        {
            readyToCounterY++;
        }
        else
        {
            readyToCounterY = 0;
        }
    }

    private bool IsHoldingAgainstHorizontalVel(Vector2 vel)
    {
        if (!(vel.x < 0f - threshold) || !(x > 0f))
        {
            if (vel.x > threshold)
            {
                return x < 0f;
            }
            return false;
        }
        return true;
    }

    private bool IsHoldingAgainstVerticalVel(Vector2 vel)
    {
        if (!(vel.y < 0f - threshold) || !(y > 0f))
        {
            if (vel.y > threshold)
            {
                return y < 0f;
            }
            return false;
        }
        return true;
    }

    public Vector2 FindVelRelativeToLook()
    {
        float current = orientation.transform.eulerAngles.y;
        float target = Mathf.Atan2(rb.velocity.x, rb.velocity.z) * 57.29578f;
        float num = Mathf.DeltaAngle(current, target);
        float num2 = 90f - num;
        float magnitude = new Vector2(rb.velocity.x, rb.velocity.z).magnitude;
        return new Vector2(y: magnitude * Mathf.Cos(num * ((float)Math.PI / 180f)), x: magnitude * Mathf.Cos(num2 * ((float)Math.PI / 180f)));
    }

    private bool IsFloor(Vector3 v)
    {
        return Vector3.Angle(Vector3.up, v) < maxSlopeAngle;
    }

    private bool IsSurf(Vector3 v)
    {
        float num = Vector3.Angle(Vector3.up, v);
        if (num < 89f)
        {
            return num > maxSlopeAngle;
        }
        return false;
    }

    private bool IsWall(Vector3 v)
    {
        return Math.Abs(90f - Vector3.Angle(Vector3.up, v)) < 0.1f;
    }

    private bool IsRoof(Vector3 v)
    {
        return v.y == -1f;
    }

    private void OnCollisionEnter(Collision other)
    {
        int layer = other.gameObject.layer;
        Vector3 normal = other.contacts[0].normal;
        if ((int)whatIsGround == ((int)whatIsGround | (1 << layer)) && IsFloor(normal) && fallSpeed < -12f)
        {
            MoveCamera.Instance.BobOnce(new Vector3(0f, fallSpeed, 0f));
            Vector3 point = other.contacts[0].point;
            ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = UnityEngine.Object.Instantiate(playerSmokeFx, point, Quaternion.LookRotation(base.transform.position - point)).GetComponent<ParticleSystem>().velocityOverLifetime;
            velocityOverLifetime.x = rb.velocity.x * 2f;
            velocityOverLifetime.z = rb.velocity.z * 2f;
        }
    }

    private void OnCollisionStay(Collision other)
    {
        int layer = other.gameObject.layer;
        if ((int)whatIsGround != ((int)whatIsGround | (1 << layer)))
        {
            return;
        }
        for (int i = 0; i < other.contactCount; i++)
        {
            Vector3 normal = other.contacts[i].normal;
            normal = new Vector3(normal.x, Mathf.Abs(normal.y), normal.z);
            if (IsFloor(normal))
            {
                if (!grounded)
                {
                    _ = crouching;
                }
                if (Vector3.Angle(Vector3.up, normal) > 1f)
                {
                    onRamp = true;
                }
                else
                {
                    onRamp = false;
                }
                grounded = true;
                normalVector = normal;
                cancellingGrounded = false;
                groundCancel = 0;
            }
            if (IsSurf(normal))
            {
                surfing = true;
                cancellingSurf = false;
                surfCancel = 0;
            }
        }
    }

    private void UpdateCollisionChecks()
    {
        if (!cancellingGrounded)
        {
            cancellingGrounded = true;
        }
        else
        {
            groundCancel++;
            if ((float)groundCancel > delay)
            {
                StopGrounded();
            }
        }
        if (!cancellingSurf)
        {
            cancellingSurf = true;
            surfCancel = 1;
            return;
        }
        surfCancel++;
        if ((float)surfCancel > delay)
        {
            StopSurf();
        }
    }

    private void StopGrounded()
    {
        grounded = false;
    }

    private void StopSurf()
    {
        surfing = false;
    }

    public Vector3 GetVelocity()
    {
        return rb.velocity;
    }

    public float GetFallSpeed()
    {
        return rb.velocity.y;
    }

    public Collider GetPlayerCollider()
    {
        return playerCollider;
    }

    public Transform GetPlayerCamTransform()
    {
        return playerCam.transform;
    }

    public Vector3 HitPoint()
    {
        RaycastHit[] array = Physics.RaycastAll(playerCam.transform.position, playerCam.transform.forward, 100f, whatIsHittable);
        if (array.Length < 1)
        {
            return playerCam.transform.position + playerCam.transform.forward * 100f;
        }
        if (array.Length > 1)
        {
            for (int i = 0; i < array.Length; i++)
            {
                if (array[i].transform.gameObject.layer == LayerMask.NameToLayer("Enemy") || array[i].transform.gameObject.layer == LayerMask.NameToLayer("Object") || array[i].transform.gameObject.layer == LayerMask.NameToLayer("Ground"))
                {
                    return array[i].point;
                }
            }
        }
        return array[0].point;
    }

    public bool IsCrouching()
    {
        return crouching;
    }

    public bool IsDead()
    {
        return dead;
    }

    public Rigidbody GetRb()
    {
        return rb;
    }
}
