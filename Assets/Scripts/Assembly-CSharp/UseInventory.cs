using System.Collections.Generic;
using UnityEngine;

public class UseInventory : MonoBehaviour
{
    public static UseInventory Instance;

    public HitBox hitBox;

    public Animator animator;

    public TrailRenderer swingTrail;

    public RandomSfx swingSfx;

    public AudioSource chargeSfx;

    public AudioSource eatSfx;

    public ParticleSystem eatingParticles;

    private ParticleSystem.EmissionModule eatingEmission;

    private ParticleSystem.VelocityOverLifetimeModule velocity;

    private float eatTime;

    private float attackTime;

    private float chargeTime;

    public MeshRenderer meshRenderer;

    public MeshFilter meshFilter;

    public Transform renderTransform;

    private InventoryItem currentItem;

    private void Awake()
    {
        Instance = this;
        AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
        foreach (AnimationClip animationClip in animationClips)
        {
            switch (animationClip.name)
            {
            case "Attack":
                attackTime = animationClip.length;
                break;
            case "Eat":
                eatTime = animationClip.length;
                break;
            case "Charge":
                chargeTime = animationClip.length;
                break;
            }
        }
        eatingEmission = eatingParticles.emission;
        eatingEmission.enabled = false;
        velocity = eatingParticles.velocityOverLifetime;
        SetWeapon(null);
    }

    public void SetWeapon(InventoryItem item)
    {
        StopUse();
        currentItem = item;
        if (item == null)
        {
            meshRenderer.material = null;
            meshFilter.mesh = null;
            return;
        }
        if (item.swingFx)
        {
            swingTrail.gameObject.SetActive(value: true);
        }
        else
        {
            swingTrail.gameObject.SetActive(value: false);
        }
        renderTransform.localRotation = Quaternion.Euler(item.rotationOffset);
        renderTransform.localScale = Vector3.one * item.scale;
        renderTransform.localPosition = item.positionOffset;
        meshRenderer.material = item.material;
        meshFilter.mesh = item.mesh;
        animator.SetFloat("AttackSpeed", currentItem.attackSpeed);
        animator.Play("Equip", -1, 0f);
        if ((bool)AchievementManager.Instance)
        {
            AchievementManager.Instance.WieldedWeapon(item);
        }
    }

    private void StopUse()
    {
        if (IsAnimationPlaying("Eat"))
        {
            eatSfx.Stop();
            eatingEmission.enabled = false;
        }
        CancelInvoke();
        animator.Play("Idle");
        CooldownBar.Instance.HideBar();
        eatingEmission.enabled = false;
    }

    private void Update()
    {
        if (IsAnimationPlaying("Eat"))
        {
            Vector3 vector = PlayerMovement.Instance.GetVelocity();
            velocity.x = vector.x;
            velocity.y = vector.y;
            velocity.z = vector.z;
        }
    }

