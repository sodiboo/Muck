using System;
using System.Collections.Generic;
using UnityEngine;

public class TraderInteract : MonoBehaviour, SharedObject, Interactable
{
    private int id;

    private WoodmanBehaviour.WoodmanType type;

    private List<WoodmanTrades.Trade> buy;

    private List<WoodmanTrades.Trade> sell;

    public void SetType(WoodmanBehaviour.WoodmanType type, ConsistentRandom rand)
    {
        this.type = type;
        switch (type)
        {
        case WoodmanBehaviour.WoodmanType.Archer:
            GenerateTrades(TradesManager.Instance.archerTrades, rand);
            break;
        case WoodmanBehaviour.WoodmanType.Chef:
            GenerateTrades(TradesManager.Instance.chefTrades, rand);
            break;
        case WoodmanBehaviour.WoodmanType.Smith:
            GenerateTrades(TradesManager.Instance.smithTrades, rand);
            break;
        case WoodmanBehaviour.WoodmanType.Woodcutter:
            GenerateTrades(TradesManager.Instance.woodTrades, rand);
            break;
        case WoodmanBehaviour.WoodmanType.Wildcard:
            GenerateTrades(TradesManager.Instance.wildcardTrades, rand);
            break;
        default:
            GenerateTrades(TradesManager.Instance.archerTrades, rand);
            break;
        }
    }

    private void GenerateTrades(WoodmanTrades trades, ConsistentRandom rand)
    {
        trades = UnityEngine.Object.Instantiate(trades);
        buy = trades.GetTrades(5, 10, rand);
        sell = trades.GetTrades(5, 10, rand, 0.5f);
    }

    private void GenerateWildcardTrades()
    {
    }

    public void SetId(int id)
    {
        this.id = id;
    }

    public int GetId()
    {
        return id;
    }

    public void Interact()
    {
        TraderUI.Instance.SetTrades(buy, sell, type);
    }

    public void LocalExecute()
    {
        throw new NotImplementedException();
    }

    public void AllExecute()
    {
        throw new NotImplementedException();
    }

    public void ServerExecute(int fromClient = -1)
    {
        throw new NotImplementedException();
    }

    public void RemoveObject()
    {
        throw new NotImplementedException();
    }

    public string GetName()
    {
        return $"Press {InputManager.interact} to trade with {type}";
    }

    public bool IsStarted()
    {
        throw new NotImplementedException();
    }
}
