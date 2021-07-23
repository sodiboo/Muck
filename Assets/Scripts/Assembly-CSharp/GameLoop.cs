using UnityEngine;
using System;

public class GameLoop : MonoBehaviour
{
	[Serializable]
	public class MobSpawn
	{
		public MobType mob;
		public int dayStart;
		public int dayPeak;
		public float maxWeight;
		public float currentWeight;
	}

	public int currentDay;
	public MobSpawn[] mobs;
	public LayerMask whatIsSpawnable;
	public MobType[] bosses;
}
