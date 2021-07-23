using System.Linq;
using UnityEngine;

public class TestAchievements : MonoBehaviour
{
    public WoodmanTrades[] ye;

    public WoodmanTrades wildcard;

    private void Awake()
    {
        Object.DontDestroyOnLoad(base.gameObject);
    }

    private void Start()
    {
        FillWildcard();
    }

    private void FillWildcard()
    {
        WoodmanTrades.Trade[] array = new WoodmanTrades.Trade[0];
        WoodmanTrades[] array2 = ye;
        foreach (WoodmanTrades woodmanTrades in array2)
        {
            array = array.Concat(woodmanTrades.trades).ToArray();
        }
        wildcard.trades = new WoodmanTrades.Trade[array.Length];
        for (int j = 0; j < array.Length; j++)
        {
            WoodmanTrades.Trade trade = array[j];
            WoodmanTrades.Trade trade2 = new WoodmanTrades.Trade();
            trade2.amount = trade.amount;
            trade2.item = trade.item;
            trade2.price = trade.price;
            wildcard.trades[j] = trade2;
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.K))
        {
            GameManager.instance.GameOver(-3);
        }
    }
}
