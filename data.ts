const sections: [string, string][] = [];
const decoder = new TextDecoder("utf-8");
const itemFiles = await readDir("./Assets/ScriptableObject/Items/", true);
const fuelFiles = await readDir("./Assets/ScriptableObject/Fuel/", true);
const images = await readDir("./Assets/Texture2D/", false);

async function readMeta(file: string): Promise<string> {
  const content = decoder.decode(await Deno.readFile(file + ".meta"));
  const guid = content.match(/^guid: (?<value>[a-f0-9]+)$/m)!.groups!.value;
  return guid;
}

async function readDir(
  dir: string,
  contents: boolean,
): Promise<Map<string, string>> {
  const result = new Map<string, string>();
  for await (const file of Deno.readDir(dir)) {
    if (!file.name.endsWith(".meta")) {
      result.set(
        await readMeta(dir + file.name),
        contents
          ? decoder.decode(await Deno.readFile(dir + file.name))
          : file.name,
      );
    }
  }
  return result;
}

type Vector3 = [number, number, number];

enum ItemType {
  Item,
  Axe,
  Pickaxe,
  Sword,
  Shield,
  Shovel,
  Storage,
  Station,
  Food,
  Bow,
}

enum ToolTier {
  None,
  Wood,
  Steel,
  Mithril,
  Adamantite,
}

enum ItemTag {
  None,
  Fuel,
  Food,
  LeftHanded,
  Helmet,
  Torso,
  Legs,
  Feet,
  Arrow,
  Armor,
}

enum ItemRarity {
  Common,
  Uncommon,
  Rare,
}

enum ProcessType {
  Smelt,
  Cook,
  None,
}

interface Item {
  id: number;
  sprite: string;
  name: string;
  description: string;

  type: ItemType;
  tier: ToolTier;
  tag: ItemTag;
  rarity: ItemRarity;

  stackable: boolean;
  max: number;

  craftable: boolean;
  craftAmount: number;
  unlockWithFirstRequirementOnly: boolean;
  requirements: { item: string; amount: number }[];
  stationRequirement: string | null;

  buildable: boolean;

  processable: boolean;
  processType: ProcessType;
  processTime: number;
  processedItem: string | null;

  attackRange: Vector3;
  resourceDamage: number;
  attackDamage: number;
  attackSpeed: number;
  sharpness: number;

  heal: number;
  hunger: number;
  stamina: number;
  projectileSpeed: number;
  armor: number;
  fuel: string | null;
}

interface Fuel {
  maxUses: number;
  speedMultiplier: number;
}

type Properties<T, O> = Exclude<
  keyof {
    [Property in keyof O as O[Property] extends T ? Property : never]: T;
  },
  number | symbol
>;

function parseValue(file: string, key: string): string {
  return file.match(new RegExp(`^  ${key}: (?<value>.*)$`, "m"))!.groups!.value;
}

function parseString<O>(file: string, key: Properties<string, O>): string {
  return parseValue(file, key);
}

function parseGuid<O>(
  file: string,
  key: Properties<string | null, O>,
): string | null {
  return parseValue(file, key).match(/guid: (?<guid>[a-f0-9]+)[,}]/)?.groups
    ?.guid ?? null;
}

function parseNumber<O>(file: string, key: Properties<number, O>): number {
  return +parseValue(file, key);
}

function parseBool<O>(file: string, key: Properties<boolean, O>): boolean {
  return parseValue(file, key) == "1";
}

function parseVector3<O>(file: string, key: Properties<Vector3, O>): Vector3 {
  const { x, y, z } = parseValue(file, key).match(
    /^\{x: (?<x>[\d\.]+), y: (?<y>[\d\.]+), z: (?<z>[\d\.]+)\}/,
  )!.groups!;
  return [+x, +y, +z];
}

const fuels = new Map<string, Fuel>();
for (const [guid, file] of fuelFiles) {
  const fuel: Fuel = {
    maxUses: parseNumber<Fuel>(file, "maxUses"),
    speedMultiplier: parseNumber<Fuel>(file, "speedMultiplier"),
  };
  fuels.set(guid, fuel);
}

const items = new Map<string, Item>();
for (const [guid, file] of itemFiles) {
  const item: Item = {
    id: parseNumber<Item>(file, "id"),
    sprite: parseGuid<Item>(file, "sprite")!,
    name: parseString<Item>(file, "name"),
    description: parseString<Item>(file, "description"),

    type: parseNumber<Item>(file, "type"),
    tier: parseNumber<Item>(file, "tier"),
    tag: parseNumber<Item>(file, "tag"),
    rarity: parseNumber<Item>(file, "rarity"),

    stackable: parseBool<Item>(file, "stackable"),
    max: parseNumber<Item>(file, "max"),

    craftable: parseBool<Item>(file, "craftable"),
    craftAmount: parseNumber<Item>(file, "craftAmount"),
    unlockWithFirstRequirementOnly: parseBool<Item>(
      file,
      "unlockWithFirstRequirementOnly",
    ),
    requirements: [],
    stationRequirement: parseGuid<Item>(file, "stationRequirement"),

    buildable: parseBool<Item>(file, "buildable"),

    processable: parseBool<Item>(file, "processable"),
    processType: parseNumber<Item>(file, "processType"),
    processTime: parseNumber<Item>(file, "processTime"),
    processedItem: parseGuid<Item>(file, "processedItem"),

    attackRange: parseVector3<Item>(file, "attackRange"),
    resourceDamage: parseNumber<Item>(file, "resourceDamage"),
    attackDamage: parseNumber<Item>(file, "attackDamage"),
    attackSpeed: parseNumber<Item>(file, "attackSpeed"),
    sharpness: parseNumber<Item>(file, "sharpness"),

    heal: parseNumber<Item>(file, "heal"),
    hunger: parseNumber<Item>(file, "hunger"),
    stamina: parseNumber<Item>(file, "stamina"),
    projectileSpeed: parseNumber<Item>(file, "projectileSpeed"),
    armor: parseNumber<Item>(file, "armor"),
    fuel: parseGuid<Item>(file, "fuel"),
  };
  const lines = file.split(/\r?\n/g);
  let i = lines.indexOf("  requirements:");
  let match = null;
  while (
    (match = /^  - item: .*guid: (?<guid>[a-f0-9]+)[,}]/.exec(lines[++i])) !==
      null
  ) {
    item.requirements.push({
      item: match.groups!.guid,
      amount: +/^    amount: (?<amount>[0-9]+)$/.exec(lines[++i])!.groups!
        .amount,
    });
  }
  items.set(guid, item);
}

