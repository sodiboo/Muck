using System;
using UnityEngine;

public class HitableChest : HitableResource
{
    public override void OnKill(Vector3 dir)
    {
        ChestManager.Instance.RemoveChest(base.GetId());
		ResourceManager.Instance.RemoveItem(base.GetId());
        if (!SaveData.isExecuting) SaveData.Instance.save.Add(new SaveData.DestroyItem { objectId = id });
    }
}
