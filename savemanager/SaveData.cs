using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Numerics;

public class SaveData
{
    public static CultureInfo us = CultureInfo.CreateSpecificCulture("en-US");
    public uint version;
    public int seed;
    public List<SaveEntry> save = new List<SaveEntry>();
    public void ToASCII(TextWriter writer)
    {
        writer.Write('a');
        writer.Write(version);
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
        writer.Write(version);
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
            version = 0;
            seed = int.Parse(reader.ReadLine());
        }
        else
        {
            var header = reader.ReadLine().Split(',');
            version = uint.Parse(header[0]);
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
        version = 0;
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
        version = old ? 0 : reader.ReadUInt32();
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
        version = 0;
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

    public interface SaveEntry { }
    public class DestroyItem : SaveEntry
    {
        public int objectId;
    }
    public class AddItem : SaveEntry
    {
        public int itemId;
        public int objectId;
        public Vector3 position;
        public Quaternion rotation;
    }
}