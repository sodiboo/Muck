using TMPro;
using UnityEngine;

namespace DebugStuff
{
    public class ConsoleToGUI : MonoBehaviour
    {
        public TextMeshProUGUI debugText;

        private static string myLog = "";

        private string output;

        private string stack;

        public static ConsoleToGUI Instance;

        private void Awake()
        {
            if ((bool)Instance)
            {
                Object.Destroy(base.gameObject);
                return;
            }
            Instance = this;
            Object.DontDestroyOnLoad(base.gameObject);
        }

        private void OnEnable()
        {
            Application.logMessageReceived += Log;
        }

        private void OnDisable()
        {
            Application.logMessageReceived -= Log;
        }

        public void Log(string logString, string stackTrace, LogType type)
        {
            output = logString;
            stack = stackTrace;
            myLog = output + "\n" + myLog;
            if (myLog.Length > 300)
            {
                myLog = myLog.Substring(0, 200);
            }
            debugText.text = myLog;
        }

        private void OnGUI()
        {
        }
    }
}
