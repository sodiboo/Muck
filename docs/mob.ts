export enum Weakness {
  Sharp,
  Blunt,
  Water,
  Fire,
  Lightning,
}

export interface Mob {
  name: string;
  loot: string;
  health: number;
  weaknesses: Weakness[];
  boss: boolean;
}

interface Dummy {
  mobPrefab: string;
  entityName: string;
  dropTable: string;
  maxHp: number;
}

export const mobs = new Map<string, Mob>();

import { io, link, parse, prefabs, scripts } from "./common.ts";
import { items } from "./item.ts";
import { lootTables } from "./loot.ts";

for (const [guid, file] of await io.ScriptableObjects("Mobs")) {
  const prefab = parse.guid<Dummy>(file, "mobPrefab")!;
  const hitable = prefabs.get(prefab)!.scripts.get(scripts.HitableMob)![0];
  const mob: Mob = {
    name: parse.string<Dummy>(hitable, "entityName"),
    loot: parse.guid<Dummy>(hitable, "dropTable")!,
    health: parse.number<Dummy>(hitable, "maxHp"),
    weaknesses: [],
    boss: parse.bool<Mob>(file, "boss"),
  };
  const raw = parse.raw(file, "weaknesses");
  if (raw == "") {
    mob.weaknesses = parse.array<Mob, Weakness>(
      file,
      "weaknesses",
      (s) => +s.replaceAll("0", ""),
    );
  } else {
    mob.weaknesses = [+raw.replaceAll("0", "")];
  }
  mobs.set(guid, mob);
}

const explanation = await Deno.readTextFile("./Health.md");

export const section: () => [string, string] =
  () => [
    "Mobs",
    explanation + "\n\n---\n\n" + Array.from(mobs.values()).sort((a, b) => {
      if (a.boss != b.boss) {
        if (a.boss) return -1;
        return 1;
      }
      return a.name.localeCompare(b.name);
    }).map((mob) =>
      `###${mob.boss ? " BOSS: " : " "}${mob.name}
- Base Health: ${mob.health}
#### Weaknesses
${mob.weaknesses.length ? mob.weaknesses.map((weakness) => `- ${Weakness[weakness]}`).join("\n") : "- None"}
#### Loot Table
${
        lootTables.get(mob.loot)!.loot.map((entry) =>
          `- ${entry.dropChance *
            100}% chance to drop ${entry.amountMin}-${entry.amountMax} ${
            link(items.get(entry.item)!.name)
          }`
        ).join("\n")
      }`
    ).join("\n\n---\n\n"),
  ];
