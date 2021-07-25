using System.Collections.Generic;
using UnityEngine;

public class BuildDestruction : MonoBehaviour
{
    public bool connectedToGround;

    public bool directlyGrounded;

    public bool started;

    public bool destroyed;

    private List<BuildDestruction> otherBuilds = new List<BuildDestruction>();

    private BoxCollider trigger;

    private void Awake()
    {
        Invoke(nameof(CheckDirectlyGrounded), 2f);
    }

    private void Start()
    {
        BoxCollider[] components = GetComponents<BoxCollider>();
        foreach (BoxCollider boxCollider in components)
        {
            if (boxCollider.isTrigger)
            {
                trigger = boxCollider;
                break;
            }
        }
        trigger.size *= 1.1f;
    }

    private void Update()
    {
    }

    private void OnDestroy()
    {
        destroyed = true;
        List<BuildDestruction> list = new List<BuildDestruction>();
        list.Add(this);
        for (int num = otherBuilds.Count - 1; num >= 0; num--)
        {
            if (!(otherBuilds[num] == null) && !otherBuilds[num].IsDirectlyGrounded(list))
            {
                otherBuilds[num].DestroyBuild();
            }
        }
    }

    private void DestroyBuild()
    {
        Hitable component = GetComponent<Hitable>();
        component.Hit(component.hp, 1f, 1, base.transform.position, -1);
    }

    public bool IsDirectlyGrounded(List<BuildDestruction> alreadyChecked)
    {
        if (directlyGrounded)
        {
            return true;
        }
        foreach (BuildDestruction otherBuild in otherBuilds)
        {
            if (!(otherBuild == null) && !alreadyChecked.Contains(otherBuild))
            {
                alreadyChecked.Add(otherBuild);
                if (otherBuild.IsDirectlyGrounded(alreadyChecked))
                {
                    return true;
                }
            }
        }
        return false;
    }

    private void CheckDirectlyGrounded()
    {
        Rigidbody component = GetComponent<Rigidbody>();
        Object.Destroy(trigger);
        Object.Destroy(component);
    }

    private void OnTriggerEnter(Collider collision)
    {
        if (collision.gameObject.layer == LayerMask.NameToLayer("Ground"))
        {
            directlyGrounded = true;
            connectedToGround = true;
        }
        if (collision.CompareTag("Build"))
        {
            BuildDestruction component = collision.GetComponent<BuildDestruction>();
            if (!otherBuilds.Contains(component))
            {
                MonoBehaviour.print("added a build: " + collision.gameObject.name);
                otherBuilds.Add(component);
            }
        }
    }

    private void OnDrawGizmos()
    {
    }
}
