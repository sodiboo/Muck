using System;
using UnityEngine;

namespace MilkShake
{
    [Serializable]
    public class ShakeParameters : IShakeParameters
    {
        [Header("Shake Type")]
        [SerializeField]
        private ShakeType shakeType;

        [Header("Shake Strength")]
        [SerializeField]
        private float strength;

        [SerializeField]
        private float roughness;

        [Header("Fade")]
        [SerializeField]
        private float fadeIn;

        [SerializeField]
        private float fadeOut;

        [Header("Shake Influence")]
        [SerializeField]
        private Vector3 positionInfluence;

        [SerializeField]
        private Vector3 rotationInfluence;

        public ShakeType ShakeType
        {
            get
            {
                return shakeType;
            }
            set
            {
                shakeType = value;
            }
        }

        public float Strength
        {
            get
            {
                return strength;
            }
            set
            {
                strength = value;
            }
        }

        public float Roughness
        {
            get
            {
                return roughness;
            }
            set
            {
                roughness = value;
            }
        }

        public float FadeIn
        {
            get
            {
                return fadeIn;
            }
            set
            {
                fadeIn = value;
            }
        }

        public float FadeOut
        {
            get
            {
                return fadeOut;
            }
            set
            {
                fadeOut = value;
            }
        }

        public Vector3 PositionInfluence
        {
            get
            {
                return positionInfluence;
            }
            set
            {
                positionInfluence = value;
            }
        }

        public Vector3 RotationInfluence
        {
            get
            {
                return rotationInfluence;
            }
            set
            {
                rotationInfluence = value;
            }
        }

        public ShakeParameters()
        {
        }

        public ShakeParameters(IShakeParameters original)
        {
            shakeType = original.ShakeType;
            strength = original.Strength;
            roughness = original.Roughness;
            fadeIn = original.FadeIn;
            fadeOut = original.FadeOut;
            positionInfluence = original.PositionInfluence;
            rotationInfluence = original.RotationInfluence;
        }
    }
}
