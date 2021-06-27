using System;
using UnityEngine;

public class FloatItem : MonoBehaviour
{
	private void Start()
	{
		this.PositionItem();
		this.yPos = base.transform.position.y;
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		base.transform.Rotate(Vector3.up, 20f * Time.deltaTime);
		float b = Mathf.PingPong(Time.time * 0.5f, this.maxOffset) - this.maxOffset / 2f;
		this.yOffset = Mathf.Lerp(this.yOffset, b, Time.deltaTime * 2f);
		base.transform.position = new Vector3(base.transform.position.x, this.yPos + this.yOffset, base.transform.position.z);
	}

	private void PositionItem()
	{
		this.whatIsGround = LayerMask.GetMask(new string[]
		{
			"Ground"
		});
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 20f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + Vector3.up * this.floatHeight;
		}
	}

	private LayerMask whatIsGround;

	private float floatHeight = 2f;

	private Vector3 desiredScale;

	private float yPos;

	private float yOffset;

	public float maxOffset = 0.5f;
}
