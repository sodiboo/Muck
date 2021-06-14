using UnityEngine;
using System;
using System.Collections.Generic;

public class Outline : MonoBehaviour
{
	[Serializable]
	private class ListVector3
	{
		public List<Vector3> data;
	}

	public enum Mode
	{
		OutlineAll = 0,
		OutlineVisible = 1,
		OutlineHidden = 2,
		OutlineAndSilhouette = 3,
		SilhouetteOnly = 4,
	}

	[SerializeField]
	private Mode outlineMode;
	[SerializeField]
	private Color outlineColor;
	[SerializeField]
	private float outlineWidth;
	[SerializeField]
	private bool precomputeOutline;
	[SerializeField]
	private List<Mesh> bakeKeys;
	[SerializeField]
	private List<Outline.ListVector3> bakeValues;
}
