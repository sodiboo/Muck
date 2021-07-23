using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ChatBox : MonoBehaviour
{
	public Image overlay;
	public TMP_InputField inputField;
	public TextMeshProUGUI messages;
	public Color localPlayer;
	public Color onlinePlayer;
	public Color deadPlayer;
	public TextAsset profanityList;
	public string[] commands;
}
