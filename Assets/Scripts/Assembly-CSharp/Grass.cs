using System.Collections.Generic;
using UnityEngine;

public class Grass : MonoBehaviour
{
    public float length;

    public int thicc = 10;

    public GameObject grass;

    private GameObject[,] grassPool;

    private Dictionary<(float, float), int> grassPositions;

    public LayerMask whatIsGround;

    private float updateRate = 0.02f;

    private void Awake()
    {
        grassPool = new GameObject[thicc, thicc];
        grassPositions = new Dictionary<(float, float), int>();
        for (int i = 0; i < thicc; i++)
        {
            for (int j = 0; j < thicc; j++)
            {
                grassPool[i, j] = Object.Instantiate(grass);
            }
        }
        InvokeRepeating(nameof(MakeGrass), 0f, updateRate);
    }

    private void MakeGrass()
    {
        float num = length / (float)thicc;
        for (int i = 0; i < thicc; i++)
        {
            for (int j = 0; j < thicc; j++)
            {
                float num2 = base.transform.position.x - base.transform.position.x % num;
                float num3 = base.transform.position.z - base.transform.position.z % num;
                float x = num2 + (float)(i - thicc / 2) / (float)thicc * length;
                float z = num3 + (float)(j - thicc / 2) / (float)thicc * length;
                Vector3 vector = new Vector3(x, base.transform.position.y + 50f, z);
                if (Physics.Raycast(vector, Vector3.down, out var hitInfo, 60f, whatIsGround))
                {
                    Debug.DrawLine(vector, hitInfo.point, Color.blue);
                    vector.y = hitInfo.point.y;
                    Quaternion rotation = Quaternion.LookRotation(Vector3.Cross(Vector3.up, hitInfo.normal));
                    Transform obj = grassPool[i, j].transform;
                    obj.gameObject.SetActive(value: true);
                    obj.position = vector;
                    obj.rotation = rotation;
                    obj.localScale = Vector3.one * Random.Range(0.85f, 1.4f);
                }
                else
                {
                    grassPool[i, j].SetActive(value: false);
                }
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.green;
        Gizmos.DrawWireCube(base.transform.position, Vector3.one * length);
    }
}
