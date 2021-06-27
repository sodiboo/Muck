using System;
using UnityEngine;

public class FootStep : MonoBehaviour
{
	private void Start()
	{
		this.FindGroundType();
	}

	private void FindGroundType()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, Vector3.down, out raycastHit, 5f, this.whatIsGround) && raycastHit.collider.gameObject.CompareTag("Build"))
		{
			this.randomSfx.sounds = this.woodSfx;
		}
		this.randomSfx.Randomize(0f);
	}

	public LayerMask whatIsGround;

	public RandomSfx randomSfx;

	public AudioClip[] woodSfx;
}
