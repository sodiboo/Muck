using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using UnityEngine;

public class SaveData : MonoBehaviour
{
    public static SaveData Instance;
    public List<SaveEntry> save;
    private void Awake()
    {
        Instance = this;
        save = new List<SaveEntry>();
    }
    public void ToASCII(TextWriter writer)
    {
        writer.Write('A');
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
                    writer.Write(add.position.x.ToString(CultureInfo.CreateSpecificCulture("en-US")));
                    writer.Write(',');
                    writer.Write(add.position.y.ToString(CultureInfo.CreateSpecificCulture("en-US")));
                    writer.Write(',');
                    writer.Write(add.position.z.ToString(CultureInfo.CreateSpecificCulture("en-US")));
                    writer.Write(',');
                    writer.Write(add.yRot);
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
        writer.Write('B');
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
                    writer.Write(add.yRot);
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
                    packet.Write(add.position.x);
                    packet.Write(add.position.y);
                    packet.Write(add.position.z);
                    packet.Write(add.yRot);
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
                        return ReadASCII(streamReader);
                    }
                case 'B':
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
                        position = new Vector3(packet.ReadFloat(), packet.ReadFloat(), packet.ReadFloat()),
                        yRot = packet.ReadInt(),
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
                        position = new Vector3(float.Parse(args[2], CultureInfo.CreateSpecificCulture("en-US")), float.Parse(args[3], CultureInfo.CreateSpecificCulture("en-US")), float.Parse(args[4], CultureInfo.CreateSpecificCulture("en-US"))),
                        yRot = int.Parse(args[5]),
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
                        yRot = reader.ReadInt32(),
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
                        BuildManager.Instance.BuildItem(-1, add.itemId, add.objectId, add.position, add.yRot);
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
        public int yRot;
    }
}