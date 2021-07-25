using System;
using UnityEngine;

public class Tutorial : MonoBehaviour
{
    [Serializable]
    public class TutorialStep
    {
        public TutorialState state;

        public string text;

        public InventoryItem item;

        public Transform arrowTargetPos;
    }

    [Serializable]
    public enum TutorialState
    {
        Unlock,
        Hotbar,
        Inventory,
        Tree,
        Workbench,
        Build
    }

    public Transform tutorialArrow;

    public RectTransform canvasRect;

    private bool started;

    public TutorialStep[] steps;

    public Transform taskParent;

    public GameObject taskPrefab;

    public static Tutorial Instance;

    public bool stationPlaced;

    private TutorialTaskUI currentTaskUi;

    private int progress;

    public Transform target { get; set; }

    public TutorialStep currentStep { get; set; }

    private void Awake()
    {
        Instance = this;
    }

    private void Start()
    {
        if (!CurrentSettings.Instance.tutorial)
        {
            UnityEngine.Object.Destroy(base.gameObject);
        }
    }

    private void Update()
    {
        if (!started)
        {
            if ((bool)PlayerMovement.Instance)
            {
                started = true;
                Invoke(nameof(ContinueTutorial), 5f);
            }
        }
        else if (currentStep != null)
        {
            if (currentStep.state == TutorialState.Unlock || currentStep.state == TutorialState.Tree)
            {
                TargetFollowItem();
            }
            else if (currentStep.state == TutorialState.Hotbar)
            {
                TargetFollowUI();
            }
            else if (currentStep.state == TutorialState.Inventory)
            {
                Inventory();
            }
            else if (currentStep.state == TutorialState.Workbench)
            {
                Workbench();
            }
            else if (currentStep.state == TutorialState.Build)
            {
                Build();
            }
        }
    }

    private void Tree()
    {
    }

    private void Workbench()
    {
        InventoryCell[] hotkeyCells = InventoryUI.Instance.hotkeyCells;
        foreach (InventoryCell inventoryCell in hotkeyCells)
        {
            if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.id == currentStep.item.id)
            {
                ContinueTutorial();
                tutorialArrow.gameObject.SetActive(value: false);
            }
        }
    }

    private void Build()
    {
        if (stationPlaced)
        {
            ContinueTutorial();
            tutorialArrow.gameObject.SetActive(value: false);
        }
    }

    private void Inventory()
    {
        if (InventoryUI.Instance.gameObject.activeInHierarchy)
        {
            ContinueTutorial();
        }
    }

    private void TargetFollowUI()
    {
        if (!currentStep.arrowTargetPos || !InventoryUI.Instance.gameObject.activeInHierarchy)
        {
            tutorialArrow.gameObject.SetActive(value: false);
            return;
        }
        tutorialArrow.gameObject.SetActive(value: true);
        tutorialArrow.position = currentStep.arrowTargetPos.position;
        InventoryCell[] hotkeyCells = InventoryUI.Instance.hotkeyCells;
        foreach (InventoryCell inventoryCell in hotkeyCells)
        {
            if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.id == currentStep.item.id)
            {
                ContinueTutorial();
                tutorialArrow.gameObject.SetActive(value: false);
            }
        }
    }

    private void TargetFollowItem()
    {
        if (UiEvents.Instance.IsHardUnlocked(currentStep.item.id))
        {
            ContinueTutorial();
            tutorialArrow.gameObject.SetActive(value: false);
            return;
        }
        if (!target)
        {
            tutorialArrow.gameObject.SetActive(value: false);
            return;
        }
        tutorialArrow.gameObject.SetActive(value: true);
        Vector3 vector = calculateWorldPosition(target.position, Camera.main);
        Vector3 position = new Vector3(vector.x, vector.y, vector.z);
        Vector2 screenPoint = Camera.main.WorldToScreenPoint(position);
        RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRect, screenPoint, null, out var localPoint);
        float num = 0.85f;
        Vector3 vector2 = canvasRect.sizeDelta;
        Vector2 vector3 = new Vector2(vector2.x / 2f, vector2.y / 2f) * num;
        Vector2 vector4 = new Vector2((0f - vector2.x) / 2f, (0f - vector2.y) / 2f) * num;
        if (localPoint.x > vector3.x)
        {
            localPoint.x = vector3.x;
        }
        if (localPoint.x < vector4.x)
        {
            localPoint.x = vector4.x;
        }
        if (localPoint.y > vector3.y)
        {
            localPoint.y = vector3.y;
        }
        if (localPoint.y < vector4.y)
        {
            localPoint.y = vector4.y;
        }
        tutorialArrow.localPosition = localPoint;
    }

    private Vector3 calculateWorldPosition(Vector3 position, Camera camera)
    {
        Vector3 forward = camera.transform.forward;
        Vector3 vector = position - camera.transform.position;
        if (Vector3.Dot(forward, vector.normalized) <= 0f)
        {
            float num = Vector3.Dot(forward, vector);
            Vector3 vector2 = forward * num * 1.01f;
            position = camera.transform.position + (vector - vector2);
        }
        return position;
    }

    private void FindItem(InventoryItem item)
    {
        float num = float.PositiveInfinity;
        GameObject gameObject = null;
        foreach (GameObject value in ResourceManager.Instance.list.Values)
        {
            if (value == null)
            {
                continue;
            }
            PickupInteract component = value.GetComponent<PickupInteract>();
            if (component != null && component.item.id == item.id)
            {
                float num2 = Vector3.Distance(value.transform.position, PlayerMovement.Instance.transform.position);
                if (num2 < num)
                {
                    num = num2;
                    gameObject = value;
                }
            }
        }
        if (gameObject != null)
        {
            target = gameObject.transform;
        }
    }

    public void ContinueTutorial()
    {
        if ((bool)currentTaskUi)
        {
            currentTaskUi.StartFade();
        }
        currentTaskUi = null;
        UiSfx.Instance.PlayTaskComplete();
        if (progress >= steps.Length)
        {
            currentStep = null;
            UnityEngine.Object.Destroy(base.gameObject);
            return;
        }
        currentStep = steps[progress++];
        currentTaskUi = UnityEngine.Object.Instantiate(taskPrefab, taskParent).GetComponent<TutorialTaskUI>();
        currentTaskUi.SetItem(currentStep.item, currentStep.text);
        if (currentStep.state == TutorialState.Unlock)
        {
            FindItem(currentStep.item);
        }
        else if (currentStep.state == TutorialState.Tree)
        {
            FindTree();
        }
    }

    private void FindTree()
    {
        float num = float.PositiveInfinity;
        GameObject gameObject = null;
        foreach (GameObject value in ResourceManager.Instance.list.Values)
        {
            if (value == null)
            {
                continue;
            }
            HitableTree component = value.GetComponent<HitableTree>();
            if (component != null && component.entityName == "Tree")
            {
                float num2 = Vector3.Distance(value.transform.position, PlayerMovement.Instance.transform.position);
                if (num2 < num)
                {
                    num = num2;
                    gameObject = value;
                }
            }
        }
        if (gameObject != null)
        {
            target = gameObject.transform;
        }
        else
        {
            Debug.LogError("didnt find tree");
        }
    }
}
