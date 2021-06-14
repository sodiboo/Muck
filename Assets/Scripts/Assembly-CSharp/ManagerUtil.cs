using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A5 RID: 165
public class ManagerUtil : MonoBehaviour
{
	// Token: 0x060003D2 RID: 978 RVA: 0x00016060 File Offset: 0x00014260
	public static int FindRandomUnusedID(InventoryItem.ItemType item, Dictionary<int, GameObject> list, System.Random random)
	{
		Vector2 idRange = ManagerUtil.GetIdRange(item);
		int minValue = (int)idRange.x;
		int maxValue = (int)idRange.y;
		int num = random.Next(minValue, maxValue);
		int num2 = 0;
		while (list.ContainsKey(num))
		{
			num = random.Next(minValue, maxValue);
			num2++;
			if (num2 > 1000)
			{
				return -1;
			}
		}
		return num;
	}

	// Token: 0x060003D3 RID: 979 RVA: 0x000160B0 File Offset: 0x000142B0
	public static Vector2 GetIdRange(InventoryItem.ItemType item)
	{
		int num = 10000;
		int num2 = (int)item * 10000;
		int num3 = num * (int)(item + 1);
		return new Vector2((float)num2, (float)num3);
	}
}
