using System;
using System.Linq;
using TMPro;
using UnityEngine;

public class Commands : MonoBehaviour
{
    public TMP_InputField inputField;

    public TextMeshProUGUI suggestText;

    private string suggestedText;

    private void Update()
    {
        PredictCommands();
        PlayerInput();
        suggestText.text = suggestedText;
    }

    private void PlayerInput()
    {
        if (Input.GetKeyDown(KeyCode.Tab))
        {
            FillCommand();
        }
    }

    private void FillCommand()
    {
        if (ChatBox.Instance.typing && !(suggestedText == ""))
        {
            inputField.text = suggestedText;
            inputField.stringPosition = inputField.text.Length;
        }
    }

    private void PredictCommands()
    {
        if (!ChatBox.Instance.typing)
        {
            if (suggestText.text != "")
            {
                suggestedText = "";
                suggestText.text = "";
            }
            return;
        }
        suggestedText = "";
        string text = inputField.text;
        if (text.Length < 1)
        {
            return;
        }
        string text2 = text.Split(' ').Last();
        if (text2.Length < 1)
        {
            return;
        }
        string text3 = text2[0].ToString() ?? "";
        string text4 = text2.Remove(0, 1);
        if (text3 == "/")
        {
            string[] commands = ChatBox.Instance.commands;
            foreach (string text5 in commands)
            {
                if (text5.StartsWith(text4))
                {
                    suggestedText = text;
                    int num = text5.Length - text4.Length;
                    suggestedText += text5.Substring(text5.Length - num);
                    return;
                }
            }
        }
        string[] array = text.Split();
        if (array.Length < 2)
        {
            return;
        }
        int startIndex = text.IndexOf(" ", StringComparison.Ordinal) + 1;
        string text6 = text.Substring(startIndex);
        if (!(array[0] == "/kick"))
        {
            return;
        }
        foreach (Client value in Server.clients.Values)
        {
            if (value != null && value.player != null && value.player.username.ToLower().Contains(text6.ToLower()))
            {
                suggestedText = array[0] + " ";
                suggestedText += value.player.username;
                break;
            }
        }
    }
}
