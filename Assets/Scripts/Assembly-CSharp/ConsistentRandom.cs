using System;

// Token: 0x020000D3 RID: 211
public class ConsistentRandom : Random
{
	// Token: 0x06000676 RID: 1654 RVA: 0x0002145F File Offset: 0x0001F65F
	public ConsistentRandom() : this(Environment.TickCount)
	{
	}

	// Token: 0x06000677 RID: 1655 RVA: 0x0002146C File Offset: 0x0001F66C
	public ConsistentRandom(int seed)
	{
		int num = (seed == int.MinValue) ? int.MaxValue : Math.Abs(seed);
		int num2 = 161803398 - num;
		this.SeedArray[55] = num2;
		int num3 = 1;
		for (int i = 1; i < 55; i++)
		{
			int num4 = 21 * i % 55;
			this.SeedArray[num4] = num3;
			num3 = num2 - num3;
			if (num3 < 0)
			{
				num3 += int.MaxValue;
			}
			num2 = this.SeedArray[num4];
		}
		for (int j = 1; j < 5; j++)
		{
			for (int k = 1; k < 56; k++)
			{
				this.SeedArray[k] -= this.SeedArray[1 + (k + 30) % 55];
				if (this.SeedArray[k] < 0)
				{
					this.SeedArray[k] += int.MaxValue;
				}
			}
		}
		this.inext = 0;
		this.inextp = 21;
	}

	// Token: 0x06000678 RID: 1656 RVA: 0x00021566 File Offset: 0x0001F766
	protected override double Sample()
	{
		return (double)this.InternalSample() * 4.656612875245797E-10;
	}

	// Token: 0x06000679 RID: 1657 RVA: 0x0002157C File Offset: 0x0001F77C
	private int InternalSample()
	{
		int num = this.inext;
		int num2 = this.inextp;
		if (++num >= 56)
		{
			num = 1;
		}
		if (++num2 >= 56)
		{
			num2 = 1;
		}
		int num3 = this.SeedArray[num] - this.SeedArray[num2];
		if (num3 == 2147483647)
		{
			num3--;
		}
		if (num3 < 0)
		{
			num3 += int.MaxValue;
		}
		this.SeedArray[num] = num3;
		this.inext = num;
		this.inextp = num2;
		return num3;
	}

	// Token: 0x0600067A RID: 1658 RVA: 0x000215EF File Offset: 0x0001F7EF
	public override int Next()
	{
		return this.InternalSample();
	}

	// Token: 0x0600067B RID: 1659 RVA: 0x000215F8 File Offset: 0x0001F7F8
	private double GetSampleForLargeRange()
	{
		int num = this.InternalSample();
		if (this.InternalSample() % 2 == 0)
		{
			num = -num;
		}
		return ((double)num + 2147483646.0) / 4294967293.0;
	}

	// Token: 0x0600067C RID: 1660 RVA: 0x00021638 File Offset: 0x0001F838
	public override int Next(int minValue, int maxValue)
	{
		if (minValue > maxValue)
		{
			throw new ArgumentOutOfRangeException("minValue");
		}
		long num = (long)maxValue - (long)minValue;
		if (num <= 2147483647L)
		{
			return (int)(this.Sample() * (double)num) + minValue;
		}
		return (int)((long)(this.GetSampleForLargeRange() * (double)num) + (long)minValue);
	}

	// Token: 0x0600067D RID: 1661 RVA: 0x00021680 File Offset: 0x0001F880
	public override void NextBytes(byte[] buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		for (int i = 0; i < buffer.Length; i++)
		{
			buffer[i] = (byte)(this.InternalSample() % 256);
		}
	}

	// Token: 0x040005B9 RID: 1465
	private const int MBIG = 2147483647;

	// Token: 0x040005BA RID: 1466
	private const int MSEED = 161803398;

	// Token: 0x040005BB RID: 1467
	private const int MZ = 0;

	// Token: 0x040005BC RID: 1468
	private int inext;

	// Token: 0x040005BD RID: 1469
	private int inextp;

	// Token: 0x040005BE RID: 1470
	private int[] SeedArray = new int[56];
}
