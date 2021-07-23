using UnityEngine;

public class SpawnStepSmoke : MonoBehaviour
{
    public Transform leftFoot;

    public Transform rightFoot;

    public GameObject stepFx;

    public void LeftStep()
    {
        Object.Instantiate(stepFx, leftFoot.position, stepFx.transform.rotation);
    }

    public void RightStep()
    {
        Object.Instantiate(stepFx, rightFoot.position, stepFx.transform.rotation);
    }
}
