using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

// Token: 0x020000A9 RID: 169
public class Packet : IDisposable
{
	// Token: 0x06000549 RID: 1353 RVA: 0x0001B3C1 File Offset: 0x000195C1
	public Packet()
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
	}

	// Token: 0x0600054A RID: 1354 RVA: 0x0001B3DB File Offset: 0x000195DB
	public Packet(int _id)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.Write(_id);
	}

	// Token: 0x0600054B RID: 1355 RVA: 0x0001B3FC File Offset: 0x000195FC
	public Packet(byte[] _data)
	{
		this.buffer = new List<byte>();
		this.readPos = 0;
		this.SetBytes(_data);
	}

	// Token: 0x0600054C RID: 1356 RVA: 0x0001B41D File Offset: 0x0001961D
	public void SetBytes(byte[] _data)
	{
		this.Write(_data);
		this.readableBuffer = this.buffer.ToArray();
	}

	// Token: 0x0600054D RID: 1357 RVA: 0x0001B437 File Offset: 0x00019637
	public void WriteLength()
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(this.buffer.Count));
	}

	// Token: 0x0600054E RID: 1358 RVA: 0x0001B455 File Offset: 0x00019655
	public void InsertInt(int _value)
	{
		this.buffer.InsertRange(0, BitConverter.GetBytes(_value));
	}

	// Token: 0x0600054F RID: 1359 RVA: 0x0001B469 File Offset: 0x00019669
	public byte[] ToArray()
	{
		this.readableBuffer = this.buffer.ToArray();
		return this.readableBuffer;
	}

	// Token: 0x06000550 RID: 1360 RVA: 0x0001B482 File Offset: 0x00019682
	public int Length()
	{
		return this.buffer.Count;
	}

	// Token: 0x06000551 RID: 1361 RVA: 0x0001B48F File Offset: 0x0001968F
	public int UnreadLength()
	{
		return this.Length() - this.readPos;
	}

	// Token: 0x06000552 RID: 1362 RVA: 0x0001B49E File Offset: 0x0001969E
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

	// Token: 0x06000553 RID: 1363 RVA: 0x0001B4CB File Offset: 0x000196CB
	public void Write(byte _value)
	{
		this.buffer.Add(_value);
	}

	// Token: 0x06000554 RID: 1364 RVA: 0x0001B4D9 File Offset: 0x000196D9
	public void Write(byte[] _value)
	{
		this.buffer.AddRange(_value);
	}

	// Token: 0x06000555 RID: 1365 RVA: 0x0001B4E7 File Offset: 0x000196E7
	public void Write(short _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000556 RID: 1366 RVA: 0x0001B4FA File Offset: 0x000196FA
	public void Write(int _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000557 RID: 1367 RVA: 0x0001B50D File Offset: 0x0001970D
	public void Write(long _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000558 RID: 1368 RVA: 0x0001B520 File Offset: 0x00019720
	public void Write(float _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x06000559 RID: 1369 RVA: 0x0001B533 File Offset: 0x00019733
	public void Write(bool _value)
	{
		this.buffer.AddRange(BitConverter.GetBytes(_value));
	}

	// Token: 0x0600055A RID: 1370 RVA: 0x0001B546 File Offset: 0x00019746
	public void Write(string _value)
	{
		this.Write(_value.Length);
		this.buffer.AddRange(Encoding.ASCII.GetBytes(_value));
	}

	// Token: 0x0600055B RID: 1371 RVA: 0x0001B56A File Offset: 0x0001976A
	public void Write(Vector3 _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
	}

	// Token: 0x0600055C RID: 1372 RVA: 0x0001B590 File Offset: 0x00019790
	public void Write(Quaternion _value)
	{
		this.Write(_value.x);
		this.Write(_value.y);
		this.Write(_value.z);
		this.Write(_value.w);
	}

	// Token: 0x0600055D RID: 1373 RVA: 0x0001B5C2 File Offset: 0x000197C2
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

	// Token: 0x0600055E RID: 1374 RVA: 0x0001B600 File Offset: 0x00019800
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

	// Token: 0x0600055F RID: 1375 RVA: 0x0001B653 File Offset: 0x00019853
	public byte[] CloneBytes()
	{
		return this.buffer.ToArray();
	}

	// Token: 0x06000560 RID: 1376 RVA: 0x0001B660 File Offset: 0x00019860
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

	// Token: 0x06000561 RID: 1377 RVA: 0x0001B6B0 File Offset: 0x000198B0
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

	// Token: 0x06000562 RID: 1378 RVA: 0x0001B700 File Offset: 0x00019900
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

	// Token: 0x06000563 RID: 1379 RVA: 0x0001B750 File Offset: 0x00019950
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

	// Token: 0x06000564 RID: 1380 RVA: 0x0001B7A0 File Offset: 0x000199A0
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

	// Token: 0x06000565 RID: 1381 RVA: 0x0001B7F0 File Offset: 0x000199F0
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

	// Token: 0x06000566 RID: 1382 RVA: 0x0001B858 File Offset: 0x00019A58
	public Vector3 ReadVector3(bool moveReadPos = true)
	{
		return new Vector3(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x06000567 RID: 1383 RVA: 0x0001B874 File Offset: 0x00019A74
	public Quaternion ReadQuaternion(bool moveReadPos = true)
	{
		return new Quaternion(this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos), this.ReadFloat(moveReadPos));
	}

	// Token: 0x06000568 RID: 1384 RVA: 0x0001B897 File Offset: 0x00019A97
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

	// Token: 0x06000569 RID: 1385 RVA: 0x0001B8C0 File Offset: 0x00019AC0
	public void Dispose()
	{
		this.Dispose(true);
		GC.SuppressFinalize(this);
	}

	// Token: 0x0400049D RID: 1181
	private List<byte> buffer;

	// Token: 0x0400049E RID: 1182
	private byte[] readableBuffer;

	// Token: 0x0400049F RID: 1183
	private int readPos;

	// Token: 0x040004A0 RID: 1184
	private bool disposed;
}
