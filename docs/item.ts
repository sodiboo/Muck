import {
    GameAfterLobby,
    images,
    io,
    link,
    Menu,
    parse,
    prefabs,
    references,
    scripts,
} from "./common.ts";

export enum ItemType {
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

export enum ToolTier {
    None,
    Wood,
    Steel,
    Mithril,
    Adamantite,
    Milk,
}

export enum ItemTag {
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
    Gem,
}

export enum ItemRarity {
    Common,
    Uncommon,
    Rare,
}

export enum ProcessType {
    Smelt,
    Cook,
    None,
}

export interface ItemAndAmount {
    item: string;
    amount: number;
}

export enum RecipeType {
    Crafting,
    Cauldron,
    Furnace,
}

export type Recipe = { result: string } & (
    | CraftingRecipe
    | CauldronRecipe
    | FurnaceRecipe
);

export interface CraftingRecipe {
    type: RecipeType.Crafting;
    ingredients: ItemAndAmount[];
    station: number;
    amount: number;
}

const CraftingStations = [
    "Handcrafting",
    link("Workbench"),
    link("Anvil"),
    link("Fletching Table"),
];

export interface CauldronRecipe {
    type: RecipeType.Cauldron;
    ingredients: ItemAndAmount[];
    amount: number;
    time: number;
}

export interface FurnaceRecipe {
    type: RecipeType.Furnace;
    ingredient: string;
    time: number;
}

import { Fuel, fuels } from "./fuel.ts";
import { Bow, bows } from "./bow.ts";
import { Armor, armors } from "./armor.ts";

export interface Item {
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

    attackRange: number;
    resourceDamage: number;
    attackDamage: number;
    attackSpeed: number;
    sharpness: number;

    heal: number;
    hunger: number;
    stamina: number;
    armor: number;

    armorSet: Armor | null;
    bow: Bow | null;
    fuel: Fuel | null;

    recipes: Recipe[];
    ingredientFor: { result: string; recipe: number }[];

