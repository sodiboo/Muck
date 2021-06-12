const sections: [string, string][] = [];
const references: string[] = [];
const powerupFiles = await readDir("./Assets/ScriptableObject/Powerups/");
const itemFiles = await readDir("./Assets/ScriptableObject/Items/");
const fuelFiles = await readDir("./Assets/ScriptableObject/Fuel/");
const prefabs = await readDir("./Assets/PrefabInstance/");
const EnemyProjeticle = await readMeta(
  "./Assets/Scripts/Assembly-CSharp/EnemyProjectile.cs",
);
const images = await readDir("./Assets/Texture2D/", false);

async function readMeta(file: string): Promise<string> {
  const content = await Deno.readTextFile(file + ".meta");
  const guid = content.match(/^guid: (?<value>[a-f0-9]+)$/m)!.groups!.value;
  return guid;
}

async function readDir(
  dir: string,
  contents = true,
): Promise<Map<string, string>> {
  const result = new Map<string, string>();
  for await (const file of Deno.readDir(dir)) {
    if (!file.name.endsWith(".meta")) {
      result.set(
        await readMeta(dir + file.name),
        contents ? await Deno.readTextFile(dir + file.name) : file.name,
      );
    }
  }
  return result;
}

function fragment(name: string): string {
  return name.replace(/\s/g, "-");
}

function link(name: string): string {
  return `[${name}](#${fragment(name)})`;
}

function CumulativeDistribution(
  count: number,
  speed: number,
  max: number,
): number {
  return (1 - Math.exp(-count * speed)) * max;
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

interface ItemAndAmount {
  item: string;
  amount: number;
}

enum RecipeType {
  Crafting,
  Cauldron,
  Furnace,
}

type Recipe =
  & { result: string }
  & (CraftingRecipe | CauldronRecipe | FurnaceRecipe);

interface CraftingRecipe {
  type: RecipeType.Crafting;
  ingredients: ItemAndAmount[];
  amount: number;
}

interface CauldronRecipe {
  type: RecipeType.Cauldron;
  ingredients: ItemAndAmount[];
  amount: number;
  time: number;
}

interface FurnaceRecipe {
  type: RecipeType.Furnace;
  ingredient: string;
  time: number;
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

  buildable: boolean;
  prefab: string | null;

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

  recipes: Recipe[];
  ingredientFor: { result: string; recipe: number }[];

  // raw type stuff (will be refined as others)
  craftable: boolean;
  craftAmount: number;
  unlockWithFirstRequirementOnly: boolean;
  requirements: ItemAndAmount[];
  stationRequirement: string | null;

  processable: boolean;
  processType: ProcessType;
  processTime: number;
  processedItem: string | null;
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
let cauldron = "";
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
    prefab: parseGuid<Item>(file, "prefab"),

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

    recipes: [],
    ingredientFor: [],
  };
  if (item.name == "Cauldron") cauldron = guid;
  const lines = file.split(/\r?\n/g);
  let i = lines.indexOf("  requirements:");
  let match = null;
  while (
    (match = /^ {2}- item: .*guid: (?<guid>[a-f0-9]+)[,}]/.exec(lines[++i])) !==
      null
  ) {
    item.requirements.push({
      item: match.groups!.guid,
      amount: +/^ {4}amount: (?<amount>[0-9]+)$/.exec(lines[++i])!.groups!
        .amount,
    });
  }
  items.set(guid, item);
}

