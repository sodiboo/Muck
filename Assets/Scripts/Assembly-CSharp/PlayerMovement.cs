using System;
using UnityEngine;


public class PlayerMovement : MonoBehaviour
{



    public bool sprinting { get; private set; }

    public bool flying { get; private set; }

    public bool noclip { get; set; }




    public static PlayerMovement Instance { get; private set; }


    private void Awake()
    {
        PlayerMovement.Instance = this;
        this.rb = base.GetComponent<Rigidbody>();
        this.playerStatus = base.GetComponent<PlayerStatus>();
    }


    private void Start()
    {
        this.playerScale = base.transform.localScale;
        this.playerCollider = base.GetComponent<Collider>();
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }


    private void Update()
    {
        if (this.dead)
        {
            return;
        }
        this.FootSteps();
        this.fallSpeed = this.rb.velocity.y;
    }


    public void SetInput(Vector2 dir, bool crouching, bool jumping, bool sprinting)
    {
        this.x = dir.x;
        this.y = dir.y;
        this.crouching = crouching;
        this.jumping = jumping;
        this.sprinting = sprinting;
    }


    private void CheckInput()
    {
        if (this.crouching && !this.sliding)
        {
            this.StartCrouch();
        }
        if (!this.crouching && this.sliding)
        {
            this.StopCrouch();
        }
        if (this.flying)
        {
            this.maxSpeed = float.PositiveInfinity;
            return;
        }
        if (this.sprinting && this.playerStatus.CanRun())
        {
            this.maxSpeed = this.maxRunSpeed;
            return;
        }
        this.maxSpeed = this.maxWalkSpeed;
    }


