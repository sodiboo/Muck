using UnityEngine;

namespace Boxophobic.StyledGUI
{
    public class StyledMask : PropertyAttribute
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

        public int top = 0;
        public int down = 0;

        public StyledMask(string mask0, string mask1, int top, int down)
        {
            this.index = 2;

            this.mask0 = mask0;
            this.mask1 = mask1;

            this.top = top;
            this.down = down;
        }

        public StyledMask(string mask0, string mask1, string mask2, int top, int down)
        {
            this.index = 3;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;

            this.top = top;
            this.down = down;
        }

        public StyledMask(string mask0, string mask1, string mask2, string mask3, int top, int down)
        {
            this.index = 4;

            this.mask0 = mask0;
            this.mask1 = mask1;
            this.mask2 = mask2;
            this.mask3 = mask3;

            this.top = top;
            this.down = down;
        }

        public StyledMask(string mask0, string mask1, string mask2, string mask3, string mask4, int top, int down)
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

        public StyledMask(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, int top, int down)
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

        public StyledMask(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, string mask6, int top, int down)
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

        public StyledMask(string mask0, string mask1, string mask2, string mask3, string mask4, string mask5, string mask6, string mask7, int top, int down)
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
    }
}

