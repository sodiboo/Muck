using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Threading;

public static class Tube
{
    static IEnumerable<(Vector3, Quaternion)> CircleAround(Vector3 center, Vector3 forward, Vector3 down, int segments, float angle)
    {
        var angleDelta = MathF.Tau / segments;
        for (var radians = 0f; radians < MathF.Tau; radians += angleDelta)
        {
            var rotation = Quaternion.CreateFromAxisAngle(forward, radians);
            var position = center + Vector3.Transform(down, rotation);
            if (rotation.W == 0) Console.Error.WriteLine(rotation.ToString());
            yield return (position, rotation * Quaternion.CreateFromAxisAngle(Vector3.Cross(forward, Vector3.Normalize(down)), angle));
        }
    }

    [Generator("curved-tube")]
    public class Curved : Generator
    {
        [Parameter("segment-radius", "radius")]
        public float segmentRadius;

        [Parameter("segment-size", "size")]
        public int segmentSize;

        [Parameter("tube-radius")]
        public float tubeRadius;

        [Parameter("segment-count", "segments")]
        public int segmentCount;

        [Parameter("tube-length", "length")]
        public float tubeLength;

        [Parameter("tube-direction", "direction", "dir")]
        public float tubeDirection;

        public override IEnumerable<(Vector3, Quaternion)> Generate()
        {
            var center = Vector3.UnitY * segmentRadius + Vector3.UnitY * tubeRadius;
            if (segmentCount <= 0) yield break;
            var segments = SegmentPoints(center).ToList();

            foreach (var segment in CircleAround(segments[0].pos, Vector3.UnitZ, -Vector3.UnitY * segmentRadius, segmentSize, 0)) yield return Transform(segment);

            for (var i = 1; i < segments.Count; i++)
            {
                var previous = segments[i - 1];
                var current = segments[i];

                var down = Vector3.Normalize(current.pos - center) * segmentRadius;
                var forward = Vector3.Normalize(current.pos - previous.pos);
                foreach (var segment in CircleAround(current.pos, forward, down, segmentSize, -current.angle)) yield return Transform(segment);
            }
            yield break;
        }

        IEnumerable<(Vector3 pos, float angle)> SegmentPoints(Vector3 center)
        {
            var totalAngle = tubeLength * Program.Deg2Rad;
            var angleDelta = totalAngle / segmentCount;
            var angle = 0f;
            for (var i = 0; i <= segmentCount; i++)
            {
                yield return (center + new Vector3(0, -MathF.Cos(angle), MathF.Sin(angle)) * tubeRadius, angle);
                angle += angleDelta;
            }
        }

        (Vector3 pos, Quaternion rot) Transform((Vector3 pos, Quaternion rot) build) {
            var start = Vector3.UnitY * segmentRadius;
            var rotation = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, tubeDirection * Program.Deg2Rad);
            return (start + Vector3.Transform(build.pos - start, rotation), rotation * build.rot);
        }
    }

    [Generator("straight-tube")]
    public class Straight : Generator
    {
        [Parameter("segment-radius", "radius")]
        public float segmentRadius;

        [Parameter("segment-size", "size")]
        public int segmentSize;

        [Parameter("segment-count", "segments", "count")]
        public int segmentCount;

        [Parameter("segment-distance", "distance", "delta")]
        public float positionDelta;

        public override IEnumerable<(Vector3, Quaternion)> Generate()
        {
            var center = Vector3.UnitY * segmentRadius;
            for (var i = 0; i < segmentCount; i++)
            {
                foreach (var segment in CircleAround(center, Vector3.UnitZ, -Vector3.UnitY * segmentRadius, segmentSize, 0)) yield return segment;
                center += Vector3.UnitZ * positionDelta;
            }
            yield break;
        }
    }
}