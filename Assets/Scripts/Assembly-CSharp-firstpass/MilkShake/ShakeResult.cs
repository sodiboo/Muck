using UnityEngine;

namespace MilkShake
{
    public struct ShakeResult
    {
        public Vector3 PositionShake;

        public Vector3 RotationShake;

        public static ShakeResult operator +(ShakeResult a, ShakeResult b)
        {
            ShakeResult result = default(ShakeResult);
            result.PositionShake = a.PositionShake + b.PositionShake;
            result.RotationShake = a.RotationShake + b.RotationShake;
            return result;
        }
    }
}
