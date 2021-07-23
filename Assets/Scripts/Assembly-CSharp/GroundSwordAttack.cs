using UnityEngine;

public class GroundSwordAttack : MonoBehaviour
{
    public Rigidbody rb;

    public float speed = 60f;

    public LayerMask whatIsGround;

    public Transform rollRock;

    public GameObject rollPrefab;

    public InventoryItem projectile;

    private bool child;

    private Vector3 rollAxis;

    private float rollSpeed = 10f;

    private void Start()
    {
        Debug.LogError("Spawned");
        Vector3 forward = base.transform.forward;
        forward.y = 0f;
        rb.velocity = forward.normalized * projectile.bowComponent.projectileSpeed;
        rb.angularVelocity = Vector3.zero;
        rollAxis = Vector3.Cross(rb.velocity, Vector3.up);
        Debug.DrawLine(base.transform.position, base.transform.position + forward * 10f, Color.red, 10f);
        GetComponent<Collider>().enabled = true;
        if (!child)
        {
            int num = 25;
            Collider component = GetComponent<Collider>();
            for (int i = 0; i < 2; i++)
            {
                Transform transform = Object.Instantiate(rollPrefab, base.transform.position, base.transform.rotation).transform;
                transform.GetComponent<GroundSwordAttack>().child = true;
                transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num * 2 * i) - (float)num, transform.eulerAngles.z);
                Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
            }
            for (int j = 0; j < 2; j++)
            {
                Transform transform2 = Object.Instantiate(rollPrefab, base.transform.position, base.transform.rotation).transform;
                transform2.GetComponent<GroundSwordAttack>().child = true;
                transform2.eulerAngles = new Vector3(transform2.eulerAngles.x, transform2.eulerAngles.y + (float)(num * 4 * j) - (float)(num * 2), transform2.eulerAngles.z);
                Physics.IgnoreCollision(component, transform2.GetComponent<Collider>());
            }
        }
    }

    private void Update()
    {
        rb.velocity = base.transform.forward * projectile.bowComponent.projectileSpeed;
        KeepRockGrounded();
        SpinRock();
    }

    private void KeepRockGrounded()
    {
        if (Physics.Raycast(base.transform.position + Vector3.up * 50f, Vector3.down, out var hitInfo, 100f, whatIsGround))
        {
            Vector3 position = rb.position;
            position.y = hitInfo.point.y;
            rb.MovePosition(position);
        }
    }

    private void SpinRock()
    {
        if (Physics.Raycast(base.transform.position + Vector3.up * 2f, Vector3.down, out var hitInfo, 4f, whatIsGround))
        {
            float x = Vector3.SignedAngle(Vector3.up, hitInfo.normal, base.transform.right);
            Vector3 eulerAngles = rollRock.transform.rotation.eulerAngles;
            rollRock.transform.rotation = Quaternion.Lerp(rollRock.rotation, Quaternion.Euler(new Vector3(x, eulerAngles.y, eulerAngles.z)), Time.deltaTime * 15f);
        }
    }
}
