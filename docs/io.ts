export function ScriptableObjects(
  dir: string,
): Promise<[string, string, string][]> {
  return directory(`Assets/ScriptableObject/${dir}/`);
}

export async function meta(file: string): Promise<string> {
  const content = await Deno.readTextFile(file + ".meta");
  const guid = content.match(/^guid: (?<value>[a-f0-9]+)$/m)!.groups!.value;
  return guid;
}

export async function directory(
  dir: string,
  contents?: true,
): Promise<[string, string, string][]>;
export async function directory(
  dir: string,
  contents: false,
): Promise<[string, string][]>;
export async function directory(
  dir: string,
  contents = true,
): Promise<[string, string, string?][]> {
  dir = `../${dir}`;
  const result: [string, string, string?][] = [];
  for await (const file of Deno.readDir(dir)) {
    if (!file.name.endsWith(".meta")) {
      if (contents) {
        result.push([
          await meta(dir + file.name),
          await Deno.readTextFile(dir + file.name),
          file.name,
        ]);
      } else {
        result.push([
          await meta(dir + file.name),
          file.name,
        ]);
      }
    }
  }
  return result;
}
