using System;
using TMPro;
using UnityEngine;

namespace DebugStuff
{
	public class ConsoleToGUI : MonoBehaviour
	{
		private void Awake()
		{
			if (ConsoleToGUI.Instance)
			{
				Destroy(base.gameObject);
				return;
			}
			ConsoleToGUI.Instance = this;
			DontDestroyOnLoad(base.gameObject);
		}

		private void OnEnable()
		{
			Application.logMessageReceived += this.Log;
		}

		private void OnDisable()
		{
			Application.logMessageReceived -= this.Log;
		}

		public void Log(string logString, string stackTrace, LogType type)
		{
			this.output = logString;
			this.stack = stackTrace;
			ConsoleToGUI.myLog = this.output + "\n" + ConsoleToGUI.myLog;
			if (ConsoleToGUI.myLog.Length > 300)
			{
				ConsoleToGUI.myLog = ConsoleToGUI.myLog.Substring(0, 200);
			}
			this.debugText.text = ConsoleToGUI.myLog;
		}

		private void OnGUI()
		{
		}

		public TextMeshProUGUI debugText;

		private static string myLog = "";

		private string output;

		private string stack;

		public static ConsoleToGUI Instance;
	}
}
