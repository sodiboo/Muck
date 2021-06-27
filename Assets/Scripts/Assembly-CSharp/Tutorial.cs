using System;
using UnityEngine;

// Token: 0x02000129 RID: 297
public class Tutorial : MonoBehaviour
{
	// Token: 0x17000063 RID: 99
	// (get) Token: 0x06000883 RID: 2179 RVA: 0x0002A7F0 File Offset: 0x000289F0
	// (set) Token: 0x06000884 RID: 2180 RVA: 0x0002A7F8 File Offset: 0x000289F8
	public Transform target { get; set; }

	// Token: 0x06000885 RID: 2181 RVA: 0x0002A801 File Offset: 0x00028A01
	private void Awake()
	{
		Tutorial.Instance = this;
	}

	// Token: 0x06000886 RID: 2182 RVA: 0x0002A809 File Offset: 0x00028A09
	private void Start()
	{
		if (!CurrentSettings.Instance.tutorial)
		{
			Destroy(base.gameObject);
		}
	}

	// Token: 0x06000887 RID: 2183 RVA: 0x0002A824 File Offset: 0x00028A24
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

	// Token: 0x06000888 RID: 2184 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Tree()
	{
	}

	// Token: 0x06000889 RID: 2185 RVA: 0x0002A8DC File Offset: 0x00028ADC
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

	// Token: 0x0600088A RID: 2186 RVA: 0x0002A948 File Offset: 0x00028B48
	private void Build()
	{
		if (this.stationPlaced)
		{
			this.ContinueTutorial();
			this.tutorialArrow.gameObject.SetActive(false);
		}
	}

	// Token: 0x0600088B RID: 2187 RVA: 0x0002A969 File Offset: 0x00028B69
	private void Inventory()
	{
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.ContinueTutorial();
		}
	}

	// Token: 0x0600088C RID: 2188 RVA: 0x0002A984 File Offset: 0x00028B84
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

	// Token: 0x0600088D RID: 2189 RVA: 0x0002AA54 File Offset: 0x00028C54
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

	// Token: 0x0600088E RID: 2190 RVA: 0x0002AC08 File Offset: 0x00028E08
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

	// Token: 0x0600088F RID: 2191 RVA: 0x0002AC7C File Offset: 0x00028E7C
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

	// Token: 0x17000064 RID: 100
	// (get) Token: 0x06000890 RID: 2192 RVA: 0x0002AD48 File Offset: 0x00028F48
	// (set) Token: 0x06000891 RID: 2193 RVA: 0x0002AD50 File Offset: 0x00028F50
	public Tutorial.TutorialStep currentStep { get; set; }

	// Token: 0x06000892 RID: 2194 RVA: 0x0002AD5C File Offset: 0x00028F5C
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

	// Token: 0x06000893 RID: 2195 RVA: 0x0002AE44 File Offset: 0x00029044
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

	// Token: 0x0400081C RID: 2076
	public Transform tutorialArrow;

	// Token: 0x0400081D RID: 2077
	public RectTransform canvasRect;

	// Token: 0x0400081E RID: 2078
	private bool started;

	// Token: 0x0400081F RID: 2079
	public Tutorial.TutorialStep[] steps;

	// Token: 0x04000821 RID: 2081
	public Transform taskParent;

	// Token: 0x04000822 RID: 2082
	public GameObject taskPrefab;

	// Token: 0x04000823 RID: 2083
	public static Tutorial Instance;

	// Token: 0x04000824 RID: 2084
	public bool stationPlaced;

	// Token: 0x04000826 RID: 2086
	private TutorialTaskUI currentTaskUi;

	// Token: 0x04000827 RID: 2087
	private int progress;

	// Token: 0x02000187 RID: 391
	[Serializable]
	public class TutorialStep
	{
		// Token: 0x0400099E RID: 2462
		public Tutorial.TutorialState state;

		// Token: 0x0400099F RID: 2463
		public string text;

		// Token: 0x040009A0 RID: 2464
		public InventoryItem item;

		// Token: 0x040009A1 RID: 2465
		public Transform arrowTargetPos;
	}

	// Token: 0x02000188 RID: 392
	[Serializable]
	public enum TutorialState
	{
		// Token: 0x040009A3 RID: 2467
		Unlock,
		// Token: 0x040009A4 RID: 2468
		Hotbar,
		// Token: 0x040009A5 RID: 2469
		Inventory,
		// Token: 0x040009A6 RID: 2470
		Tree,
		// Token: 0x040009A7 RID: 2471
		Workbench,
		// Token: 0x040009A8 RID: 2472
		Build
	}
}
