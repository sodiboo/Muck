export const armors = new Map<string, Armor>();
export interface Armor {
  helmet: string;
  torso: string;
  legs: string;
  feet: string;

  setBonus: string;
}

import { io, link, parse } from "./common.ts";

const NormalArmor = await io.meta(
  "../Assets/ScriptableObject/Armor/NormalArmor.asset",
);

for (const [guid, file] of await io.ScriptableObjects("Armor")) {
  if (guid === NormalArmor) continue;
  const armor: Armor = {
    helmet: "",
    torso: "",
    legs: "",
    feet: "",

    setBonus: parse.string<Armor>(file, "setBonus").replaceAll(
      /<color=\w+>/g,
      "",
    ),
  };
  armors.set(guid, armor);
}

export const section: () => [string, string] = () => [
  "Armor Sets",
  Array.from(armors.values()).map((set) =>
    `### ${set.helmet.split(" ")[0]} Armor
*${set.setBonus}*
- ${link(set.helmet)}
- ${link(set.torso)}
- ${link(set.legs)}
- ${link(set.feet)}`
  ).join("\n"),
];
