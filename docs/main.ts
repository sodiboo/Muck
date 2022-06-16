import { link, references } from "./common.ts";

import { sections as item } from "./item.ts";
import { sections as powerup } from "./powerup.ts";
import { section as armor } from "./armor.ts";
import { section as mob } from "./mob.ts";
import { section as trades } from "./trades.ts";

references.push("[hosted-site]: https://muck.terrain.pw/Data")

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
  "links not working? [go to hosted site][hosted-site]\n\n" +
  tableOfContents + "\n\n" +
    sections.map(([header, content]) => `# ${header}\n${content}`).join(
      "\n\n",
    ) + "\n\n" + references.join("\n"),
);
