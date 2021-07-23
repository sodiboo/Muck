using UnityEngine;

public class OnlinePlayer : MonoBehaviour
{
    public enum SharedAnimation
    {
        Attack,
        Eat,
        Charge
    }

    public Animator animator;

    public Rigidbody rb;

    public Vector3 desiredPos;

    public float orientationY;

    public float orientationX;

    private float blendX;

    private float blendY;

    public bool grounded;

    public bool dashing;

    public LayerMask whatIsGround;

    public GameObject jumpSfx;

    public GameObject dashFx;

    private float moveSpeed = 15f;

    private float rotationSpeed = 13f;

    private float animationBlendSpeed = 8f;

    public GameObject weapon;

    private MeshFilter filter;

    private MeshRenderer renderer;

    public Transform hpBar;

    public Transform upperBody;

    public SkinnedMeshRenderer[] armor;

    private float currentTorsoRotation;

    private float lastFallSpeed;

    public GameObject footstepFx;

    private float distance;

    private float fallSpeed;

    public GameObject smokeFx;

    public Transform jumpSmokeFxPos;

    private float speed;

    public float hpRatio { get; set; } = 1f;


    public int currentWeaponId { get; set; } = -1;


    private void Start()
    {
        grounded = true;
        filter = weapon.GetComponent<MeshFilter>();
        renderer = weapon.GetComponent<MeshRenderer>();
    }

    private void FixedUpdate()
    {
        fallSpeed = Mathf.Abs(rb.velocity.y);
        Vector3 position = Vector3.Lerp(rb.position, desiredPos, Time.deltaTime * moveSpeed);
        rb.MovePosition(position);
    }

    private void Update()
    {
        if (Physics.Raycast(base.transform.position, Vector3.down, 2.4f, whatIsGround))
        {
            grounded = true;
        }
        else
        {
            grounded = false;
        }
        Animate();
        Sfx();
        FootSteps();
        base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(0f, orientationY, 0f), Time.deltaTime * rotationSpeed);
        float x = Mathf.Lerp(hpBar.localScale.x, hpRatio, Time.deltaTime * 10f);
        hpBar.localScale = new Vector3(x, 1f, 1f);
    }

    private void LateUpdate()
    {
        currentTorsoRotation = Mathf.Lerp(currentTorsoRotation, orientationX, Time.deltaTime * rotationSpeed);
        upperBody.localRotation = Quaternion.Euler(currentTorsoRotation, upperBody.localRotation.y, upperBody.localRotation.z);
        lastFallSpeed = rb.velocity.y;
    }

    private void FootSteps()
    {
        if (!(DistToPlayer() > 30f) && grounded)
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
                Object.Instantiate(footstepFx, base.transform.position, Quaternion.identity);
                distance = 0f;
            }
        }
    }

    public void UpdateWeapon(int objectID)
    {
        currentWeaponId = objectID;
        if (objectID == -1)
        {
            filter.mesh = null;
            return;
        }
        InventoryItem inventoryItem = ItemManager.Instance.allItems[objectID];
        filter.mesh = inventoryItem.mesh;
        renderer.material = inventoryItem.material;
        animator.SetFloat("AnimationSpeed", inventoryItem.attackSpeed);
    }

    private void Sfx()
    {
        DistToPlayer();
        _ = 20f;
    }

    public void SpawnSmoke()
    {
        if (!(DistToPlayer() > 30f))
        {
            Object.Instantiate(smokeFx, jumpSmokeFxPos.position, Quaternion.LookRotation(Vector3.up));
        }
    }

    private void Animate()
    {
        float b = Mathf.Clamp(rb.velocity.magnitude * 0.1f, 0f, 1f);
        speed = Mathf.Lerp(speed, b, Time.deltaTime * 10f);
        animator.SetBool("Grounded", grounded);
        animator.SetFloat("FallSpeed", lastFallSpeed);
        animator.SetFloat("Speed", speed);
    }

    private float DistToPlayer()
    {
        if (!PlayerMovement.Instance)
        {
            return 1000f;
        }
        return Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
    }

    public void NewAnimation(int animation, bool b)
    {
        switch (animation)
        {
        case 0:
            animator.Play("Attack");
            break;
        case 1:
            animator.SetBool("Eating", b);
            break;
        case 2:
            animator.SetBool("Charging", b);
            break;
        }
    }
}
