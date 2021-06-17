using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.UI;


public class ChatBox : MonoBehaviour
{



    public bool typing { get; set; }


    private void Awake()
    {
        ChatBox.Instance = this;
        this.HideChat();
        this.profanity = new List<string>();
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


    public new void SendMessage(string message)
    {
        this.typing = false;
        message = this.TrimMessage(message);
        if (message == "")
        {
            return;
        }
        if (message[0] == '/')
        {
            this.ChatCommand(message);
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
        string a = message.Substring(1);
        this.ClearMessage();
        string text = "#" + ColorUtility.ToHtmlStringRGB(this.console);
        if (a == "seed")
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
        else if (a == "ping")
        {
            this.AppendMessage(-1, "<color=" + text + ">pong<color=white>", "");
        }
        else if (a == "debug")
        {
            DebugNet.Instance.ToggleConsole();
        }
        else if (a == "kill")
        {
            PlayerStatus.Instance.Damage(0, true);
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
        if (this.typing && !this.inputField.isFocused)
        {
            this.inputField.Select();
        }
        if (Input.GetKeyDown(KeyCode.Escape) && this.typing)
        {
            this.ClearMessage();
            this.typing = false;
            base.CancelInvoke(nameof(HideChat));
            base.Invoke(nameof(HideChat), 5f);
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
