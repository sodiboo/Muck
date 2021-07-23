using System.Collections.Generic;
using UnityEngine;

public class EnemyHpBarsManager : MonoBehaviour
{
    public GameObject hpBarPrefab;

    private int nHpBars = 5;

    private MobHpBar[] hpBars;

    private float[] distances;

    private List<GameObject> onMobs;

    private Transform camera;

    public LayerMask whatIsEnemy;

    private void Awake()
    {
        onMobs = new List<GameObject>();
        hpBars = new MobHpBar[nHpBars];
        for (int i = 0; i < nHpBars; i++)
        {
            hpBars[i] = Object.Instantiate(hpBarPrefab).GetComponent<MobHpBar>();
            hpBars[i].gameObject.SetActive(value: false);
        }
    }

    private void Update()
    {
        if (!camera)
        {
            if (!PlayerMovement.Instance)
            {
                return;
            }
            camera = PlayerMovement.Instance.playerCam;
        }
        float radius = 4f;
        RaycastHit[] array = Physics.SphereCastAll(camera.position, radius, camera.forward, 100f, whatIsEnemy);
        RaycastHit[] array2;
        for (int i = 0; i < hpBars.Length; i++)
        {
            if (!(hpBars[i].attachedObject != null))
            {
                continue;
            }
            bool flag = false;
            array2 = array;
            foreach (RaycastHit raycastHit in array2)
            {
                if (raycastHit.transform.gameObject == hpBars[i].attachedObject)
                {
                    flag = true;
                    break;
                }
            }
            if (!flag)
            {
                hpBars[i].RemoveMob();
            }
        }
        array2 = array;
        for (int j = 0; j < array2.Length; j++)
        {
            RaycastHit hit = array2[j];
            if (hit.transform.CompareTag("NoHpBar"))
            {
                continue;
            }
            bool flag2 = false;
            for (int k = 0; k < nHpBars; k++)
            {
                if (hpBars[k].attachedObject == hit.transform.gameObject)
                {
                    flag2 = true;
                    break;
                }
            }
            if (!flag2)
            {
                MobHpBar mobHpBar = FindAvailableHpBar(hit);
                if (!(mobHpBar == null))
                {
                    mobHpBar.SetMob(hit.transform.gameObject);
                }
            }
        }
    }

    private MobHpBar FindAvailableHpBar(RaycastHit hit)
    {
        MobHpBar[] array = hpBars;
        foreach (MobHpBar mobHpBar in array)
        {
            if (!mobHpBar.gameObject.activeInHierarchy)
            {
                return mobHpBar;
            }
        }
        return null;
    }
}
