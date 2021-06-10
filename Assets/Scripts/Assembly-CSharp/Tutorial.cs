using System;
using UnityEngine;

// Token: 0x020000F9 RID: 249
public class Tutorial : MonoBehaviour
{
	// Token: 0x17000053 RID: 83
	// (get) Token: 0x0600073F RID: 1855 RVA: 0x00023F10 File Offset: 0x00022110
	// (set) Token: 0x06000740 RID: 1856 RVA: 0x00023F18 File Offset: 0x00022118
	public Transform target { get; set; }

	// Token: 0x06000741 RID: 1857 RVA: 0x00023F21 File Offset: 0x00022121
	private void Awake()
	{
		Tutorial.Instance = this;
	}

	// Token: 0x06000742 RID: 1858 RVA: 0x00023F29 File Offset: 0x00022129
	private void Start()
	{
		if (!CurrentSettings.Instance.tutorial)
		{
			Destroy(base.gameObject);
		}
	}

	// Token: 0x06000743 RID: 1859 RVA: 0x00023F44 File Offset: 0x00022144
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

	// Token: 0x06000744 RID: 1860 RVA: 0x0000276E File Offset: 0x0000096E
	private void Tree()
	{
	}

	// Token: 0x06000745 RID: 1861 RVA: 0x00023FFC File Offset: 0x000221FC
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

	// Token: 0x06000746 RID: 1862 RVA: 0x00024068 File Offset: 0x00022268
	private void Build()
	{
		if (this.stationPlaced)
		{
			this.ContinueTutorial();
			this.tutorialArrow.gameObject.SetActive(false);
		}
	}

	// Token: 0x06000747 RID: 1863 RVA: 0x00024089 File Offset: 0x00022289
	private void Inventory()
	{
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.ContinueTutorial();
		}
	}

	// Token: 0x06000748 RID: 1864 RVA: 0x000240A4 File Offset: 0x000222A4
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

	// Token: 0x06000749 RID: 1865 RVA: 0x00024174 File Offset: 0x00022374
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

	// Token: 0x0600074A RID: 1866 RVA: 0x00024328 File Offset: 0x00022528
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

	// Token: 0x0600074B RID: 1867 RVA: 0x0002439C File Offset: 0x0002259C
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

	// Token: 0x17000054 RID: 84
	// (get) Token: 0x0600074C RID: 1868 RVA: 0x00024460 File Offset: 0x00022660
	// (set) Token: 0x0600074D RID: 1869 RVA: 0x00024468 File Offset: 0x00022668
	public Tutorial.TutorialStep currentStep { get; set; }

	// Token: 0x0600074E RID: 1870 RVA: 0x00024474 File Offset: 0x00022674
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

	// Token: 0x0600074F RID: 1871 RVA: 0x0002455C File Offset: 0x0002275C
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

	// Token: 0x040006D7 RID: 1751
	public Transform tutorialArrow;

	// Token: 0x040006D8 RID: 1752
	public RectTransform canvasRect;

	// Token: 0x040006D9 RID: 1753
	private bool started;

	// Token: 0x040006DA RID: 1754
	public Tutorial.TutorialStep[] steps;

	// Token: 0x040006DC RID: 1756
	public Transform taskParent;

	// Token: 0x040006DD RID: 1757
	public GameObject taskPrefab;

	// Token: 0x040006DE RID: 1758
	public static Tutorial Instance;

	// Token: 0x040006DF RID: 1759
	public bool stationPlaced;

	// Token: 0x040006E1 RID: 1761
	private TutorialTaskUI currentTaskUi;

	// Token: 0x040006E2 RID: 1762
	private int progress;

	// Token: 0x02000145 RID: 325
	[Serializable]
	public class TutorialStep
	{
		// Token: 0x04000815 RID: 2069
		public Tutorial.TutorialState state;

		// Token: 0x04000816 RID: 2070
		public string text;

		// Token: 0x04000817 RID: 2071
		public InventoryItem item;

		// Token: 0x04000818 RID: 2072
		public Transform arrowTargetPos;
	}

	// Token: 0x02000146 RID: 326
	[Serializable]
	public enum TutorialState
	{
		// Token: 0x0400081A RID: 2074
		Unlock,
		// Token: 0x0400081B RID: 2075
		Hotbar,
		// Token: 0x0400081C RID: 2076
		Inventory,
		// Token: 0x0400081D RID: 2077
		Tree,
		// Token: 0x0400081E RID: 2078
		Workbench,
		// Token: 0x0400081F RID: 2079
		Build
	}
}
