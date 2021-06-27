using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Numerics;

public class SaveData
{
    public static CultureInfo us = CultureInfo.CreateSpecificCulture("en-US");
    public const uint CurrentVersion = 1;
    public uint readVersion;
    public int seed;
    public List<SaveEntry> save = new List<SaveEntry>();
    public void ToASCII(TextWriter writer)
    {
        writer.Write('a');
        writer.Write(CurrentVersion);
        writer.Write(',');
        writer.Write(seed);
        foreach (var entry in save)
        {
            writer.Write("\n");
            switch (entry)
            {
                case AddItem add:
                    writer.Write('+');
                    writer.Write(add.objectId);
                    writer.Write(',');
                    writer.Write(add.itemId);
                    writer.Write(',');
                    writer.Write(add.position.X.ToString(us));
                    writer.Write(',');
                    writer.Write(add.position.Y.ToString(us));
                    writer.Write(',');
                    writer.Write(add.position.Z.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.X.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.Y.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.Z.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.W.ToString(us));
                    break;
                case DestroyItem destroy:
                    writer.Write('-');
                    writer.Write(destroy.objectId);
                    break;
            }
        }
    }

    public void ToBinary(BinaryWriter writer)
    {
        writer.Write('b');
        writer.Write(CurrentVersion);
        writer.Write(seed);
        foreach (var entry in save)
        {
            switch (entry)
            {
                case AddItem add:
                    writer.Write('+');
                    writer.Write(add.objectId);
                    writer.Write(add.itemId);
                    writer.Write(add.position.X);
                    writer.Write(add.position.Y);
                    writer.Write(add.position.Z);
                    writer.Write(add.rotation.X);
                    writer.Write(add.rotation.Y);
                    writer.Write(add.rotation.Z);
                    writer.Write(add.rotation.W);
                    break;
                case DestroyItem destroy:
                    writer.Write('-');
                    writer.Write(destroy.objectId);
                    break;
            }
        }
    }

    public SaveData(int seed)
    {
        this.seed = seed;
    }

    public SaveData(Stream stream, bool old)
    {
        using (var binReader = new BinaryReader(stream))
        {
            switch (binReader.ReadChar())
            {
                case 'A':
                    using (var streamReader = new StreamReader(stream))
                    {
                        ReadOldASCII(streamReader);
                    }
                    return;
                case 'B':
                    ReadOldBinary(binReader);
                    return;
                case 'a':
                    using (var streamReader = new StreamReader(stream))
                    {
                        ReadASCII(streamReader, old);
                    }
                    return;
                case 'b':
                    ReadBinary(binReader, old);
                    return;
            }
        }
        throw new FormatException();
    }

    private void ReadASCII(TextReader reader, bool old)
    {
        if (old)
        {
            readVersion = 0;
            seed = int.Parse(reader.ReadLine());
        }
        else
        {
            var header = reader.ReadLine().Split(',');
            readVersion = uint.Parse(header[0]);
            seed = int.Parse(header[1]);
        }

        string line;
        while ((line = reader.ReadLine()) != null)
        {
            var op = line[0];
            var args = line.Substring(1).Split(',');
            switch (op)
            {
                case '+':
                    save.Add(new AddItem
                    {
                        objectId = int.Parse(args[0]),
                        itemId = int.Parse(args[1]),
                        position = new Vector3(float.Parse(args[2], us), float.Parse(args[3], us), float.Parse(args[4], us)),
                        rotation = new Quaternion(float.Parse(args[5], us), float.Parse(args[6], us), float.Parse(args[7], us), float.Parse(args[8], us)),
                    });
                    break;
                case '-':
                    save.Add(new DestroyItem
                    {
                        objectId = int.Parse(args[0]),
                    });
                    break;
                default:
                    throw new FormatException();
            }
        }
    }

