using System;
using TMPro;
using UnityEngine;

namespace DebugStuff
{
	// Token: 0x0200015C RID: 348
	public class ConsoleToGUI : MonoBehaviour
	{
		// Token: 0x0600084F RID: 2127 RVA: 0x00007670 File Offset: 0x00005870
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

		// Token: 0x06000850 RID: 2128 RVA: 0x0000769B File Offset: 0x0000589B
		private void OnEnable()
		{
			Application.logMessageReceived += this.Log;
		}

		// Token: 0x06000851 RID: 2129 RVA: 0x000076AE File Offset: 0x000058AE
		private void OnDisable()
		{
			Application.logMessageReceived -= this.Log;
		}

		// Token: 0x06000852 RID: 2130 RVA: 0x00028814 File Offset: 0x00026A14
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

		// Token: 0x06000853 RID: 2131 RVA: 0x00002147 File Offset: 0x00000347
		private void OnGUI()
		{
		}

		// Token: 0x04000890 RID: 2192
		public TextMeshProUGUI debugText;

		// Token: 0x04000891 RID: 2193
		private static string myLog = "";

		// Token: 0x04000892 RID: 2194
		private string output;

		// Token: 0x04000893 RID: 2195
		private string stack;

		// Token: 0x04000894 RID: 2196
		public static ConsoleToGUI Instance;
	}
}
