import { io, link, parse } from "./common.ts";
import { items } from "./item.ts";

export interface Trade {
  item: string;
  price: number;
  amount: number;
}

interface Trades {
  name: string;
  trades: Trade[];
}

export const trades = new Map<string, Trades>();

for (const [guid, file, name] of await io.ScriptableObjects("Trades")) {
  const trade: Trades = {
    name: name.replace(/\.asset$/, ""),
    trades: parse.array<Trades, Trade>(file, "trades", (entry) => ({
      item: parse.guid<Trade>(entry, "item")!,
      price: parse.number<Trade>(entry, "price"),
      amount: parse.number<Trade>(entry, "amount"),
    })),
  };
  trades.set(guid, trade);
}

const explanation = await Deno.readTextFile("./Trades.md");

export const section: () => [string, string] = () => [
  "Woodman Trades",
  "\n" + explanation + "\n\n---\n\n" +
  Array.from(trades.values()).map((trades) =>
    `### ${trades.name}\n\n${
      trades.trades.map((trade) =>
        `- ${trade.amount}x ${
          link(items.get(trade.item)!.name)
        } (buys for ${trade.price} coins, sells for ${
          Math.floor(trade.price / 2)
        } coins)`
      ).join("\n")
    }`
  ).join("\n\n---\n\n"),
];
