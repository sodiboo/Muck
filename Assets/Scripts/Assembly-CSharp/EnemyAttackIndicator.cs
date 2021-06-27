using System;
using UnityEngine;

public class EnemyAttackIndicator : MonoBehaviour
{
	private void Awake()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + this.offset * base.transform.localScale.x;
		}
		this.desiredScale = base.transform.localScale;
		base.transform.localScale = Vector3.zero;
	}

	public void SetWarning(float time, float scale)
	{
		this.desiredScale = Vector3.one * scale;
		Invoke(nameof(DestroySelf), time);
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 10f, Vector3.down, out raycastHit, 50f, this.whatIsGround))
		{
			base.transform.position = raycastHit.point + this.offset * base.transform.localScale.x;
		}
	}

	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 7f);
		this.projector.orthographicSize = base.transform.localScale.x / 2f;
		float z = 100f * Time.deltaTime;
		base.transform.Rotate(new Vector3(0f, 0f, z), Space.Self);
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	public Vector3 offset = new Vector3(0f, -0.25f, 0f);

	public LayerMask whatIsGround;

	public Projector projector;

	private Vector3 desiredScale;
}
