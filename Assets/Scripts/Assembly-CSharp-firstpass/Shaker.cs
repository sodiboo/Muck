
using System.Collections.Generic;
using UnityEngine;

namespace MilkShake
{
	// Token: 0x02000009 RID: 9
	[AddComponentMenu("MilkShake/Shaker")]
	public class Shaker : MonoBehaviour
	{
		// Token: 0x06000041 RID: 65 RVA: 0x000026B6 File Offset: 0x000008B6
		public static ShakeInstance ShakeAll(IShakeParameters shakeData, int? seed = null)
		{
			ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
			Shaker.AddShakeAll(shakeInstance);
			return shakeInstance;
		}

		// Token: 0x06000042 RID: 66 RVA: 0x000026C8 File Offset: 0x000008C8
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

		// Token: 0x06000043 RID: 67 RVA: 0x0000272C File Offset: 0x0000092C
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

		// Token: 0x06000044 RID: 68 RVA: 0x00002794 File Offset: 0x00000994
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

		// Token: 0x06000045 RID: 69 RVA: 0x000027DE File Offset: 0x000009DE
		private void Awake()
		{
			if (this.addToGlobalShakers)
			{
				Shaker.GlobalShakers.Add(this);
			}
		}

		// Token: 0x06000046 RID: 70 RVA: 0x000027F3 File Offset: 0x000009F3
		private void OnDestroy()
		{
			if (this.addToGlobalShakers)
			{
				Shaker.GlobalShakers.Remove(this);
			}
		}

		// Token: 0x06000047 RID: 71 RVA: 0x0000280C File Offset: 0x00000A0C
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

		// Token: 0x06000048 RID: 72 RVA: 0x0000289C File Offset: 0x00000A9C
		public ShakeInstance Shake(IShakeParameters shakeData, int? seed = null)
		{
			ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
			this.AddShake(shakeInstance);
			return shakeInstance;
		}

		// Token: 0x06000049 RID: 73 RVA: 0x000028BC File Offset: 0x00000ABC
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

		// Token: 0x0600004A RID: 74 RVA: 0x0000290F File Offset: 0x00000B0F
		public void AddShake(ShakeInstance shakeInstance)
		{
			this.activeShakes.Add(shakeInstance);
		}

		// Token: 0x0400002A RID: 42
		public static List<Shaker> GlobalShakers = new List<Shaker>();

		// Token: 0x0400002B RID: 43
		[SerializeField]
		private bool addToGlobalShakers;

		// Token: 0x0400002C RID: 44
		private List<ShakeInstance> activeShakes = new List<ShakeInstance>();
	}
}
