using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

// Token: 0x020000E3 RID: 227
public class Packet : IDisposable
{
	// Token: 0x060005DB RID: 1499 RVA: 0x00005A22 File Offset: 0x00003C22
	public Packet()
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
	}

	// Token: 0x060005DC RID: 1500 RVA: 0x00005A3C File Offset: 0x00003C3C
	public Packet(int _id)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.Write(_id);
	}

	// Token: 0x060005DD RID: 1501 RVA: 0x00005A5D File Offset: 0x00003C5D
	public Packet(byte[] _data)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.SetBytes(_data);
	}

	// Token: 0x060005DE RID: 1502 RVA: 0x00005A7E File Offset: 0x00003C7E
	public void SetBytes(byte[] _data)
	{
		this.Write(_data);
		this.readableBuffer = this.buffer.ToArray();
	}

	// Token: 0x060005DF RID: 1503 RVA: 0x00005A98 File Offset: 0x00003C98
	public void WriteLength()
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(this.buffer.Count));
	}

	// Token: 0x060005E0 RID: 1504 RVA: 0x00005AB6 File Offset: 0x00003CB6
	public void InsertInt(int _value)
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(_value));
	}

	// Token: 0x060005E1 RID: 1505 RVA: 0x00005ACA File Offset: 0x00003CCA
	public byte[] ToArray()
	{
		this.readableBuffer = this.buffer.ToArray();
		return this.readableBuffer;
	}

	// Token: 0x060005E2 RID: 1506 RVA: 0x00005AE3 File Offset: 0x00003CE3
	public int Length()
	{
		return this.buffer.Count;
	}

	// Token: 0x060005E3 RID: 1507 RVA: 0x00005AF0 File Offset: 0x00003CF0
	public int UnreadLength()
	{
		return this.Length() - this.readPos;
	}

	// Token: 0x060005E4 RID: 1508 RVA: 0x00005AFF File Offset: 0x00003CFF
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

	// Token: 0x060005E5 RID: 1509 RVA: 0x00005B2C File Offset: 0x00003D2C
	public void Write(byte _value)
	{
		this.buffer.Add(_value);
	}

	// Token: 0x060005E6 RID: 1510 RVA: 0x00005B3A File Offset: 0x00003D3A
	public void Write(byte[] _value)
	{
		this.buffer.AddRange(_value);
	}

	// Token: 0x060005E7 RID: 1511 RVA: 0x00005B48 File Offset: 0x00003D48
	public void Write(short _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x060005E8 RID: 1512 RVA: 0x00005B5B File Offset: 0x00003D5B
	public void Write(int _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x060005E9 RID: 1513 RVA: 0x00005B6E File Offset: 0x00003D6E
	public void Write(long _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x060005EA RID: 1514 RVA: 0x00005B81 File Offset: 0x00003D81
	public void Write(float _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x060005EB RID: 1515 RVA: 0x00005B94 File Offset: 0x00003D94
	public void Write(bool _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x060005EC RID: 1516 RVA: 0x00005BA7 File Offset: 0x00003DA7
	public void Write(string _value)
	{
		this.Write(_value.Length);
		this.buffer.AddRange(Encoding.ASCII.GetBytes(_value));
	}

	// Token: 0x060005ED RID: 1517 RVA: 0x00005BCB File Offset: 0x00003DCB
	public void Write(Vector3 _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
	}

	// Token: 0x060005EE RID: 1518 RVA: 0x00005BF1 File Offset: 0x00003DF1
	public void Write(Quaternion _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
		this.Write(_value.w);
	}

	// Token: 0x060005EF RID: 1519 RVA: 0x00005C23 File Offset: 0x00003E23
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

	// Token: 0x060005F0 RID: 1520 RVA: 0x0001F714 File Offset: 0x0001D914
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

	// Token: 0x060005F1 RID: 1521 RVA: 0x00005C61 File Offset: 0x00003E61
	public byte[] CloneBytes()
	{
		return this.buffer.ToArray();
	}

	// Token: 0x060005F2 RID: 1522 RVA: 0x0001F768 File Offset: 0x0001D968
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

	// Token: 0x060005F3 RID: 1523 RVA: 0x0001F7B8 File Offset: 0x0001D9B8
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

	// Token: 0x060005F4 RID: 1524 RVA: 0x0001F808 File Offset: 0x0001DA08
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

	// Token: 0x060005F5 RID: 1525 RVA: 0x0001F858 File Offset: 0x0001DA58
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

	// Token: 0x060005F6 RID: 1526 RVA: 0x0001F8A8 File Offset: 0x0001DAA8
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

	// Token: 0x060005F7 RID: 1527 RVA: 0x0001F8F8 File Offset: 0x0001DAF8
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

	// Token: 0x060005F8 RID: 1528 RVA: 0x00005C6E File Offset: 0x00003E6E
	public Vector3 ReadVector3(bool moveReadPos = true)
	{
		return new Vector3(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x060005F9 RID: 1529 RVA: 0x00005C8A File Offset: 0x00003E8A
	public Quaternion ReadQuaternion(bool moveReadPos = true)
	{
		return new Quaternion(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x060005FA RID: 1530 RVA: 0x00005CAD File Offset: 0x00003EAD
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

	// Token: 0x060005FB RID: 1531 RVA: 0x00005CD6 File Offset: 0x00003ED6
	public void Dispose()
	{
		this.Dispose(true);
		GC.SuppressFinalize(this);
	}

	// Token: 0x04000594 RID: 1428
	private List<byte> buffer;

	// Token: 0x04000595 RID: 1429
	private byte[] readableBuffer;

	// Token: 0x04000596 RID: 1430
	private int readPos;

	// Token: 0x04000597 RID: 1431
	private bool disposed;
}
