using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Numerics;
using System.Reflection;

class Program
{
    public const float Deg2Rad = (MathF.PI / 180);
    public static CultureInfo us = CultureInfo.CreateSpecificCulture("en-US");
    string[] args;
    int arg = 0;
    string NextArgument() => args[arg++];

    Dictionary<Type, Func<FieldInfo, Action<object>>> parseMethods = new Dictionary<Type, Func<FieldInfo, Action<object>>>();

    static void Main(string[] args)
    {
        var program = new Program();
        program.args = args;
        program.Main();
    }
    void Main()
    {
        var methods = typeof(Program).GetMethods();
        foreach (var method in methods)
        {
            var parse = method.GetCustomAttribute<ParseAttribute>();
            if (parse != null) parseMethods[parse.type] = Parse(method);
        }

        var types = Assembly.GetExecutingAssembly().GetTypes();
        var generators = new Dictionary<string, Generator>();
        foreach (var type in types)
        {
            var attr = type.GetCustomAttribute<GeneratorAttribute>();
            if (attr == null) continue;
            var instance = (Generator)Activator.CreateInstance(type);
            instance.parameters = new Dictionary<string, Action<object>>();
            foreach (var field in type.GetFields())
            {
                var parameter = field.GetCustomAttribute<ParameterAttribute>();
                if (parameter == null) continue;
                var parse = parseMethods[field.FieldType](field);
                var names = parameter.names;
                if (names.Length == 0) names = new[] { field.Name };
                foreach (var name in names)
                {
                    instance.parameters[name] = parse;
                }
            }
            generators[attr.name] = instance;
        }
        var builds = new List<(Vector3 pos, Quaternion rot)>() { (Vector3.Zero, Quaternion.Identity) };
        try
        {
        next:
            var generator = generators[NextArgument()];
            while (arg < args.Length)
            {
                var arg = NextArgument();
                if (arg == "then")
                {
                    var origin = builds.Last();
                    builds = builds.Concat(Transform(origin.pos, origin.rot, generator.Generate())).ToList();
                    goto next;
                }
                if (!arg.StartsWith('-')) throw new FormatException($"Expected argument name, got {arg}");
                if (!generator.parameters.TryGetValue(arg.Substring(1), out var param)) throw new FormatException($"Unknown argument {arg}");
                param(generator);
            }
            {
                var origin = builds.Last();
                builds = builds.Concat(Transform(origin.pos, origin.rot, generator.Generate())).ToList();
            }
            Console.Write("bulk ");
            Console.Write(string.Join(';', builds.Skip(1).Select(pair => $"buildrel {string.Join(' ', new[] { pair.pos.X, pair.pos.Y, pair.pos.Z, pair.rot.X, pair.rot.Y, pair.rot.Z, pair.rot.W }.Select(v => v.ToString(us)))}")));
        }
        catch (FormatException ex)
        {
            Console.Error.WriteLine(ex.Message);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine(ex);
        }
    }

    Func<FieldInfo, Action<object>> Parse(MethodInfo method) => (FieldInfo field) => (Action<object>)method.Invoke(this, new[] { field });

    [Parse(typeof(Vector3))]
    public Action<object> ParseVector3(FieldInfo field) => (object generator) =>
    {
        var x = float.Parse(NextArgument(), us);
        var y = float.Parse(NextArgument(), us);
        var z = float.Parse(NextArgument(), us);
        field.SetValue(generator, new Vector3(x, y, z));
    };

    [Parse(typeof(Quaternion))]
    public Action<object> ParseQuaternion(FieldInfo field) => (object generator) =>
    {
        var x = Deg2Rad * float.Parse(NextArgument(), us);
        var y = Deg2Rad * float.Parse(NextArgument(), us);
        var z = Deg2Rad * float.Parse(NextArgument(), us);
        field.SetValue(generator, Quaternion.CreateFromYawPitchRoll(y, x, z));
    };

    [Parse(typeof(int))]
    public Action<object> ParseInt(FieldInfo field) => (object generator) =>
    {
        field.SetValue(generator, int.Parse(NextArgument()));
    };

    [Parse(typeof(float))]
    public Action<object> ParseFloat(FieldInfo field) => (object generator) =>
    {
        field.SetValue(generator, float.Parse(NextArgument(), us));
    };

    static IEnumerable<(Vector3 pos, Quaternion rot)> Transform(Vector3 origin, Quaternion rot, IEnumerable<(Vector3 pos, Quaternion rot)> builds)
    {
        foreach (var build in builds)
        {
            var pos = origin + Vector3.Transform(build.pos, rot);
            yield return (pos, rot * build.rot);
        }
    }
}