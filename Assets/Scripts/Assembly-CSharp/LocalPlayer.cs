using UnityEngine;

public class LocalPlayer : MonoBehaviour
{
    public GameObject[] objects;

    public void SwitchUserInterface(bool b)
    {
        GameObject[] array = objects;
        for (int i = 0; i < array.Length; i++)
        {
            array[i].SetActive(b);
        }
    }
}
