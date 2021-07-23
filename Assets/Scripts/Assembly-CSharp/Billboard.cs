using UnityEngine;

public class Billboard : MonoBehaviour
{
    private Vector3 defaultScale;

    public bool xz;

    public bool affectScale;

    private Transform t;

    private void Awake()
    {
        defaultScale = base.transform.localScale;
    }

    private void Update()
    {
        if (!t)
        {
            if (t == null || !t.gameObject.activeInHierarchy)
            {
                if ((bool)PlayerMovement.Instance)
                {
                    t = PlayerMovement.Instance.playerCam;
                }
                else if ((bool)Camera.main)
                {
                    t = Camera.main.transform;
                }
            }
        }
        else
        {
            base.transform.LookAt(t);
            if (!xz)
            {
                base.transform.rotation = Quaternion.Euler(0f, base.transform.rotation.eulerAngles.y + 180f, 0f);
            }
            if (affectScale)
            {
                base.transform.localScale = defaultScale;
            }
        }
    }
}