    private void ReadOldASCII(TextReader reader)
    {
        seed = int.Parse(reader.ReadLine());
        readVersion = 0;
        string line;
        while ((line = reader.ReadLine()) != null)
        {
            var op = line[0];
            var args = line.Substring(1).Split(',');
            switch (op)
            {
                case '+':
                    save.Add(new AddItem
                    {
                        objectId = int.Parse(args[0]),
                        itemId = int.Parse(args[1]),
                        position = new Vector3(float.Parse(args[2], us), float.Parse(args[3], us), float.Parse(args[4], us)),
                        rotation = Quaternion.CreateFromYawPitchRoll(int.Parse(args[5]), 0, 0), // why y,x,z
                    });
                    break;
                case '-':
                    save.Add(new DestroyItem
                    {
                        objectId = int.Parse(args[0]),
                    });
                    break;
                default:
                    throw new FormatException();
            }
        }
    }

    private void ReadBinary(BinaryReader reader, bool old)
    {
        var version = old ? 0 : reader.ReadUInt32();
        if (version > CurrentVersion) throw new VersionException { value = version };
        seed = reader.ReadInt32();
        readVersion = version;

        while (reader.BaseStream.Position != reader.BaseStream.Length)
        {

            switch (reader.ReadChar())
            {
                case '+':
                    save.Add(new AddItem
                    {
                        objectId = reader.ReadInt32(),
                        itemId = reader.ReadInt32(),
                        position = new Vector3(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle()),
                        rotation = new Quaternion(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle()),
                    });
                    break;
                case '-':
                    save.Add(new DestroyItem
                    {
                        objectId = reader.ReadInt32(),
                    });
                    break;
                default:
                    throw new FormatException();
            }
        }
    }

    private void ReadOldBinary(BinaryReader reader)
    {
        seed = reader.ReadInt32();
        readVersion = 0;
        while (reader.BaseStream.Position != reader.BaseStream.Length)
        {

            switch (reader.ReadChar())
            {
                case '+':
                    save.Add(new AddItem
                    {
                        objectId = reader.ReadInt32(),
                        itemId = reader.ReadInt32(),
                        position = new Vector3(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle()),
                        rotation = Quaternion.CreateFromYawPitchRoll(reader.ReadInt32(), 0, 0), // why y,x,z
                    });
                    break;
                case '-':
                    save.Add(new DestroyItem
                    {
                        objectId = reader.ReadInt32(),
                    });
                    break;
                default:
                    throw new FormatException();
            }
        }
    }

    public static bool isExecuting { get; private set; }

    public void FixSave()
    {
        foreach (var entry in save)
        {
            switch (entry)
            {
                case AddItem add:
                    for (var i = readVersion; i < CurrentVersion; i++)
                    {
                        if (add.itemId >= upgrade[i].Length)
                        {
                            add.itemId = -1;
                        }
                        if (add.itemId >= 0) add.itemId = upgrade[i][add.itemId];
                    }
                    break;
            }
        }
    }

    public interface SaveEntry { }
    public struct DestroyItem : SaveEntry
    {
        public int objectId;
    }
    public struct AddItem : SaveEntry
    {
        public int itemId;
        public int objectId;
        public Vector3 position;
        public Quaternion rotation;
    }

    public class VersionException : Exception
    {
        public uint value;
    }


    public int[][] upgrade = new int[][] {new int[] {
0,
1,
2,
3,
4,
5,
6,
7,
8,
9,
10,
11,
12,
13,
14,
15,
16,
17,
18,
19,
20,
21,
22,
23,
24,
25,
26,
27,
28,
30,
30,
31,
33,
33,
34,
35,
36,
37,
38,
39,
40,
41,
42,
43,
44,
45,
46,
47,
48,
49,
50,
51,
52,
53,
54,
55,
56,
57,
58,
59,
60,
61,
62,
63,
64,
65,
66,
67,
69,
70,
72,
72,
74,
75,
76,
77,
78,
79,
80,
81,
83,
84,
85,
86,
87,
88,
89,
90,
91,
92,
93,
101,
102,
103,
104,
105,
106,
107,
108,
109,
110,
111,
112,
113,
114,
115,
116,
117,
118,
119,
120,
121,
123,
124,
125,
126,
127,
128,
129,
130,
131,
132,
133,
134,
135,
136,
137,
138,
139,
144,
145,
146,
147,
148,
149,
150,
151,
152,
153,
154,
    },
    };
}