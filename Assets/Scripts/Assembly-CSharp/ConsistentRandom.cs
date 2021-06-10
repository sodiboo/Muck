using System;

// Token: 0x020000AB RID: 171
public class ConsistentRandom : Random
{
	// Token: 0x0600056C RID: 1388 RVA: 0x0001B8CF File Offset: 0x00019ACF
	public ConsistentRandom() : this(Environment.TickCount)
	{
	}

	// Token: 0x0600056D RID: 1389 RVA: 0x0001B8DC File Offset: 0x00019ADC
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

	// Token: 0x0600056E RID: 1390 RVA: 0x0001B9D6 File Offset: 0x00019BD6
	protected override double Sample()
	{
		return (double)this.InternalSample() * 4.656612875245797E-10;
	}

	// Token: 0x0600056F RID: 1391 RVA: 0x0001B9EC File Offset: 0x00019BEC
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

	// Token: 0x06000570 RID: 1392 RVA: 0x0001BA5F File Offset: 0x00019C5F
	public override int Next()
	{
		return this.InternalSample();
	}

	// Token: 0x06000571 RID: 1393 RVA: 0x0001BA68 File Offset: 0x00019C68
	private double GetSampleForLargeRange()
	{
		int num = this.InternalSample();
		if (this.InternalSample() % 2 == 0)
		{
			num = -num;
		}
		return ((double)num + 2147483646.0) / 4294967293.0;
	}

	// Token: 0x06000572 RID: 1394 RVA: 0x0001BAA8 File Offset: 0x00019CA8
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

	// Token: 0x06000573 RID: 1395 RVA: 0x0001BAF0 File Offset: 0x00019CF0
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

	// Token: 0x040004A1 RID: 1185
	private const int MBIG = 2147483647;

	// Token: 0x040004A2 RID: 1186
	private const int MSEED = 161803398;

	// Token: 0x040004A3 RID: 1187
	private const int MZ = 0;

	// Token: 0x040004A4 RID: 1188
	private int inext;

	// Token: 0x040004A5 RID: 1189
	private int inextp;

	// Token: 0x040004A6 RID: 1190
	private int[] SeedArray = new int[56];
}
