using UnityEngine;

public class FloatItem : MonoBehaviour
{
    private LayerMask whatIsGround;

    private float floatHeight = 2f;

    private Vector3 desiredScale;

    private float yPos;

    private float yOffset;

    public float maxOffset = 0.5f;

    private void Start()
    {
        PositionItem();
        yPos = base.transform.position.y;
        desiredScale = base.transform.localScale;
        base.transform.localScale = Vector3.zero;
    }

    private void Update()
    {
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, desiredScale, Time.deltaTime * 7f);
        base.transform.Rotate(Vector3.up, 20f * Time.deltaTime);
        float b = Mathf.PingPong(Time.time * 0.5f, maxOffset) - maxOffset / 2f;
        yOffset = Mathf.Lerp(yOffset, b, Time.deltaTime * 2f);
        base.transform.position = new Vector3(base.transform.position.x, yPos + yOffset, base.transform.position.z);
    }

    private void PositionItem()
    {
        whatIsGround = LayerMask.GetMask("Ground");
        if (Physics.Raycast(base.transform.position + Vector3.up * 20f, Vector3.down, out var hitInfo, 50f, whatIsGround))
        {
            base.transform.position = hitInfo.point + Vector3.up * floatHeight;
        }
    }
}
