using TMPro;
using UnityEngine;

namespace DebugStuff
{
	// Token: 0x02000105 RID: 261
	public class ConsoleToGUI : MonoBehaviour
	{
		// Token: 0x06000790 RID: 1936 RVA: 0x00025760 File Offset: 0x00023960
		private void Awake()
		{
			if (ConsoleToGUI.Instance)
			{
			Destroy(base.gameObject);
				return;
			}
			ConsoleToGUI.Instance = this;
			Object.DontDestroyOnLoad(base.gameObject);
		}

		// Token: 0x06000791 RID: 1937 RVA: 0x0002578B File Offset: 0x0002398B
		private void OnEnable()
		{
			Application.logMessageReceived += this.Log;
		}

		// Token: 0x06000792 RID: 1938 RVA: 0x0002579E File Offset: 0x0002399E
		private void OnDisable()
		{
			Application.logMessageReceived -= this.Log;
		}

		// Token: 0x06000793 RID: 1939 RVA: 0x000257B4 File Offset: 0x000239B4
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

		// Token: 0x06000794 RID: 1940 RVA: 0x0000276E File Offset: 0x0000096E
		private void OnGUI()
		{
		}

		// Token: 0x0400071D RID: 1821
		public TextMeshProUGUI debugText;

		// Token: 0x0400071E RID: 1822
		private static string myLog = "";

		// Token: 0x0400071F RID: 1823
		private string output;

		// Token: 0x04000720 RID: 1824
		private string stack;

		// Token: 0x04000721 RID: 1825
		public static ConsoleToGUI Instance;
	}
}