    public void Use()
    {
        if (!(currentItem == null) && !OtherInput.Instance.IsAnyMenuOpen() && !IsAnimationPlaying("Attack") && !IsAnimationPlaying("Equip") && !IsAnimationPlaying("Eat") && !IsAnimationPlaying("Charge") && !IsAnimationPlaying("ChargeHold") && !IsAnimationPlaying("Shoot"))
        {
            float num = attackTime;
            string text = "";
            float attackSpeed = currentItem.attackSpeed;
            attackSpeed *= PowerupInventory.Instance.GetAttackSpeedMultiplier(null);
            num /= attackSpeed;
            bool stayOnScreen = false;
            if (currentItem.tag == InventoryItem.ItemTag.Food)
            {
                num = eatTime / attackSpeed;
                text = "Eat";
                eatSfx.Stop();
                CancelInvoke(nameof(FinishEating));
                eatSfx.PlayDelayed(0.3f / attackSpeed);
                ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, b: true);
                Invoke(nameof(FinishEating), num * 0.95f);
                Invoke(nameof(StartParticles), num * 0.25f);
            }
            else if (currentItem.type == InventoryItem.ItemType.Bow)
            {
                float robinMultiplier = PowerupInventory.Instance.GetRobinMultiplier(null);
                num = chargeTime / (attackSpeed * robinMultiplier);
                text = "Charge";
                ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, b: true);
                chargeSfx.Play();
                chargeSfx.pitch = currentItem.attackSpeed;
                stayOnScreen = true;
            }
            else
            {
                swingSfx.Randomize(0.15f / attackSpeed);
                text = "Attack" + Random.Range(1, 4);
                ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Attack, b: true);
            }
            animator.Play(text);
            animator.SetFloat("AttackSpeed", attackSpeed);
            CooldownBar.Instance.ResetCooldownTime(num, stayOnScreen);
        }
    }

    private void StartParticles()
    {
        eatingEmission.enabled = true;
    }

    public void UseButtonUp()
    {
        if (IsAnimationPlaying("Eat"))
        {
            animator.Play("Idle");
            eatingEmission.enabled = false;
            CooldownBar.Instance.HideBar();
            eatSfx.Stop();
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, b: false);
            CancelInvoke();
        }
        if (IsAnimationPlaying("Charge") || IsAnimationPlaying("ChargeHold"))
        {
            chargeSfx.Stop();
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, b: false);
            ReleaseWeapon();
        }
    }

    private void ReleaseWeapon()
    {
        float num = 0f;
        if (IsAnimationPlaying("ChargeHold"))
        {
            num = 1f;
        }
        else
        {
            num = animator.GetCurrentAnimatorStateInfo(0).normalizedTime;
            MonoBehaviour.print("charge: " + num);
        }
        ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, b: false);
        animator.Play("Shoot", -1, 0f);
        CooldownBar.Instance.HideBar();
        if (InventoryUI.Instance.arrows.currentItem == null)
        {
            return;
        }
        InventoryItem inventoryItem = Hotbar.Instance.currentItem;
        InventoryItem inventoryItem2 = InventoryUI.Instance.arrows.currentItem;
        List<Collider> list = new List<Collider>();
        for (int i = 0; i < inventoryItem.bowComponent.nArrows; i++)
        {
            if (InventoryUI.Instance.arrows.currentItem == null)
            {
                break;
            }
            inventoryItem2.amount--;
            if (inventoryItem2.amount <= 0)
            {
                InventoryUI.Instance.arrows.currentItem = null;
            }
            Vector3 vector = PlayerMovement.Instance.playerCam.position + Vector3.down * 0.5f;
            Vector3 forward = PlayerMovement.Instance.playerCam.forward;
            float num2 = inventoryItem.bowComponent.angleDelta;
            forward = Quaternion.AngleAxis((0f - num2 * (float)(inventoryItem.bowComponent.nArrows - 1)) / 2f + num2 * (float)i, PlayerMovement.Instance.playerCam.up) * forward;
            GameObject obj = Object.Instantiate(inventoryItem2.prefab);
            obj.GetComponent<Renderer>().material = inventoryItem2.material;
            obj.transform.position = vector;
            obj.transform.rotation = base.transform.rotation;
            float num3 = Hotbar.Instance.currentItem.attackDamage;
            float num4 = inventoryItem2.attackDamage;
            float projectileSpeed = inventoryItem.bowComponent.projectileSpeed;
            Rigidbody component = obj.GetComponent<Rigidbody>();
            float num5 = 100f * num * projectileSpeed * PowerupInventory.Instance.GetRobinMultiplier(null);
            component.AddForce(forward * num5);
            Physics.IgnoreCollision(obj.GetComponent<Collider>(), PlayerMovement.Instance.GetPlayerCollider(), ignore: true);
            float num6 = num4 * num3;
            num6 *= num;
            Arrow component2 = obj.GetComponent<Arrow>();
            component2.damage = (int)(num6 * PowerupInventory.Instance.GetRobinMultiplier(null));
            component2.fallingWhileShooting = !PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f;
            component2.speedWhileShooting = PlayerMovement.Instance.GetVelocity().magnitude;
            component2.item = inventoryItem2;
            ClientSend.ShootArrow(vector, forward, num5, inventoryItem2.id);
            list.Add(component2.GetComponent<Collider>());
        }
        foreach (Collider item in list)
        {
            foreach (Collider item2 in list)
            {
                Physics.IgnoreCollision(item, item2, ignore: true);
            }
        }
        InventoryUI.Instance.arrows.UpdateCell();
        CameraShaker.Instance.ChargeShake(num);
    }

    private void FinishEating()
    {
        eatSfx.Stop();
        eatingEmission.enabled = false;
        PlayerStatus.Instance.Eat(currentItem);
        ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, b: false);
        Hotbar.Instance.UseItem(1);
    }

    private bool IsAnimationPlaying(string animationName)
    {
        if (animator.GetCurrentAnimatorClipInfo(0).Length == 0)
        {
            return false;
        }
        string text = animator.GetCurrentAnimatorClipInfo(0)[0].clip.name;
        if (text.Contains(animationName))
        {
            return true;
        }
        return animationName == text;
    }
}
