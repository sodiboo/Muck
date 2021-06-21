using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Numerics;

public class SaveData
{
    public int seed;
    public List<SaveEntry> save = new List<SaveEntry>();
    public void ToASCII(TextWriter writer)
    {
        writer.Write('A');
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
                    writer.Write(add.position.X.ToString(CultureInfo.CreateSpecificCulture("en-US")));
                    writer.Write(',');
                    writer.Write(add.position.Y.ToString(CultureInfo.CreateSpecificCulture("en-US")));
                    writer.Write(',');
                    writer.Write(add.position.Z.ToString(CultureInfo.CreateSpecificCulture("en-US")));
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
                    writer.Write(add.yRot);
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

    public SaveData(Stream stream)
    {
        using (var binReader = new BinaryReader(stream))
        {
            switch (binReader.ReadChar())
            {
                case 'A':
                    using (var streamReader = new StreamReader(stream))
                    {
                        ReadASCII(streamReader);
                    }
                    return;
                case 'B':
                    ReadBinary(binReader);
                    return;
            }
        }
        throw new FormatException();
    }

    private void ReadASCII(TextReader reader)
    {
        seed = int.Parse(reader.ReadLine());

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
    }

    private void ReadBinary(BinaryReader reader)
    {
        seed = reader.ReadInt32();

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