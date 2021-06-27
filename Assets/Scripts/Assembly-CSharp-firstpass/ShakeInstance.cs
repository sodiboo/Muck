using UnityEngine;

namespace MilkShake
{
	[System.Serializable]
	public class ShakeInstance
	{
		public ShakeState State { get; private set; }

		public bool IsPaused { get; private set; }

		public bool IsFinished
		{
			get
			{
				return this.State == ShakeState.Stopped && this.RemoveWhenStopped;
			}
		}

		public float CurrentStrength
		{
			get
			{
				return this.ShakeParameters.Strength * this.fadeTimer * this.StrengthScale;
			}
		}

		public float CurrentRoughness
		{
			get
			{
				return this.ShakeParameters.Roughness * this.fadeTimer * this.RoughnessScale;
			}
		}

		public ShakeInstance(int? seed = null)
		{
			if (seed == null)
			{
				seed = new int?(Random.Range(-10000, 10000));
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

		public ShakeInstance(IShakeParameters shakeData, int? seed = null) : this(seed)
		{
			this.ShakeParameters = new ShakeParameters(shakeData);
			this.fadeInTime = shakeData.FadeIn;
			this.fadeOutTime = shakeData.FadeOut;
			this.State = ShakeState.FadingIn;
		}

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

		public void Start(float fadeTime)
		{
			this.fadeInTime = fadeTime;
			this.State = ShakeState.FadingIn;
		}

		public void Stop(float fadeTime, bool removeWhenStopped)
		{
			this.fadeOutTime = fadeTime;
			this.RemoveWhenStopped = removeWhenStopped;
			this.State = ShakeState.FadingOut;
		}

		public void Pause(float fadeTime)
		{
			this.IsPaused = true;
			this.pauseFadeTime = fadeTime;
			if (fadeTime <= 0f)
			{
				this.pauseTimer = 1f;
			}
		}

		public void Resume(float fadeTime)
		{
			this.IsPaused = false;
			this.pauseFadeTime = fadeTime;
			if (fadeTime <= 0f)
			{
				this.pauseTimer = 0f;
			}
		}

		public void TogglePaused(float fadeTime)
		{
			if (this.IsPaused)
			{
				this.Resume(fadeTime);
				return;
			}
			this.Pause(fadeTime);
		}

		private Vector3 getPositionShake()
		{
			Vector3 zero = Vector3.zero;
			zero.x = this.getNoise(this.noiseTimer + this.seed1, (float)this.baseSeed);
			zero.y = this.getNoise((float)this.baseSeed, this.noiseTimer);
			zero.z = this.getNoise(this.seed3 + this.noiseTimer, (float)this.baseSeed + this.noiseTimer);
			return Vector3.Scale(zero * this.CurrentStrength, this.ShakeParameters.PositionInfluence);
		}

		private Vector3 getRotationShake()
		{
			Vector3 zero = Vector3.zero;
			zero.x = this.getNoise(this.noiseTimer - (float)this.baseSeed, this.seed3);
			zero.y = this.getNoise((float)this.baseSeed, this.noiseTimer + this.seed2);
			zero.z = this.getNoise((float)this.baseSeed + this.noiseTimer, this.seed1 + this.noiseTimer);
			return Vector3.Scale(zero * this.CurrentStrength, this.ShakeParameters.RotationInfluence);
		}

		private float getNoise(float x, float y)
		{
			return (Mathf.PerlinNoise(x, y) - 0.5f) * 2f;
		}

		public ShakeParameters ShakeParameters;

		public float StrengthScale;

		public float RoughnessScale;

		public bool RemoveWhenStopped;

		private int baseSeed;

		private float seed1;

		private float seed2;

		private float seed3;

		private float noiseTimer;

		private float fadeTimer;

		private float fadeInTime;

		private float fadeOutTime;

		private float pauseTimer;

		private float pauseFadeTime;

		private int lastUpdatedFrame;
	}
}
