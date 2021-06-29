using System;
using UnityEditor;
using UnityEngine;

public class PlayerSave
{
    public int volume { get; set; } = 4;

    public int music { get; set; } = 2;

    public bool cameraShake = true;

    public int fov = 85;

    public float sensMultiplier = 1f;

    public bool invertedCarX = true;
    public bool invertedCarY = true;
    public bool invertedMouseX = false;
    public bool invertedMouseY = false;
    public bool invertedRotateX = true;
    public bool invertedRotateY = true;

    public bool grass = true;

    public bool tutorial = true;

    public bool disableCrouch = true;

    public bool disableBuildFx = false;

    public KeyCode forward = KeyCode.W;

    public KeyCode backwards = KeyCode.S;

    public KeyCode left = KeyCode.A;

    public KeyCode right = KeyCode.D;

    public KeyCode jump = KeyCode.Space;

    public KeyCode sprint = KeyCode.LeftShift;

    public KeyCode crouch = KeyCode.LeftControl;

    public KeyCode interact = KeyCode.E;

    public KeyCode rotate = KeyCode.R;

    public KeyCode precisionRotate = KeyCode.LeftAlt;

    public KeyCode inventory = KeyCode.Tab;

    public KeyCode map = KeyCode.M;

    public KeyCode leftClick = KeyCode.Mouse0;

    public KeyCode rightClick = KeyCode.Mouse1;

    public int shadowQuality = 2;

    public int shadowResolution = 2;

    public int shadowDistance = 2;

    public int shadowCascade = 1;

    public int textureQuality = 2;

    public int antiAliasing = 1;

    public bool softParticles = true;

    public int bloom = 2;

    public bool motionBlur;

    public bool ambientOcclusion = true;

    public Vector2 resolution;

    public int refreshRate = 144;

    public bool fullscreen = true;

    public int fullscreenMode;

    public int vSync;

    public int fpsLimit = 144;

    public int xp;

    public int money;

    private bool[] bossesBeatEasy = new bool[20];

    private bool[] bossesBeatNormal = new bool[20];

    private bool[] bossesBeatHard = new bool[20];

    public enum Bosses
    {
        BigChonk,
        Gronk,
    }
}
