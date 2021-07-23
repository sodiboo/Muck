using UnityEngine;

public class GroundRollAttack : MonoBehaviour
{
    public Rigidbody rb;

    public float speed = 60f;

    public LayerMask whatIsGround;

    public Transform rollRock;

    public GameObject rollPrefab;

    private bool child;

    private Vector3 rollAxis;

    private float rollSpeed = 10f;

    private void Start()
    {
        Vector3 forward = base.transform.forward;
        forward.y = 0f;
        rb.velocity = forward * speed;
        rollAxis = Vector3.Cross(rb.velocity, Vector3.up);
        Debug.DrawLine(base.transform.position, base.transform.position + forward * 10f, Color.red, 10f);
        GetComponent<Collider>().enabled = true;
        if (!child)
        {
            int num = 2;
            int num2 = 25;
            Collider component = GetComponent<Collider>();
            for (int i = 0; i < num; i++)
            {
                Transform transform = Object.Instantiate(rollPrefab, base.transform.position, base.transform.rotation).transform;
                transform.GetComponent<GroundRollAttack>().child = true;
                transform.eulerAngles = new Vector3(transform.eulerAngles.x, transform.eulerAngles.y + (float)(num2 * 2 * i) - (float)num2, transform.eulerAngles.z);
                Physics.IgnoreCollision(component, transform.GetComponent<Collider>());
            }
        }
    }

    private void Update()
    {
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
        rollRock.transform.Rotate(rollAxis * rollSpeed * Time.deltaTime);
    }
}
