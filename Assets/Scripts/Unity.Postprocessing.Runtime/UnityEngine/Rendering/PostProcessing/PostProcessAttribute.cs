using System;

namespace UnityEngine.Rendering.PostProcessing
{
	public class PostProcessAttribute : Attribute
	{
		public PostProcessAttribute(Type renderer, PostProcessEvent eventType, string menuItem, bool allowInSceneView)
		{
		}

	}
}
