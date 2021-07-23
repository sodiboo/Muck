using UnityEngine;

public class EnemyAttackIndicator : MonoBehaviour
{
    public Vector3 offset = new Vector3(0f, -0.25f, 0f);

    public LayerMask whatIsGround;

    public Projector projector;

    private Vector3 desiredScale;

    private void Awake()
    {
        if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out var hitInfo, 50f, whatIsGround))
        {
            base.transform.position = hitInfo.point + offset * base.transform.localScale.x;
        }
        desiredScale = base.transform.localScale;
        base.transform.localScale = Vector3.zero;
    }

    public void SetWarning(float time, float scale)
    {
        desiredScale = Vector3.one * scale;
        Invoke("DestroySelf", time);
        if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out var hitInfo, 50f, whatIsGround))
        {
            base.transform.position = hitInfo.point + offset * base.transform.localScale.x;
        }
    }

    private void Update()
    {
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, desiredScale, Time.deltaTime * 7f);
        projector.orthographicSize = base.transform.localScale.x / 2f;
        float z = 100f * Time.deltaTime;
        base.transform.Rotate(new Vector3(0f, 0f, z), Space.Self);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }
}
