using System;
using TMPro;
using UnityEngine;

// Token: 0x02000025 RID: 37
public class DetectInteractables : MonoBehaviour
{
	// Token: 0x060000BF RID: 191 RVA: 0x00002AD5 File Offset: 0x00000CD5
	private void Awake()
	{
		DetectInteractables.Instance = this;
		this.interactUi =Instantiate<GameObject>(this.interactUiPrefab).transform;
		this.interactText = this.interactUi.GetComponentInChildren<TextMeshProUGUI>();
		this.interactUi.gameObject.SetActive(false);
	}

	// Token: 0x060000C0 RID: 192 RVA: 0x00002B15 File Offset: 0x00000D15
	private void Start()
	{
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x17000007 RID: 7
	// (get) Token: 0x060000C1 RID: 193 RVA: 0x00002B27 File Offset: 0x00000D27
	// (set) Token: 0x060000C2 RID: 194 RVA: 0x00002B2F File Offset: 0x00000D2F
	public Interactable currentInteractable { get; private set; }

	// Token: 0x060000C3 RID: 195 RVA: 0x0000A0B4 File Offset: 0x000082B4
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

	// Token: 0x040000BB RID: 187
	public LayerMask whatIsInteractable;

	// Token: 0x040000BC RID: 188
	public GameObject interactUiPrefab;

	// Token: 0x040000BD RID: 189
	private Transform interactUi;

	// Token: 0x040000BE RID: 190
	private TextMeshProUGUI interactText;

	// Token: 0x040000BF RID: 191
	private Transform playerCam;

	// Token: 0x040000C0 RID: 192
	public static DetectInteractables Instance;

	// Token: 0x040000C1 RID: 193
	private Collider currentCollider;
}
