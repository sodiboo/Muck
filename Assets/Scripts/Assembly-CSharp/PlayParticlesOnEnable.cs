using UnityEngine;

public class PlayParticlesOnEnable : MonoBehaviour
{
    public ParticleSystem ps;

    private void OnEnable()
    {
        ps.Play(withChildren: true);
    }
}
