using System;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	public class SignalEmitter : Marker
	{
		[SerializeField]
		private bool m_Retroactive;
		[SerializeField]
		private bool m_EmitOnce;
		[SerializeField]
		private SignalAsset m_Asset;
	}
}
