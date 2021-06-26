using System;
using System.Collections.Generic;
using UnityEngine;

namespace UnityEngine.Timeline
{
	[Serializable]
	internal struct MarkerList
	{
		public MarkerList(int capacity) : this()
		{
		}

		[SerializeField]
		private List<ScriptableObject> m_Objects;
	}
}
