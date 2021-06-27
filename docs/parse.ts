import { Vector3 } from "./common.ts";

type Properties<T, O> = Exclude<
  keyof {
    [Property in keyof O as O[Property] extends T ? Property : never]: T;
  },
  number | symbol
>;

export function raw(file: string, key: string): string {
  return file.match(new RegExp(`^ {2}${key}: (?<value>.*)$`, "m"))?.groups
    ?.value ?? "";
}

export function string<O>(
  file: string,
  key: Properties<string, O>,
): string {
  return raw(file, key);
}

export function guid<O>(
  file: string,
  key: Properties<string | null, O>,
): string | null {
  return raw(file, key).match(/guid: (?<guid>[a-f0-9]+)[,}]/)?.groups
    ?.guid ?? null;
}
export function fileID<O>(file: string, key: Properties<number, O>): number {
  return +raw(file, key).match(/^{fileID: (?<id>-?[0-9]+)}$/)!.groups!.id;
}

export function number<O>(
  file: string,
  key: Properties<number, O>,
): number {
  return +raw(file, key);
}

export function bool<O>(
  file: string,
  key: Properties<boolean, O>,
): boolean {
  return raw(file, key) == "1";
}

export function array<O, T>(
  file: string,
  key: Properties<T[], O>,
  converter: (file: string) => T,
): T[] {
  const lines = file.split(/\r?\n/g);
  let i = lines.indexOf(`  ${key}:`);
  let match = null;
  const entries: string[] = [];
  while (
    (match = /^ {2}- (?<line>.*)$/m.exec(lines[++i])) !==
      null
  ) {
    let entry = `  ${match.groups!.line}`;
    while ((match = /^ {2}(?<line> {2}.*)$/m.exec(lines[i + 1])) !== null) {
      entry += "\n" + match.groups!.line;
      ++i;
    }
    entries.push(entry);
  }
  return entries.map(converter);
}

export function vector3<O>(
  file: string,
  key: Properties<Vector3, O>,
): Vector3 {
  const { x, y, z } = raw(file, key).match(
    /^\{x: (?<x>[\d\.]+), y: (?<y>[\d\.]+), z: (?<z>[\d\.]+)\}/,
  )!.groups!;
  return [+x, +y, +z];
}

export function split(file: string): [number, string][] {
  const components = file.split(/^--- !u!\d+ &(?=-?\d+$)/gm).map<
    [number, string]
  >(
    (component) => {
      const newline = component.indexOf("\n");
      return [
        +component.substring(0, newline),
        component.substring(newline + 1),
      ];
    },
  );
  if (Number.isNaN(components[0][0])) components.shift();
  return components;
}
