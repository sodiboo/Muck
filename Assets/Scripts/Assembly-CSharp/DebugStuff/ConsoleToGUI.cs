using System;
using TMPro;
using UnityEngine;

namespace DebugStuff
{
	// Token: 0x02000138 RID: 312
	public class ConsoleToGUI : MonoBehaviour
	{
		// Token: 0x060008DC RID: 2268 RVA: 0x0002C14C File Offset: 0x0002A34C
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

		// Token: 0x060008DD RID: 2269 RVA: 0x0002C177 File Offset: 0x0002A377
		private void OnEnable()
		{
			Application.logMessageReceived += this.Log;
		}

		// Token: 0x060008DE RID: 2270 RVA: 0x0002C18A File Offset: 0x0002A38A
		private void OnDisable()
		{
			Application.logMessageReceived -= this.Log;
		}

		// Token: 0x060008DF RID: 2271 RVA: 0x0002C1A0 File Offset: 0x0002A3A0
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

		// Token: 0x060008E0 RID: 2272 RVA: 0x000030D7 File Offset: 0x000012D7
		private void OnGUI()
		{
		}

		// Token: 0x0400086B RID: 2155
		public TextMeshProUGUI debugText;

		// Token: 0x0400086C RID: 2156
		private static string myLog = "";

		// Token: 0x0400086D RID: 2157
		private string output;

		// Token: 0x0400086E RID: 2158
		private string stack;

		// Token: 0x0400086F RID: 2159
		public static ConsoleToGUI Instance;
	}
}
