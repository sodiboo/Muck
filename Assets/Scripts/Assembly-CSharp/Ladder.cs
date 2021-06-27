using System;
using UnityEngine;

// Token: 0x0200005B RID: 91
public class Ladder : MonoBehaviour
{
	// Token: 0x06000207 RID: 519 RVA: 0x0000C6A8 File Offset: 0x0000A8A8
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

	// Token: 0x06000208 RID: 520 RVA: 0x0000C719 File Offset: 0x0000A919
	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Local"))
		{
			PlayerMovement.Instance.GetRb().drag = 3f;
			this.onLadder = true;
		}
	}

	// Token: 0x06000209 RID: 521 RVA: 0x0000C748 File Offset: 0x0000A948
	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.CompareTag("Local"))
		{
			PlayerMovement.Instance.GetRb().drag = 0f;
			this.onLadder = false;
		}
	}

	// Token: 0x0400021D RID: 541
	private bool onLadder;
}
