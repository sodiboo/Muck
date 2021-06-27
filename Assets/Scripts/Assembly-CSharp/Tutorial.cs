using System;
using UnityEngine;

public class Tutorial : MonoBehaviour
{
	public Transform target { get; set; }

	private void Awake()
	{
		Tutorial.Instance = this;
	}

	private void Start()
	{
		if (!CurrentSettings.Instance.tutorial)
		{
			Destroy(base.gameObject);
		}
	}

	private void Update()
	{
		if (!this.started)
		{
			if (!PlayerMovement.Instance)
			{
				return;
			}
			this.started = true;
			Invoke(nameof(ContinueTutorial), 5f);
			return;
		}
		else
		{
			if (this.currentStep == null)
			{
				return;
			}
			if (this.currentStep.state == Tutorial.TutorialState.Unlock || this.currentStep.state == Tutorial.TutorialState.Tree)
			{
				this.TargetFollowItem();
				return;
			}
			if (this.currentStep.state == Tutorial.TutorialState.Hotbar)
			{
				this.TargetFollowUI();
				return;
			}
			if (this.currentStep.state == Tutorial.TutorialState.Inventory)
			{
				this.Inventory();
				return;
			}
			if (this.currentStep.state == Tutorial.TutorialState.Workbench)
			{
				this.Workbench();
				return;
			}
			if (this.currentStep.state == Tutorial.TutorialState.Build)
			{
				this.Build();
			}
			return;
		}
	}

	private void Tree()
	{
	}

	private void Workbench()
	{
		foreach (InventoryCell inventoryCell in InventoryUI.Instance.hotkeyCells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.id == this.currentStep.item.id)
			{
				this.ContinueTutorial();
				this.tutorialArrow.gameObject.SetActive(false);
			}
		}
	}

	private void Build()
	{
		if (this.stationPlaced)
		{
			this.ContinueTutorial();
			this.tutorialArrow.gameObject.SetActive(false);
		}
	}

	private void Inventory()
	{
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.ContinueTutorial();
		}
	}

	private void TargetFollowUI()
	{
		if (!this.currentStep.arrowTargetPos || !InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.tutorialArrow.gameObject.SetActive(false);
			return;
		}
		this.tutorialArrow.gameObject.SetActive(true);
		this.tutorialArrow.position = this.currentStep.arrowTargetPos.position;
		foreach (InventoryCell inventoryCell in InventoryUI.Instance.hotkeyCells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.id == this.currentStep.item.id)
			{
				this.ContinueTutorial();
				this.tutorialArrow.gameObject.SetActive(false);
			}
		}
	}

	private void TargetFollowItem()
	{
		if (UiEvents.Instance.IsHardUnlocked(this.currentStep.item.id))
		{
			this.ContinueTutorial();
			this.tutorialArrow.gameObject.SetActive(false);
			return;
		}
		if (!this.target)
		{
			this.tutorialArrow.gameObject.SetActive(false);
			return;
		}
		this.tutorialArrow.gameObject.SetActive(true);
		Vector3 vector = this.calculateWorldPosition(this.target.position, Camera.main);
		Vector3 position = new Vector3(vector.x, vector.y, vector.z);
		Vector2 screenPoint = Camera.main.WorldToScreenPoint(position);
		Vector2 vector2;
		RectTransformUtility.ScreenPointToLocalPointInRectangle(this.canvasRect, screenPoint, null, out vector2);
		float d = 0.85f;
		Vector3 vector3 = this.canvasRect.sizeDelta;
		Vector2 vector4 = new Vector2(vector3.x / 2f, vector3.y / 2f) * d;
		Vector2 vector5 = new Vector2(-vector3.x / 2f, -vector3.y / 2f) * d;
		if (vector2.x > vector4.x)
		{
			vector2.x = vector4.x;
		}
		if (vector2.x < vector5.x)
		{
			vector2.x = vector5.x;
		}
		if (vector2.y > vector4.y)
		{
			vector2.y = vector4.y;
		}
		if (vector2.y < vector5.y)
		{
			vector2.y = vector5.y;
		}
		this.tutorialArrow.localPosition = vector2;
	}

	private Vector3 calculateWorldPosition(Vector3 position, Camera camera)
	{
		Vector3 forward = camera.transform.forward;
		Vector3 vector = position - camera.transform.position;
		if (Vector3.Dot(forward, vector.normalized) <= 0f)
		{
			float d = Vector3.Dot(forward, vector);
			Vector3 b = forward * d * 1.01f;
			position = camera.transform.position + (vector - b);
		}
		return position;
	}

	private void FindItem(InventoryItem item)
	{
		float num = float.PositiveInfinity;
		GameObject gameObject = null;
		foreach (GameObject gameObject2 in ResourceManager.Instance.list.Values)
		{
			if (!(gameObject2 == null))
			{
				PickupInteract component = gameObject2.GetComponent<PickupInteract>();
				if (component != null && component.item.id == item.id)
				{
					float num2 = Vector3.Distance(gameObject2.transform.position, PlayerMovement.Instance.transform.position);
					if (num2 < num)
					{
						num = num2;
						gameObject = gameObject2;
					}
				}
			}
		}
		if (gameObject != null)
		{
			this.target = gameObject.transform;
		}
	}

	public Tutorial.TutorialStep currentStep { get; set; }

	public void ContinueTutorial()
	{
		if (this.currentTaskUi)
		{
			this.currentTaskUi.StartFade();
		}
		this.currentTaskUi = null;
		UiSfx.Instance.PlayTaskComplete();
		if (this.progress >= this.steps.Length)
		{
			this.currentStep = null;
			Destroy(base.gameObject);
			return;
		}
		Tutorial.TutorialStep[] array = this.steps;
		int num = this.progress;
		this.progress = num + 1;
		this.currentStep = array[num];
		this.currentTaskUi = Instantiate<GameObject>(this.taskPrefab, this.taskParent).GetComponent<TutorialTaskUI>();
		this.currentTaskUi.SetItem(this.currentStep.item, this.currentStep.text);
		if (this.currentStep.state == Tutorial.TutorialState.Unlock)
		{
			this.FindItem(this.currentStep.item);
			return;
		}
		if (this.currentStep.state == Tutorial.TutorialState.Tree)
		{
			this.FindTree();
		}
	}

	private void FindTree()
	{
		float num = float.PositiveInfinity;
		GameObject gameObject = null;
		foreach (GameObject gameObject2 in ResourceManager.Instance.list.Values)
		{
			HitableTree component = gameObject2.GetComponent<HitableTree>();
			if (component != null && component.entityName == "Tree")
			{
				float num2 = Vector3.Distance(gameObject2.transform.position, PlayerMovement.Instance.transform.position);
				if (num2 < num)
				{
					num = num2;
					gameObject = gameObject2;
				}
			}
		}
		if (gameObject != null)
		{
			this.target = gameObject.transform;
			return;
		}
		Debug.LogError("didnt find tree");
	}

	public Transform tutorialArrow;

	public RectTransform canvasRect;

	private bool started;

	public Tutorial.TutorialStep[] steps;

	public Transform taskParent;

	public GameObject taskPrefab;

	public static Tutorial Instance;

	public bool stationPlaced;

	private TutorialTaskUI currentTaskUi;

	private int progress;

	[Serializable]
	public class TutorialStep
	{
		public Tutorial.TutorialState state;

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
}
