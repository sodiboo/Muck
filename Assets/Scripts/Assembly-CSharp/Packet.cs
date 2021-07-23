using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

public class Packet : IDisposable
{
    private List<byte> buffer;

    private byte[] readableBuffer;

    private int readPos;

    private bool disposed;

    public Packet()
    {
        buffer = new List<byte>();
        readPos = 0;
    }

    public Packet(int _id)
    {
        buffer = new List<byte>();
        readPos = 0;
        Write(_id);
    }

    public Packet(byte[] _data)
    {
        buffer = new List<byte>();
        readPos = 0;
        SetBytes(_data);
    }

    public void SetBytes(byte[] _data)
    {
        Write(_data);
        readableBuffer = buffer.ToArray();
    }

    public void WriteLength()
    {
        buffer.InsertRange(0, BitConverter.GetBytes(buffer.Count));
    }

    public void InsertInt(int _value)
    {
        buffer.InsertRange(0, BitConverter.GetBytes(_value));
    }

    public byte[] ToArray()
    {
        readableBuffer = buffer.ToArray();
        return readableBuffer;
    }

    public int Length()
    {
        return buffer.Count;
    }

    public int UnreadLength()
    {
        return Length() - readPos;
    }

    public void Reset(bool _shouldReset = true)
    {
        if (_shouldReset)
        {
            buffer.Clear();
            readableBuffer = null;
            readPos = 0;
        }
        else
        {
            readPos -= 4;
        }
    }

    public void Write(byte _value)
    {
        buffer.Add(_value);
    }

    public void Write(byte[] _value)
    {
        buffer.AddRange(_value);
    }

    public void Write(short _value)
    {
        buffer.AddRange(BitConverter.GetBytes(_value));
    }

    public void Write(int _value)
    {
        buffer.AddRange(BitConverter.GetBytes(_value));
    }

    public void Write(long _value)
    {
        buffer.AddRange(BitConverter.GetBytes(_value));
    }

    public void Write(float _value)
    {
        buffer.AddRange(BitConverter.GetBytes(_value));
    }

    public void Write(bool _value)
    {
        buffer.AddRange(BitConverter.GetBytes(_value));
    }

    public void Write(string _value)
    {
        Write(_value.Length);
        buffer.AddRange(Encoding.ASCII.GetBytes(_value));
    }

    public void Write(Vector3 _value)
    {
        Write(_value.x);
        Write(_value.y);
        Write(_value.z);
    }

    public void Write(Quaternion _value)
    {
        Write(_value.x);
        Write(_value.y);
        Write(_value.z);
        Write(_value.w);
    }

    public byte ReadByte(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            byte result = readableBuffer[readPos];
            if (_moveReadPos)
            {
                readPos++;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'byte'!");
    }

    public byte[] ReadBytes(int _length, bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            byte[] result = buffer.GetRange(readPos, _length).ToArray();
            if (_moveReadPos)
            {
                readPos += _length;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'byte[]'!");
    }

    public byte[] CloneBytes()
    {
        return buffer.ToArray();
    }

    public short ReadShort(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            short result = BitConverter.ToInt16(readableBuffer, readPos);
            if (_moveReadPos)
            {
                readPos += 2;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'short'!");
    }

    public int ReadInt(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            int result = BitConverter.ToInt32(readableBuffer, readPos);
            if (_moveReadPos)
            {
                readPos += 4;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'int'!");
    }

    public long ReadLong(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            long result = BitConverter.ToInt64(readableBuffer, readPos);
            if (_moveReadPos)
            {
                readPos += 8;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'long'!");
    }

    public float ReadFloat(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            float result = BitConverter.ToSingle(readableBuffer, readPos);
            if (_moveReadPos)
            {
                readPos += 4;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'float'!");
    }

    public bool ReadBool(bool _moveReadPos = true)
    {
        if (buffer.Count > readPos)
        {
            bool result = BitConverter.ToBoolean(readableBuffer, readPos);
            if (_moveReadPos)
            {
                readPos++;
            }
            return result;
        }
        throw new Exception("Could not read value of type 'bool'!");
    }

    public string ReadString(bool _moveReadPos = true)
    {
        try
        {
            int num = ReadInt();
            string @string = Encoding.ASCII.GetString(readableBuffer, readPos, num);
            if (_moveReadPos && @string.Length > 0)
            {
                readPos += num;
            }
            return @string;
        }
        catch
        {
            throw new Exception("Could not read value of type 'string'!");
        }
    }

    public Vector3 ReadVector3(bool moveReadPos = true)
    {
        return new Vector3(ReadFloat(moveReadPos), ReadFloat(moveReadPos), ReadFloat(moveReadPos));
    }

    public Quaternion ReadQuaternion(bool moveReadPos = true)
    {
        return new Quaternion(ReadFloat(moveReadPos), ReadFloat(moveReadPos), ReadFloat(moveReadPos), ReadFloat(moveReadPos));
    }

    protected virtual void Dispose(bool _disposing)
    {
        if (!disposed)
        {
            if (_disposing)
            {
                buffer = null;
                readableBuffer = null;
                readPos = 0;
            }
            disposed = true;
        }
    }

    public void Dispose()
    {
        Dispose(_disposing: true);
        GC.SuppressFinalize(this);
    }
}
