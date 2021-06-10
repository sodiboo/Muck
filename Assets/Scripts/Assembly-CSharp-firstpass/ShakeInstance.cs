using System;
using UnityEngine;

namespace MilkShake
{
	// Token: 0x02000003 RID: 3
	[Serializable]
	public class ShakeInstance
	{
		// Token: 0x17000008 RID: 8
		// (get) Token: 0x0600000F RID: 15 RVA: 0x00002050 File Offset: 0x00000250
		// (set) Token: 0x06000010 RID: 16 RVA: 0x00002058 File Offset: 0x00000258
		public ShakeState State { get; private set; }

		// Token: 0x17000009 RID: 9
		// (get) Token: 0x06000011 RID: 17 RVA: 0x00002061 File Offset: 0x00000261
		// (set) Token: 0x06000012 RID: 18 RVA: 0x00002069 File Offset: 0x00000269
		public bool IsPaused { get; private set; }

		// Token: 0x1700000A RID: 10
		// (get) Token: 0x06000013 RID: 19 RVA: 0x00002072 File Offset: 0x00000272
		public bool IsFinished
		{
			get
			{
				return this.State == ShakeState.Stopped && this.RemoveWhenStopped;
			}
		}

		// Token: 0x1700000B RID: 11
		// (get) Token: 0x06000014 RID: 20 RVA: 0x00002085 File Offset: 0x00000285
		public float CurrentStrength
		{
			get
			{
				return this.ShakeParameters.Strength * this.fadeTimer * this.StrengthScale;
			}
		}

		// Token: 0x1700000C RID: 12
		// (get) Token: 0x06000015 RID: 21 RVA: 0x000020A0 File Offset: 0x000002A0
		public float CurrentRoughness
		{
			get
			{
				return this.ShakeParameters.Roughness * this.fadeTimer * this.RoughnessScale;
			}
		}

		// Token: 0x06000016 RID: 22 RVA: 0x000020BC File Offset: 0x000002BC
		public ShakeInstance(int? seed = null)
		{
			if (seed == null)
			{
				seed = new int?(UnityEngine.Random.Range(-10000, 10000));
			}
			this.baseSeed = seed.Value;
			this.seed1 = (float)this.baseSeed / 2f;
			this.seed2 = (float)this.baseSeed / 3f;
			this.seed3 = (float)this.baseSeed / 4f;
			this.noiseTimer = (float)this.baseSeed;
			this.fadeTimer = 0f;
			this.pauseTimer = 0f;
			this.StrengthScale = 1f;
			this.RoughnessScale = 1f;
		}

		// Token: 0x06000017 RID: 23 RVA: 0x0000216D File Offset: 0x0000036D
		public ShakeInstance(IShakeParameters shakeData, int? seed = null) : this(seed)
		{
			this.ShakeParameters = new ShakeParameters(shakeData);
			this.fadeInTime = shakeData.FadeIn;
			this.fadeOutTime = shakeData.FadeOut;
			this.State = ShakeState.FadingIn;
		}

		// Token: 0x06000018 RID: 24 RVA: 0x000021A4 File Offset: 0x000003A4
		public ShakeResult UpdateShake(float deltaTime)
		{
			ShakeResult result = default(ShakeResult);
			result.PositionShake = this.getPositionShake();
			result.RotationShake = this.getRotationShake();
			if (Time.frameCount == this.lastUpdatedFrame)
			{
				return result;
			}
			if (this.pauseFadeTime > 0f)
			{
				if (this.IsPaused)
				{
					this.pauseTimer += deltaTime / this.pauseFadeTime;
				}
				else
				{
					this.pauseTimer -= deltaTime / this.pauseFadeTime;
				}
			}
			this.pauseTimer = Mathf.Clamp01(this.pauseTimer);
			this.noiseTimer += (1f - this.pauseTimer) * deltaTime * this.CurrentRoughness;
			if (this.State == ShakeState.FadingIn)
			{
				if (this.fadeInTime > 0f)
				{
					this.fadeTimer += deltaTime / this.fadeInTime;
				}
				else
				{
					this.fadeTimer = 1f;
				}
			}
			else if (this.State == ShakeState.FadingOut)
			{
				if (this.fadeOutTime > 0f)
				{
					this.fadeTimer -= deltaTime / this.fadeOutTime;
				}
				else
				{
					this.fadeTimer = 0f;
				}
			}
			this.fadeTimer = Mathf.Clamp01(this.fadeTimer);
			if (this.fadeTimer == 1f)
			{
				if (this.ShakeParameters.ShakeType == ShakeType.Sustained)
				{
					this.State = ShakeState.Sustained;
				}
				else if (this.ShakeParameters.ShakeType == ShakeType.OneShot)
				{
					this.Stop(this.ShakeParameters.FadeOut, true);
				}
			}
			else if (this.fadeTimer == 0f)
			{
				this.State = ShakeState.Stopped;
			}
			this.lastUpdatedFrame = Time.frameCount;
			return result;
		}

