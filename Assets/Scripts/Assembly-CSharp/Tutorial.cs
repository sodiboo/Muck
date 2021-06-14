using System;
using UnityEngine;

// Token: 0x0200014D RID: 333
public class Tutorial : MonoBehaviour
{
	// Token: 0x1700005C RID: 92
	// (get) Token: 0x060007FB RID: 2043 RVA: 0x000073B2 File Offset: 0x000055B2
	// (set) Token: 0x060007FC RID: 2044 RVA: 0x000073BA File Offset: 0x000055BA
	public Transform target { get; set; }

	// Token: 0x060007FD RID: 2045 RVA: 0x000073C3 File Offset: 0x000055C3
	private void Awake()
	{
		Tutorial.Instance = this;
	}

	// Token: 0x060007FE RID: 2046 RVA: 0x000073CB File Offset: 0x000055CB
	private void Start()
	{
		if (!CurrentSettings.Instance.tutorial)
		{
		Destroy(base.gameObject);
		}
	}

	// Token: 0x060007FF RID: 2047 RVA: 0x00027274 File Offset: 0x00025474
	private void Update()
	{
		if (!this.started)
		{
			if (!PlayerMovement.Instance)
			{
				return;
			}
			this.started = true;
			base.Invoke("ContinueTutorial", 5f);
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

	// Token: 0x06000800 RID: 2048 RVA: 0x00002147 File Offset: 0x00000347
	private void Tree()
	{
	}

	// Token: 0x06000801 RID: 2049 RVA: 0x0002732C File Offset: 0x0002552C
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

	// Token: 0x06000802 RID: 2050 RVA: 0x000073E4 File Offset: 0x000055E4
	private void Build()
	{
		if (this.stationPlaced)
		{
			this.ContinueTutorial();
			this.tutorialArrow.gameObject.SetActive(false);
		}
	}

	// Token: 0x06000803 RID: 2051 RVA: 0x00007405 File Offset: 0x00005605
	private void Inventory()
	{
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.ContinueTutorial();
		}
	}

	// Token: 0x06000804 RID: 2052 RVA: 0x00027398 File Offset: 0x00025598
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

	// Token: 0x06000805 RID: 2053 RVA: 0x00027468 File Offset: 0x00025668
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

	// Token: 0x06000806 RID: 2054 RVA: 0x0002761C File Offset: 0x0002581C
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

	// Token: 0x06000807 RID: 2055 RVA: 0x00027690 File Offset: 0x00025890
	private void FindItem(InventoryItem item)
	{
		float num = float.PositiveInfinity;
		GameObject gameObject = null;
		foreach (GameObject gameObject2 in ResourceManager.Instance.list.Values)
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
		if (gameObject != null)
		{
			this.target = gameObject.transform;
		}
	}

	// Token: 0x1700005D RID: 93
	// (get) Token: 0x06000808 RID: 2056 RVA: 0x0000741E File Offset: 0x0000561E
	// (set) Token: 0x06000809 RID: 2057 RVA: 0x00007426 File Offset: 0x00005626
	public Tutorial.TutorialStep currentStep { get; set; }

	// Token: 0x0600080A RID: 2058 RVA: 0x00027754 File Offset: 0x00025954
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
		this.currentTaskUi =Instantiate<GameObject>(this.taskPrefab, this.taskParent).GetComponent<TutorialTaskUI>();
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

	// Token: 0x0600080B RID: 2059 RVA: 0x0002783C File Offset: 0x00025A3C
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

	// Token: 0x0400083D RID: 2109
	public Transform tutorialArrow;

	// Token: 0x0400083E RID: 2110
	public RectTransform canvasRect;

	// Token: 0x0400083F RID: 2111
	private bool started;

	// Token: 0x04000840 RID: 2112
	public Tutorial.TutorialStep[] steps;

	// Token: 0x04000842 RID: 2114
	public Transform taskParent;

	// Token: 0x04000843 RID: 2115
	public GameObject taskPrefab;

	// Token: 0x04000844 RID: 2116
	public static Tutorial Instance;

	// Token: 0x04000845 RID: 2117
	public bool stationPlaced;

	// Token: 0x04000847 RID: 2119
	private TutorialTaskUI currentTaskUi;

	// Token: 0x04000848 RID: 2120
	private int progress;

	// Token: 0x0200014E RID: 334
	[Serializable]
	public class TutorialStep
	{
		// Token: 0x04000849 RID: 2121
		public Tutorial.TutorialState state;

		// Token: 0x0400084A RID: 2122
		public string text;

		// Token: 0x0400084B RID: 2123
		public InventoryItem item;

		// Token: 0x0400084C RID: 2124
		public Transform arrowTargetPos;
	}

	// Token: 0x0200014F RID: 335
	[Serializable]
	public enum TutorialState
	{
		// Token: 0x0400084E RID: 2126
		Unlock,
		// Token: 0x0400084F RID: 2127
		Hotbar,
		// Token: 0x04000850 RID: 2128
		Inventory,
		// Token: 0x04000851 RID: 2129
		Tree,
		// Token: 0x04000852 RID: 2130
		Workbench,
		// Token: 0x04000853 RID: 2131
		Build
	}
}
