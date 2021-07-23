using System;
using System.Collections.Generic;
using UnityEngine;

public class ManagerUtil : MonoBehaviour
{
    public static int FindRandomUnusedID(InventoryItem.ItemType item, Dictionary<int, GameObject> list, System.Random random)
    {
        Vector2 idRange = GetIdRange(item);
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

    public static Vector2 GetIdRange(InventoryItem.ItemType item)
    {
        int num = (int)item * 10000;
        int num2 = 10000 * (int)(item + 1);
        return new Vector2(num, num2);
    }
}
