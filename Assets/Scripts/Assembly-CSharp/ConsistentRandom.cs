using System;

// Token: 0x020000E5 RID: 229
public class ConsistentRandom : Random
{
	// Token: 0x060005FE RID: 1534 RVA: 0x00005CE5 File Offset: 0x00003EE5
	public ConsistentRandom() : this(Environment.TickCount)
	{
	}

	// Token: 0x060005FF RID: 1535 RVA: 0x0001F960 File Offset: 0x0001DB60
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

	// Token: 0x06000600 RID: 1536 RVA: 0x00005CF2 File Offset: 0x00003EF2
	protected override double Sample()
	{
		return (double)this.InternalSample() * 4.656612875245797E-10;
	}

	// Token: 0x06000601 RID: 1537 RVA: 0x0001FA5C File Offset: 0x0001DC5C
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

	// Token: 0x06000602 RID: 1538 RVA: 0x00005D05 File Offset: 0x00003F05
	public override int Next()
	{
		return this.InternalSample();
	}

	// Token: 0x06000603 RID: 1539 RVA: 0x0001FAD0 File Offset: 0x0001DCD0
	private double GetSampleForLargeRange()
	{
		int num = this.InternalSample();
		if (this.InternalSample() % 2 == 0)
		{
			num = -num;
		}
		return ((double)num + 2147483646.0) / 4294967293.0;
	}

	// Token: 0x06000604 RID: 1540 RVA: 0x0001FB10 File Offset: 0x0001DD10
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

	// Token: 0x06000605 RID: 1541 RVA: 0x0001FB58 File Offset: 0x0001DD58
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

	// Token: 0x04000598 RID: 1432
	private const int MBIG = 2147483647;

	// Token: 0x04000599 RID: 1433
	private const int MSEED = 161803398;

	// Token: 0x0400059A RID: 1434
	private const int MZ = 0;

	// Token: 0x0400059B RID: 1435
	private int inext;

	// Token: 0x0400059C RID: 1436
	private int inextp;

	// Token: 0x0400059D RID: 1437
	private int[] SeedArray = new int[56];
}
