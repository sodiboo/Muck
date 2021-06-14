using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000041 RID: 65
public class HitableInspector : MonoBehaviour
{
	// Token: 0x06000156 RID: 342 RVA: 0x0000CF68 File Offset: 0x0000B168
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
	}

	// Token: 0x06000157 RID: 343 RVA: 0x0000CFB8 File Offset: 0x0000B1B8
	private void Update()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		Transform playerCam = PlayerMovement.Instance.playerCam;
		RaycastHit raycastHit;
		if (Physics.Raycast(playerCam.position, playerCam.forward, out raycastHit, this.maxMobDistance, this.whatIsObject))
		{
			Hitable component = raycastHit.collider.gameObject.GetComponent<Hitable>();
			bool flag = true;
			if (component != null && component.gameObject.layer != LayerMask.NameToLayer("Enemy") && raycastHit.distance > this.maxResourceDistance)
			{
				flag = false;
				this.currentResource = null;
			}
			if (this.currentResource != component && component != null && flag)
			{
				this.currentResource = component;
				this.show = true;
				this.maxBar.CrossFadeAlpha(1f, 0.25f, true);
				this.hpBar.CrossFadeAlpha(1f, 0.25f, true);
				this.info.CrossFadeAlpha(1f, 0.25f, true);
				this.overlay.CrossFadeAlpha(1f, 0.25f, true);
				this.hpBar.transform.localScale = new Vector3((float)this.currentResource.hp / (float)this.currentResource.maxHp, 1f, 1f);
				this.info.text = component.entityName;
			}
			if (this.currentResource)
			{
				float y = raycastHit.collider.ClosestPoint(raycastHit.collider.transform.position + Vector3.up * 10f).y;
				float num = raycastHit.transform.position.y + 2f;
				if (y < num)
				{
					this.offsetPos.y = y + 1f;
				}
				else
				{
					this.offsetPos.y = num + 1f;
				}
				if (this.currentResource.gameObject.layer == LayerMask.NameToLayer("Enemy"))
				{
					this.offsetPos.y = y + 0.4f;
				}
				this.ratio = (float)this.currentResource.hp / (float)this.currentResource.maxHp;
				Vector3 position = this.currentResource.transform.position;
				position.y = this.offsetPos.y;
				base.transform.position = position;
			}
			else
			{
				this.show = false;
				this.maxBar.CrossFadeAlpha(0f, 0.25f, true);
				this.hpBar.CrossFadeAlpha(0f, 0.25f, true);
				this.overlay.CrossFadeAlpha(0f, 0.25f, true);
				this.info.CrossFadeAlpha(0f, 0.25f, true);
			}
		}
		else
		{
			if (this.currentResource || this.show)
			{
				this.show = false;
				this.maxBar.CrossFadeAlpha(0f, 0.25f, true);
				this.hpBar.CrossFadeAlpha(0f, 0.25f, true);
				this.info.CrossFadeAlpha(0f, 0.25f, true);
				this.overlay.CrossFadeAlpha(0f, 0.25f, true);
			}
			this.currentResource = null;
		}
		this.hpBar.transform.localScale = Vector3.Lerp(this.hpBar.transform.localScale, new Vector3(this.ratio, 1f, 1f), Time.deltaTime * 4f);
	}

	// Token: 0x04000156 RID: 342
	public LayerMask whatIsObject;

	// Token: 0x04000157 RID: 343
	private GameObject child;

	// Token: 0x04000158 RID: 344
	public TextMeshProUGUI hp;

	// Token: 0x04000159 RID: 345
	public TextMeshProUGUI info;

	// Token: 0x0400015A RID: 346
	public Image hpBar;

	// Token: 0x0400015B RID: 347
	public Image maxBar;

	// Token: 0x0400015C RID: 348
	public Image overlay;

	// Token: 0x0400015D RID: 349
	private Vector3 desiredPosition;

	// Token: 0x0400015E RID: 350
	private float speed = 2f;

	// Token: 0x0400015F RID: 351
	private Hitable currentResource;

	// Token: 0x04000160 RID: 352
	private bool show;

	// Token: 0x04000161 RID: 353
	private Vector3 offsetPos = Vector3.zero;

	// Token: 0x04000162 RID: 354
	private float maxResourceDistance = 15f;

	// Token: 0x04000163 RID: 355
	private float maxMobDistance = 100f;

	// Token: 0x04000164 RID: 356
	private float ratio;
}
