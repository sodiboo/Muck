using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.Assertions.Must;
using UnityEngine.UI;

public class ChatBox : MonoBehaviour
{

    string saveDir;

    public bool typing { get; set; }


    private void Awake()
    {
        ChatBox.Instance = this;
        this.HideChat();
        this.profanity = new List<string>();
        saveDir = Path.Combine(Application.persistentDataPath, "saves");
        foreach (string input in this.profanityList.text.Split(new char[]
        {
            '\n'
        }))
        {
            this.profanity.Add(ChatBox.RemoveWhitespace(input));
        }
    }


    public static string RemoveWhitespace(string input)
    {
        return new string((from c in input.ToCharArray()
                           where !char.IsWhiteSpace(c)
                           select c).ToArray<char>());
    }

    string clipboard;

    void Copy(string content)
    {
        if (clipboard == null)
        {
            GUIUtility.systemCopyBuffer = content;
            return;
        }
        clipboard += $";{content}";
    }

    public void AppendMessage(int fromUser, string message, string fromUsername)
    {
        string str = this.TrimMessage(message);
        string text = "\n";
        if (fromUser != -1)
        {
            string text2 = "<color=";
            if (fromUser == LocalClient.instance.myId)
            {
                text2 = text2 + "#" + ColorUtility.ToHtmlStringRGB(this.localPlayer) + ">";
            }
            else if (GameManager.players[fromUser].dead)
            {
                text2 = text2 + "#" + ColorUtility.ToHtmlStringRGB(this.deadPlayer) + ">";
            }
            else
            {
                text2 = text2 + "#" + ColorUtility.ToHtmlStringRGB(this.onlinePlayer) + ">";
            }
            text += text2;
        }
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus && GameManager.players[fromUser].dead && !PlayerStatus.Instance.IsPlayerDead())
        {
            return;
        }
        if (fromUser != -1 || (fromUser == -1 && fromUsername != ""))
        {
            text = text + fromUsername + ": ";
        }
        text += str;
        TextMeshProUGUI textMeshProUGUI = this.messages;
        textMeshProUGUI.text += text;
        int length = this.messages.text.Length;
        if (length > this.maxChars)
        {
            int startIndex = length - this.purgeAmount;
            this.messages.text = this.messages.text.Substring(startIndex);
        }
        this.ShowChat();
        if (!this.typing)
        {
            base.CancelInvoke(nameof(HideChat));
            base.Invoke(nameof(HideChat), 5f);
        }
    }

    List<string> messageHistory = new List<string>();
    int selectedMessage = -1;

    public new void SendMessage(string message)
    {
        this.typing = false;
        if (message == "")
        {
            ClearMessage();
            base.CancelInvoke(nameof(HideChat));
            base.Invoke(nameof(HideChat), 5f);
            return;
        }
        if (message != "") messageHistory.Insert(0, message);
        if (message[0] == '/')
        {
            this.ChatCommand(message);
            return;
        }
        message = this.TrimMessage(message);
        foreach (string pattern in this.profanity)
        {
            message = Regex.Replace(message, pattern, "muck");
        }
        this.AppendMessage(0, message, GameManager.players[LocalClient.instance.myId].username);
        ClientSend.SendChatMessage(message);
        this.ClearMessage();
    }


    private void ClearMessage()
    {
        this.inputField.text = "";
        this.inputField.interactable = false;
    }


    private void ChatCommand(string message)
    {
        string command = message.Substring(1);
        this.ClearMessage();
        base.CancelInvoke(nameof(HideChat));
        base.Invoke(nameof(HideChat), 5f);
        string color = "#" + ColorUtility.ToHtmlStringRGB(this.console);
        if (command == "seed")
        {
            int seed = GameManager.gameSettings.Seed;
            this.AppendMessage(-1, string.Concat(new object[]
            {
                "<color=",
                color,
                ">Seed: ",
                seed,
                " (copied to clipboard)<color=white>"
            }), "");
            Copy(string.Concat(seed));
        }
        else if (command == "ping")
        {
            this.AppendMessage(-1, "<color=" + color + ">pong<color=white>", "");
        }
        else if (command == "debug")
        {
            DebugNet.Instance.ToggleConsole();
        }
        else if (command == "kill")
        {
            PlayerStatus.Instance.Damage(0, true);
        }
        else if (command.StartsWith("save "))
        {
            command = command.Substring(5);
            if (command == "") return;
            if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
            var path = Path.Combine(saveDir, command);
            using (var file = File.Open(path, FileMode.OpenOrCreate))
            {
                file.SetLength(0);
                using (var writer = new BinaryWriter(file))
                {
                    SaveData.Instance.ToBinary(writer);
                }
            }
            AppendMessage(-1, $"<color=green>Successfully saved the game<color=white>", "");
        }
        else if (command.StartsWith("asciisave "))
        {
            command = command.Substring(10);
            if (command == "") return;
            if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
            var path = Path.Combine(saveDir, command);
            using (var file = File.Open(path, FileMode.OpenOrCreate))
            {
                file.SetLength(0);
                using (var writer = new StreamWriter(file))
                {
                    SaveData.Instance.ToASCII(writer);
                }
            }
            AppendMessage(-1, $"<color=green>Successfully saved the game<color=white>", "");
        }
        else if (command.StartsWith("load"))
        {
            if (!LocalClient.serverOwner)
            {
                AppendMessage(-1, $"<color={color}>Only the server host can load saves<color=white>", "");
                return;
            }

            if (SaveData.Instance.save.Count != 0)
            {
                AppendMessage(-1, $"<color={color}>Cannot load a save after the world has been modified<color=white>", "");
                return;
            }
            command = command.Substring(4);
            int offset;
            switch (command[0])
            {
                case ' ':
                    command = command.Substring(1);
                    offset = 0;
                    break;
                case '+':
                case '-':
                    offset = int.Parse(command.Substring(0, command.IndexOf(' ') + 1));
                    command = command.Substring(command.IndexOf(' ') + 1);
                    break;
                default:
                    return;
            }
            if (command == "") return;
            var path = Path.Combine(Application.persistentDataPath, "saves", command);
            try
            {
                using (var file = File.Open(path, FileMode.Open))
                {
                    try
                    {
                        if (SaveData.Instance.Read(file))
                        {
                            if (offset > 0)
                            {
                                SaveData.Instance.save = SaveData.Instance.save.Take(offset).ToList();
                            }
                            else if (offset < 0)
                            {
                                SaveData.Instance.save = SaveData.Instance.save.Take(SaveData.Instance.save.Count + offset).ToList();
                            }
                            var old = SaveData.Instance.readVersion < SaveData.CurrentVersion;
                            var (mappedObjects, mappedItems, ignoredDestructions, ignoredBuilds) = SaveData.Instance.FixSave();
                            if (mappedObjects > 0)
                            {
                                AppendMessage(-1, $"<color={color}>{mappedObjects} object IDs were modified because they corresponded to an object that already existed<color=white>", "");
                            }
                            if (mappedItems > 0)
                            {
                                AppendMessage(-1, $"<color={color}>{mappedItems} item IDs were modified in a game update and updated in the save automatically<color=white>", "");
                            }
                            if (ignoredDestructions > 0)
                            {
                                AppendMessage(-1, $"<color={color}>{ignoredDestructions} destruction entries were ignored because they corresponded to an object that didn't exist<color=white>", "");
                            }
                            if (old)
                            {
                                AppendMessage(-1, $"<color={color}>All destruction entries of items that weren't placed in this save were ignored because they might correspond to different generated objects<color=white>", "");
                            }
                            if (ignoredBuilds > 0)
                            {
                                AppendMessage(-1, $"<color={color}>{ignoredBuilds} build entries were ignored because they corresponded to an ID that was out of range or an item that isn't buildable<color=white>", "");
                            }
                            SaveData.Instance.ExecuteSave();
                            ServerSend.LoadSave();
                        }
                        else
                        {
                            AppendMessage(-1, $"<color={color}>The seed of the save file does not match the world seed<color=white>", "");
                            return;
                        }
                    }
                    catch (SaveData.VersionException ex)
                    {
                        AppendMessage(-1, $"<color={color}>This save file is too new ({ex.value - SaveData.CurrentVersion} versions ahead)<color=white>", "");
                    }
                    catch
                    {
                        AppendMessage(-1, $"<color={color}>Bad file format<color=white>", "");
                    }
                }
            }
            catch
            {
                AppendMessage(-1, $"<color={color}>There was an error reading the file<color=white>", "");
            }
        }
        else if (command.StartsWith("autosave "))
        {
            command = command.Substring(9);
            var mins = float.Parse(command.Substring(0, command.IndexOf(' ') + 1));
            command = command.Substring(command.IndexOf(' ') + 1);
            if (command == "") return;
            if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
            SaveData.Instance.AutoSave(mins, Path.Combine(saveDir, command));
        }
        else if (command.StartsWith("bulk "))
        {
            clipboard = "";
            foreach (var cmd in command.Substring(5).Split(';'))
            {
                try
                {
                    ChatCommand($"/{cmd}");
                }
                catch (Exception ex)
                {
                    Debug.LogError(ex);
                }
            }
            var finalClipboard = clipboard;
            clipboard = null;
            if (finalClipboard != "") Copy(finalClipboard);
        }
        else if (command == "saveinventory")
        {
            var commands = new List<string>();
            foreach (var cell in InventoryUI.Instance.allCells)
            {
                if (cell.currentItem != null)
                {
                    commands.Add($"give {cell.currentItem.id} {cell.currentItem.amount}");
                }
            }
            foreach (var powerup in ItemManager.Instance.allPowerups.Values)
            {
                var amount = PowerupInventory.Instance.GetAmount(powerup.name);
                if (amount != 0) commands.Add($"powerup {powerup.id} {amount}");
            }
            Copy($"/bulk {string.Join(";", commands)}");
            AppendMessage(-1, $"<color={color}>Copied inventory command to clipboard<color=white>", "");
        }
        else if (command == "paste")
        {
            ChatCommand(GUIUtility.systemCopyBuffer);
        }
        else if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Creative) return;

        if (command.StartsWith("give "))
        {
            command = command.Substring(5);
            int id;
            int amount = 1;
            if (command.Contains(' '))
            {
                var args = command.Split(' ');
                if (!int.TryParse(args[0], out id)) return;
                if (!int.TryParse(args[1], out amount)) return;
            }
            else if (!int.TryParse(command, out id)) return;

            if (id < 0) return;
            if (amount <= 0) return;
            if (id >= ItemManager.Instance.allItems.Count) return;

            var item = Instantiate(ItemManager.Instance.allItems[id]);
            item.amount = amount;
            InventoryUI.Instance.AddItemToInventory(item);
        }
        else if (command.StartsWith("powerup "))
        {
            command = command.Substring(8);
            int id;
            int amount = 1;
            if (command.Contains(' '))
            {
                var args = command.Split(' ');
                if (!int.TryParse(args[0], out id)) return;
                if (!int.TryParse(args[1], out amount)) return;
            }
            else if (!int.TryParse(command, out id)) return;

            if (id < 0) return;
            if (id >= ItemManager.Instance.allPowerups.Count) return;

            PowerupInventory.Instance.AddPowerup(id, amount);
        }
        else if (command == "clearinventory")
        {
            foreach (var item in InventoryUI.Instance.allCells)
            {
                if (item.currentItem != null)
                {
                    item.currentItem = null;
                    item.UpdateCell();
                }
            }
        }
        else if (command == "clearpowerups")
        {
            foreach (var powerup in ItemManager.Instance.allPowerups.Values)
            {
                var amount = PowerupInventory.Instance.GetAmount(powerup.name);
                if (amount != 0) PowerupInventory.Instance.AddPowerup(powerup.id, -amount);
            }
        }
        else if (command == "dontdestroyneighbors" || command == "dontdestroyneighbours" || command == "ddn")
        {
            if (!LocalClient.serverOwner)
            {
                AppendMessage(-1, $"<color={color}>Only the server host can enable/disable destroying neighbors<color=white>", "");
                return;
            }
            ServerSend.DontDestroy(!BuildDestruction.dontDestroy);
        }
        else if (command == "noclip")
        {
            if (PlayerMovement.Instance.noclip = !PlayerMovement.Instance.noclip)
            {
                AppendMessage(-1, $"<color={color}>Enabled noclip<color=white>", "");
            }
            else
            {
                AppendMessage(-1, $"<color={color}>Disabled noclip<color=white>", "");
            }
        }
        else if (command == "getbuildpos")
        {
            var pos = BuildManager.Instance.lastPosition;

            var text = $"{pos.x.ToString(SaveData.us)}, {pos.y.ToString(SaveData.us)}, {pos.z.ToString(SaveData.us)}";
            Copy(text);
            AppendMessage(-1, $"<color={color}>Build Ghost position is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command == "getbuildrot")
        {
            var text = $"{BuildManager.Instance.xRot.ToString(SaveData.us)}, {BuildManager.Instance.yRot.ToString(SaveData.us)}";

            Copy(text);
            AppendMessage(-1, $"<color={color}>Build Ghost rotation is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command == "getbuildrotq")
        {
            var rot = BuildManager.Instance.buildRot;
            var text = $"{rot.x.ToString(SaveData.us)}, {rot.y.ToString(SaveData.us)}, {rot.z.ToString(SaveData.us)}, {rot.w.ToString(SaveData.us)}";

            Copy(text);
            AppendMessage(-1, $"<color={color}>Build Ghost quaternion is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command == "getplayerpos")
        {
            var pos = BuildManager.Instance.lastPosition;

            var text = $"{pos.x.ToString(SaveData.us)}, {pos.y.ToString(SaveData.us)}, {pos.z.ToString(SaveData.us)}";
            Copy(text);
            AppendMessage(-1, $"<color={color}>Build Ghost position is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command == "getplayerrot")
        {
            var rot = PlayerInput.Instance.cameraRot;
            var text = $"{rot.x.ToString(SaveData.us)}, {rot.y.ToString(SaveData.us)}, {rot.z.ToString(SaveData.us)}";

            Copy(text);
            AppendMessage(-1, $"<color={color}>Player View rotation is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command == "getplayerrotq")
        {
            var rot = Quaternion.Euler(PlayerInput.Instance.cameraRot);
            var text = $"{rot.x.ToString(SaveData.us)}, {rot.y.ToString(SaveData.us)}, {rot.z.ToString(SaveData.us)}, {rot.w.ToString(SaveData.us)}";

            Copy(text);
            AppendMessage(-1, $"<color={color}>Player View quaternion is {text} (copied to clipboard)<color=white>", "");
        }
        else if (command.StartsWith("setbuildrot "))
        {
            command = command.Substring(12);
            var args = command.Split(' ');
            if (float.TryParse(args[0], NumberStyles.Float, SaveData.us, out var x)
             && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var y)
             && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var z))
            {
                BuildManager.Instance.baseXRot = x;
                BuildManager.Instance.baseYRot = y;
                BuildManager.Instance.baseZRot = z;
            }
        }
        else if (command.StartsWith("build "))
        {
            if (!BuildManager.Instance.CanBuild())
                AppendMessage(-1, $"<color={color}>Cannot build this item<color=white>", "");
            command = command.Substring(6);
            var args = command.Split(' ');
            if (float.TryParse(args[0], NumberStyles.Float, SaveData.us, out var xPos)
             && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var yPos)
             && float.TryParse(args[2], NumberStyles.Float, SaveData.us, out var zPos)
             && float.TryParse(args[3], NumberStyles.Float, SaveData.us, out var xRot)
             && float.TryParse(args[4], NumberStyles.Float, SaveData.us, out var yRot)
             && float.TryParse(args[5], NumberStyles.Float, SaveData.us, out var zRot)
             && float.TryParse(args[6], NumberStyles.Float, SaveData.us, out var wRot))
            {
                buildQueue.Add((Hotbar.Instance.currentItem.id, new Vector3(xPos, yPos, zPos), new Quaternion(xRot, yRot, zRot, wRot)));
            }
        }
        else if (command.StartsWith("buildrel "))
        {
            command = command.Substring(9);
            var args = command.Split(' ');
            if (float.TryParse(args[0], NumberStyles.Float, SaveData.us, out var xPos)
             && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var yPos)
             && float.TryParse(args[2], NumberStyles.Float, SaveData.us, out var zPos)
             && float.TryParse(args[3], NumberStyles.Float, SaveData.us, out var xRot)
             && float.TryParse(args[4], NumberStyles.Float, SaveData.us, out var yRot)
             && float.TryParse(args[5], NumberStyles.Float, SaveData.us, out var zRot)
             && float.TryParse(args[6], NumberStyles.Float, SaveData.us, out var wRot))
            {
                var pos = BuildManager.Instance.lastPosition;
                var rot = BuildManager.Instance.buildRot;
                buildQueue.Add((Hotbar.Instance.currentItem.id, pos + rot * new Vector3(xPos, yPos, zPos), rot * new Quaternion(xRot, yRot, zRot, wRot)));
            }
        }
        else if (command.StartsWith("smooth "))
        {
            command = command.Substring(7);
            var args = command.Split(' ');
            if (float.TryParse(args[0], NumberStyles.Float, SaveData.us, out var angle) && int.TryParse(args[1], out var count) && float.TryParse(args[2], NumberStyles.Float, SaveData.us, out var radius))
            {
                Smooth(count, Vector3.forward * Mathf.Deg2Rad * angle / count * radius, Quaternion.Euler(-angle / count, 0, 0));
                AppendMessage(-1, $"<color={color}>Copied smooth command to clipboard<color=white>", "");
            }
        }
        else if (command.StartsWith("smoothd "))
        {
            command = command.Substring(8);
            var args = command.Split(' ');
            if (int.TryParse(args[0], out var count) && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var angle) && float.TryParse(args[2], NumberStyles.Float, SaveData.us, out var distance))
            {
                Smooth(count, Vector3.forward * distance, Quaternion.Euler(-angle, 0, 0));
                AppendMessage(-1, $"<color={color}>Copied smooth command to clipboard<color=white>", "");
            }
        }
        else if (command.StartsWith("smoothraw "))
        {
            command = command.Substring(10);
            var args = command.Split(' ');
            if (int.TryParse(args[0], out var count)
             && float.TryParse(args[1], NumberStyles.Float, SaveData.us, out var xPos)
             && float.TryParse(args[2], NumberStyles.Float, SaveData.us, out var yPos)
             && float.TryParse(args[3], NumberStyles.Float, SaveData.us, out var zPos)
             && float.TryParse(args[4], NumberStyles.Float, SaveData.us, out var xRot)
             && float.TryParse(args[5], NumberStyles.Float, SaveData.us, out var yRot)
             && float.TryParse(args[6], NumberStyles.Float, SaveData.us, out var zRot))
            {
                Smooth(count, new Vector3(xPos, yPos, zPos), Quaternion.Euler(xRot, yRot, zRot));
            }
        }
    }

    private void Smooth(int count, Vector3 posDelta, Quaternion rotDelta)
    {
        var commands = new string[count];
        var pos = Vector3.zero;
        var rot = Quaternion.identity;
        for (var i = 0; i < count; i++)
        {
            commands[i] = $"buildrel {pos.x.ToString(SaveData.us)} {pos.y.ToString(SaveData.us)} {pos.z.ToString(SaveData.us)} {rot.x.ToString(SaveData.us)} {rot.y.ToString(SaveData.us)} {rot.z.ToString(SaveData.us)} {rot.w.ToString(SaveData.us)}";
            rot = rotDelta * rot;
            pos += rot * posDelta;
        }
        Copy("/bulk " + string.Join(";", commands));
    }


    private string TrimMessage(string message)
    {
        if (string.IsNullOrEmpty(message))
        {
            return "";
        }
        return message.Substring(0, Mathf.Min(message.Length, this.maxMsgLength));
    }


    private void UserInput()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            if (this.typing)
            {
                this.SendMessage(this.inputField.text);
            }
            else
            {
                this.ShowChat();
                this.inputField.interactable = true;
                this.inputField.Select();
                this.typing = true;
            }
        }
        if (this.typing)
        {
            if (!this.inputField.isFocused) this.inputField.Select();

            var prevMsg = selectedMessage;

            if (selectedMessage >= 0 && inputField.text != messageHistory[selectedMessage]) selectedMessage = -1;

            if (Input.GetKeyDown(KeyCode.UpArrow))
            {
                selectedMessage++;
            }

            if (Input.GetKeyDown(KeyCode.DownArrow))
            {
                selectedMessage--;
            }

            if (selectedMessage >= messageHistory.Count) selectedMessage = messageHistory.Count - 1;
            if (selectedMessage < 0) selectedMessage = -1;

            if (selectedMessage != -1 && selectedMessage != prevMsg)
            {
                inputField.text = messageHistory[selectedMessage];
            }

            if (Input.GetKeyDown(KeyCode.Escape))
            {
                this.ClearMessage();
                this.typing = false;
                base.CancelInvoke(nameof(HideChat));
                base.Invoke(nameof(HideChat), 5f);
            }
        }
    }


    private void Update()
    {
        this.UserInput();
        if (buildQueue.Count == 0) return;
        var build = buildQueue[0];
        buildQueue.RemoveAt(0);
        Gun.Instance.Build();
        ClientSend.RequestBuild(build.item, build.pos, build.rot);
    }


    private void HideChat()
    {
        if (this.typing)
        {
            return;
        }
        this.typing = false;
        this.overlay.CrossFadeAlpha(0f, 1f, true);
        this.messages.CrossFadeAlpha(0f, 1f, true);
        this.inputField.GetComponent<Image>().CrossFadeAlpha(0f, 1f, true);
        this.inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0f, 1f, true);
    }


    private void ShowChat()
    {
        this.overlay.CrossFadeAlpha(1f, 0.2f, true);
        this.messages.CrossFadeAlpha(1f, 0.2f, true);
        this.inputField.GetComponent<Image>().CrossFadeAlpha(0.2f, 1f, true);
        this.inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0.2f, 1f, true);
    }


    public Image overlay;


    public TMP_InputField inputField;


    public TextMeshProUGUI messages;


    public Color localPlayer;


    public Color onlinePlayer;


    public Color deadPlayer;


    private Color console = Color.cyan;


    private int maxMsgLength = 120;


    private int maxChars = 800;


    private int purgeAmount = 400;


    public static ChatBox Instance;


    public TextAsset profanityList;


    private List<string> profanity;


    private List<(int item, Vector3 pos, Quaternion rot)> buildQueue = new List<(int, Vector3, Quaternion)>();
}
