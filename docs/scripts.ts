import { meta } from "./io.ts";

function script(name: string): Promise<string> {
  return meta(`../Assets/Scripts/Assembly-CSharp/${name}.cs`);
}

export const HitableMob = await script("HitableMob");
export const EnemyProjectile = await script("EnemyProjectile");
export const CauldronUI = await script("CauldronUI");
export const CraftingUI = await script("CraftingUI");
export const ItemManager = await script("ItemManager");
export const OtherInput = await script("OtherInput");
