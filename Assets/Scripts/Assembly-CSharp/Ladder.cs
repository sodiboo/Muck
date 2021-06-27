using System;
using UnityEngine;

public class Ladder : MonoBehaviour
{
	private void FixedUpdate()
	{
		if (this.onLadder)
		{
			Vector3 vector = Vector3.up * -Physics.gravity.y * PlayerMovement.Instance.GetRb().mass;
			if (PlayerMovement.Instance.GetInput().y > 0f)
			{
				vector *= 6f;
			}
			PlayerMovement.Instance.GetRb().AddForce(vector);
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Local"))
		{
			PlayerMovement.Instance.GetRb().drag = 3f;
			this.onLadder = true;
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.CompareTag("Local"))
		{
			PlayerMovement.Instance.GetRb().drag = 0f;
			this.onLadder = false;
		}
	}

	private bool onLadder;
}
