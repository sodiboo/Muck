using System;
using System.Collections.Generic;
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
        messageHistory.Insert(0, message);
        this.typing = false;
        if (message[0] == '/')
        {
            this.ChatCommand(message);
            return;
        }
        message = this.TrimMessage(message);
        if (message == "")
        {
            return;
        }
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
        string text = "#" + ColorUtility.ToHtmlStringRGB(this.console);
        if (command == "seed")
        {
            int seed = GameManager.gameSettings.Seed;
            this.AppendMessage(-1, string.Concat(new object[]
            {
                "<color=",
                text,
                ">Seed: ",
                seed,
                " (copied to clipboard)<color=white>"
            }), "");
            GUIUtility.systemCopyBuffer = string.Concat(seed);
        }
        else if (command == "ping")
        {
            this.AppendMessage(-1, "<color=" + text + ">pong<color=white>", "");
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
                AppendMessage(-1, $"<color={text}>Only the server host can load saves<color=white>", "");
                return;
            }

            if (SaveData.Instance.save.Count != 0)
            {
                AppendMessage(-1, $"<color={text}>Cannot load a save after the world has been modified<color=white>", "");
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
                            SaveData.Instance.ExecuteSave();
                            ServerSend.LoadSave();
                        }
                        else
                        {
                            AppendMessage(-1, $"<color={text}>The seed of the save file does not match the world seed<color=white>", "");
                            return;
                        }
                    }
                    catch
                    {
                        AppendMessage(-1, $"<color={text}>Bad file format<color=white>", "");
                    }
                }
            }
            catch
            {
                AppendMessage(-1, $"<color={text}>There was an error reading the file<color=white>", "");
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
            GUIUtility.systemCopyBuffer = $"/bulk {string.Join(";", commands)}";
            AppendMessage(-1, $"<color={text}>Copied inventory command to clipboard<color=white>", "");
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
                AppendMessage(-1, $"<color={text}>Only the server host can enable/disable destroying neighbors<color=white>", "");
                return;
            }
            ServerSend.DontDestroy(!BuildDestruction.dontDestroy);
        }
        else if (command == "noclip")
        {
            if (PlayerMovement.Instance.noclip = !PlayerMovement.Instance.noclip)
            {
                AppendMessage(-1, $"<color={text}>Enabled noclip<color=white>", "");
            }
            else
            {
                AppendMessage(-1, $"<color={text}>Disabled noclip<color=white>", "");
            }
        }
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
}
