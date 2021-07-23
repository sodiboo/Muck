using System;
using UnityEngine;
using UnityEngine.UI;

public class Settings : MonoBehaviour
{
    public enum BoolSetting
    {
        Off,
        On
    }

    public enum VSync
    {
        Off,
        Always,
        Half
    }

    public enum ShadowQuality
    {
        Off,
        Hard,
        Soft
    }

    public enum ShadowResolution
    {
        Low,
        Medium,
        High,
        Ultra
    }

    public enum ShadowDistance
    {
        Low,
        Medium,
        High,
        Ultra
    }

    public enum ShadowCascades
    {
        None,
        Two,
        Four
    }

    public enum TextureResolution
    {
        Low,
        Medium,
        High,
        Ultra
    }

    public enum AntiAliasing
    {
        Off,
        x2,
        x4,
        x8
    }

    public enum Bloom
    {
        Off,
        Fast,
        Fancy
    }

    public Button backBtn;

    [Header("Game")]
    public MyBoolSetting camShake;

    public SliderSetting fov;

    public SliderSetting sens;

    public MyBoolSetting invertedHor;

    public MyBoolSetting invertedVer;

    public MyBoolSetting grass;

    public MyBoolSetting tutorial;

    [Header("Controls")]
    public ControlSetting forward;

    public ControlSetting backward;

    public ControlSetting left;

    public ControlSetting right;

    public ControlSetting jump;

    public ControlSetting sprint;

    public ControlSetting interact;

    public ControlSetting inventory;

    public ControlSetting map;

    public ControlSetting leftClick;

    public ControlSetting rightClick;

    [Header("Graphics")]
    public ScrollSettings shadowQuality;

    public ScrollSettings shadowResolution;

    public ScrollSettings shadowDistance;

    public ScrollSettings shadowCascades;

    public ScrollSettings textureQuality;

    public ScrollSettings antiAliasing;

    public MyBoolSetting softParticles;

    public ScrollSettings bloom;

    public MyBoolSetting motionBlur;

    public MyBoolSetting ao;

    [Header("Video")]
    public ResolutionSetting resolution;

    public MyBoolSetting fullscreen;

    public ScrollSettings fullscreenMode;

    public ScrollSettings vSync;

    public SliderSetting fpsLimit;

    [Header("Audio")]
    public SliderSetting volume;

    [Header("Audio")]
    public SliderSetting music;

    private void Start()
    {
        UpdateSave();
    }

