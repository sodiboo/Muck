
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200000F RID: 15
public class ChatBox : MonoBehaviour
{
	// Token: 0x17000003 RID: 3
	// (get) Token: 0x0600004A RID: 74 RVA: 0x00003BC6 File Offset: 0x00001DC6
	// (set) Token: 0x0600004B RID: 75 RVA: 0x00003BCE File Offset: 0x00001DCE
	public bool typing { get; set; }

	// Token: 0x0600004C RID: 76 RVA: 0x00003BD8 File Offset: 0x00001DD8
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

	// Token: 0x0600004D RID: 77 RVA: 0x00003C3B File Offset: 0x00001E3B
	public static string RemoveWhitespace(string input)
	{
		return new string((from c in input.ToCharArray()
		where !char.IsWhiteSpace(c)
		select c).ToArray<char>());
	}

	// Token: 0x0600004E RID: 78 RVA: 0x00003C74 File Offset: 0x00001E74
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
			base.Invoke("HideChat", 5f);
		}
	}

	// Token: 0x0600004F RID: 79 RVA: 0x00003DF4 File Offset: 0x00001FF4
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

	// Token: 0x06000050 RID: 80 RVA: 0x00003EAC File Offset: 0x000020AC
	private void ClearMessage()
	{
		this.inputField.text = "";
		this.inputField.interactable = false;
	}

	// Token: 0x06000051 RID: 81 RVA: 0x00003ECC File Offset: 0x000020CC
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
		PlayerStatus.Instance.Damage(0);
	}

	// Token: 0x06000052 RID: 82 RVA: 0x00003FCF File Offset: 0x000021CF
	private string TrimMessage(string message)
	{
		if (string.IsNullOrEmpty(message))
		{
			return "";
		}
		return message.Substring(0, Mathf.Min(message.Length, this.maxMsgLength));
	}

	// Token: 0x06000053 RID: 83 RVA: 0x00003FF8 File Offset: 0x000021F8
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
			base.Invoke("HideChat", 5f);
		}
	}

	// Token: 0x06000054 RID: 84 RVA: 0x000040A6 File Offset: 0x000022A6
	private void Update()
	{
		this.UserInput();
	}

	// Token: 0x06000055 RID: 85 RVA: 0x000040B0 File Offset: 0x000022B0
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

	// Token: 0x06000056 RID: 86 RVA: 0x00004130 File Offset: 0x00002330
	private void ShowChat()
	{
		this.overlay.CrossFadeAlpha(1f, 0.2f, true);
		this.messages.CrossFadeAlpha(1f, 0.2f, true);
		this.inputField.GetComponent<Image>().CrossFadeAlpha(0.2f, 1f, true);
		this.inputField.GetComponentInChildren<TextMeshProUGUI>().CrossFadeAlpha(0.2f, 1f, true);
	}

	// Token: 0x0400004A RID: 74
	public Image overlay;

	// Token: 0x0400004B RID: 75
	public TMP_InputField inputField;

	// Token: 0x0400004C RID: 76
	public TextMeshProUGUI messages;

	// Token: 0x0400004D RID: 77
	public Color localPlayer;

	// Token: 0x0400004E RID: 78
	public Color onlinePlayer;

	// Token: 0x0400004F RID: 79
	public Color deadPlayer;

	// Token: 0x04000050 RID: 80
	private Color console = Color.cyan;

	// Token: 0x04000051 RID: 81
	private int maxMsgLength = 120;

	// Token: 0x04000052 RID: 82
	private int maxChars = 800;

	// Token: 0x04000053 RID: 83
	private int purgeAmount = 400;

	// Token: 0x04000055 RID: 85
	public static ChatBox Instance;

	// Token: 0x04000056 RID: 86
	public TextAsset profanityList;

	// Token: 0x04000057 RID: 87
	private List<string> profanity;
}
