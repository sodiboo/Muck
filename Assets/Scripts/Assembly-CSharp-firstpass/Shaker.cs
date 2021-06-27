using System;
using System.Collections.Generic;
using UnityEngine;

namespace MilkShake
{
	[AddComponentMenu("MilkShake/Shaker")]
	public class Shaker : MonoBehaviour
	{
		public static ShakeInstance ShakeAll(IShakeParameters shakeData, int? seed = null)
		{
			ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
			Shaker.AddShakeAll(shakeInstance);
			return shakeInstance;
		}

		public static void ShakeAllSeparate(IShakeParameters shakeData, List<ShakeInstance> shakeInstances = null, int? seed = null)
		{
			if (shakeInstances != null)
			{
				shakeInstances.Clear();
			}
			for (int i = 0; i < Shaker.GlobalShakers.Count; i++)
			{
				if (Shaker.GlobalShakers[i].gameObject.activeInHierarchy)
				{
					ShakeInstance shakeInstance = Shaker.GlobalShakers[i].Shake(shakeData, seed);
					if (shakeInstances != null && shakeInstance != null)
					{
						shakeInstances.Add(shakeInstance);
					}
				}
			}
		}

		public static void ShakeAllFromPoint(Vector3 point, float maxDistance, IShakeParameters shakeData, List<ShakeInstance> shakeInstances = null, int? seed = null)
		{
			if (shakeInstances != null)
			{
				shakeInstances.Clear();
			}
			for (int i = 0; i < Shaker.GlobalShakers.Count; i++)
			{
				if (Shaker.GlobalShakers[i].gameObject.activeInHierarchy)
				{
					ShakeInstance shakeInstance = Shaker.GlobalShakers[i].ShakeFromPoint(point, maxDistance, shakeData, seed);
					if (shakeInstances != null && shakeInstance != null)
					{
						shakeInstances.Add(shakeInstance);
					}
				}
			}
		}

		public static void AddShakeAll(ShakeInstance shakeInstance)
		{
			for (int i = 0; i < Shaker.GlobalShakers.Count; i++)
			{
				if (Shaker.GlobalShakers[i].gameObject.activeInHierarchy)
				{
					Shaker.GlobalShakers[i].AddShake(shakeInstance);
				}
			}
		}

		private void Awake()
		{
			if (this.addToGlobalShakers)
			{
				Shaker.GlobalShakers.Add(this);
			}
		}

		private void OnDestroy()
		{
			if (this.addToGlobalShakers)
			{
				Shaker.GlobalShakers.Remove(this);
			}
		}

		private void Update()
		{
			ShakeResult shakeResult = default(ShakeResult);
			for (int i = 0; i < this.activeShakes.Count; i++)
			{
				if (this.activeShakes[i].IsFinished)
				{
					this.activeShakes.RemoveAt(i);
					i--;
				}
				else
				{
					shakeResult += this.activeShakes[i].UpdateShake(Time.deltaTime);
				}
			}
			base.transform.localPosition = shakeResult.PositionShake;
			base.transform.localEulerAngles = shakeResult.RotationShake;
		}

		public ShakeInstance Shake(IShakeParameters shakeData, int? seed = null)
		{
			ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
			this.AddShake(shakeInstance);
			return shakeInstance;
		}

		public ShakeInstance ShakeFromPoint(Vector3 point, float maxDistance, IShakeParameters shakeData, int? seed = null)
		{
			float num = Vector3.Distance(base.transform.position, point);
			if (num < maxDistance)
			{
				ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
				float num2 = 1f - Mathf.Clamp01(num / maxDistance);
				shakeInstance.StrengthScale = num2;
				shakeInstance.RoughnessScale = num2;
				this.AddShake(shakeInstance);
				return shakeInstance;
			}
			return null;
		}

		public void AddShake(ShakeInstance shakeInstance)
		{
			this.activeShakes.Add(shakeInstance);
		}

		public static List<Shaker> GlobalShakers = new List<Shaker>();

		[SerializeField]
		private bool addToGlobalShakers;

		private List<ShakeInstance> activeShakes = new List<ShakeInstance>();
	}
}
