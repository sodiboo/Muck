export const prefabs = new Map<string, Map<string, string>>();

import * as io from "./io.ts";
import * as parse from "./parse.ts";

interface MonoBehaviour {
  // deno-lint-ignore camelcase
  m_Script: string;
}

function componentsOf(file: string) {
  const components = new Map<string, string>();
  for (const component of parse.split(file)) {
    if (component.startsWith("MonoBehaviour")) {
      components.set(
        parse.guid<MonoBehaviour>(component, "m_Script")!,
        component,
      );
    }
  }
  return components;
}

for (const [guid, file] of await io.directory("Assets/PrefabInstance/")) {
  prefabs.set(guid, componentsOf(file));
}

export const GameAfterLobby = componentsOf(
  await Deno.readTextFile("../Assets/Scene/Scenes/GameAfterLobby.unity"),
);
