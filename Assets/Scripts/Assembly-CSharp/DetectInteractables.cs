using TMPro;
using UnityEngine;

public class DetectInteractables : MonoBehaviour
{
    public LayerMask whatIsInteractable;

    public GameObject interactUiPrefab;

    private Transform interactUi;

    private TextMeshProUGUI interactText;

    private Transform playerCam;

    public static DetectInteractables Instance;

    private Collider currentCollider;

    public Interactable currentInteractable { get; private set; }

    private void Awake()
    {
        Instance = this;
        interactUi = Object.Instantiate(interactUiPrefab).transform;
        interactText = interactUi.GetComponentInChildren<TextMeshProUGUI>();
        interactUi.gameObject.SetActive(value: false);
    }

    private void Start()
    {
        playerCam = PlayerMovement.Instance.playerCam;
    }

    private void Update()
    {
        if (Physics.SphereCast(playerCam.position, 1.5f, playerCam.forward, out var hitInfo, 4f, whatIsInteractable))
        {
            if (currentCollider == hitInfo.collider)
            {
                interactText.text = currentInteractable.GetName() ?? "";
            }
            else
            {
                if (!hitInfo.collider.isTrigger)
                {
                    return;
                }
                currentInteractable = hitInfo.collider.gameObject.GetComponent<Interactable>();
                if (currentInteractable != null)
                {
                    if (currentInteractable != null)
                    {
                        currentCollider = hitInfo.collider;
                    }
                    interactUi.gameObject.SetActive(value: true);
                    interactText.text = currentInteractable.GetName() ?? "";
                    interactUi.transform.position = hitInfo.collider.gameObject.transform.position + Vector3.up * hitInfo.collider.bounds.extents.y;
                    interactText.CrossFadeAlpha(1f, 0.25f, ignoreTimeScale: false);
                }
            }
        }
        else
        {
            currentCollider = null;
            currentInteractable = null;
            interactText.CrossFadeAlpha(0f, 0.15f, ignoreTimeScale: false);
        }
    }
}