    _extras: ExtraItemData;
}

interface ExtraItemData {
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

interface _ {
    armorComponent: string | null;
    bowComponent: string | null;
    fuel: string | null;
}

export const items = new Map<string, Item>();
for (const [guid, file] of await io.ScriptableObjects("Items")) {
    const extras: ExtraItemData = {
        craftable: parse.bool<ExtraItemData>(file, "craftable"),
        craftAmount: parse.number<ExtraItemData>(file, "craftAmount"),
        unlockWithFirstRequirementOnly: parse.bool<ExtraItemData>(
            file,
            "unlockWithFirstRequirementOnly"
        ),
        requirements: parse.array<ExtraItemData, ItemAndAmount>(
            file,
            "requirements",
            (requirement) => {
                const data: ItemAndAmount = {
                    item: parse.guid<ItemAndAmount>(requirement, "item")!,
                    amount: parse.number<ItemAndAmount>(requirement, "amount"),
                };
                return data;
            }
        ),
        stationRequirement: parse.guid<ExtraItemData>(
            file,
            "stationRequirement"
        ),

        processable: parse.bool<ExtraItemData>(file, "processable"),
        processType: parse.number<ExtraItemData>(file, "processType"),
        processTime: parse.number<ExtraItemData>(file, "processTime"),
        processedItem: parse.guid<ExtraItemData>(file, "processedItem"),
    };
    const item: Item = {
        id: parse.number<Item>(file, "id"),
        sprite: parse.guid<Item>(file, "sprite")!,
        name: parse.string<Item>(file, "name"),
        description: parse.string<Item>(file, "description"),

        type: parse.number<Item>(file, "type"),
        tier: parse.number<Item>(file, "tier"),
        tag: parse.number<Item>(file, "tag"),
        rarity: parse.number<Item>(file, "rarity"),

        buildable: parse.bool<Item>(file, "buildable"),
        stackable: parse.bool<Item>(file, "stackable"),
        prefab: parse.guid<Item>(file, "prefab"),
        max: parse.number<Item>(file, "max"),

        attackRange: parse.number<Item>(file, "attackRange"),
        resourceDamage: parse.number<Item>(file, "resourceDamage"),
        attackDamage: parse.number<Item>(file, "attackDamage"),
        attackSpeed: parse.number<Item>(file, "attackSpeed"),
        sharpness: parse.number<Item>(file, "sharpness"),

        heal: parse.number<Item>(file, "heal"),
        hunger: parse.number<Item>(file, "hunger"),
        stamina: parse.number<Item>(file, "stamina"),
        armor: parse.number<Item>(file, "armor"),
        armorSet: null,
        bow: null,
        fuel: null,

        ingredientFor: [],
        recipes: [],

        _extras: extras,
    };
    const armor = parse.guid<_>(file, "armorComponent");
    const bow = parse.guid<_>(file, "bowComponent");
    const fuel = parse.guid<_>(file, "fuel");
    if (armor !== null) {
        item.armorSet = armors.get(armor) ?? null;
        if (item.armorSet !== null) {
            switch (item.tag) {
                case ItemTag.Helmet:
                    item.armorSet.helmet = item.name;
                    break;
                case ItemTag.Torso:
                    item.armorSet.torso = item.name;
                    break;
                case ItemTag.Legs:
                    item.armorSet.legs = item.name;
                    break;
                case ItemTag.Feet:
                    item.armorSet.feet = item.name;
                    break;
            }
        }
    }
    if (bow !== null) item.bow = bows.get(bow)!;
    if (fuel !== null) item.fuel = fuels.get(fuel)!;
    items.set(guid, item);
}

const allRecipes: Recipe[] = [];
const cauldronResults = new Set(
    parse.array<{ processableFood: string[] }, string>(
        GameAfterLobby.scripts.get(scripts.CauldronUI)![0],
        "processableFood",
        (raw) => raw.match(/guid: (?<guid>[a-f0-9]+)[,}]/)!.groups!.guid
    )
);
function parseCrafting(id: number) {
    return parse
        .array<{ tabs: string[][] }, string[]>(
            GameAfterLobby.components.get(id)!,
            "tabs",
            (tab) =>
                parse.array<{ items: string[] }, string>(
                    tab,
                    "items",
                    (item) =>
                        item.match(/guid: (?<guid>[a-f0-9]+)[,}]/)!.groups!.guid
                )
        )
        .flat();
}
const otherinput = GameAfterLobby.scripts.get(scripts.OtherInput)![0];
interface OtherInput {
    handcrafts: number;
    workbench: number;
    anvil: number;
    fletch: number;
}
const handcrafts = parseCrafting(
    parse.fileID<OtherInput>(otherinput, "handcrafts")
);
const workbench = parseCrafting(
    parse.fileID<OtherInput>(otherinput, "workbench")
);
const anvil = parseCrafting(parse.fileID<OtherInput>(otherinput, "anvil"));
const fletch = parseCrafting(parse.fileID<OtherInput>(otherinput, "fletch"));
const allCrafting = new Set([handcrafts, workbench, anvil, fletch].flat());
const itemList = parse.array<{ allScriptableItems: string[] }, string>(
    Menu.scripts.get(scripts.ItemManager)![0], // why is there an empty item manager
    "allScriptableItems",
    (item) => item.match(/guid: (?<guid>[a-f0-9]+)[,}]/)!.groups!.guid
);
for (let i = 0; i < itemList.length; i++) {
    const guid = itemList[i];
    const item = items.get(guid)!;
    item.id = i; // this shouldn't be necessary since i manually saved everything after running once, but just in case, this will make sure it works even without doing that after a future decompile
    const extras = item._extras;
    if (extras.processable && extras.processType == ProcessType.Smelt) {
        const result = items.get(extras.processedItem!)!;
        item.ingredientFor.push({
            result: extras.processedItem!,
            recipe: result.recipes.length,
        });
        const recipe: Recipe = {
            result: result.name,
            type: RecipeType.Furnace,
            ingredient: guid,
            time: extras.processTime,
        };
        result.recipes.push(recipe);
        allRecipes.push(recipe);
    }
    if (allCrafting.has(guid)) {
        for (const { item: ingredient } of extras.requirements) {
            items.get(ingredient)!.ingredientFor.push({
                result: guid,
                recipe: item.recipes.length,
            });
        }
        const recipe: Recipe = {
            result: item.name,
            station: [handcrafts, workbench, anvil, fletch].findIndex(
                (station) => station.includes(guid)
            )!,
            type: RecipeType.Crafting,
            ingredients: extras.requirements,
            amount: extras.craftAmount,
        };
        item.recipes.push(recipe);
        allRecipes.push(recipe);
    }
    if (cauldronResults.has(guid)) {
        // holy fuck this is a disgusting mix of data fields, and cauldrons ignore the ProcessType, Cauldron behaves identically to None! Cauldrons just have a hardcoded list of items, which use the type recipe but are marked non-fucking-craftable! What the hell is this, Dani?
        for (const { item: ingredient } of extras.requirements) {
            items.get(ingredient)!.ingredientFor.push({
                result: guid,
                recipe: item.recipes.length,
            });
        }
        const recipe: Recipe = {
            result: item.name,
            type: RecipeType.Cauldron,
            ingredients: extras.requirements,
            amount: extras.craftAmount,
            time: extras.processTime,
        };
        item.recipes.push(recipe);
        allRecipes.push(recipe);
    }
}

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

