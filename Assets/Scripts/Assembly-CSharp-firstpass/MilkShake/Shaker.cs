using System.Collections.Generic;
using UnityEngine;

namespace MilkShake
{
    [AddComponentMenu("MilkShake/Shaker")]
    public class Shaker : MonoBehaviour
    {
        public static List<Shaker> GlobalShakers = new List<Shaker>();

        [SerializeField]
        private bool addToGlobalShakers;

        private List<ShakeInstance> activeShakes = new List<ShakeInstance>();

        public static ShakeInstance ShakeAll(IShakeParameters shakeData, int? seed = null)
        {
            ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
            AddShakeAll(shakeInstance);
            return shakeInstance;
        }

        public static void ShakeAllSeparate(IShakeParameters shakeData, List<ShakeInstance> shakeInstances = null, int? seed = null)
        {
            shakeInstances?.Clear();
            for (int i = 0; i < GlobalShakers.Count; i++)
            {
                if (GlobalShakers[i].gameObject.activeInHierarchy)
                {
                    ShakeInstance shakeInstance = GlobalShakers[i].Shake(shakeData, seed);
                    if (shakeInstances != null && shakeInstance != null)
                    {
                        shakeInstances.Add(shakeInstance);
                    }
                }
            }
        }

        public static void ShakeAllFromPoint(Vector3 point, float maxDistance, IShakeParameters shakeData, List<ShakeInstance> shakeInstances = null, int? seed = null)
        {
            shakeInstances?.Clear();
            for (int i = 0; i < GlobalShakers.Count; i++)
            {
                if (GlobalShakers[i].gameObject.activeInHierarchy)
                {
                    ShakeInstance shakeInstance = GlobalShakers[i].ShakeFromPoint(point, maxDistance, shakeData, seed);
                    if (shakeInstances != null && shakeInstance != null)
                    {
                        shakeInstances.Add(shakeInstance);
                    }
                }
            }
        }

        public static void AddShakeAll(ShakeInstance shakeInstance)
        {
            for (int i = 0; i < GlobalShakers.Count; i++)
            {
                if (GlobalShakers[i].gameObject.activeInHierarchy)
                {
                    GlobalShakers[i].AddShake(shakeInstance);
                }
            }
        }

        private void Awake()
        {
            if (addToGlobalShakers)
            {
                GlobalShakers.Add(this);
            }
        }

        private void OnDestroy()
        {
            if (addToGlobalShakers)
            {
                GlobalShakers.Remove(this);
            }
        }

        private void Update()
        {
            ShakeResult shakeResult = default(ShakeResult);
            for (int i = 0; i < activeShakes.Count; i++)
            {
                if (activeShakes[i].IsFinished)
                {
                    activeShakes.RemoveAt(i);
                    i--;
                }
                else
                {
                    shakeResult += activeShakes[i].UpdateShake(Time.deltaTime);
                }
            }
            base.transform.localPosition = shakeResult.PositionShake;
            base.transform.localEulerAngles = shakeResult.RotationShake;
        }

        public ShakeInstance Shake(IShakeParameters shakeData, int? seed = null)
        {
            ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
            AddShake(shakeInstance);
            return shakeInstance;
        }

        public ShakeInstance ShakeFromPoint(Vector3 point, float maxDistance, IShakeParameters shakeData, int? seed = null)
        {
            float num = Vector3.Distance(base.transform.position, point);
            if (num < maxDistance)
            {
                ShakeInstance shakeInstance = new ShakeInstance(shakeData, seed);
                shakeInstance.RoughnessScale = (shakeInstance.StrengthScale = 1f - Mathf.Clamp01(num / maxDistance));
                AddShake(shakeInstance);
                return shakeInstance;
            }
            return null;
        }

        public void AddShake(ShakeInstance shakeInstance)
        {
            activeShakes.Add(shakeInstance);
        }
    }
}
