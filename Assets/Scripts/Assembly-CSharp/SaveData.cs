using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;

public class SaveData : MonoBehaviour
{
    public static CultureInfo us = CultureInfo.CreateSpecificCulture("en-US");
    public static SaveData Instance;
    public const uint CurrentVersion = 1;
    public uint readVersion;
    public List<SaveEntry> save;
    private void Awake()
    {
        Instance = this;
        save = new List<SaveEntry>();
    }
    public void ToASCII(TextWriter writer)
    {
        writer.Write('a');
        writer.Write(CurrentVersion);
        writer.Write(',');
        writer.Write(GameManager.gameSettings.Seed);
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
                    writer.Write(add.position.x.ToString(us));
                    writer.Write(',');
                    writer.Write(add.position.y.ToString(us));
                    writer.Write(',');
                    writer.Write(add.position.z.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.x.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.y.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.z.ToString(us));
                    writer.Write(',');
                    writer.Write(add.rotation.w.ToString(us));
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
        writer.Write(GameManager.gameSettings.Seed);
        foreach (var entry in save)
        {
            switch (entry)
            {
                case AddItem add:
                    writer.Write('+');
                    writer.Write(add.objectId);
                    writer.Write(add.itemId);
                    writer.Write(add.position.x);
                    writer.Write(add.position.y);
                    writer.Write(add.position.z);
                    writer.Write(add.rotation.x);
                    writer.Write(add.rotation.y);
                    writer.Write(add.rotation.z);
                    writer.Write(add.rotation.w);
                    break;
                case DestroyItem destroy:
                    writer.Write('-');
                    writer.Write(destroy.objectId);
                    break;
            }
        }
    }

    public void ToPacket(Packet packet)
    {
        foreach (var entry in save)
        {
            switch (entry)
            {
                case AddItem add:
                    packet.Write('+');
                    packet.Write(add.objectId);
                    packet.Write(add.itemId);
                    packet.Write(add.position);
                    packet.Write(add.rotation);
                    break;
                case DestroyItem destroy:
                    packet.Write('-');
                    packet.Write(destroy.objectId);
                    break;
            }
        }
    }

    public bool Read(Stream stream)
    {
        using (var binReader = new BinaryReader(stream))
        {

            switch (binReader.ReadChar())
            {
                case 'A':
                    using (var streamReader = new StreamReader(stream))
                    {
                        return ReadOldASCII(streamReader);
                    }
                case 'B':
                    return ReadOldBinary(binReader);
                case 'a':
                    using (var streamReader = new StreamReader(stream))
                    {
                        return ReadASCII(streamReader);
                    }
                case 'b':
                    return ReadBinary(binReader);
            }
        }
        throw new FormatException();
    }

    public void ReadPacket(Packet packet)
    {
        while (packet.UnreadLength() != 0)
        {

            switch (packet.ReadInt())
            {
                case '+':
                    save.Add(new AddItem
                    {
                        objectId = packet.ReadInt(),
                        itemId = packet.ReadInt(),
                        position = packet.ReadVector3(),
                        rotation = packet.ReadQuaternion(),
                    });
                    break;
                case '-':
                    save.Add(new DestroyItem
                    {
                        objectId = packet.ReadInt(),
                    });
                    break;
            }
        }
    }

    private bool ReadASCII(TextReader reader)
    {
        var header = reader.ReadLine().Split(',').ToArray();
        readVersion = uint.Parse(header[0]);
        if (GameManager.gameSettings.Seed != int.Parse(header[1])) return false;

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

        return true;
    }

    private bool ReadOldASCII(TextReader reader)
    {
        if (GameManager.gameSettings.Seed != int.Parse(reader.ReadLine())) return false;
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
                        rotation = Quaternion.Euler(0, int.Parse(args[5]), 0),
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

        return true;
    }

    private bool ReadBinary(BinaryReader reader)
    {
        var version = reader.ReadUInt32();
        if (version > CurrentVersion) throw new VersionException { value = version };
        if (GameManager.gameSettings.Seed != reader.ReadInt32()) return false;
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

        return true;
    }