function info(item: Item): string {
    const lines = [];
    lines.push(
        `### ${item.name}`,
        `*${item.description}*`,
        "",
        `![item-${item.id}]`
    );

    lines.push(`- Type: ${ItemType[item.type]}`);
    if (TierTypes.has(item.type)) lines.push(`- Tier: ${ToolTier[item.tier]}`);
    if (item.tag !== ItemTag.None) lines.push(`- Tag: ${ItemTag[item.tag]}`);
    lines.push(`- Rarity: ${ItemRarity[item.rarity]}`);

    if (!item.stackable) lines.push("- Stackable: No");
    else if (item.max === 69) lines.push("- Stackable: Yes");
    else lines.push(`- Stackable: ${item.max}`);

    if (item.buildable) lines.push("- Buildable");

    if (item.fuel !== null) {
        lines.push(
            `- Fuel: ${item.fuel.maxUses} items`,
            `- Fuel Speed: ${item.fuel.speedMultiplier}x`
        );
    }

    if (ArmorTags.has(item.tag)) {
        lines.push(
            `- +${item.armor} armor`,
            `- Armor Set: ${
                item.armorSet === null
                    ? "None"
                    : `${link(
                          `${item.armorSet.helmet.split(" ")[0]} Armor`
                      )} (${item.armorSet.setBonus})`
            }`
        );
    }
    if (
        item.tag == ItemTag.Arrow &&
        prefabs.get(item.prefab!)!.scripts.has(scripts.EnemyProjectile)
    ) {
        lines.push("- Enemy Projectile");
    }

    if (item.tag === ItemTag.Food) {
        lines.push(
            "#### Food",
            `- Health: ${item.heal}`,
            `- Hunger: ${item.hunger}`,
            `- Stamina: ${item.stamina}`
        );
    }

    if (item.bow !== null) {
        lines.push(
            "#### Bow",
            `- Projectile Speed: ${item.bow.projectileSpeed}`,
            `- Arrows per shot: ${item.bow.nArrows}`
        );
        if (item.bow.nArrows > 1) {
            lines.push(`${lines.pop()} (${item.bow.angleDelta} degrees apart)`);
        }
    } else {
        lines.push(
            "#### Weapon",
            `- Resource Damage: ${item.resourceDamage}`,
            `- Attack Damage: ${item.attackDamage}`,
            `- Attack Speed: ${item.attackSpeed}`,
            `- DPS: ${item.attackDamage * item.attackSpeed}`,
            `- Attack Range: ${item.attackRange}`,
            `- Sharpness: ${item.sharpness}`
        );
    }
    if (item.recipes.length) {
        for (const recipe of item.recipes) {
            switch (recipe.type) {
                case RecipeType.Crafting:
                    lines.push(
                        `#### Crafting: Gives ${recipe.amount} ${item.name}`
                    );
                    for (const ingredient of recipe.ingredients) {
                        lines.push(
                            `- ${ingredient.amount} ${link(
                                items.get(ingredient.item)!.name
                            )}`
                        );
                    }
                    break;
                case RecipeType.Furnace:
                    lines.push(
                        `#### Smelting: Gives 1 ${item.name}`,
                        `- Takes ${recipe.time} seconds`,
                        `- Made in Furnace`,
                        `- Needs 1 ${link(items.get(recipe.ingredient)!.name)}`
                    );
                    break;
                case RecipeType.Cauldron:
                    lines.push(
                        `#### Cooking: Gives 1 ${item.name}`,
                        `- Takes ${recipe.time} seconds`,
                        `- Made in Cauldron`,
                        ...recipe.ingredients.map(
                            ({ item: ingredient, amount }) =>
                                `- Needs ${amount} ${link(
                                    items.get(ingredient)!.name
                                )}`
                        )
                    );
                    break;
            }
        }
    }
    if (item.ingredientFor.length) {
        lines.push("#### Ingredient For:");
        lines.push(
            ...item.ingredientFor.map(
                (ingredient) => `- ${link(items.get(ingredient.result)!.name)}`
            )
        );
    }
    return lines.join("\n");
}

