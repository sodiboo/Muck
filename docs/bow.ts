export interface Bow {
  projectileSpeed: number;
  nArrows: number;
  angleDelta: number;
}

export const bows = new Map<string, Bow>();

import { io, parse } from "./common.ts";

for (const [guid, file] of await io.ScriptableObjects("Bow")) {
  const bow: Bow = {
    projectileSpeed: parse.number<Bow>(file, "projectileSpeed"),
    nArrows: parse.number<Bow>(file, "nArrows"),
    angleDelta: parse.number<Bow>(file, "angleDelta"),
  };
  bows.set(guid, bow);
}
