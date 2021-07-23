using UnityEngine;

public class InputManager : MonoBehaviour
{
    public static KeyCode forward;

    public static KeyCode backwards;

    public static KeyCode left;

    public static KeyCode right;

    public static KeyCode jump;

    public static KeyCode sprint;

    public static KeyCode interact;

    public static KeyCode inventory;

    public static KeyCode map;

    public static KeyCode leftClick;

    public static KeyCode rightClick;

    private void Start()
    {
        Init();
    }

    private void Init()
    {
        forward = SaveManager.Instance.state.forward;
        backwards = SaveManager.Instance.state.backwards;
        left = SaveManager.Instance.state.left;
        right = SaveManager.Instance.state.right;
        jump = SaveManager.Instance.state.jump;
        sprint = SaveManager.Instance.state.sprint;
        interact = SaveManager.Instance.state.interact;
        inventory = SaveManager.Instance.state.inventory;
        map = SaveManager.Instance.state.map;
        leftClick = SaveManager.Instance.state.leftClick;
        rightClick = SaveManager.Instance.state.rightClick;
    }
}