    private void UpdateSave()
    {
        camShake.SetSetting(SaveManager.Instance.state.cameraShake);
        camShake.onClick.AddListener(UpdateCamShake);
        fov.SetSettings(SaveManager.Instance.state.fov);
        fov.onClick.AddListener(UpdateFov);
        sens.SetSettings(FloatToInt(SaveManager.Instance.state.sensMultiplier));
        sens.onClick.AddListener(UpdateSens);
        invertedHor.SetSetting(SaveManager.Instance.state.invertedMouseHor);
        invertedHor.onClick.AddListener(UpdateInverted);
        invertedVer.SetSetting(SaveManager.Instance.state.invertedMouseVert);
        invertedVer.onClick.AddListener(UpdateInverted);
        grass.SetSetting(SaveManager.Instance.state.grass);
        grass.onClick.AddListener(UpdateGrass);
        tutorial.SetSetting(SaveManager.Instance.state.tutorial);
        tutorial.onClick.AddListener(UpdateTutorial);
        forward.SetSetting(SaveManager.Instance.state.forward, "Forward");
        forward.onClick.AddListener(UpdateForwardKey);
        backward.SetSetting(SaveManager.Instance.state.backwards, "Backward");
        backward.onClick.AddListener(UpdateBackwardKey);
        left.SetSetting(SaveManager.Instance.state.left, "Left");
        left.onClick.AddListener(UpdateLeftKey);
        right.SetSetting(SaveManager.Instance.state.right, "Right");
        right.onClick.AddListener(UpdateRightKey);
        jump.SetSetting(SaveManager.Instance.state.jump, "Jump");
        jump.onClick.AddListener(UpdateJumpKey);
        sprint.SetSetting(SaveManager.Instance.state.sprint, "Sprint");
        sprint.onClick.AddListener(UpdateSprintKey);
        interact.SetSetting(SaveManager.Instance.state.interact, "Interact");
        interact.onClick.AddListener(UpdateInteractKey);
        inventory.SetSetting(SaveManager.Instance.state.inventory, "Inventory");
        inventory.onClick.AddListener(UpdateInventoryKey);
        map.SetSetting(SaveManager.Instance.state.map, "Map");
        map.onClick.AddListener(UpdateMapKey);
        leftClick.SetSetting(SaveManager.Instance.state.leftClick, "Left Click / Attack");
        leftClick.onClick.AddListener(UpdateLeftClickKey);
        rightClick.SetSetting(SaveManager.Instance.state.rightClick, "Right Click / Build");
        rightClick.onClick.AddListener(UpdateRightClickKey);
        shadowQuality.SetSettings(Enum.GetNames(typeof(ShadowQuality)), SaveManager.Instance.state.shadowQuality);
        shadowQuality.onClick.AddListener(UpdateShadowQuality);
        shadowResolution.SetSettings(Enum.GetNames(typeof(ShadowResolution)), SaveManager.Instance.state.shadowResolution);
        shadowResolution.onClick.AddListener(UpdateShadowResolution);
        shadowDistance.SetSettings(Enum.GetNames(typeof(ShadowDistance)), SaveManager.Instance.state.shadowDistance);
        shadowDistance.onClick.AddListener(UpdateShadowDistance);
        shadowCascades.SetSettings(Enum.GetNames(typeof(ShadowCascades)), SaveManager.Instance.state.shadowCascade);
        shadowCascades.onClick.AddListener(UpdateShadowCascades);
        textureQuality.SetSettings(Enum.GetNames(typeof(TextureResolution)), SaveManager.Instance.state.textureQuality);
        textureQuality.onClick.AddListener(UpdateTextureRes);
        antiAliasing.SetSettings(Enum.GetNames(typeof(AntiAliasing)), SaveManager.Instance.state.antiAliasing);
        antiAliasing.onClick.AddListener(UpdateAntiAliasing);
        softParticles.SetSetting(SaveManager.Instance.state.softParticles);
        softParticles.onClick.AddListener(UpdateSoftParticles);
        bloom.SetSettings(Enum.GetNames(typeof(Bloom)), SaveManager.Instance.state.bloom);
        bloom.onClick.AddListener(UpdateBloom);
        motionBlur.SetSetting(SaveManager.Instance.state.motionBlur);
        motionBlur.onClick.AddListener(UpdateMotionBlur);
        ao.SetSetting(SaveManager.Instance.state.ambientOcclusion);
        ao.onClick.AddListener(UpdateAO);
        resolution.SetSettings(Screen.resolutions, Screen.currentResolution);
        fullscreen.SetSetting(Screen.fullScreen);
        fullscreen.onClick.AddListener(UpdateFullscreen);
        vSync.SetSettings(Enum.GetNames(typeof(VSync)), SaveManager.Instance.state.vSync);
        vSync.onClick.AddListener(UpdateVSync);
        fullscreenMode.SetSettings(Enum.GetNames(typeof(FullScreenMode)), SaveManager.Instance.state.fullscreenMode);
        fullscreenMode.onClick.AddListener(UpdateFullscreenMode);
        fpsLimit.SetSettings(SaveManager.Instance.state.fpsLimit);
        fpsLimit.onClick.AddListener(UpdateMaxFps);
        volume.SetSettings(SaveManager.Instance.state.volume);
        volume.onClick.AddListener(UpdateVolume);
        music.SetSettings(SaveManager.Instance.state.music);
        music.onClick.AddListener(UpdateMusic);
    }

    private void UpdateCamShake()
    {
        CurrentSettings.Instance.UpdateCamShake(IntToBool(camShake.currentSetting));
    }

    private void UpdateInverted()
    {
        CurrentSettings.Instance.UpdateInverted(IntToBool(invertedHor.currentSetting), IntToBool(invertedVer.currentSetting));
    }

    private void UpdateGrass()
    {
        CurrentSettings.Instance.UpdateGrass(IntToBool(grass.currentSetting));
    }

    private void UpdateTutorial()
    {
        CurrentSettings.Instance.UpdateTutorial(IntToBool(grass.currentSetting));
    }

    private void UpdateSens()
    {
        CurrentSettings.Instance.UpdateSens(IntToFloat(sens.currentSetting));
    }

    private void UpdateFov()
    {
        CurrentSettings.Instance.UpdateFov(fov.currentSetting);
    }

    private void UpdateForwardKey()
    {
        SaveManager.Instance.state.forward = forward.currentKey;
        SaveManager.Instance.Save();
        InputManager.forward = forward.currentKey;
    }

    private void UpdateBackwardKey()
    {
        SaveManager.Instance.state.backwards = backward.currentKey;
        SaveManager.Instance.Save();
        InputManager.backwards = backward.currentKey;
    }