const allRecipes: Recipe[] = [];
const cauldronResults = new Set<number>([31, 32, 33, 34, 69]);
for (const [guid, item] of items) {
  if (item.processable && item.processType == ProcessType.Smelt) {
    const result = items.get(item.processedItem!)!;
    item.ingredientFor.push({
      result: item.processedItem!,
      recipe: result.recipes.length,
    });
    const recipe: Recipe = {
      result: result.name,
      type: RecipeType.Furnace,
      ingredient: guid,
      time: item.processTime,
    };
    result.recipes.push(recipe);
    allRecipes.push(recipe);
  }
  if (item.craftable && item.stationRequirement !== cauldron) {
    for (const { item: ingredient } of item.requirements) {
      items.get(ingredient)!.ingredientFor.push({
        result: guid,
        recipe: item.recipes.length,
      });
    }
    const recipe: Recipe = {
      result: item.name,
      type: RecipeType.Crafting,
      ingredients: item.requirements,
      amount: item.craftAmount,
    };
    item.recipes.push(recipe);
    allRecipes.push(recipe);
  }
  if (cauldronResults.has(item.id)) {
    // holy fuck this is a disgusting mix of data fields, and cauldrons ignore the ProcessType, Cauldron behaves identically to None! Cauldrons just have a hardcoded list of items, which use the type recipe but are marked non-fucking-craftable! What the hell is this, Dani?
    for (const { item: ingredient } of item.requirements) {
      items.get(ingredient)!.ingredientFor.push({
        result: guid,
        recipe: item.recipes.length,
      });
    }
    const recipe: Recipe = {
      result: item.name,
      type: RecipeType.Cauldron,
      ingredients: item.requirements,
      amount: item.craftAmount,
      time: item.processTime,
    };
    item.recipes.push(recipe);
    allRecipes.push(recipe);
  }
}

const index = new Map<number, string>();
for (const [, item] of items) {
  index.set(item.id, link(item.name));
}
index.set(100, index.get(101)!);

sections.push([
  "Items by ID",
  Array.from(index.entries()).sort(([a, _a], [b, _b]) => a - b).map((
    [index, item],
  ) => `${index}. ${item}`).join("\n"),
]);

for (const item of Array.from(items.values()).sort((a, b) => a.id - b.id)) {
  references.push(
    `[item-${item.id}]: Assets/Texture2D/${
      encodeURIComponent(images.get(item.sprite)!)
    }`,
  );
}

sections.push([
  "Items by name",
  Array.from(items.values()).sort((a, b) => a.name.localeCompare(b.name)).map(
    (item) => `- ${link(item.name)}`,
  ).join("\n"),
]);

const TierTypes = new Set<ItemType>([
  ItemType.Axe,
  ItemType.Pickaxe,
  ItemType.Shovel,
]);

const ArmorTags = new Set<ItemTag>([
  ItemTag.Helmet,
  ItemTag.Torso,
  ItemTag.Legs,
  ItemTag.Feet,
]);

function createPage(item: Item) {
  const lines = [];
  lines.push(
    `### ${item.name}`,
    `*${item.description}*`,
    "",
    `![item-${item.id}]`,
  );

  lines.push(`- Type: ${ItemType[item.type]}`);
  if (TierTypes.has(item.type)) lines.push(`- Tier: ${ToolTier[item.tier]}`);
  if (item.tag !== ItemTag.None) lines.push(`- Tag: ${ItemTag[item.tag]}`);
  lines.push(`- Rarity: ${ItemRarity[item.rarity]}`);

  if (!item.stackable) lines.push("- Stackable: No");
  else if (item.max === 69) lines.push("- Stackable: Yes");
  else lines.push(`- Stackable: ${item.max}`);

  if (item.buildable) lines.push("- Buildable: Yes");
  else lines.push("- Buildable: No");

  if (item.fuel == null) lines.push("- Fuel: No");
  else {
    lines.push(
      `- Fuel: ${fuels.get(item.fuel)?.maxUses} items`,
      `- Fuel Speed: ${fuels.get(item.fuel)?.speedMultiplier}x`,
    );
  }

  if (item.recipes.length) {
    lines.push("<details>", "<summary> Recipes </summary>", "");
    for (const recipe of item.recipes) {
      switch (recipe.type) {
        case RecipeType.Crafting:
          lines.push(
            `#### Crafting: ${recipe.amount} ${item.name}`,
          );
          for (const requirement of item.requirements) {
            lines.push(
              `- ${requirement.amount} ${
                link(items.get(requirement.item)!.name)
              }`,
            );
          }
          break;
        case RecipeType.Furnace:
          lines.push(
            `#### Smelting: ${item.name}`,
            `- Takes ${recipe.time} seconds`,
            `- Made in Furnace`,
            `- Needs 1 ${link(items.get(recipe.ingredient)!.name)}`,
          );
          break;
        case RecipeType.Cauldron:
          lines.push(
            `#### Smelting: ${item.name}`,
            `- Takes ${recipe.time} seconds`,
            `- Made in Cauldron`,
            ...recipe.ingredients.map(({ item: ingredient, amount }) =>
              `- Needs ${amount} ${link(items.get(ingredient)!.name)}`
            ),
          );
          break;
      }
    }
    lines.push("", "</details>", "");
  }

  const misc: string[] = [];
  if (item.tag === ItemTag.Food) {
    lines.push(
      "#### Food Stats",
      `- Health: ${item.heal}`,
      `- Hunger: ${item.hunger}`,
      `- Stamina: ${item.stamina}`,
    );
  } else if (ArmorTags.has(item.tag)) {
    misc.push(`- +${item.armor} armor`);
  }

  if (item.type === ItemType.Bow) {
    misc.push(`- Projectile Speed: ${item.projectileSpeed}`);
  } else {
    lines.push(
      "#### Weapon Stats",
      `- Resource Damage: ${item.resourceDamage}`,
      `- Attack Damage: ${item.attackDamage}`,
      `- Attack Speed: ${item.attackSpeed}`,
      `- Attack Range: ${item.attackRange[2]}`,
      `- Sharpness: ${item.sharpness}`,
    );
    if (
      item.tag == ItemTag.Arrow &&
      prefabs.get(item.prefab!)!.includes(EnemyProjeticle)
    ) {
      misc.push("- Enemy Projectile");
    }
  }
  if (misc.length) lines.push("#### Misc", ...misc);
  return lines.join("\n");
}

