export interface UnityAsset {
  components: Map<number, string>;
  scripts: Map<string, string[]>;
}

export const prefabs = new Map<string, UnityAsset>();

import * as io from "./io.ts";
import * as parse from "./parse.ts";

interface MonoBehaviour {
  // deno-lint-ignore camelcase
  m_Script: string;
}

function componentsOf(file: string): UnityAsset {
  const components = new Map<number, string>();
  const scripts = new Map<string, string[]>();
  for (const [id, component] of parse.split(file)) {
    components.set(id, component);
    if (component.startsWith("MonoBehaviour")) {
      const guid = parse.guid<MonoBehaviour>(component, "m_Script")!;
      if (!scripts.has(guid)) scripts.set(guid, []);
      scripts.get(guid)!.push(
        component,
      );
    }
  }
  return { components, scripts };
}

for (const [guid, file] of await io.directory("Assets/PrefabInstance/")) {
  prefabs.set(guid, componentsOf(file));
}

export const GameAfterLobby = componentsOf(
  await Deno.readTextFile("../Assets/Scene/Scenes/GameAfterLobby.unity"),
);

export const Menu = componentsOf(
  await Deno.readTextFile("../Assets/Scene/Scenes/Menu.unity"),
);
