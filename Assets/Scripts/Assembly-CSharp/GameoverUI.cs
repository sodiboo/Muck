using UnityEngine;
using TMPro;
using System.Collections.Generic;

public class GameoverUI : MonoBehaviour
{
	public TextMeshProUGUI header;
	public TextMeshProUGUI nameText;
	public GameObject statPrefab;
	public List<StatPrefab> statPrefabs;
	public Transform statsParent;
}
