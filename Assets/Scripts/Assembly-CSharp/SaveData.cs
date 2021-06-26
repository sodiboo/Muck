using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using UnityEngine;

public class SaveData : MonoBehaviour
{
    public static CultureInfo us = CultureInfo.CreateSpecificCulture("en-US");
    public static SaveData Instance;
    public List<SaveEntry> save;
    private void Awake()
    {
        Instance = this;
        save = new List<SaveEntry>();
    }
    public void ToASCII(TextWriter writer)
    {
        writer.Write('a');
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
        if (GameManager.gameSettings.Seed != int.Parse(reader.ReadLine())) return false;

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
        if (GameManager.gameSettings.Seed != reader.ReadInt32()) return false;

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

    public int ExecuteSave()
    {
        isExecuting = true;
        var saveToReal = new Dictionary<int, int>();
        foreach (var entry in save)
        {
            try
            {
                switch (entry)
                {
                    case AddItem add:
                        if (ResourceManager.Instance.list.ContainsKey(add.objectId))
                        {
                            saveToReal[add.objectId] = ResourceManager.Instance.GetNextId();
                            Debug.Log($"Save object {add.objectId} already exists, mapping to {saveToReal[add.objectId]}");
                            add.objectId = saveToReal[add.objectId];
                        }
                        ResourceManager.globalId = Math.Max(ResourceManager.globalId, add.objectId + 1);
                        BuildManager.Instance.BuildItem(-1, add.itemId, add.objectId, add.position, add.rotation);
                        break;
                    case DestroyItem destroy:
                        if (saveToReal.ContainsKey(destroy.objectId)) destroy.objectId = saveToReal[destroy.objectId];
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
        return saveToReal.Count;
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
}