using System.Collections.Generic;
using UnityEngine;

public class CountPlayersOnBoat : MonoBehaviour
{
    public List<PlayerManager> players;

    private void OnTriggerEnter(Collider other)
    {
        GameObject gameObject = other.gameObject;
        if (gameObject.layer == LayerMask.NameToLayer("Player"))
        {
            PlayerManager component = gameObject.GetComponent<PlayerManager>();
            if ((bool)component)
            {
                players.Add(component);
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        GameObject gameObject = other.gameObject;
        if (gameObject.layer == LayerMask.NameToLayer("Player"))
        {
            PlayerManager component = gameObject.GetComponent<PlayerManager>();
            if ((bool)component)
            {
                players.Remove(component);
            }
        }
    }
}
