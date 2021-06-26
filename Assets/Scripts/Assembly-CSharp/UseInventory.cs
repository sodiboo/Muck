using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Steamworks;
using UnityEngine.Analytics;

public class UseInventory : MonoBehaviour
{

    private void Awake()
    {
        UseInventory.Instance = this;
        foreach (AnimationClip animationClip in this.animator.runtimeAnimatorController.animationClips)
        {
            string name = animationClip.name;
            if (!(name == "Attack"))
            {
                if (!(name == "Eat"))
                {
                    if (name == "Charge")
                    {
                        this.chargeTime = animationClip.length;
                    }
                }
                else
                {
                    this.eatTime = animationClip.length;
                }
            }
            else
            {
                this.attackTime = animationClip.length;
            }
        }
        this.eatingEmission = this.eatingParticles.emission;
        this.eatingEmission.enabled = false;
        this.velocity = this.eatingParticles.velocityOverLifetime;
        this.SetWeapon(null);
    }


    public void SetWeapon(InventoryItem item)
    {
        this.StopUse();
        this.currentItem = item;
        if (item == null)
        {
            this.meshRenderer.material = null;
            this.meshFilter.mesh = null;
            return;
        }
        if (item.swingFx)
        {
            this.swingTrail.gameObject.SetActive(true);
        }
        else
        {
            this.swingTrail.gameObject.SetActive(false);
        }
        this.renderTransform.localRotation = Quaternion.Euler(item.rotationOffset);
        this.renderTransform.localScale = Vector3.one * item.scale;
        this.renderTransform.localPosition = item.positionOffset;
        this.meshRenderer.materials = new Material[item.mats].Select(_ => item.material).ToArray();
        this.meshFilter.mesh = item.mesh;
        this.hitBox.transform.parent.localScale = item.attackRange;
        this.animator.SetFloat("AttackSpeed", this.currentItem.attackSpeed);
        this.animator.Play("Equip", -1, 0f);
    }


    private void StopUse()
    {
        if (this.IsAnimationPlaying("Eat"))
        {
            this.eatSfx.Stop();
            this.eatingEmission.enabled = false;
        }
        base.CancelInvoke();
        this.animator.Play("Idle");
        CooldownBar.Instance.HideBar();
        this.eatingEmission.enabled = false;
    }


    private void Update()
    {
        if (this.IsAnimationPlaying("Eat"))
        {
            Vector3 vector = PlayerMovement.Instance.GetVelocity();
            this.velocity.x = vector.x;
            this.velocity.y = vector.y;
            this.velocity.z = vector.z;
        }
    }


