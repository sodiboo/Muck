
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000034 RID: 52
public class HitableInspector : MonoBehaviour
{
	// Token: 0x0600012F RID: 303 RVA: 0x0000823C File Offset: 0x0000643C
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
	}

	// Token: 0x06000130 RID: 304 RVA: 0x0000828C File Offset: 0x0000648C
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

	// Token: 0x04000121 RID: 289
	public LayerMask whatIsObject;

	// Token: 0x04000122 RID: 290
	private GameObject child;

	// Token: 0x04000123 RID: 291
	public TextMeshProUGUI hp;

	// Token: 0x04000124 RID: 292
	public TextMeshProUGUI info;

	// Token: 0x04000125 RID: 293
	public Image hpBar;

	// Token: 0x04000126 RID: 294
	public Image maxBar;

	// Token: 0x04000127 RID: 295
	public Image overlay;

	// Token: 0x04000128 RID: 296
	private Vector3 desiredPosition;

	// Token: 0x04000129 RID: 297
	private float speed = 2f;

	// Token: 0x0400012A RID: 298
	private Hitable currentResource;

	// Token: 0x0400012B RID: 299
	private bool show;

	// Token: 0x0400012C RID: 300
	private Vector3 offsetPos = Vector3.zero;

	// Token: 0x0400012D RID: 301
	private float maxResourceDistance = 15f;

	// Token: 0x0400012E RID: 302
	private float maxMobDistance = 100f;

	// Token: 0x0400012F RID: 303
	private float ratio;
}
