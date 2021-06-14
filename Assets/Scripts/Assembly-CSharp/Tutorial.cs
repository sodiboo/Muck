using UnityEngine;
using System;

public class Tutorial : MonoBehaviour
{
	[Serializable]
	public class TutorialStep
	{
		public Tutorial.TutorialState state;
		public string text;
		public InventoryItem item;
		public Transform arrowTargetPos;
	}

	public enum TutorialState
	{
		Unlock = 0,
		Hotbar = 1,
		Inventory = 2,
		Tree = 3,
		Workbench = 4,
		Build = 5,
	}

	public Transform tutorialArrow;
	public RectTransform canvasRect;
	public TutorialStep[] steps;
	public Transform taskParent;
	public GameObject taskPrefab;
	public bool stationPlaced;
}