		// Token: 0x06000019 RID: 25 RVA: 0x0000233D File Offset: 0x0000053D
		public void Start(float fadeTime)
		{
			this.fadeInTime = fadeTime;
			this.State = ShakeState.FadingIn;
		}

		// Token: 0x0600001A RID: 26 RVA: 0x0000234D File Offset: 0x0000054D
		public void Stop(float fadeTime, bool removeWhenStopped)
		{
			this.fadeOutTime = fadeTime;
			this.RemoveWhenStopped = removeWhenStopped;
			this.State = ShakeState.FadingOut;
		}

		// Token: 0x0600001B RID: 27 RVA: 0x00002364 File Offset: 0x00000564
		public void Pause(float fadeTime)
		{
			this.IsPaused = true;
			this.pauseFadeTime = fadeTime;
			if (fadeTime <= 0f)
			{
				this.pauseTimer = 1f;
			}
		}

		// Token: 0x0600001C RID: 28 RVA: 0x00002387 File Offset: 0x00000587
		public void Resume(float fadeTime)
		{
			this.IsPaused = false;
			this.pauseFadeTime = fadeTime;
			if (fadeTime <= 0f)
			{
				this.pauseTimer = 0f;
			}
		}

		// Token: 0x0600001D RID: 29 RVA: 0x000023AA File Offset: 0x000005AA
		public void TogglePaused(float fadeTime)
		{
			if (this.IsPaused)
			{
				this.Resume(fadeTime);
				return;
			}
			this.Pause(fadeTime);
		}

		// Token: 0x0600001E RID: 30 RVA: 0x000023C4 File Offset: 0x000005C4
		private Vector3 getPositionShake()
		{
			Vector3 zero = Vector3.zero;
			zero.x = this.getNoise(this.noiseTimer + this.seed1, (float)this.baseSeed);
			zero.y = this.getNoise((float)this.baseSeed, this.noiseTimer);
			zero.z = this.getNoise(this.seed3 + this.noiseTimer, (float)this.baseSeed + this.noiseTimer);
			return Vector3.Scale(zero * this.CurrentStrength, this.ShakeParameters.PositionInfluence);
		}

		// Token: 0x0600001F RID: 31 RVA: 0x00002458 File Offset: 0x00000658
		private Vector3 getRotationShake()
		{
			Vector3 zero = Vector3.zero;
			zero.x = this.getNoise(this.noiseTimer - (float)this.baseSeed, this.seed3);
			zero.y = this.getNoise((float)this.baseSeed, this.noiseTimer + this.seed2);
			zero.z = this.getNoise((float)this.baseSeed + this.noiseTimer, this.seed1 + this.noiseTimer);
			return Vector3.Scale(zero * this.CurrentStrength, this.ShakeParameters.RotationInfluence);
		}

		// Token: 0x06000020 RID: 32 RVA: 0x000024F1 File Offset: 0x000006F1
		private float getNoise(float x, float y)
		{
			return (Mathf.PerlinNoise(x, y) - 0.5f) * 2f;
		}

		// Token: 0x04000001 RID: 1
		public ShakeParameters ShakeParameters;

		// Token: 0x04000002 RID: 2
		public float StrengthScale;

		// Token: 0x04000003 RID: 3
		public float RoughnessScale;

		// Token: 0x04000004 RID: 4
		public bool RemoveWhenStopped;

		// Token: 0x04000007 RID: 7
		private int baseSeed;

		// Token: 0x04000008 RID: 8
		private float seed1;

		// Token: 0x04000009 RID: 9
		private float seed2;

		// Token: 0x0400000A RID: 10
		private float seed3;

		// Token: 0x0400000B RID: 11
		private float noiseTimer;

		// Token: 0x0400000C RID: 12
		private float fadeTimer;

		// Token: 0x0400000D RID: 13
		private float fadeInTime;

		// Token: 0x0400000E RID: 14
		private float fadeOutTime;

		// Token: 0x0400000F RID: 15
		private float pauseTimer;

		// Token: 0x04000010 RID: 16
		private float pauseFadeTime;

		// Token: 0x04000011 RID: 17
		private int lastUpdatedFrame;
	}
}
