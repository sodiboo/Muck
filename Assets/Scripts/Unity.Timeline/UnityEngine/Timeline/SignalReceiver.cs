using UnityEngine;
using System;
using System.Collections.Generic;
using UnityEngine.Events;

namespace UnityEngine.Timeline
{
	public class SignalReceiver : MonoBehaviour
	{
		[Serializable]
		private class EventKeyValue
		{
			[SerializeField]
			private List<SignalAsset> m_Signals;
			[SerializeField]
			private List<UnityEvent> m_Events;
		}

		[SerializeField]
		private EventKeyValue m_Events;
	}
}
