// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System;

namespace Boxophobic.StyledGUI
{
    public class StyledMaskDrawer : MaterialPropertyDrawer
    {
        public int index = 0;
        public string mask0 = "";
        public string mask1 = "";
        public string mask2 = "";
        public string mask3 = "";
        public string mask4 = "";
        public string mask5 = "";
        public string mask6 = "";
        public string mask7 = "";

        public float top = 0;
        public float down = 0;

        public StyledMaskDrawer(string mask0, string mask1, float top, float down)
        {
            this.index = 2;

            this.mask0 = mask0;
            this.mask1 = mask1;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, float top, float down)
        {
            this.index = 3;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, float top, float down)
        {
            this.index = 4;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;

            this.top = top;
            this.down = down;
        }
        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, int top, int down)
        {
            this.index = 4;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, string mask4, int top, int down)
        {
            this.index = 5;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;
            this.mask4 = mask4;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, int top, int down)
        {
            this.index = 6;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;
            this.mask4 = mask4;
            this.mask5 = mask5;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, string mask6, int top, int down)
        {
            this.index = 7;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;
            this.mask4 = mask4;
            this.mask5 = mask5;
            this.mask6 = mask6;

            this.top = top;
            this.down = down;
        }

        public StyledMaskDrawer(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, string mask6, string mask7, int top, int down)
        {
            this.index = 8;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;
            this.mask4 = mask4;
            this.mask5 = mask5;
            this.mask6 = mask6;
            this.mask7 = mask7;

            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor materialEditor)
        {
            GUIStyle styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                wordWrap = true
            };

            string[] masks = new string[] { mask0, mask1 };

            if (index == 3)
            {
                masks = new string[] { mask0, mask1, mask2 };
            }
            else if (index == 4)
            {
                masks = new string[] { mask0, mask1, mask2, mask3 };
            }
            else if (index == 5)
            {
                masks = new string[] { mask0, mask1, mask2, mask3, mask4 };
            }
            else if (index == 6)
            {
                masks = new string[] { mask0, mask1, mask2, mask3, mask4, mask5 };
            }
            else if (index == 7)
            {
                masks = new string[] { mask0, mask1, mask2, mask3, mask4, mask5, mask6 };
            }
            else if (index == 8)
            {
                masks = new string[] { mask0, mask1, mask2, mask3, mask4, mask5, mask6, mask7 };
            }

            GUILayout.Space(top);

            int mask = (int)prop.floatValue;

            mask = EditorGUILayout.MaskField(prop.displayName, mask, masks);

            if (mask < 0)
            {
                mask = -1;
            }

            // Debug Value
            //EditorGUILayout.LabelField(mask.ToString());

            prop.floatValue = mask;

            GUI.enabled = true;

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
}
