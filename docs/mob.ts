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

import { io, parse, prefabs, scripts } from "./common.ts";

for (const [guid, file] of await io.ScriptableObjects("Mobs")) {
  const prefab = parse.guid<Dummy>(file, "mobPrefab")!;
  const hitable = prefabs.get(prefab)!.get(scripts.HitableMob)!;
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
