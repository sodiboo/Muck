import { directory } from "./io.ts";
export const images = new Map(await directory("Assets/Texture2D/", false));
