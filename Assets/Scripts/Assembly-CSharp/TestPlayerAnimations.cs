using UnityEngine;
using UnityEngine.AI;

public class TestPlayerAnimations : MonoBehaviour
{
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

    public NavMeshAgent agent;

    private float fallSpeed;

    public float hpRatio { get; set; } = 1f;


    private void Start()
    {
        grounded = true;
        InvokeRepeating("FindRandomPosition", 1f, 5f);
        filter = weapon.GetComponent<MeshFilter>();
        renderer = weapon.GetComponent<MeshRenderer>();
    }

    private void FindRandomPosition()
    {
        Vector3 vector = new Vector3(Random.Range(-20f, 20f), 20f, Random.Range(-20f, 20f));
        if (Physics.Raycast(base.transform.position + vector, Vector3.down, out var hitInfo, 70f, whatIsGround))
        {
            agent.destination = hitInfo.point;
            agent.isStopped = false;
        }
    }

    private void FixedUpdate()
    {
        animator.SetFloat("Speed", agent.speed);
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
        animator.SetFloat("FallSpeed", fallSpeed);
        Animate();
        Sfx();
        orientationX = -60f;
        upperBody.localRotation = Quaternion.Lerp(upperBody.localRotation, Quaternion.Euler(orientationX, upperBody.localRotation.y, upperBody.localRotation.z), Time.deltaTime * rotationSpeed);
    }

    private void LateUpdate()
    {
        fallSpeed = rb.velocity.y;
        MonoBehaviour.print("fallspeed: " + fallSpeed);
    }

    public void AttackAnimation()
    {
        animator.Play("Attack");
    }

    public void UpdateWeapon(int objectID)
    {
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

    private void Animate()
    {
        animator.SetBool("Grounded", grounded);
    }

    private float DistToPlayer()
    {
        return 1f;
    }
}
