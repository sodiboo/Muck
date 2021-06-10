
using TMPro;
using UnityEngine;

// Token: 0x0200001F RID: 31
public class DetectInteractables : MonoBehaviour
{
	// Token: 0x060000B3 RID: 179 RVA: 0x000057DA File Offset: 0x000039DA
	private void Awake()
	{
		DetectInteractables.Instance = this;
		this.interactUi =Instantiate(this.interactUiPrefab).transform;
		this.interactText = this.interactUi.GetComponentInChildren<TextMeshProUGUI>();
		this.interactUi.gameObject.SetActive(false);
	}

	// Token: 0x060000B4 RID: 180 RVA: 0x0000581A File Offset: 0x00003A1A
	private void Start()
	{
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x17000006 RID: 6
	// (get) Token: 0x060000B5 RID: 181 RVA: 0x0000582C File Offset: 0x00003A2C
	// (set) Token: 0x060000B6 RID: 182 RVA: 0x00005834 File Offset: 0x00003A34
	public Interactable currentInteractable { get; private set; }

	// Token: 0x060000B7 RID: 183 RVA: 0x00005840 File Offset: 0x00003A40
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

	// Token: 0x040000A7 RID: 167
	public LayerMask whatIsInteractable;

	// Token: 0x040000A8 RID: 168
	public GameObject interactUiPrefab;

	// Token: 0x040000A9 RID: 169
	private Transform interactUi;

	// Token: 0x040000AA RID: 170
	private TextMeshProUGUI interactText;

	// Token: 0x040000AB RID: 171
	private Transform playerCam;

	// Token: 0x040000AC RID: 172
	public static DetectInteractables Instance;

	// Token: 0x040000AD RID: 173
	private Collider currentCollider;
}