    private void UpdateLeftKey()
    {
        SaveManager.Instance.state.left = left.currentKey;
        SaveManager.Instance.Save();
        InputManager.left = left.currentKey;
    }

    private void UpdateRightKey()
    {
        SaveManager.Instance.state.right = right.currentKey;
        SaveManager.Instance.Save();
        InputManager.right = right.currentKey;
    }

    private void UpdateJumpKey()
    {
        SaveManager.Instance.state.jump = jump.currentKey;
        SaveManager.Instance.Save();
        InputManager.jump = jump.currentKey;
    }

    private void UpdateSprintKey()
    {
        SaveManager.Instance.state.sprint = sprint.currentKey;
        SaveManager.Instance.Save();
        InputManager.sprint = sprint.currentKey;
    }

    private void UpdateInteractKey()
    {
        SaveManager.Instance.state.interact = interact.currentKey;
        SaveManager.Instance.Save();
        InputManager.interact = interact.currentKey;
    }

    private void UpdateInventoryKey()
    {
        SaveManager.Instance.state.inventory = inventory.currentKey;
        SaveManager.Instance.Save();
        InputManager.inventory = inventory.currentKey;
    }

    private void UpdateMapKey()
    {
        SaveManager.Instance.state.map = map.currentKey;
        SaveManager.Instance.Save();
        InputManager.map = map.currentKey;
    }

    private void UpdateLeftClickKey()
    {
        SaveManager.Instance.state.leftClick = leftClick.currentKey;
        SaveManager.Instance.Save();
        InputManager.leftClick = leftClick.currentKey;
    }

    private void UpdateRightClickKey()
    {
        SaveManager.Instance.state.rightClick = rightClick.currentKey;
        SaveManager.Instance.Save();
        InputManager.rightClick = rightClick.currentKey;
    }

    private void UpdateShadowQuality()
    {
        CurrentSettings.Instance.UpdateShadowQuality(shadowQuality.currentSetting);
    }

    private void UpdateShadowResolution()
    {
        CurrentSettings.Instance.UpdateShadowResolution(shadowResolution.currentSetting);
    }

    private void UpdateShadowDistance()
    {
        CurrentSettings.Instance.UpdateShadowDistance(shadowDistance.currentSetting);
    }

    private void UpdateShadowCascades()
    {
        CurrentSettings.Instance.UpdateShadowCascades(shadowCascades.currentSetting);
    }

    private void UpdateTextureRes()
    {
        CurrentSettings.Instance.UpdateTextureQuality(textureQuality.currentSetting);
    }

    private void UpdateAntiAliasing()
    {
        CurrentSettings.Instance.UpdateAntiAliasing(antiAliasing.currentSetting);
    }

    private void UpdateSoftParticles()
    {
        CurrentSettings.Instance.UpdateSoftParticles(IntToBool(softParticles.currentSetting));
    }

    private void UpdateBloom()
    {
        CurrentSettings.Instance.UpdateBloom(bloom.currentSetting);
    }

    private void UpdateMotionBlur()
    {
        CurrentSettings.Instance.UpdateMotionBlur(IntToBool(motionBlur.currentSetting));
    }

    private void UpdateAO()
    {
        CurrentSettings.Instance.UpdateAO(IntToBool(ao.currentSetting));
    }

    private void UpdateFullscreen()
    {
        CurrentSettings.Instance.UpdateFullscreen(IntToBool(fullscreen.currentSetting));
    }

    private void UpdateFullscreenMode()
    {
        CurrentSettings.Instance.UpdateFullscreenMode(fullscreenMode.currentSetting);
    }

    private void UpdateVSync()
    {
        CurrentSettings.Instance.UpdateVSync(vSync.currentSetting);
    }

    private void UpdateMaxFps()
    {
        CurrentSettings.Instance.UpdateMaxFps(fpsLimit.currentSetting);
    }

    private void UpdateVolume()
    {
        CurrentSettings.Instance.UpdateVolume(volume.currentSetting);
    }

    private void UpdateMusic()
    {
        CurrentSettings.Instance.UpdateMusic(music.currentSetting);
    }

    private float IntToFloat(int i)
    {
        return (float)i / 100f;
    }

    private int FloatToInt(float f)
    {
        return (int)(f * 100f);
    }

    private int BoolToInt(bool b)
    {
        if (b)
        {
            return 1;
        }
        return 0;
    }

    private bool IntToBool(int i)
    {
        if (i == 0)
        {
            return false;
        }
        return true;
    }

    public void ResetSaveFile()
    {
        SaveManager.Instance.NewSave();
        SaveManager.Instance.Save();
        UpdateSave();
        CurrentSettings.Instance.UpdateSave();
    }
}
