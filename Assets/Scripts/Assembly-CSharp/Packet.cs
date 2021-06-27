using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

// Token: 0x020000D0 RID: 208
public class Packet : IDisposable
{
	// Token: 0x06000651 RID: 1617 RVA: 0x00020EF1 File Offset: 0x0001F0F1
	public Packet()
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
	}

	// Token: 0x06000652 RID: 1618 RVA: 0x00020F0B File Offset: 0x0001F10B
	public Packet(int _id)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.Write(_id);
	}

	// Token: 0x06000653 RID: 1619 RVA: 0x00020F2C File Offset: 0x0001F12C
	public Packet(byte[] _data)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.SetBytes(_data);
	}

	// Token: 0x06000654 RID: 1620 RVA: 0x00020F4D File Offset: 0x0001F14D
	public void SetBytes(byte[] _data)
	{
		this.Write(_data);
		this.readableBuffer = this.buffer.ToArray();
	}

	// Token: 0x06000655 RID: 1621 RVA: 0x00020F67 File Offset: 0x0001F167
	public void WriteLength()
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(this.buffer.Count));
	}

	// Token: 0x06000656 RID: 1622 RVA: 0x00020F85 File Offset: 0x0001F185
	public void InsertInt(int _value)
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(_value));
	}

	// Token: 0x06000657 RID: 1623 RVA: 0x00020F99 File Offset: 0x0001F199
	public byte[] ToArray()
	{
		this.readableBuffer = this.buffer.ToArray();
		return this.readableBuffer;
	}

	// Token: 0x06000658 RID: 1624 RVA: 0x00020FB2 File Offset: 0x0001F1B2
	public int Length()
	{
		return this.buffer.Count;
	}

	// Token: 0x06000659 RID: 1625 RVA: 0x00020FBF File Offset: 0x0001F1BF
	public int UnreadLength()
	{
		return this.Length() - this.readPos;
	}

	// Token: 0x0600065A RID: 1626 RVA: 0x00020FCE File Offset: 0x0001F1CE
	public void Reset(bool _shouldReset = true)
	{
		if (_shouldReset)
		{
			this.buffer.Clear();
			this.readableBuffer = null;
			this.readPos = 0;
			return;
		}
		this.readPos -= 4;
	}

	// Token: 0x0600065B RID: 1627 RVA: 0x00020FFB File Offset: 0x0001F1FB
	public void Write(byte _value)
	{
		this.buffer.Add(_value);
	}

	// Token: 0x0600065C RID: 1628 RVA: 0x00021009 File Offset: 0x0001F209
	public void Write(byte[] _value)
	{
		this.buffer.AddRange(_value);
	}

	// Token: 0x0600065D RID: 1629 RVA: 0x00021017 File Offset: 0x0001F217
	public void Write(short _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x0600065E RID: 1630 RVA: 0x0002102A File Offset: 0x0001F22A
	public void Write(int _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x0600065F RID: 1631 RVA: 0x0002103D File Offset: 0x0001F23D
	public void Write(long _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000660 RID: 1632 RVA: 0x00021050 File Offset: 0x0001F250
	public void Write(float _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000661 RID: 1633 RVA: 0x00021063 File Offset: 0x0001F263
	public void Write(bool _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000662 RID: 1634 RVA: 0x00021076 File Offset: 0x0001F276
	public void Write(string _value)
	{
		this.Write(_value.Length);
		this.buffer.AddRange(Encoding.ASCII.GetBytes(_value));
	}

	// Token: 0x06000663 RID: 1635 RVA: 0x0002109A File Offset: 0x0001F29A
	public void Write(Vector3 _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
	}

	// Token: 0x06000664 RID: 1636 RVA: 0x000210C0 File Offset: 0x0001F2C0
	public void Write(Quaternion _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
		this.Write(_value.w);
	}

	// Token: 0x06000665 RID: 1637 RVA: 0x000210F2 File Offset: 0x0001F2F2
	public byte ReadByte(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			byte result = this.readableBuffer[this.readPos];
			if (_moveReadPos)
			{
				this.readPos++;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'byte'!");
	}

	// Token: 0x06000666 RID: 1638 RVA: 0x00021130 File Offset: 0x0001F330
	public byte[] ReadBytes(int _length, bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			byte[] result = this.buffer.GetRange(this.readPos, _length).ToArray();
			if (_moveReadPos)
			{
				this.readPos += _length;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'byte[]'!");
	}

	// Token: 0x06000667 RID: 1639 RVA: 0x00021183 File Offset: 0x0001F383
	public byte[] CloneBytes()
	{
		return this.buffer.ToArray();
	}

	// Token: 0x06000668 RID: 1640 RVA: 0x00021190 File Offset: 0x0001F390
	public short ReadShort(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			short result = BitConverter.ToInt16(this.readableBuffer, this.readPos);
			if (_moveReadPos)
			{
				this.readPos += 2;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'short'!");
	}

	// Token: 0x06000669 RID: 1641 RVA: 0x000211E0 File Offset: 0x0001F3E0
	public int ReadInt(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			int result = BitConverter.ToInt32(this.readableBuffer, this.readPos);
			if (_moveReadPos)
			{
				this.readPos += 4;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'int'!");
	}

	// Token: 0x0600066A RID: 1642 RVA: 0x00021230 File Offset: 0x0001F430
	public long ReadLong(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			long result = BitConverter.ToInt64(this.readableBuffer, this.readPos);
			if (_moveReadPos)
			{
				this.readPos += 8;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'long'!");
	}

	// Token: 0x0600066B RID: 1643 RVA: 0x00021280 File Offset: 0x0001F480
	public float ReadFloat(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			float result = BitConverter.ToSingle(this.readableBuffer, this.readPos);
			if (_moveReadPos)
			{
				this.readPos += 4;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'float'!");
	}

	// Token: 0x0600066C RID: 1644 RVA: 0x000212D0 File Offset: 0x0001F4D0
	public bool ReadBool(bool _moveReadPos = true)
	{
		if (this.buffer.Count > this.readPos)
		{
			bool result = BitConverter.ToBoolean(this.readableBuffer, this.readPos);
			if (_moveReadPos)
			{
				this.readPos++;
			}
			return result;
		}
		throw new Exception("Could not read value of type 'bool'!");
	}

	// Token: 0x0600066D RID: 1645 RVA: 0x00021320 File Offset: 0x0001F520
	public string ReadString(bool _moveReadPos = true)
	{
		string result;
		try
		{
			int num = this.ReadInt(true);
			string @string = Encoding.ASCII.GetString(this.readableBuffer, this.readPos, num);
			if (_moveReadPos && @string.Length > 0)
			{
				this.readPos += num;
			}
			result = @string;
		}
		catch
		{
			throw new Exception("Could not read value of type 'string'!");
		}
		return result;
	}

	// Token: 0x0600066E RID: 1646 RVA: 0x00021388 File Offset: 0x0001F588
	public Vector3 ReadVector3(bool moveReadPos = true)
	{
		return new Vector3(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x0600066F RID: 1647 RVA: 0x000213A4 File Offset: 0x0001F5A4
	public Quaternion ReadQuaternion(bool moveReadPos = true)
	{
		return new Quaternion(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x06000670 RID: 1648 RVA: 0x000213C7 File Offset: 0x0001F5C7
	protected virtual void Dispose(bool _disposing)
	{
		if (!this.disposed)
		{
			if (_disposing)
			{
				this.buffer = null;
				this.readableBuffer = null;
				this.readPos = 0;
			}
			this.disposed = true;
		}
	}

	// Token: 0x06000671 RID: 1649 RVA: 0x000213F0 File Offset: 0x0001F5F0
	public void Dispose()
	{
		this.Dispose(true);
		GC.SuppressFinalize(this);
	}

	// Token: 0x040005B5 RID: 1461
	private List<byte> buffer;

	// Token: 0x040005B6 RID: 1462
	private byte[] readableBuffer;

	// Token: 0x040005B7 RID: 1463
	private int readPos;

	// Token: 0x040005B8 RID: 1464
	private bool disposed;
}
