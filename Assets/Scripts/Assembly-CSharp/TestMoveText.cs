using System.Collections.Generic;
using UnityEngine;

public class TestMoveText : MonoBehaviour
{
    private List<int> toSurface;

    private List<int> notSurfacing;

    private Transform[] children;

    private Vector3 startHeight;

    public Material[] mats;

    public GameObject[] trees;

    private int a;

    public LayerMask whatIsGround;

    public Vector3 drawArea;

    private void Awake()
    {
        toSurface = new List<int>();
        notSurfacing = new List<int>();
        children = GetComponentsInChildren<Transform>();
        startHeight = new Vector3(1f, base.transform.GetChild(0).position.y, 1f);
        Transform[] array = children;
        foreach (Transform transform in array)
        {
            transform.transform.position += Vector3.down * 50f;
            notSurfacing.Add(transform.GetSiblingIndex());
        }
        float num = 0.08f;
        float num2 = 2f;
        InvokeRepeating(nameof(SlowUpdate), num2, num);
        InvokeRepeating(nameof(AddMaterial), num * (float)base.transform.childCount + num2 + 2f, 0.05f);
    }

    private void AddMaterial()
    {
        a++;
        if (a > 50)
        {
            CancelInvoke();
        }
        for (int i = 0; i < 100; i++)
        {
            GameObject gameObject = trees[Random.Range(0, trees.Length)];
            Vector3 vector = new Vector3(Random.Range((0f - drawArea.x) / 2f, drawArea.x / 2f), 80f, Random.Range((0f - drawArea.z) / 2f, drawArea.z / 2f));
            Vector3 vector2 = base.transform.position + vector;
            Debug.DrawLine(vector2, vector2 + Vector3.down * 120f, Color.red, 10f);
            Debug.DrawLine(Vector3.zero, vector2 * 50f, Color.black, 10f);
            if (!Physics.Raycast(vector2, Vector3.down, out var hitInfo, 120f, whatIsGround) || Vector3.Angle(hitInfo.normal, Vector3.up) > 5f)
            {
                continue;
            }
            Transform transform = Object.Instantiate(gameObject, hitInfo.point, gameObject.transform.rotation).transform;
            HitableResource component = transform.GetComponent<HitableResource>();
            if ((bool)component)
            {
                float num = 1f;
                if (transform.CompareTag("Count"))
                {
                    num = 3f;
                }
                component.SetDefaultScale(Vector3.one * 0.2f * num);
                component.PopIn();
            }
        }
    }

    private void SlowUpdate()
    {
        int index = Random.Range(0, notSurfacing.Count);
        int item = notSurfacing[index];
        toSurface.Add(item);
        notSurfacing.Remove(item);
        if (notSurfacing.Count <= 0)
        {
            CancelInvoke(nameof(SlowUpdate));
        }
    }

    private void Update()
    {
        int num = 0;
        foreach (int item in toSurface)
        {
            num++;
            Transform child = base.transform.GetChild(item);
            child.position = Vector3.Lerp(child.position, new Vector3(child.position.x, startHeight.y, child.position.z), Time.deltaTime * 5f);
        }
    }
}