    private bool ReadOldBinary(BinaryReader reader)
    {
        if (GameManager.gameSettings.Seed != reader.ReadInt32()) return false;
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
                        rotation = Quaternion.Euler(0, reader.ReadInt32(), 0),
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

        return true;
    }

    public static bool isExecuting { get; private set; }

    public (int mappedObjects, int mappedItems, int ignoredDestructions, int ignoredBuilds) FixSave()
    {
        var saveToReal = new Dictionary<int, int>();
        var mappedItems = 0;
        var ignoredDestructions = 0;
        var ignoredBuilds = 0;
        var remove = new List<SaveEntry>();
        foreach (var entry in save)
        {
            try
            {
                switch (entry)
                {
                    case AddItem add:
                        for (var i = readVersion; i < CurrentVersion; i++) {
                            if (add.itemId >= upgrade[i].Length) {
                                add.itemId = -1;
                                break;
                            }
                            if (add.itemId < 0) break;
                            add.itemId = upgrade[i][add.itemId];
                        }
                        if (!ItemManager.Instance.allItems.ContainsKey(add.itemId) || !ItemManager.Instance.allItems[add.itemId].buildable)
                        {
                            remove.Add(entry);
                            ignoredBuilds++;
                            break;
                        }
                        if (ResourceManager.Instance.list.ContainsKey(add.objectId))
                        {
                            saveToReal[add.objectId] = ResourceManager.Instance.GetNextId();
                            add.objectId = saveToReal[add.objectId];
                        }
                        else
                        {
                            saveToReal[add.objectId] = add.objectId;
                        }
                        break;
                    case DestroyItem destroy:
                        if (saveToReal.ContainsKey(destroy.objectId)) destroy.objectId = saveToReal[destroy.objectId];
                        else if (readVersion < CurrentVersion)
                        {
                            remove.Add(entry);
                            break;
                        }
                        if (!ResourceManager.Instance.list.ContainsKey(destroy.objectId))
                        {
                            remove.Add(entry);
                            ignoredDestructions++;
                        }
                        break;
                }
            }
            catch (Exception ex)
            {
                Debug.LogError(ex);
            }
        }
        foreach (var entry in remove) save.Remove(entry);
        return (saveToReal.Where(pair => pair.Key != pair.Value).Count(), mappedItems, ignoredDestructions, ignoredBuilds);
    }

    public void ExecuteSave()
    {
        isExecuting = true;
        foreach (var entry in save)
        {
            try
            {
                switch (entry)
                {
                    case AddItem add:
                        ResourceManager.globalId = Math.Max(ResourceManager.globalId, add.objectId + 1);
                        BuildManager.Instance.BuildItem(-1, add.itemId, add.objectId, add.position, add.rotation);
                        break;
                    case DestroyItem destroy:
                        ResourceManager.Instance.list[destroy.objectId].GetComponent<Hitable>().KillObject(Vector3.zero);
                        break;
                }
            }
            catch (Exception ex)
            {
                Debug.LogError(ex);
            }
        }
        isExecuting = false;
    }

    private Coroutine autosave;

    public void AutoSave(float minutes, string path)
    {
        if (autosave != null) StopCoroutine(autosave);
        autosave = StartCoroutine(AutoSaveRoutine(minutes * 60f, path));
    }

    private IEnumerator AutoSaveRoutine(float seconds, string path)
    {
        while (true)
        {
            try
            {
                using (var file = File.Open($"{path}-{DateTime.Now:yyyy-MM-dd-HH-mm-ss}", FileMode.OpenOrCreate))
                {
                    file.SetLength(0);
                    using (var writer = new BinaryWriter(file))
                    {
                        SaveData.Instance.ToBinary(writer);
                    }
                }
                ChatBox.Instance.AppendMessage(-1, $"<color=green>Game has been autosaved<color=white>", "");
            }
            catch
            {
                ChatBox.Instance.AppendMessage(-1, $"<color=red>There was an error autosaving the game<color=white>", "");
            }
            yield return new WaitForSecondsRealtime(seconds);
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