sections.push([
  "Items",
  Array.from(items.values()).sort((a, b) =>
    a.rarity - b.rarity || a.name.localeCompare(b.name)
  ).map(
    createPage,
  ).join("\n\n---\n\n"),
]);

const craftingRecipes: string[] = [];
const cauldronRecipes: string[] = [];
const furnaceRecipes: string[] = [];

for (const recipe of allRecipes) {
  switch (recipe.type) {
    case RecipeType.Crafting:
      craftingRecipes.push(
        `- ${
          recipe.ingredients.map(({ item, amount }) =>
            `${amount} ${link(items.get(item)!.name)}`
          ).join(" + ")
        } => ${recipe.amount} ${link(recipe.result)}`,
      );
      break;
    case RecipeType.Cauldron:
      cauldronRecipes.push(
        `- ${
          recipe.ingredients.map(({ item, amount }) =>
            `${amount} ${link(items.get(item)!.name)}`
          ).join(" + ")
        } => ${link(recipe.result)} (${recipe.time}s)`,
      );
      break;
    case RecipeType.Furnace:
      furnaceRecipes.push(
        `- ${link(items.get(recipe.ingredient)!.name)} => ${
          link(recipe.result)
        } (${recipe.time}s)`,
      );
      break;
  }
}

sections.push([
  "Recipes",
  `### Crafting Recipes
${craftingRecipes.join("\n")}
---
### Cauldron Recipes
${cauldronRecipes.join("\n")}
---
### Furnace Recipes
${furnaceRecipes.join("\n")}`,
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
  article: string;
}

const powerups: Powerup[] = [];

for (const [, file] of powerupFiles) {
  const powerup: Powerup = {
    id: parseNumber<Powerup>(file, "id"),
    tier: parseNumber<Powerup>(file, "tier"),
    name: parseString<Powerup>(file, "name"),
    description: parseString<Powerup>(file, "description"),
    sprite: parseGuid<Powerup>(file, "sprite")!,
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

function createPowerupPage(powerup: Powerup): string {
  const lines: string[] = [];
  lines.push(
    `### ${powerup.name}`,
    `*${powerup.description}*`,
    `###### ![${fragment(powerup.name)}](Assets/Texture2D/${
      encodeURIComponent(images.get(powerup.sprite)!)
    })`,
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
        // deno-lint-ignore no-unused-vars
        const calc = (speed: number, max: number) =>
          CumulativeDistribution(i, speed, max);
        // deno-lint-ignore no-unused-vars
        const n = (final: number, value: number, precision = 1) => {
          precision = Math.max(
            final.toString().split(".")[1]?.length ?? 0,
            precision,
          );
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

const unimplemented = new Set([
  "Enforcer",
  "Robin Hood Hat",
  "X Juice",
  "Spooo Bean",
]);
const powerupIndex: [number, string][] = [];
for (const powerup of powerups) {
  if (unimplemented.has(powerup.name)) continue;
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
      .map(
        createPowerupPage,
      ),
  ).join("\n\n---\n\n"),
]);

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
