using System;
using UnityEngine;

namespace MilkShake
{
    [Serializable]
    public class ShakeInstance
    {
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

        public ShakeState State { get; private set; }

        public bool IsPaused { get; private set; }

        public bool IsFinished
        {
            get
            {
                if (State == ShakeState.Stopped)
                {
                    return RemoveWhenStopped;
                }
                return false;
            }
        }

        public float CurrentStrength => ShakeParameters.Strength * fadeTimer * StrengthScale;

        public float CurrentRoughness => ShakeParameters.Roughness * fadeTimer * RoughnessScale;

        public ShakeInstance(int? seed = null)
        {
            if (!seed.HasValue)
            {
                seed = UnityEngine.Random.Range(-10000, 10000);
            }
            baseSeed = seed.Value;
            seed1 = (float)baseSeed / 2f;
            seed2 = (float)baseSeed / 3f;
            seed3 = (float)baseSeed / 4f;
            noiseTimer = baseSeed;
            fadeTimer = 0f;
            pauseTimer = 0f;
            StrengthScale = 1f;
            RoughnessScale = 1f;
        }

        public ShakeInstance(IShakeParameters shakeData, int? seed = null)
            : this(seed)
        {
            ShakeParameters = new ShakeParameters(shakeData);
            fadeInTime = shakeData.FadeIn;
            fadeOutTime = shakeData.FadeOut;
            State = ShakeState.FadingIn;
        }

        public ShakeResult UpdateShake(float deltaTime)
        {
            ShakeResult result = default(ShakeResult);
            result.PositionShake = getPositionShake();
            result.RotationShake = getRotationShake();
            if (Time.frameCount == lastUpdatedFrame)
            {
                return result;
            }
            if (pauseFadeTime > 0f)
            {
                if (IsPaused)
                {
                    pauseTimer += deltaTime / pauseFadeTime;
                }
                else
                {
                    pauseTimer -= deltaTime / pauseFadeTime;
                }
            }
            pauseTimer = Mathf.Clamp01(pauseTimer);
            noiseTimer += (1f - pauseTimer) * deltaTime * CurrentRoughness;
            if (State == ShakeState.FadingIn)
            {
                if (fadeInTime > 0f)
                {
                    fadeTimer += deltaTime / fadeInTime;
                }
                else
                {
                    fadeTimer = 1f;
                }
            }
            else if (State == ShakeState.FadingOut)
            {
                if (fadeOutTime > 0f)
                {
                    fadeTimer -= deltaTime / fadeOutTime;
                }
                else
                {
                    fadeTimer = 0f;
                }
            }
            fadeTimer = Mathf.Clamp01(fadeTimer);
            if (fadeTimer == 1f)
            {
                if (ShakeParameters.ShakeType == ShakeType.Sustained)
                {
                    State = ShakeState.Sustained;
                }
                else if (ShakeParameters.ShakeType == ShakeType.OneShot)
                {
                    Stop(ShakeParameters.FadeOut, removeWhenStopped: true);
                }
            }
            else if (fadeTimer == 0f)
            {
                State = ShakeState.Stopped;
            }
            lastUpdatedFrame = Time.frameCount;
            return result;
        }

        public void Start(float fadeTime)
        {
            fadeInTime = fadeTime;
            State = ShakeState.FadingIn;
        }

        public void Stop(float fadeTime, bool removeWhenStopped)
        {
            fadeOutTime = fadeTime;
            RemoveWhenStopped = removeWhenStopped;
            State = ShakeState.FadingOut;
        }

        public void Pause(float fadeTime)
        {
            IsPaused = true;
            pauseFadeTime = fadeTime;
            if (fadeTime <= 0f)
            {
                pauseTimer = 1f;
            }
        }

        public void Resume(float fadeTime)
        {
            IsPaused = false;
            pauseFadeTime = fadeTime;
            if (fadeTime <= 0f)
            {
                pauseTimer = 0f;
            }
        }

        public void TogglePaused(float fadeTime)
        {
            if (IsPaused)
            {
                Resume(fadeTime);
            }
            else
            {
                Pause(fadeTime);
            }
        }

        private Vector3 getPositionShake()
        {
            Vector3 zero = Vector3.zero;
            zero.x = getNoise(noiseTimer + seed1, baseSeed);
            zero.y = getNoise(baseSeed, noiseTimer);
            zero.z = getNoise(seed3 + noiseTimer, (float)baseSeed + noiseTimer);
            return Vector3.Scale(zero * CurrentStrength, ShakeParameters.PositionInfluence);
        }

        private Vector3 getRotationShake()
        {
            Vector3 zero = Vector3.zero;
            zero.x = getNoise(noiseTimer - (float)baseSeed, seed3);
            zero.y = getNoise(baseSeed, noiseTimer + seed2);
            zero.z = getNoise((float)baseSeed + noiseTimer, seed1 + noiseTimer);
            return Vector3.Scale(zero * CurrentStrength, ShakeParameters.RotationInfluence);
        }

        private float getNoise(float x, float y)
        {
            return (Mathf.PerlinNoise(x, y) - 0.5f) * 2f;
        }
    }
}
