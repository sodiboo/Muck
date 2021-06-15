import {
  CumulativeDistribution,
  fragment,
  images,
  io,
  link,
  parse,
  references,
} from "./common.ts";

const powerups: Powerup[] = [];

enum PowerupTier {
  White,
  Blue,
  Orange,
}

interface Powerup {
  id: number;
  tier: PowerupTier;
  name: string;
  description: string;
  sprite: string;
  article: string;
}

for (const [, file] of await io.ScriptableObjects("Powerups")) {
  const powerup: Powerup = {
    id: parse.number<Powerup>(file, "id"),
    tier: parse.number<Powerup>(file, "tier"),
    name: parse.string<Powerup>(file, "name"),
    description: parse.string<Powerup>(file, "description"),
    sprite: parse.guid<Powerup>(file, "sprite")!,
    article: "",
  };
  try {
    powerup.article = await Deno.readTextFile(
      `./PowerupStats/${fragment(powerup.name)}.md`,
    );
  } catch (up) {
    if (!(up instanceof Deno.errors.NotFound)) throw up;
  }
  powerups.push(powerup);
}

function info(powerup: Powerup): string {
  const lines: string[] = [];
  lines.push(
    `### ${powerup.name}`,
    `*${powerup.description}*`,
    `###### ![${fragment(powerup.name)}]`,
  );
  references.push(
    `[${fragment(powerup.name)}]: ../Assets/Texture2D/${
      encodeURIComponent(images.get(powerup.sprite)!)
    }`,
  );

  const matches = Array.from(
    powerup.article.matchAll(/^\[(?<label>.*)\]: (?<image>.*)$/gm),
  );

  for (const match of matches) {
    references.push(
      `[${fragment(powerup.name)}-${match.groups!.label}]: ${
        match.groups!.image.startsWith("Images/") ? "PowerupStats/" : ""
      }${match.groups!.image}`,
    );
    powerup.article = powerup.article.replace(match[0], "").replaceAll(
      match.groups!.label,
      `${fragment(powerup.name)}-${match.groups!.label}`,
    );
  }
  powerup.article = powerup.article.replaceAll(
    /^cum: .*$/gm,
    (match) => {
      const expression = /^cum: (?<expr>.*)$/.exec(
        match,
      )!.groups!.expr;

      const results: string[] = [];

      let moreLines = true;
      for (let i = 0; moreLines || (i % 5 != 1 && i !== 70); i++) {
        moreLines = false;
        const calc = (speed: number, max: number) =>
          CumulativeDistribution(i, speed, max);
        // deno-lint-ignore no-unused-vars
        const n = (final: number, value: number, precision = 1) => {
          precision = Math.max(
            final.toString().split(".")[1]?.length ?? 0,
            precision,
          );
          calc;
          n;

          const margin = Math.pow(10, precision);
          const result = Math.round(value * margin) / margin;
          if (final !== result) moreLines = true;
          return result.toString();
        };
        results.push(eval(expression));
      }
      return results.map((value, i) => `${i}. ${value}`).join("\n");
    },
  );
  powerup.article = powerup.article.trim();
  if (powerup.article.length) {
    lines.push(
      "",
      "<details>",
      "<summary> Boring nerd details </summary>",
      "",
      powerup.article,
      "",
      "</details>",
    );
  }
  return lines.join("\n");
}

export const sections: [string, string][] = [];

const powerupIndex: [number, string][] = [];
for (const powerup of powerups) {
  powerupIndex.push([powerup.id, link(powerup.name)]);
}

sections.push([
  "Powerups by ID",
  powerupIndex.sort(([a], [b]) => a - b).map(([index, powerup]) =>
    `${index}. ${powerup}`
  ).join("\n"),
]);

sections.push([
  "Powerups by name",
  powerups.sort((a, b) => a.name.localeCompare(b.name)).map((powerup) =>
    `- ${link(powerup.name)}`
  ).join("\n"),
]);

sections.push([
  "Powerups",
  [await Deno.readTextFile("./Cumulative Distribution.md")].concat(
    powerups.sort((a, b) => (a.tier - b.tier) || a.name.localeCompare(b.name))
      .map(info),
  ).join("\n\n---\n\n"),
]);
