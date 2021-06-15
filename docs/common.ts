export type Vector3 = [number, number, number];

export function fragment(name: string): string {
  return name.replace(/\s/g, "-");
}

export function link(name: string): string {
  return `[${name}](#${fragment(name)})`;
}

export function CumulativeDistribution(
  count: number,
  speed: number,
  max: number,
): number {
  return (1 - Math.exp(-count * speed)) * max;
}

export * as parse from "./parse.ts";
export * as io from "./io.ts";
export * as scripts from "./scripts.ts";
export { references } from "./data.ts";
export { GameAfterLobby, prefabs } from "./prefabs.ts";
export { images } from "./images.ts";