    public void StartCrouch()
    {
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) return;
        if (this.sliding)
        {
            return;
        }
        this.sliding = true;
        base.transform.localScale = this.crouchScale;
        base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y - 0.65f, base.transform.position.z);
        if (this.rb.velocity.magnitude > 0.5f && this.grounded)
        {
            this.rb.AddForce(this.orientation.transform.forward * this.slideForce);
        }
    }


    public void StopCrouch()
    {
        this.sliding = false;
        base.transform.localScale = this.playerScale;
        base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 0.65f, base.transform.position.z);
    }


    private void FootSteps()
    {
        if (this.crouching || this.dead)
        {
            return;
        }
        if (this.grounded)
        {
            float num = 1f;
            float num2 = this.rb.velocity.magnitude;
            if (num2 > 20f)
            {
                num2 = 20f;
            }
            this.distance += num2 * Time.deltaTime * 50f;
            if (this.distance > 300f / num)
            {
                Instantiate<GameObject>(this.footstepFx, base.transform.position, Quaternion.identity);
                this.distance = 0f;
            }
        }
    }


    public void Movement(float x, float y)
    {
        if (flying && grounded) flying = false;
        if (flying) rb.useGravity = false;
        playerCollider.enabled = !noclip || !flying;
        this.UpdateCollisionChecks();
        this.x = x;
        this.y = y;
        if (this.dead)
        {
            return;
        }
        this.CheckInput();
        if (WorldUtility.WorldHeightToBiome(base.transform.position.y + 1.6f) == TextureData.TerrainType.Water)
        {
            this.maxSpeed *= 0.4f;
        }
        if (!flying && !this.grounded)
        {
            this.rb.AddForce(Vector3.down * this.extraGravity);
        }
        Vector2 vector = this.FindVelRelativeToLook();
        float num = vector.x;
        float num2 = vector.y;
        this.CounterMovement(x, y, vector);
        this.RampMovement(vector);
        if (this.readyToJump && this.jumping && this.grounded)
        {
            this.Jump();
        }
        if (!flying && this.crouching && this.grounded && this.readyToJump)
        {
            this.rb.AddForce(Vector3.down * 60f);
            return;
        }
        if (flying)
        {
            var v = 0f;
            if (crouching) v -= 1f;
            if (jumping) v += 1f;
            rb.velocity = new Vector3(rb.velocity.x, v * 20f, rb.velocity.z);
        }
        float num3 = x;
        float num4 = y;
        if (!flying)
        {
            float num5 = this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
            if (x > 0f && num > num5)
            {
                num3 = 0f;
            }
            if (x < 0f && num < -num5)
            {
                num3 = 0f;
            }
            if (y > 0f && num2 > num5)
            {
                num4 = 0f;
            }
            if (y < 0f && num2 < -num5)
            {
                num4 = 0f;
            }
        }
        float d = 1f;
        float d2 = 1f;
        if (!this.grounded && !flying)
        {
            d = 0.2f;
            d2 = 0.2f;
            if (this.IsHoldingAgainstVerticalVel(vector))
            {
                float num6 = Mathf.Abs(vector.y * 0.025f);
                if (num6 < 0.5f)
                {
                    num6 = 0.5f;
                }
                d2 = Mathf.Abs(num6);
            }
        }
        if (this.grounded && this.crouching)
        {
            d2 = 0f;
        }
        if (this.surfing)
        {
            d = 0.6f;
            d2 = 0.3f;
        }
        float d3 = 0.01f;
        var moveSpeed = sprinting ? this.moveSpeed * 5f : this.moveSpeed;
        var forceZ = this.orientation.forward * num4 * moveSpeed * 0.02f * d2;
        var forceX = this.orientation.right * num3 * moveSpeed * 0.02f * d;
        if (flying && ((x == 0 && y == 0) || Vector3.Dot((forceX + forceZ).normalized, rb.velocity.normalized) < 0))
        {
            rb.drag = 2f;
        }
        else
        {
            rb.drag = 0f;
        }
        this.rb.AddForce(forceZ);
        this.rb.AddForce(forceX);
        if (!this.grounded)
        {
            if (num3 != 0f)
            {
                this.rb.AddForce(-this.orientation.forward * vector.y * moveSpeed * 0.02f * d3);
            }
            if (num4 != 0f)
            {
                this.rb.AddForce(-this.orientation.right * vector.x * moveSpeed * 0.02f * d3);
            }
        }
        if (!this.readyToJump)
        {
            this.resetJumpCounter++;
            if (this.resetJumpCounter >= this.jumpCounterResetTime)
            {
                this.ResetJump();
            }
        }
    }


    private void RampMovement(Vector2 mag)
    {
        if (this.grounded && this.onRamp && !this.surfing && !this.crouching && !this.jumping && this.resetJumpCounter >= this.jumpCounterResetTime && Math.Abs(this.x) < 0.05f && Math.Abs(this.y) < 0.05f)
        {
            this.rb.useGravity = false;
            if (this.rb.velocity.y > 0f)
            {
                this.rb.velocity = new Vector3(this.rb.velocity.x, 0f, this.rb.velocity.z);
                return;
            }
            if (this.rb.velocity.y <= 0f && Math.Abs(mag.magnitude) < 1f)
            {
                this.rb.velocity = Vector3.zero;
                return;
            }
        }
        else if (!flying)
        {
            this.rb.useGravity = true;
        }
    }


    private void ResetJump()
    {
        this.readyToJump = true;
        base.CancelInvoke(nameof(JumpCooldown));
    }

    DateTime lastJump = DateTime.MinValue;

    public void Jump()
    {
        if (lastJump + TimeSpan.FromMilliseconds(500) > DateTime.Now)
        {
            flying = !flying;
        }
        if ((this.grounded || this.surfing || (!this.grounded && this.jumps > 0)) && this.readyToJump && this.playerStatus.CanJump() && !flying)
        {
            if (this.grounded)
            {
                this.jumps = PowerupInventory.Instance.GetExtraJumps(null);
            }
            this.rb.isKinematic = false;
            if (!this.grounded)
            {
                this.jumps--;
            }
            this.readyToJump = false;
            base.CancelInvoke(nameof(JumpCooldown));
            base.Invoke(nameof(JumpCooldown), 0.25f);
            this.resetJumpCounter = 0;
            float d = this.jumpForce * PowerupInventory.Instance.GetJumpMultiplier(null);
            this.rb.AddForce(Vector3.up * d * 1.5f, ForceMode.Impulse);
            this.rb.AddForce(this.normalVector * d * 0.5f, ForceMode.Impulse);
            Vector3 velocity = this.rb.velocity;
            if (this.rb.velocity.y < 0.5f)
            {
                this.rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
            }
            else if (this.rb.velocity.y > 0f)
            {
                this.rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
            }
            ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = Instantiate<GameObject>(this.playerJumpSmokeFx, base.transform.position, Quaternion.LookRotation(Vector3.up)).GetComponent<ParticleSystem>().velocityOverLifetime;
            velocityOverLifetime.x = this.rb.velocity.x * 2f;
            velocityOverLifetime.z = this.rb.velocity.z * 2f;
            this.playerStatus.Jump();
        }
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) lastJump = DateTime.Now;
    }


    private void JumpCooldown()
    {
        this.readyToJump = true;
    }


    private void CounterMovement(float x, float y, Vector2 mag)
    {
        if (x == 0f && y == 0f && this.rb.velocity.magnitude < 1f && this.grounded && !this.jumping && this.playerStatus.CanJump())
        {
            this.rb.isKinematic = true;
        }
        else
        {
            this.rb.isKinematic = false;
        }
        if (!this.grounded || (this.jumping && this.playerStatus.CanJump()))
        {
            return;
        }
        if (this.crouching)
        {
            this.rb.AddForce(this.moveSpeed * 0.02f * -this.rb.velocity.normalized * this.slideCounterMovement);
            return;
        }
        if (Math.Abs(mag.x) > this.threshold && Math.Abs(x) < 0.05f && this.readyToCounterX > 1)
        {
            this.rb.AddForce(this.moveSpeed * this.orientation.transform.right * 0.02f * -mag.x * this.counterMovement);
        }
        if (Math.Abs(mag.y) > this.threshold && Math.Abs(y) < 0.05f && this.readyToCounterY > 1)
        {
            this.rb.AddForce(this.moveSpeed * this.orientation.transform.forward * 0.02f * -mag.y * this.counterMovement);
        }
        if (this.IsHoldingAgainstHorizontalVel(mag))
        {
            this.rb.AddForce(this.moveSpeed * this.orientation.transform.right * 0.02f * -mag.x * this.counterMovement * 2f);
        }
        if (this.IsHoldingAgainstVerticalVel(mag))
        {
            this.rb.AddForce(this.moveSpeed * this.orientation.transform.forward * 0.02f * -mag.y * this.counterMovement * 2f);
        }
        if (Mathf.Sqrt(Mathf.Pow(this.rb.velocity.x, 2f) + Mathf.Pow(this.rb.velocity.z, 2f)) > this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null))
        {
            float num = this.rb.velocity.y;
            Vector3 vector = this.rb.velocity.normalized * this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
            this.rb.velocity = new Vector3(vector.x, num, vector.z);
        }
        if (Math.Abs(x) < 0.05f)
        {
            this.readyToCounterX++;
        }
        else
        {
            this.readyToCounterX = 0;
        }
        if (Math.Abs(y) < 0.05f)
        {
            this.readyToCounterY++;
            return;
        }
        this.readyToCounterY = 0;
    }


    private bool IsHoldingAgainstHorizontalVel(Vector2 vel)
    {
        return (vel.x < -this.threshold && this.x > 0f) || (vel.x > this.threshold && this.x < 0f);
    }


    private bool IsHoldingAgainstVerticalVel(Vector2 vel)
    {
        return (vel.y < -this.threshold && this.y > 0f) || (vel.y > this.threshold && this.y < 0f);
    }


    public Vector2 FindVelRelativeToLook()
    {
        float current = this.orientation.transform.eulerAngles.y;
        float target = Mathf.Atan2(this.rb.velocity.x, this.rb.velocity.z) * 57.29578f;
        float num = Mathf.DeltaAngle(current, target);
        float num2 = 90f - num;
        float magnitude = new Vector2(this.rb.velocity.x, this.rb.velocity.z).magnitude;
        float num3 = magnitude * Mathf.Cos(num * 0.017453292f);
        return new Vector2(magnitude * Mathf.Cos(num2 * 0.017453292f), num3);
    }


    private bool IsFloor(Vector3 v)
    {
        return Vector3.Angle(Vector3.up, v) < this.maxSlopeAngle;
    }


    private bool IsSurf(Vector3 v)
    {
        float num = Vector3.Angle(Vector3.up, v);
        return num < 89f && num > this.maxSlopeAngle;
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
        if (this.whatIsGround != (this.whatIsGround | 1 << layer))
        {
            return;
        }
        if (this.IsFloor(normal) && this.fallSpeed < -12f)
        {
            MoveCamera.Instance.BobOnce(new Vector3(0f, this.fallSpeed, 0f));
            Vector3 point = other.contacts[0].point;
            ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = Instantiate<GameObject>(this.playerSmokeFx, point, Quaternion.LookRotation(base.transform.position - point)).GetComponent<ParticleSystem>().velocityOverLifetime;
            velocityOverLifetime.x = this.rb.velocity.x * 2f;
            velocityOverLifetime.z = this.rb.velocity.z * 2f;
        }
    }


    private void OnCollisionStay(Collision other)
    {
        int layer = other.gameObject.layer;
        if (this.whatIsGround != (this.whatIsGround | 1 << layer))
        {
            return;
        }
        for (int i = 0; i < other.contactCount; i++)
        {
            Vector3 normal = other.contacts[i].normal;
            if (this.IsFloor(normal))
            {
                if (!this.grounded)
                {
                    bool flag = this.crouching;
                }
                if (Vector3.Angle(Vector3.up, normal) > 1f)
                {
                    this.onRamp = true;
                }
                else
                {
                    this.onRamp = false;
                }
                this.grounded = true;
                this.normalVector = normal;
                this.cancellingGrounded = false;
                this.groundCancel = 0;
            }
            if (this.IsSurf(normal))
            {
                this.surfing = true;
                this.cancellingSurf = false;
                this.surfCancel = 0;
            }
        }
    }


    private void UpdateCollisionChecks()
    {
        if (!this.cancellingGrounded)
        {
            this.cancellingGrounded = true;
        }
        else
        {
            this.groundCancel++;
            if ((float)this.groundCancel > this.delay)
            {
                this.StopGrounded();
            }
        }
        if (!this.cancellingSurf)
        {
            this.cancellingSurf = true;
            this.surfCancel = 1;
            return;
        }
        this.surfCancel++;
        if ((float)this.surfCancel > this.delay)
        {
            this.StopSurf();
        }
    }


    private void StopGrounded()
    {
        this.grounded = false;
    }


    private void StopSurf()
    {
        this.surfing = false;
    }


    public Vector3 GetVelocity()
    {
        return this.rb.velocity;
    }


    public float GetFallSpeed()
    {
        return this.rb.velocity.y;
    }


    public Collider GetPlayerCollider()
    {
        return this.playerCollider;
    }


    public Transform GetPlayerCamTransform()
    {
        return this.playerCam.transform;
    }


    public Vector3 HitPoint()
    {
        RaycastHit[] array = Physics.RaycastAll(this.playerCam.transform.position, this.playerCam.transform.forward, 100f, this.whatIsHittable);
        if (array.Length < 1)
        {
            return this.playerCam.transform.position + this.playerCam.transform.forward * 100f;
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
        return this.crouching && !flying;
    }


    public bool IsDead()
    {
        return this.dead;
    }


    public Rigidbody GetRb()
    {
        return this.rb;
    }


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


    private bool jumping;


    private bool sliding;


    private bool crouching;


    private Vector3 normalVector;


    public ParticleSystem ps;


    private ParticleSystem.EmissionModule psEmission;


    private Collider playerCollider;


    private float fallSpeed;


    public GameObject playerSmokeFx;


    private PlayerStatus playerStatus;


    private float distance;


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
}
