export function ScriptableObjects(dir: string): Promise<Map<string, string>> {
  return directory(`Assets/ScriptableObject/${dir}/`);
}

export async function meta(file: string): Promise<string> {
  const content = await Deno.readTextFile(file + ".meta");
  const guid = content.match(/^guid: (?<value>[a-f0-9]+)$/m)!.groups!.value;
  return guid;
}

export async function directory(
  dir: string,
  contents = true,
): Promise<Map<string, string>> {
  dir = `../${dir}`;
  const result = new Map<string, string>();
  for await (const file of Deno.readDir(dir)) {
    if (!file.name.endsWith(".meta")) {
      result.set(
        await meta(dir + file.name),
        contents ? await Deno.readTextFile(dir + file.name) : file.name,
      );
    }
  }
  return result;
}
