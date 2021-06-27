using System;
using TMPro;
using UnityEngine;

// Token: 0x02000029 RID: 41
public class DetectInteractables : MonoBehaviour
{
	// Token: 0x060000F1 RID: 241 RVA: 0x00006766 File Offset: 0x00004966
	private void Awake()
	{
		DetectInteractables.Instance = this;
		this.interactUi = Instantiate<GameObject>(this.interactUiPrefab).transform;
		this.interactText = this.interactUi.GetComponentInChildren<TextMeshProUGUI>();
		this.interactUi.gameObject.SetActive(false);
	}

	// Token: 0x060000F2 RID: 242 RVA: 0x000067A6 File Offset: 0x000049A6
	private void Start()
	{
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x1700000C RID: 12
	// (get) Token: 0x060000F3 RID: 243 RVA: 0x000067B8 File Offset: 0x000049B8
	// (set) Token: 0x060000F4 RID: 244 RVA: 0x000067C0 File Offset: 0x000049C0
	public Interactable currentInteractable { get; private set; }

	// Token: 0x060000F5 RID: 245 RVA: 0x000067CC File Offset: 0x000049CC
	private void Update()
	{
		RaycastHit raycastHit;
		if (Physics.SphereCast(this.playerCam.position, 1.5f, this.playerCam.forward, out raycastHit, 4f, this.whatIsInteractable))
		{
			if (this.currentCollider == raycastHit.collider)
			{
				this.interactText.text = (this.currentInteractable.GetName() ?? "");
				return;
			}
			if (raycastHit.collider.isTrigger)
			{
				this.currentInteractable = raycastHit.collider.gameObject.GetComponent<Interactable>();
				if (this.currentInteractable == null)
				{
					return;
				}
				if (this.currentInteractable != null)
				{
					this.currentCollider = raycastHit.collider;
				}
				this.interactUi.gameObject.SetActive(true);
				this.interactText.text = (this.currentInteractable.GetName() ?? "");
				this.interactUi.transform.position = raycastHit.collider.gameObject.transform.position + Vector3.up * raycastHit.collider.bounds.extents.y;
				this.interactText.CrossFadeAlpha(1f, 0.25f, false);
				return;
			}
		}
		else
		{
			this.currentCollider = null;
			this.currentInteractable = null;
			this.interactText.CrossFadeAlpha(0f, 0.15f, false);
		}
	}

	// Token: 0x040000F3 RID: 243
	public LayerMask whatIsInteractable;

	// Token: 0x040000F4 RID: 244
	public GameObject interactUiPrefab;

	// Token: 0x040000F5 RID: 245
	private Transform interactUi;

	// Token: 0x040000F6 RID: 246
	private TextMeshProUGUI interactText;

	// Token: 0x040000F7 RID: 247
	private Transform playerCam;

	// Token: 0x040000F8 RID: 248
	public static DetectInteractables Instance;

	// Token: 0x040000F9 RID: 249
	private Collider currentCollider;
}
