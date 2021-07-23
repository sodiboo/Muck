using UnityEngine;

public class DistanceTravelled : MonoBehaviour
{
    public float groundTravelled;

    public float waterTravelled;

    public PlayerMovement playerMovement;

    public Rigidbody rb;

    public Vector3 lastPos;

    private float interval = 5f;

    private void Start()
    {
        lastPos = rb.position;
        InvokeRepeating("SlowUpdate", interval, interval);
    }

    private void SlowUpdate()
    {
        int groundDist = (int)groundTravelled;
        int waterDist = (int)waterTravelled;
        if ((bool)AchievementManager.Instance)
        {
            AchievementManager.Instance.MoveDistance(groundDist, waterDist);
        }
        groundTravelled = 0f;
        waterTravelled = 0f;
    }

    private void FixedUpdate()
    {
        float num = Vector3.Distance(VectorExtensions.XZVector(rb.position), VectorExtensions.XZVector(lastPos));
        if (playerMovement.IsUnderWater())
        {
            waterTravelled += num;
        }
        else
        {
            groundTravelled += num;
        }
        lastPos = rb.transform.position;
    }
}
