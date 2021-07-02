using System;
using System.Collections.Generic;
using System.Numerics;

[Generator("smooth")]
public class Smooth : Generator {
    [Parameter]
    public float radius;

    [Parameter]
    public float angle;

    [Parameter]
    public int count;

    public override IEnumerable<(Vector3 pos, Quaternion rot)> Generate()
    {
        var posDelta = Vector3.UnitZ * Program.Deg2Rad * angle / count * radius;
        var rotDelta = Quaternion.CreateFromYawPitchRoll(0, Program.Deg2Rad * -angle / count, 0);
        var pos = Vector3.Zero;
        var rot = Quaternion.Identity;
        for (var i = 0; i < count; i++)
        {
            yield return (pos, rot);
            rot = rotDelta * rot;
            pos += Vector3.Transform(posDelta, rot);
        }
    }
}