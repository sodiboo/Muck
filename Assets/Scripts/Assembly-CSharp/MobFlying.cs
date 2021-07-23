using UnityEngine;

public class MobFlying : Mob
{
    private float defaultHeight = 5.6f;

    public LayerMask whatIsGround;

    public override void ExtraUpdate()
    {
        if ((bool)base.target && Physics.Raycast(base.target.transform.position, Vector3.down, out var hitInfo, 5000f, whatIsGround))
        {
            float num = hitInfo.distance;
            float b = defaultHeight + num;
            base.agent.baseOffset = Mathf.Lerp(base.agent.baseOffset, b, Time.deltaTime * 0.3f);
        }
    }
}
