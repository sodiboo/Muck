using UnityEngine;

public class LaserTest : MonoBehaviour
{
	public ParticleSystem ps;
	public ParticleSystem psSwirl;
	public LineRenderer lr;
	public Transform targetParticles;
	public LayerMask whatIsHittable;
	public Hitable hitable;
	public Transform hitParticles;
	public GameObject damageFx;
	public GameObject sfx;
	public Transform target;
}
