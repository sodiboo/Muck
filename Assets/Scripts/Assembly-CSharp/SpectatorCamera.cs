using UnityEngine;

public class SpectatorCamera : MonoBehaviour
{
    public Transform target;

    private bool ready;

    private int targetId;

    private string targetName;

    public static SpectatorCamera Instance { get; private set; }

    private void OnEnable()
    {
        ready = false;
        Invoke("GetReady", 1f);
    }

    private void Awake()
    {
        Instance = this;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            targetId++;
            target = null;
            targetName = "";
        }
        if (ready && (bool)target && target.gameObject.activeInHierarchy && (bool)target)
        {
            Transform child = target.GetChild(0);
            base.transform.position = target.position - child.forward * 5f + Vector3.up * 2f;
            base.transform.LookAt(target);
        }
    }

    public void SetTarget(Transform target, string name)
    {
        this.target = target;
    }

    private void GetReady()
    {
        ready = true;
    }
}
