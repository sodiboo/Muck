export type Vector3 = [number, number, number];

export function fragment(name: string): string {
  return name.replace(/\s/g, "-").toLowerCase();
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
export * from "./data.ts";
export * from "./prefabs.ts";
export * from "./images.ts";
