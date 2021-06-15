export const lootTables = new Map<string, LootTable>();
export interface LootTable {
  loot: LootItem[];
}

export interface LootItem {
  item: string;
  amountMin: number;
  amountMax: number;
  dropChance: number;
}

import { io, parse } from "./common.ts";

for (const [guid, file] of await io.ScriptableObjects("Loot")) {
  const lootTable: LootTable = {
    loot: parse.array<LootTable, LootItem>(file, "loot", (loot) => {
      const item: LootItem = {
        item: parse.guid<LootItem>(loot, "item")!,
        amountMin: parse.number<LootItem>(loot, "amountMin"),
        amountMax: parse.number<LootItem>(loot, "amountMax"),
        dropChance: parse.number<LootItem>(loot, "dropChance"),
      };
      return item;
    }),
  };
  lootTables.set(guid, lootTable);
}
