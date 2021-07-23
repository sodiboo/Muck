using UnityEngine;

public class GraveInteract : MonoBehaviour, SharedObject, Interactable
{
    private int id;

    private bool holding;

    private float holdTime;

    private float requiredHoldTime = 3f;

    public int playerId { get; set; }

    public string username { get; set; }

    public float timeLeft { get; set; } = 30f;


    public void SetTime(float time)
    {
        timeLeft = time;
    }

    private void Update()
    {
        if (timeLeft > 0f)
        {
            timeLeft -= Time.deltaTime;
            if (timeLeft <= 0f)
            {
                timeLeft = 0f;
            }
        }
        if (holding)
        {
            if (!PlayerMovement.Instance || Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) > 6f || !Input.GetKey(InputManager.interact) || PlayerStatus.Instance.IsPlayerDead())
            {
                StopHolding();
            }
            holdTime += Time.deltaTime;
            if (holdTime >= requiredHoldTime)
            {
                ClientSend.RevivePlayer(playerId, id, grave: true);
                StopHolding();
            }
        }
    }

    private void StartHolding()
    {
        CooldownBar.Instance.ResetCooldownTime(requiredHoldTime, stayOnScreen: true);
        holding = true;
        holdTime = 0f;
    }

    private void StopHolding()
    {
        holding = false;
        CooldownBar.Instance.HideBar();
        holdTime = 0f;
    }

    public void Interact()
    {
        if (IsDay() && !(timeLeft > 0f))
        {
            StartHolding();
        }
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
        Object.Destroy(base.gameObject.transform.parent.gameObject);
    }

    public void ServerExecute(int fromClient)
    {
    }

    public void RemoveObject()
    {
        Object.Destroy(base.gameObject.transform.parent.gameObject);
    }

    public string GetName()
    {
        if (timeLeft > 0f)
        {
            int num = Mathf.CeilToInt(timeLeft);
            return $"Can revive {username} in {num} seconds";
        }
        if (IsDay())
        {
            return $"Hold {InputManager.interact} to revive";
        }
        return "Can only revive during day..";
    }

    public bool IsStarted()
    {
        return false;
    }

    public void SetId(int id)
    {
        this.id = id;
    }

    public int GetId()
    {
        return id;
    }

    public bool IsDay()
    {
        if (DayCycle.time > 0f)
        {
            return DayCycle.time < 0.5f;
        }
        return false;
    }
}
