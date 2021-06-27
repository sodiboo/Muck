using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class HitableInspector : MonoBehaviour
{
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
		this.hpBar.CrossFadeAlpha(0f, 0f, true);
	}

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

	public LayerMask whatIsObject;

	private GameObject child;

	public TextMeshProUGUI hp;

	public TextMeshProUGUI info;

	public Image hpBar;

	public Image maxBar;

	public Image overlay;

	private Vector3 desiredPosition;

	private float speed = 2f;

	private Hitable currentResource;

	private bool show;

	private Vector3 offsetPos = Vector3.zero;

	private float maxResourceDistance = 15f;

	private float maxMobDistance = 100f;

	private float ratio;
}
