using System.Collections;
using UnityEngine;

public class GenerateAllResources : MonoBehaviour
{
    public GameObject[] spawnersFirst;

    public GameObject[] spawners;

    public static int seedOffset;

    private void Awake()
    {
        StartCoroutine(GenerateResources());
    }

    private IEnumerator GenerateResources()
    {
        for (int i = 0; i < spawnersFirst.Length; i++)
        {
            spawnersFirst[i].SetActive(value: true);
        }
        yield return 3000;
        for (int j = 0; j < spawners.Length; j++)
        {
            spawners[j].SetActive(value: true);
        }
    }
}
