using UnityEngine;


public class CollisionSfx : MonoBehaviour
{
    
    private void OnCollisionEnter(Collision other)
    {
        if (!crashAudio || !ready)
        {
            return;
        }
        if (other.relativeVelocity.magnitude < 6f)
        {
            return;
        }
        if (other.contacts.Length != 0)
        {
            var rotation = Quaternion.LookRotation(other.contacts[0].normal);
            var gameObject = UnityEngine.Object.Instantiate<GameObject>(ItemManager.Instance.crashParticles, other.contacts[0].point, rotation);
            var component = other.gameObject.GetComponent<Renderer>();
            if (component)
            {
                var material = component.materials[0];
                gameObject.GetComponent<ParticleSystem>().GetComponent<Renderer>().material = material;
            }
        }
        crashAudio.Randomize(0f);
        ready = false;
        Invoke(nameof(GetReady), 0.5f);
    }

    
    private void GetReady() => ready = true;

    
    public RandomSfx crashAudio;

    
    private bool ready = true;
}
