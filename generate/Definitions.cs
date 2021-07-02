using System;
using System.Collections.Generic;
using System.Numerics;

[AttributeUsage(AttributeTargets.Class)]
public class GeneratorAttribute : Attribute {
    string _name;
    public GeneratorAttribute(string name) {
        _name = name;
    }
    public string name => _name;
}

[AttributeUsage(AttributeTargets.Field)]
public class ParameterAttribute : Attribute {
    string[] _names;
    public ParameterAttribute(params string[] names) {
        _names = names;
    }
    public string[] names => _names;
}

[AttributeUsage(AttributeTargets.Method)]
public class ParseAttribute : Attribute {
    Type _type;
    public ParseAttribute(Type type) {
        _type = type;
    }
    public Type type => _type;
}

public abstract class Generator {
    public Dictionary<string, Action<object>> parameters;
    public abstract IEnumerable<(Vector3 pos, Quaternion rot)> Generate();
}