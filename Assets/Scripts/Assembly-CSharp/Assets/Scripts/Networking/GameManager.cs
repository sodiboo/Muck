using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Networking
{
    public class GameManager
    {
        public static GameState state;

        public static void StartGame()
        {
            if (NumPlayersLeftInServer() < 4 || state == GameState.Playing)
            {
                return;
            }
            state = GameState.Playing;
            Debug.Log("Starting game");
            List<int> list = new List<int>();
            foreach (Client value in Server.clients.Values)
            {
                if (value?.player != null)
                {
                    list.Add(value.id);
                }
            }
        }

        public void FindSpawnPositions()
        {
        }

        public static int NumPlayersLeftInGame()
        {
            int num = 0;
            foreach (Client value in Server.clients.Values)
            {
                if (value?.player != null)
                {
                    num++;
                }
            }
            return num;
        }

        public static int NumPlayersLeftAlive()
        {
            int num = 0;
            foreach (Client value in Server.clients.Values)
            {
                if (value?.player != null && !value.player.dead)
                {
                    num++;
                }
            }
            return num;
        }

        public static int NumPlayersLeftInServer()
        {
            int num = 0;
            foreach (Client value in Server.clients.Values)
            {
                if (value.player != null)
                {
                    num++;
                }
            }
            return num;
        }

        public static int NumPlayersReady()
        {
            int num = 0;
            foreach (Client value in Server.clients.Values)
            {
                if (value?.player != null && value.player.ready)
                {
                    num++;
                }
            }
            return num;
        }
    }
}