export const sections: [string, string][] = [];

sections.push([
    "Items by ID",
    itemList
        .map((item, i) => `${i}. ${link(items.get(item)!.name)}`)
        .join("\n"),
]);

for (const item of itemList
    .map((guid) => items.get(guid)!)
    .sort((a, b) => a.id - b.id)) {
    references.push(
        `[item-${
            item.id
        }]: https://raw.githubusercontent.com/Terrain2/Muck/main/Assets/Texture2D/${encodeURIComponent(
            images.get(item.sprite)!
        )}`
    );
}

sections.push([
    "Items by name",
    itemList
        .map((guid) => items.get(guid)!)
        .sort((a, b) => a.name.localeCompare(b.name))
        .map((item) => `- ${link(item.name)}`)
        .join("\n"),
]);

sections.push([
    "Items",
    itemList
        .map((guid) => items.get(guid)!)
        .sort((a, b) => a.rarity - b.rarity || a.name.localeCompare(b.name))
        .map(info)
        .join("\n\n---\n\n"),
]);
const craftingRecipes: string[][] = [[], [], [], []];
const cauldronRecipes: string[] = [];
const furnaceRecipes: string[] = [];

for (const recipe of allRecipes) {
    switch (recipe.type) {
        case RecipeType.Crafting:
            craftingRecipes[recipe.station].push(
                `- ${recipe.ingredients
                    .map(
                        ({ item, amount }) =>
                            `${amount} ${link(items.get(item)!.name)}`
                    )
                    .join(" + ")} => ${recipe.amount} ${link(recipe.result)}`
            );
            break;
        case RecipeType.Cauldron:
            cauldronRecipes.push(
                `- ${recipe.ingredients
                    .map(
                        ({ item, amount }) =>
                            `${amount} ${link(items.get(item)!.name)}`
                    )
                    .join(" + ")} => ${link(recipe.result)} (${recipe.time}s)`
            );
            break;
        case RecipeType.Furnace:
            furnaceRecipes.push(
                `- ${link(items.get(recipe.ingredient)!.name)} => ${link(
                    recipe.result
                )} (${recipe.time}s)`
            );
            break;
    }
}

sections.push([
    "Recipes",
    `${craftingRecipes
        .map(
            (recipes, i) =>
                `### ${CraftingStations[i]} Recipes
${recipes.join("\n")}`
        )
        .join("\n---\n")}
---
### ${link("Cauldron")} Recipes
${cauldronRecipes.join("\n")}
---
### ${link("Furnace")} Recipes
${furnaceRecipes.join("\n")}`,
]);
