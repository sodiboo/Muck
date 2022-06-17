import { link, references } from "./common.ts";

import { sections as item } from "./item.ts";
import { sections as powerup } from "./powerup.ts";
import { section as armor } from "./armor.ts";
import { section as mob } from "./mob.ts";
import { section as trades } from "./trades.ts";

const sections: [string, string][] = [
  ...item,
  armor(),
  ...powerup,
  mob(),
  trades(),
];

let tableOfContents = "# Table of Contents";
for (const [header] of sections) {
  tableOfContents += `\n- ${link(header)}`;
}

await Deno.writeTextFile(
  "./Data.md",
  tableOfContents + "\n\n" +
    sections.map(([header, content]) => `# ${header}\n${content}`).join(
      "\n\n",
    ) + "\n\n" + references.join("\n"),
);
