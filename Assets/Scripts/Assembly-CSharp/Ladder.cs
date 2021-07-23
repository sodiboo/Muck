using UnityEngine;

public class Ladder : MonoBehaviour
{
    private bool onLadder;

    private void FixedUpdate()
    {
        if (onLadder)
        {
            Vector3 force = Vector3.up * (0f - Physics.gravity.y) * PlayerMovement.Instance.GetRb().mass;
            if (PlayerMovement.Instance.GetInput().y > 0f)
            {
                force *= 6f;
            }
            PlayerMovement.Instance.GetRb().AddForce(force);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Local"))
        {
            PlayerMovement.Instance.GetRb().drag = 3f;
            onLadder = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Local"))
        {
            PlayerMovement.Instance.GetRb().drag = 0f;
            onLadder = false;
        }
    }
}
