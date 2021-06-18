using UnityEngine;


public class AntiRoll : MonoBehaviour
{
    
    private void Awake() => bodyRb = base.GetComponent<Rigidbody>();

    
    private void FixedUpdate() => StabilizerBars();

    
    private void StabilizerBars()
    {
        float num;
        if (right.grounded)
        {
            num = right.lastCompression;
        }
        else
        {
            num = 1f;
        }
        float num2;
        if (left.grounded)
        {
            num2 = left.lastCompression;
        }
        else
        {
            num2 = 1f;
        }
        var num3 = (num2 - num) * antiRoll;
        if (right.grounded)
        {
            bodyRb.AddForceAtPosition(right.transform.up * -num3, right.transform.position);
        }
        if (left.grounded)
        {
            bodyRb.AddForceAtPosition(left.transform.up * num3, left.transform.position);
        }
    }

    
    public Suspension right;

    
    public Suspension left;

    
    public float antiRoll = 5000f;

    
    private Rigidbody bodyRb;
}
