using UnityEngine;

public class TestCenterDeleteThisLol : MonoBehaviour
{
    public MobType mob;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.L))
        {
            int nextId = MobManager.Instance.GetNextId();
            int id = mob.id;
            Vector3 position = PlayerMovement.Instance.transform.position;
            MobSpawner.Instance.ServerSpawnNewMob(nextId, id, position, 1f, 1f);
        }
    }
}
