// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;

namespace Boxophobic.StyledGUI
{
    [CustomPropertyDrawer(typeof(StyledMask))]
    public class StyledMaskAttributeDrawer : PropertyDrawer
    {
        StyledMask a;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            a = (StyledMask)attribute;

            GUIStyle styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                wordWrap = true
            };

            string[] masks = new string[] { a.mask0, a.mask1 };

            if (a.index == 3)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2 };
            }
            else if (a.index == 4)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2, a.mask3 };
            }
            else if (a.index == 5)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2, a.mask3, a.mask4 };
            }
            else if (a.index == 6)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2, a.mask3, a.mask4, a.mask5 };
            }
            else if (a.index == 7)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2, a.mask3, a.mask4, a.mask5, a.mask6 };
            }
            else if (a.index == 8)
            {
                masks = new string[] { a.mask0, a.mask1, a.mask2, a.mask3, a.mask4, a.mask5, a.mask6, a.mask7 };
            }

            GUILayout.Space(a.top);

            int mask = (int)property.intValue;

            mask = EditorGUILayout.MaskField(property.displayName, mask, masks);

            if (Mathf.Abs(mask) > 32000)
            {
                mask = -1;
            }

            // Debug Value
            //EditorGUILayout.LabelField(mask.ToString());

            property.intValue = mask;

            GUI.enabled = true;

            GUILayout.Space(a.down);
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return -2;
        }
    }
}
