using System;
using UnityEngine;

// Token: 0x0200002B RID: 43
[ExecuteInEditMode]
public class DragonFire : MonoBehaviour
{
	// Token: 0x060000FC RID: 252 RVA: 0x000069D6 File Offset: 0x00004BD6
	private void Awake()
	{
		InvokeRepeating(nameof(UpdateHitbox), 0.1f, 0.1f);
		Invoke(nameof(StartHitbox), 1.35f);
		this.c = base.GetComponent<Collider>();
		this.c.enabled = false;
	}

	// Token: 0x060000FD RID: 253 RVA: 0x00006A15 File Offset: 0x00004C15
	private void StartHitbox()
	{
		Invoke(nameof(StopHitbox), 1.5f);
		this.c.enabled = true;
	}

	// Token: 0x060000FE RID: 254 RVA: 0x00006A33 File Offset: 0x00004C33
	private void StopHitbox()
	{
		this.c.enabled = false;
	}

	// Token: 0x060000FF RID: 255 RVA: 0x00006A41 File Offset: 0x00004C41
	private void UpdateHitbox()
	{
		this.hitbox.Reset();
	}

	// Token: 0x06000100 RID: 256 RVA: 0x00006A50 File Offset: 0x00004C50
	private void Update()
	{
		Vector3 euler = new Vector3(0f, base.transform.parent.rotation.eulerAngles.y, 0f);
		base.transform.rotation = Quaternion.Euler(euler);
	}

	// Token: 0x040000FE RID: 254
	private Collider c;

	// Token: 0x040000FF RID: 255
	public HitboxDamage hitbox;

	// Token: 0x04000100 RID: 256
	private float yHeight;
}
