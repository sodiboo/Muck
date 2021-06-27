using System;
using UnityEngine;

public class TestScroll : MonoBehaviour
{
	private void Awake()
	{
		TestScroll.Instance = this;
		Invoke(nameof(GetReady), 4f);
	}

	private void GetReady()
	{
		this.ready = true;
	}

	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		if (this.terrain.heightMultiplier > 300f)
		{
			return;
		}
		this.terrain.heightMultiplier += 20f * Time.deltaTime;
	}

	public NoiseData noise;

	public TerrainData terrain;

	public bool ready;

	public static TestScroll Instance;
}