    public void Use()
    {
        if (this.currentItem == null)
        {
            return;
        }
        if (OtherInput.Instance.IsAnyMenuOpen())
        {
            return;
        }
        if (this.IsAnimationPlaying("Attack") || this.IsAnimationPlaying("Equip") || this.IsAnimationPlaying("Eat") || this.IsAnimationPlaying("Charge") || this.IsAnimationPlaying("ChargeHold") || this.IsAnimationPlaying("Shoot"))
        {
            return;
        }
        if (currentItem.name == "Precision Delete") return;
        float num = this.attackTime;
        float num2 = this.currentItem.attackSpeed;
        num2 *= PowerupInventory.Instance.GetAttackSpeedMultiplier(null);
        num /= num2;
        bool stayOnScreen = false;
        string stateName;
        if (this.currentItem.tag == InventoryItem.ItemTag.Food)
        {
            num = this.eatTime / num2;
            stateName = "Eat";
            this.eatSfx.Stop();
            base.CancelInvoke(nameof(FinishEating));
            this.eatSfx.PlayDelayed(0.3f / num2);
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, true);
            base.Invoke(nameof(FinishEating), num * 0.95f);
            base.Invoke(nameof(StartParticles), num * 0.25f);
        }
        else if (this.currentItem.type == InventoryItem.ItemType.Bow)
        {
            float robinMultiplier = PowerupInventory.Instance.GetRobinMultiplier(null);
            num = this.chargeTime / (num2 * robinMultiplier);
            stateName = "Charge";
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, true);
            this.chargeSfx.Play();
            this.chargeSfx.pitch = this.currentItem.attackSpeed;
            stayOnScreen = true;
        }
        else
        {
            this.swingSfx.Randomize(0.15f / num2);
            stateName = "Attack" + Random.Range(1, 4);
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Attack, true);
        }
        this.animator.Play(stateName);
        this.animator.SetFloat("AttackSpeed", num2);
        CooldownBar.Instance.ResetCooldownTime(num, stayOnScreen);
    }


    private void StartParticles()
    {
        this.eatingEmission.enabled = true;
    }

    public void UseButtonUp()
    {
        if (currentItem && currentItem.tag == InventoryItem.ItemTag.Precision)
        {
            if (!BuildDestruction.dontDestroy)
            {
                ChatBox.Instance.AppendMessage(-1, LocalClient.serverOwner ? "<color=red>Cannot use precision delete right now. Please run /dontdestroyneighbors first.<color=white>" : $"<color=red>Cannot use precision delete right now. Please ask the host ({new Friend(LocalClient.instance.serverHost).Name}) to run /dontdestroyneighbors first.<color=white>", "");
                return;
            }
            if (Physics.Raycast(PlayerMovement.Instance.playerCam.position, PlayerMovement.Instance.playerCam.forward, out var hit, float.PositiveInfinity, 1 << LayerMask.NameToLayer("Object"), Input.GetKey(InputManager.precisionRotate) ? QueryTriggerInteraction.Collide : QueryTriggerInteraction.Ignore))
            {
                Hitable target;
                if (!hit.collider.TryGetComponent<Hitable>(out target) && hit.collider.transform.parent && !hit.collider.transform.parent.TryGetComponent<Hitable>(out target)) return;
                target.GetComponent<Hitable>().Hit(int.MaxValue, 1, 0, hit.point);
            }
            return;
        }
        if (this.IsAnimationPlaying("Eat"))

        {
            this.animator.Play("Idle");
            this.eatingEmission.enabled = false;
            CooldownBar.Instance.HideBar();
            this.eatSfx.Stop();
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
            base.CancelInvoke();
        }
        if (this.IsAnimationPlaying("Charge") || this.IsAnimationPlaying("ChargeHold"))
        {
            this.chargeSfx.Stop();
            ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, false);
            this.ReleaseWeapon();
        }
    }


    private void ReleaseWeapon()
    {
        float num = 0f;
        if (this.IsAnimationPlaying("ChargeHold"))
        {
            num = 1f;
        }
        else
        {
            num = this.animator.GetCurrentAnimatorStateInfo(0).normalizedTime;
            MonoBehaviour.print("charge: " + num);
        }
        ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, false);
        this.animator.Play("Shoot", -1, 0f);
        CooldownBar.Instance.HideBar();
        if (InventoryUI.Instance.arrows.currentItem == null)
        {
            return;
        }
        InventoryItem inventoryItem = Hotbar.Instance.currentItem;
        InventoryItem inventoryItem2 = InventoryUI.Instance.arrows.currentItem;
        List<Collider> list = new List<Collider>();
        int num2 = 0;
        while (num2 < inventoryItem.bowComponent.nArrows && !(InventoryUI.Instance.arrows.currentItem == null))
        {
            inventoryItem2.amount--;
            if (inventoryItem2.amount <= 0)
            {
                InventoryUI.Instance.arrows.currentItem = null;
            }
            Vector3 vector = PlayerMovement.Instance.playerCam.position + Vector3.down * 0.5f;
            Vector3 vector2 = PlayerMovement.Instance.playerCam.forward;
            float num3 = (float)inventoryItem.bowComponent.angleDelta;
            vector2 = Quaternion.AngleAxis(-(num3 * (float)(inventoryItem.bowComponent.nArrows - 1)) / 2f + num3 * (float)num2, PlayerMovement.Instance.playerCam.up) * vector2;
            GameObject gameObject = Instantiate<GameObject>(inventoryItem2.prefab);
            gameObject.GetComponent<Renderer>().material = inventoryItem2.material;
            gameObject.transform.position = vector;
            gameObject.transform.rotation = base.transform.rotation;
            float num4 = (float)Hotbar.Instance.currentItem.attackDamage;
            float num5 = (float)inventoryItem2.attackDamage;
            float projectileSpeed = inventoryItem.bowComponent.projectileSpeed;
            Rigidbody component = gameObject.GetComponent<Rigidbody>();
            float num6 = 100f * num * projectileSpeed * PowerupInventory.Instance.GetRobinMultiplier(null);
            component.AddForce(vector2 * num6);
            Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), PlayerMovement.Instance.GetPlayerCollider(), true);
            float num7 = num5 * num4;
            num7 *= num;
            Arrow component2 = gameObject.GetComponent<Arrow>();
            component2.damage = (int)(num7 * PowerupInventory.Instance.GetRobinMultiplier(null));
            component2.fallingWhileShooting = (!PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f);
            component2.speedWhileShooting = PlayerMovement.Instance.GetVelocity().magnitude;
            component2.item = inventoryItem2;
            ClientSend.ShootArrow(vector, vector2, num6, inventoryItem2.id);
            list.Add(component2.GetComponent<Collider>());
            num2++;
        }
        foreach (Collider collider in list)
        {
            foreach (Collider collider2 in list)
            {
                Physics.IgnoreCollision(collider, collider2, true);
            }
        }
        InventoryUI.Instance.arrows.UpdateCell();
        CameraShaker.Instance.ChargeShake(num);
    }


    private void FinishEating()
    {
        this.eatSfx.Stop();
        this.eatingEmission.enabled = false;
        PlayerStatus.Instance.Eat(this.currentItem);
        ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
        Hotbar.Instance.UseItem(1);
    }


    private bool IsAnimationPlaying(string animationName)
    {
        if (this.animator.GetCurrentAnimatorClipInfo(0).Length == 0)
        {
            return false;
        }
        string name = this.animator.GetCurrentAnimatorClipInfo(0)[0].clip.name;
        return name.Contains(animationName) || animationName == name;
    }


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
}
