using UnityEngine;

public class FootStep : MonoBehaviour
{
    public LayerMask whatIsGround;

    public RandomSfx randomSfx;

    public AudioClip[] woodSfx;

    private void Start()
    {
        FindGroundType();
    }

    private void FindGroundType()
    {
        if (Physics.Raycast(base.transform.position, Vector3.down, out var hitInfo, 5f, whatIsGround) && hitInfo.collider.gameObject.CompareTag("Build"))
        {
            randomSfx.sounds = woodSfx;
        }
        randomSfx.Randomize(0f);
    }
}
