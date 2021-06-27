using System;
using UnityEngine;

[ExecuteInEditMode]
public class DragonFire : MonoBehaviour
{
	private void Awake()
	{
		InvokeRepeating(nameof(UpdateHitbox), 0.1f, 0.1f);
		Invoke(nameof(StartHitbox), 1.35f);
		this.c = base.GetComponent<Collider>();
		this.c.enabled = false;
	}

	private void StartHitbox()
	{
		Invoke(nameof(StopHitbox), 1.5f);
		this.c.enabled = true;
	}

	private void StopHitbox()
	{
		this.c.enabled = false;
	}

	private void UpdateHitbox()
	{
		this.hitbox.Reset();
	}

	private void Update()
	{
		Vector3 euler = new Vector3(0f, base.transform.parent.rotation.eulerAngles.y, 0f);
		base.transform.rotation = Quaternion.Euler(euler);
	}

	private Collider c;

	public HitboxDamage hitbox;

	private float yHeight;
}
