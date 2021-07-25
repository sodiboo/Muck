using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ChatBox : MonoBehaviour
{
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

    public string[] commands = new string[5] { "seed", "ping", "debug", "kill", "kick" };

    public bool typing { get; set; }

    private void Awake()
    {
        Instance = this;
        HideChat();
        profanity = new List<string>();
        string[] array = profanityList.text.Split('\n');
        foreach (string input in array)
        {
            profanity.Add(RemoveWhitespace(input));
        }
    }

    public static string RemoveWhitespace(string input)
    {
        return new string(input.ToCharArray().Where((char c) => !char.IsWhiteSpace(c)).ToArray());
    }

    public void AppendMessage(int fromUser, string message, string fromUsername)
    {
        string text = TrimMessage(message);
        string text2 = "\n";
        if (fromUser != -1)
        {
            string text3 = "<color=";
            text3 = ((fromUser == LocalClient.instance.myId) ? (text3 + "#" + ColorUtility.ToHtmlStringRGB(localPlayer) + ">") : ((!GameManager.players[fromUser].dead) ? (text3 + "#" + ColorUtility.ToHtmlStringRGB(onlinePlayer) + ">") : (text3 + "#" + ColorUtility.ToHtmlStringRGB(deadPlayer) + ">")));
            text2 += text3;
        }
        if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus || fromUser == -1 || !GameManager.players[fromUser].dead || PlayerStatus.Instance.IsPlayerDead())
        {
            if (fromUser != -1 || (fromUser == -1 && fromUsername != ""))
            {
                text2 = text2 + fromUsername + ": ";
            }
            text2 += text;
            messages.text += text2;
            int length = messages.text.Length;
            if (length > maxChars)
            {
                int startIndex = length - purgeAmount;
                messages.text = messages.text.Substring(startIndex);
            }
            ShowChat();
            if (!typing)
            {
                CancelInvoke(nameof(HideChat));
                Invoke(nameof(HideChat), 5f);
            }
        }
    }

    public new void SendMessage(string message)
    {
        typing = false;
        message = TrimMessage(message);
        if (message == "")
        {
            return;
        }
        if (message[0] == '/')
        {
            ChatCommand(message);
            return;
        }
        foreach (string item in profanity)
        {
            message = Regex.Replace(message, item, "muck");
        }
        AppendMessage(0, message, GameManager.players[LocalClient.instance.myId].username);
        ClientSend.SendChatMessage(message);
        ClearMessage();
    }

    private void ClearMessage()
    {
        inputField.text = "";
        inputField.interactable = false;
    }

    private void ChatCommand(string message)
    {
        if (message.Length <= 0)
        {
            return;
        }
        string text = message.Split(' ')[0].Substring(1);
        ClearMessage();
        string text2 = "#" + ColorUtility.ToHtmlStringRGB(console);
        switch (text)
        {
        case "seed":
        {
            int seed = GameManager.gameSettings.Seed;
            AppendMessage(-1, "<color=" + text2 + ">Seed: " + seed + " (copied to clipboard)<color=white>", "");
            GUIUtility.systemCopyBuffer = string.Concat(seed);
            break;
        }
        case "ping":
            AppendMessage(-1, "<color=" + text2 + ">pong<color=white>", "");
            break;
        case "debug":
            DebugNet.Instance.ToggleConsole();
            break;
        case "kill":
            PlayerStatus.Instance.Damage(0, 0, ignoreProtection: true);
            break;
        case "kick":
        {
            int startIndex = message.IndexOf(" ", StringComparison.Ordinal) + 1;
            string username = message.Substring(startIndex);
            if (!GameManager.instance.KickPlayer(username))
            {
                AppendMessage(0, "Failed to kick player...", GameManager.players[LocalClient.instance.myId].username);
            }
            break;
        }
        }
    }

    private string TrimMessage(string message)
    {
        if (string.IsNullOrEmpty(message))
        {
            return "";
        }
        return message.Substring(0, Mathf.Min(message.Length, maxMsgLength));
    }

    private void UserInput()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            if (typing)
            {
                SendMessage(inputField.text);
            }
            else
            {
                ShowChat();
                inputField.interactable = true;
                inputField.Select();
                typing = true;
            }
        }
        if (typing && !inputField.isFocused)
        {
            inputField.Select();
        }
        if (Input.GetKeyDown(KeyCode.Escape) && typing)
        {
            ClearMessage();
            typing = false;
            CancelInvoke(nameof(HideChat));
            Invoke(nameof(HideChat), 5f);
        }
    }

    private void Update()
    {
        UserInput();
    }

    private void HideChat()
    {
        if (!typing)
        {
            typing = false;
            overlay.CrossFadeAlpha(0f, 1f, ignoreTimeScale: true);
            messages.CrossFadeAlpha(0f, 1f, ignoreTimeScale: true);
            inputField.GetComponent<Image>().CrossFadeAlpha(0f, 1f, ignoreTimeScale: true);
            inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0f, 1f, ignoreTimeScale: true);
        }
    }

    private void ShowChat()
    {
        overlay.CrossFadeAlpha(1f, 0.2f, ignoreTimeScale: true);
        messages.CrossFadeAlpha(1f, 0.2f, ignoreTimeScale: true);
        inputField.GetComponent<Image>().CrossFadeAlpha(0.2f, 1f, ignoreTimeScale: true);
        inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0.2f, 1f, ignoreTimeScale: true);
    }
}
