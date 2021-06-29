using System;
using System.Collections.Generic;
using System.IO;

bool? outputAsBinary = null;
string outpath = null;
string inpath = null;
var simplify = false;
var input = false;
var output = false;
var old = false;

foreach (var flag in args)
{
    if (input)
    {
        inpath = flag;
        input = false;
        continue;
    }
    else if (output)
    {
        outpath = flag;
        output = false;
        continue;
    }
    switch (flag.ToLower())
    {
        case "-ascii":
        case "-a":
            {
                outputAsBinary = false;
                break;
            }
        case "-binary":
        case "-bin":
        case "-b":
            {
                outputAsBinary = true;
                break;
            }
        case "-simplify":
        case "-s":
            {
                simplify = true;
                break;
            }
        case "-input":
        case "-i":
            {
                input = true;
                break;
            }
        case "-output":
        case "-o":
            {
                output = true;
                break;
            }
        case "-old":
            {
                old = true;
                break;
            }
    }
}
if (!outputAsBinary.HasValue)
{
    Console.Error.WriteLine("Invalid arguments: no output encoding specified");
    return;
}
if (inpath == null)
{
    Console.Error.WriteLine("Invalid arguments: no input file specified");
    return;
}
if (outpath == null)
{
    Console.Error.WriteLine("Invalid arguments: no output file specified");
    return;
}

SaveData data;

try
{
    using var infile = File.Open(inpath, FileMode.Open);
    data = new SaveData(infile, old);
    data.FixSave();
}
catch (SaveData.VersionException)
{
    Console.Error.WriteLine("This save file is too new");
    return;
}
catch (Exception ex)
{
    Console.Error.WriteLine("The input file could not be loaded");
    Console.Error.WriteLine(ex);
    return;
}


if (simplify)
{
    var additions = new Dictionary<int, SaveData.AddItem>();
    var remove = new List<(SaveData.AddItem add, SaveData.DestroyItem destroy)>();
    foreach (var entry in data.save)
    {
        switch (entry)
        {
            case SaveData.AddItem add:
                additions[add.objectId] = add;
                break;
            case SaveData.DestroyItem destroy:
                if (additions.ContainsKey(destroy.objectId)) remove.Add((additions[destroy.objectId], destroy));
                break;
        }
    }
    foreach (var entry in remove)
    {
        data.save.Remove(entry.add);
        data.save.Remove(entry.destroy);
    }
}

using var outfile = File.Open(outpath, FileMode.OpenOrCreate);
outfile.SetLength(0);

if (outputAsBinary.Value)
{
    using var writer = new BinaryWriter(outfile);
    data.ToBinary(writer);
}
else
{
    using var writer = new StreamWriter(outfile);
    data.ToASCII(writer);
}