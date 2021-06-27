using System;
using UnityEngine;

public class InputManager : MonoBehaviour
{
    private void Start()
    {
        this.Init();
    }

    private void Init()
    {
        InputManager.forward = SaveManager.Instance.state.forward;
        InputManager.backwards = SaveManager.Instance.state.backwards;
        InputManager.left = SaveManager.Instance.state.left;
        InputManager.right = SaveManager.Instance.state.right;
        InputManager.jump = SaveManager.Instance.state.jump;
        InputManager.sprint = SaveManager.Instance.state.sprint;
        InputManager.crouch = SaveManager.Instance.state.crouch;
        InputManager.interact = SaveManager.Instance.state.interact;
        InputManager.rotate = SaveManager.Instance.state.rotate;
        InputManager.precisionRotate = SaveManager.Instance.state.precisionRotate;
        InputManager.inventory = SaveManager.Instance.state.inventory;
        InputManager.map = SaveManager.Instance.state.map;
        InputManager.leftClick = SaveManager.Instance.state.leftClick;
        InputManager.rightClick = SaveManager.Instance.state.rightClick;
    }

    public static KeyCode forward;

    public static KeyCode backwards;

    public static KeyCode left;

    public static KeyCode right;

    public static KeyCode jump;

    public static KeyCode sprint;

    public static KeyCode crouch;

    public static KeyCode interact;

    public static KeyCode rotate;

    public static KeyCode precisionRotate;

    public static KeyCode inventory;

    public static KeyCode map;

    public static KeyCode leftClick;

    public static KeyCode rightClick;
}
