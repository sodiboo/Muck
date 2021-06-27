using System;
using TMPro;
using UnityEngine;

public class DetectInteractables : MonoBehaviour
{
	private void Awake()
	{
		DetectInteractables.Instance = this;
		this.interactUi = Instantiate<GameObject>(this.interactUiPrefab).transform;
		this.interactText = this.interactUi.GetComponentInChildren<TextMeshProUGUI>();
		this.interactUi.gameObject.SetActive(false);
	}

	private void Start()
	{
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	private void OnDisable() {
		currentInteractable = null;
	}

	public Interactable currentInteractable { get; private set; }

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

	public LayerMask whatIsInteractable;

	public GameObject interactUiPrefab;

	private Transform interactUi;

	private TextMeshProUGUI interactText;

	private Transform playerCam;

	public static DetectInteractables Instance;

	private Collider currentCollider;
}
