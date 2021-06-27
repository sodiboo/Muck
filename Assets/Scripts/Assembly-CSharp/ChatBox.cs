using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000015 RID: 21
public class ChatBox : MonoBehaviour
{
	// Token: 0x17000009 RID: 9
	// (get) Token: 0x0600007E RID: 126 RVA: 0x00004811 File Offset: 0x00002A11
	// (set) Token: 0x0600007F RID: 127 RVA: 0x00004819 File Offset: 0x00002A19
	public bool typing { get; set; }

	// Token: 0x06000080 RID: 128 RVA: 0x00004824 File Offset: 0x00002A24
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

	// Token: 0x06000081 RID: 129 RVA: 0x00004887 File Offset: 0x00002A87
	public static string RemoveWhitespace(string input)
	{
		return new string((from c in input.ToCharArray()
		where !char.IsWhiteSpace(c)
		select c).ToArray<char>());
	}

	// Token: 0x06000082 RID: 130 RVA: 0x000048C0 File Offset: 0x00002AC0
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
			base.CancelInvoke("HideChat");
			Invoke(nameof(HideChat), 5f);
		}
	}

	// Token: 0x06000083 RID: 131 RVA: 0x00004A40 File Offset: 0x00002C40
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

	// Token: 0x06000084 RID: 132 RVA: 0x00004AF8 File Offset: 0x00002CF8
	private void ClearMessage()
	{
		this.inputField.text = "";
		this.inputField.interactable = false;
	}

	// Token: 0x06000085 RID: 133 RVA: 0x00004B18 File Offset: 0x00002D18
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
			return;
		}
		if (a == "ping")
		{
			this.AppendMessage(-1, "<color=" + text + ">pong<color=white>", "");
			return;
		}
		if (a == "debug")
		{
			DebugNet.Instance.ToggleConsole();
			return;
		}
		if (!(a == "kill"))
		{
			return;
		}
		PlayerStatus.Instance.Damage(0, true);
	}

	// Token: 0x06000086 RID: 134 RVA: 0x00004C1C File Offset: 0x00002E1C
	private string TrimMessage(string message)
	{
		if (string.IsNullOrEmpty(message))
		{
			return "";
		}
		return message.Substring(0, Mathf.Min(message.Length, this.maxMsgLength));
	}

	// Token: 0x06000087 RID: 135 RVA: 0x00004C44 File Offset: 0x00002E44
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
			base.CancelInvoke("HideChat");
			Invoke(nameof(HideChat), 5f);
		}
	}

	// Token: 0x06000088 RID: 136 RVA: 0x00004CF2 File Offset: 0x00002EF2
	private void Update()
	{
		this.UserInput();
	}

	// Token: 0x06000089 RID: 137 RVA: 0x00004CFC File Offset: 0x00002EFC
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

	// Token: 0x0600008A RID: 138 RVA: 0x00004D7C File Offset: 0x00002F7C
	private void ShowChat()
	{
		this.overlay.CrossFadeAlpha(1f, 0.2f, true);
		this.messages.CrossFadeAlpha(1f, 0.2f, true);
		this.inputField.GetComponent<Image>().CrossFadeAlpha(0.2f, 1f, true);
		this.inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0.2f, 1f, true);
	}

	// Token: 0x04000083 RID: 131
	public Image overlay;

	// Token: 0x04000084 RID: 132
	public TMP_InputField inputField;

	// Token: 0x04000085 RID: 133
	public TextMeshProUGUI messages;

	// Token: 0x04000086 RID: 134
	public Color localPlayer;

	// Token: 0x04000087 RID: 135
	public Color onlinePlayer;

	// Token: 0x04000088 RID: 136
	public Color deadPlayer;

	// Token: 0x04000089 RID: 137
	private Color console = Color.cyan;

	// Token: 0x0400008A RID: 138
	private int maxMsgLength = 120;

	// Token: 0x0400008B RID: 139
	private int maxChars = 800;

	// Token: 0x0400008C RID: 140
	private int purgeAmount = 400;

	// Token: 0x0400008E RID: 142
	public static ChatBox Instance;

	// Token: 0x0400008F RID: 143
	public TextAsset profanityList;

	// Token: 0x04000090 RID: 144
	private List<string> profanity;
}
