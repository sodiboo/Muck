using System.Collections.Generic;
using System.Numerics;

[Generator("repeat-offset")]
public class RepeatOffset : Generator
{
    [Parameter("position", "pos")]
    public Vector3 posDelta;

    [Parameter("rotation", "rot")]
    public Quaternion rotDelta;

    [Parameter("count")]
    public int count;

    public override IEnumerable<(Vector3 pos, Quaternion rot)> Generate()
    {
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