using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000AB RID: 171
public class ManagerUtil : MonoBehaviour
{
	// Token: 0x06000472 RID: 1138 RVA: 0x00017254 File Offset: 0x00015454
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

	// Token: 0x06000473 RID: 1139 RVA: 0x000172A4 File Offset: 0x000154A4
	public static Vector2 GetIdRange(InventoryItem.ItemType item)
	{
		int num = 10000;
		int num2 = (int)item * 10000;
		int num3 = num * (int)(item + 1);
		return new Vector2((float)num2, (float)num3);
	}
}
