public class HitableResource : Hitable
{
	public InventoryItem.ItemType compatibleItem;
	public int minTier;
	public InventoryItem dropItem;
	public InventoryItem[] dropExtra;
	public float[] dropChance;
	public int amount;
	public bool dontScale;
	public int poolId;
}
