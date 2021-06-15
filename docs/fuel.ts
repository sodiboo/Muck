export const fuels = new Map<string, Fuel>();
export interface Fuel {
  maxUses: number;
  speedMultiplier: number;
}

import { io, parse } from "./common.ts";

for (const [guid, file] of await io.ScriptableObjects("Fuel")) {
  const fuel: Fuel = {
    maxUses: parse.number<Fuel>(file, "maxUses"),
    speedMultiplier: parse.number<Fuel>(file, "speedMultiplier"),
  };
  fuels.set(guid, fuel);
}