const index = new Map<number, string>();
for (const [, item] of items) {
  index.set(item.id, `[${item.name}](#${item.id})`);
}
index.set(100, index.get(101)!);

sections.push([
  "Items by ID",
  Array.from(index.entries()).sort(([a, _a], [b, _b]) => a - b).map((
    [index, item],
  ) => `${index}. ${item}`).join("\n"),
]);

const TierTypes = new Set<ItemType>([
  ItemType.Axe,
  ItemType.Pickaxe,
  ItemType.Shovel,
]);

function createPage(item: Item) {
  let lines = [];
  lines.push(
    `###### ![${item.id}](Assets/Texture2D/${images.get(item.sprite)})`,
  );
  lines.push(`## ${item.name}`);
  lines.push(`*${item.description}*`);

  lines.push(`- Type: ${ItemType[item.type]}`);
  if (TierTypes.has(item.type)) lines.push(`- Tier: ${ToolTier[item.tier]}`);
  if (item.tag !== ItemTag.None) lines.push(`- Tag: ${ItemTag[item.tag]}`);
  lines.push(`- Rarity: ${ItemRarity[item.rarity]}`);

  if (!item.stackable) lines.push("- Stackable: No");
  else if (item.max === 69) lines.push("- Stackable: Yes");
  else lines.push(`- Stackable: ${item.max}`);

  if (!item.craftable) lines.push("- Craftable: No");
  else lines.push(`- Crafting Amount: ${item.craftAmount}`);

  if (item.buildable) lines.push("- Buildable: Yes");
  else lines.push("- Buildable: No");

  if (!item.processable) lines.push("- Processable: No");
  else {
    lines.push(`- Processing Time: ${item.processTime}`);
    const processResult = items.get(item.processedItem!)!;
    lines.push(
      `- Processing Result: [${processResult.name}](#${processResult.id})`,
    );
  }

  if (item.fuel == null) lines.push("- Fuel: No");
  else {
    lines.push(`- Fuel: ${fuels.get(item.fuel)?.maxUses} items`);
    lines.push(`- Fuel Speed: ${fuels.get(item.fuel)?.speedMultiplier}x`);
  }

  if (item.craftable) {
    lines.push("#### Crafting Recipe");
    for (const requirement of item.requirements) {
      lines.push(
        `- ${requirement.amount} [${items.get(requirement.item)!.name}](#${
          items.get(requirement.item)!.id
        })`,
      );
    }
  }

  if (item.tag === ItemTag.Food) {
    lines.push("#### Food Stats");
    lines.push(`- Health: ${item.heal}`);
    lines.push(`- Hunger: ${item.hunger}`);
    lines.push(`- Stamina: ${item.stamina}`);
  } else {
    lines.push("#### Weapon Stats");
    lines.push(`- Resource Damage:${item.resourceDamage}`);
    lines.push(`- Attack Damage:${item.attackDamage}`);
    lines.push(`- Attack Speed:${item.attackSpeed}`);
    lines.push(`- Attack Range:${item.attackRange[2]}`);
    lines.push(`- Sharpness: ${item.sharpness}`);
  }
  return lines.join("\n");
}

sections.push([
  "Items",
  Array.from(items.values()).map(createPage).join("\n\n"),
]);

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
}

const powerupFiles = await readDir("./Assets/ScriptableObject/Powerups/", true);

const powerups: string[] = [];

for (const [guid, file] of powerupFiles) {
  const powerup: Powerup = {
    id: parseNumber<Powerup>(file, "id"),
    tier: parseNumber<Powerup>(file, "tier"),
    name: parseString<Powerup>(file, "name"),
    description: parseString<Powerup>(file, "description"),
    sprite: parseGuid<Powerup>(file, "sprite")!,
  };

  const lines: string[] = [];
  lines.push(
    `###### ![${powerup.name}](Assets/Texture2D/${
      images.get(powerup.sprite)
    })`,
  );
  lines.push(`## ${powerup.name}`);
  lines.push(`*${powerup.description}*`);
  powerups.push(lines.join("\n"));
}
sections.push(["Powerups", powerups.join("\n\n")]);

let tableOfContents = "# Table of Contents";
for (const [header] of sections) {
  tableOfContents += `\n- [${header}](#${
    header.replace(/\s/g, "-")
  })`;
}
tableOfContents += "\n\n";

await Deno.writeFile(
  "./Data.md",
  new TextEncoder().encode(
    tableOfContents +
      sections.map(([header, content]) => `# ${header}\n${content}`).join(
        "\n\n",
      ),
  ),
);
