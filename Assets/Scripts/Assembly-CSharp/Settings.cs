using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.PlayerLoop;
using UnityEngine.UI;


public class Settings : MonoBehaviour
{

    private void Start()
    {
        this.UpdateSave();
    }

    public GameObject controlsSetting;
    public RectTransform controlsParent;


    private void UpdateSave()
    {
        this.camShake.SetSetting(SaveManager.Instance.state.cameraShake);
        this.camShake.onClick.AddListener(new UnityAction(this.UpdateCamShake));
        this.fov.SetSettings(SaveManager.Instance.state.fov);
        this.fov.onClick.AddListener(new UnityAction(this.UpdateFov));
        this.sens.SetSettings(this.FloatToInt(SaveManager.Instance.state.sensMultiplier));
        this.sens.onClick.AddListener(new UnityAction(this.UpdateSens));
        
        invertedCarX.SetSetting(SaveManager.Instance.state.invertedCarX);
        invertedCarX.onClick.AddListener(UpdateInvertedCar);
        invertedCarY.SetSetting(SaveManager.Instance.state.invertedCarY);
        invertedCarY.onClick.AddListener(UpdateInvertedCar);

        invertedMouseX.SetSetting(SaveManager.Instance.state.invertedMouseX);
        invertedMouseX.onClick.AddListener(UpdateInvertedMouse);
        invertedMouseY.SetSetting(SaveManager.Instance.state.invertedMouseY);
        invertedMouseY.onClick.AddListener(UpdateInvertedMouse);

        invertedRotateX.SetSetting(SaveManager.Instance.state.invertedRotateX);
        invertedRotateX.onClick.AddListener(UpdateInvertedRotate);
        invertedRotateY.SetSetting(SaveManager.Instance.state.invertedRotateY);
        invertedRotateY.onClick.AddListener(UpdateInvertedRotate);

        this.grass.SetSetting(SaveManager.Instance.state.grass);
        this.grass.onClick.AddListener(new UnityAction(this.UpdateGrass));
        this.tutorial.SetSetting(SaveManager.Instance.state.tutorial);
        this.tutorial.onClick.AddListener(new UnityAction(this.UpdateTutorial));
        this.disableBuildFx.SetSetting(SaveManager.Instance.state.disableBuildFx);
        this.disableBuildFx.onClick.AddListener(new UnityAction(this.UpdateBuildFx));

        var controls = new (KeyCode defaultValue, Action<KeyCode> update, string name)[]
        {
            (SaveManager.Instance.state.forward, UpdateForwardKey, "Forward"),
            (SaveManager.Instance.state.backwards, UpdateBackwardKey, "Backward"),
            (SaveManager.Instance.state.left, UpdateLeftKey, "Left"),
            (SaveManager.Instance.state.right, UpdateRightKey, "Right"),
            (SaveManager.Instance.state.jump, UpdateJumpKey, "Jump"),
            (SaveManager.Instance.state.sprint, UpdateSprintKey, "Sprint"),
            (SaveManager.Instance.state.crouch, UpdateCrouchKey, "Crouch/Slide"),
            (SaveManager.Instance.state.interact, UpdateInteractKey, "Interact"),
            (SaveManager.Instance.state.rotate, UpdateRotateKey, "Rotate Build"),
            (SaveManager.Instance.state.precisionRotate, UpdatePrecisionRotateKey, "Rotate Build Exactly"),
            (SaveManager.Instance.state.inventory, UpdateInventoryKey, "Inventory"),
            (SaveManager.Instance.state.map, UpdateMapKey, "Map"),
            (SaveManager.Instance.state.leftClick, UpdateLeftClickKey, "Attack/Eat"),
            (SaveManager.Instance.state.rightClick, UpdateRightClickKey, "Build"),
        };

        var height = 0f;

        foreach (var control in controls)
        {
            var setting = Instantiate(controlsSetting).GetComponent<ControlSetting>();
            setting.SetSetting(control.defaultValue, control.name);
            setting.onClick.AddListener(() => control.update(setting.currentKey));
            var transform = (RectTransform)setting.transform;
            transform.SetParent(controlsParent, false);
            height += transform.sizeDelta.y;
        }
        var group = controlsParent.GetComponent<VerticalLayoutGroup>();
        controlsParent.sizeDelta = new Vector2(controlsParent.sizeDelta.x, height + (controls.Length - 1) * group.spacing + group.padding.top + group.padding.bottom);

        this.shadowQuality.SetSettings(Enum.GetNames(typeof(Settings.ShadowQuality)), SaveManager.Instance.state.shadowQuality);
        this.shadowQuality.onClick.AddListener(new UnityAction(this.UpdateShadowQuality));
        this.shadowResolution.SetSettings(Enum.GetNames(typeof(Settings.ShadowResolution)), SaveManager.Instance.state.shadowResolution);
        this.shadowResolution.onClick.AddListener(new UnityAction(this.UpdateShadowResolution));
        this.shadowDistance.SetSettings(Enum.GetNames(typeof(Settings.ShadowDistance)), SaveManager.Instance.state.shadowDistance);
        this.shadowDistance.onClick.AddListener(new UnityAction(this.UpdateShadowDistance));
        this.shadowCascades.SetSettings(Enum.GetNames(typeof(Settings.ShadowCascades)), SaveManager.Instance.state.shadowCascade);
        this.shadowCascades.onClick.AddListener(new UnityAction(this.UpdateShadowCascades));
        this.textureQuality.SetSettings(Enum.GetNames(typeof(Settings.TextureResolution)), SaveManager.Instance.state.textureQuality);
        this.textureQuality.onClick.AddListener(new UnityAction(this.UpdateTextureRes));
        this.antiAliasing.SetSettings(Enum.GetNames(typeof(Settings.AntiAliasing)), SaveManager.Instance.state.antiAliasing);
        this.antiAliasing.onClick.AddListener(new UnityAction(this.UpdateAntiAliasing));
        this.softParticles.SetSetting(SaveManager.Instance.state.softParticles);
        this.softParticles.onClick.AddListener(new UnityAction(this.UpdateSoftParticles));
        this.bloom.SetSettings(Enum.GetNames(typeof(Settings.Bloom)), SaveManager.Instance.state.bloom);
        this.bloom.onClick.AddListener(new UnityAction(this.UpdateBloom));
        this.motionBlur.SetSetting(SaveManager.Instance.state.motionBlur);
        this.motionBlur.onClick.AddListener(new UnityAction(this.UpdateMotionBlur));
        this.ao.SetSetting(SaveManager.Instance.state.ambientOcclusion);
        this.ao.onClick.AddListener(new UnityAction(this.UpdateAO));
        this.resolution.SetSettings(Screen.resolutions, Screen.currentResolution);
        this.fullscreen.SetSetting(Screen.fullScreen);
        this.fullscreen.onClick.AddListener(new UnityAction(this.UpdateFullscreen));
        this.vSync.SetSettings(Enum.GetNames(typeof(Settings.VSync)), SaveManager.Instance.state.vSync);
        this.vSync.onClick.AddListener(new UnityAction(this.UpdateVSync));
        this.fullscreenMode.SetSettings(Enum.GetNames(typeof(FullScreenMode)), SaveManager.Instance.state.fullscreenMode);
        this.fullscreenMode.onClick.AddListener(new UnityAction(this.UpdateFullscreenMode));
        this.fpsLimit.SetSettings(SaveManager.Instance.state.fpsLimit);
        this.fpsLimit.onClick.AddListener(new UnityAction(this.UpdateMaxFps));
        this.volume.SetSettings(SaveManager.Instance.state.volume);
        this.volume.onClick.AddListener(new UnityAction(this.UpdateVolume));
        this.music.SetSettings(SaveManager.Instance.state.music);
        this.music.onClick.AddListener(new UnityAction(this.UpdateMusic));
    }


    private void UpdateCamShake()
    {
        CurrentSettings.Instance.UpdateCamShake(this.IntToBool(this.camShake.currentSetting));
    }

    private void UpdateInvertedCar()
    {
        CurrentSettings.Instance.UpdateInvertedCar(IntToBool(invertedCarX.currentSetting), IntToBool(invertedCarY.currentSetting));
    }


    private void UpdateInvertedMouse()
    {
        CurrentSettings.Instance.UpdateInvertedMouse(IntToBool(invertedMouseX.currentSetting), IntToBool(invertedMouseY.currentSetting));
    }

    private void UpdateInvertedRotate()
    {
        CurrentSettings.Instance.UpdateInvertedRotate(IntToBool(invertedRotateX.currentSetting), IntToBool(invertedRotateY.currentSetting));
    }


    private void UpdateGrass()
    {
        CurrentSettings.Instance.UpdateGrass(this.IntToBool(this.grass.currentSetting));
    }


    private void UpdateTutorial()
    {
        CurrentSettings.Instance.UpdateTutorial(this.IntToBool(this.tutorial.currentSetting));
    }


    private void UpdateBuildFx()
    {
        CurrentSettings.Instance.UpdateBuildFx(this.IntToBool(this.disableBuildFx.currentSetting));
    }


    private void UpdateSens()
    {
        CurrentSettings.Instance.UpdateSens(this.IntToFloat(this.sens.currentSetting));
    }


    private void UpdateFov()
    {
        CurrentSettings.Instance.UpdateFov((float)this.fov.currentSetting);
    }


    private void UpdateForwardKey(KeyCode current)
    {
        SaveManager.Instance.state.forward = current;
        SaveManager.Instance.Save();
        InputManager.forward = current;
    }


    private void UpdateBackwardKey(KeyCode current)
    {
        SaveManager.Instance.state.backwards = current;
        SaveManager.Instance.Save();
        InputManager.backwards = current;
    }


    private void UpdateLeftKey(KeyCode current)
    {
        SaveManager.Instance.state.left = current;
        SaveManager.Instance.Save();
        InputManager.left = current;
    }


    private void UpdateRightKey(KeyCode current)
    {
        SaveManager.Instance.state.right = current;
        SaveManager.Instance.Save();
        InputManager.right = current;
    }


    private void UpdateJumpKey(KeyCode current)
    {
        SaveManager.Instance.state.jump = current;
        SaveManager.Instance.Save();
        InputManager.jump = current;
    }


    private void UpdateSprintKey(KeyCode current)
    {
        SaveManager.Instance.state.sprint = current;
        SaveManager.Instance.Save();
        InputManager.sprint = current;
    }

    private void UpdateCrouchKey(KeyCode current)
    {
        SaveManager.Instance.state.crouch = current;
        SaveManager.Instance.Save();
        InputManager.crouch = current;
    }


    private void UpdateInteractKey(KeyCode current)
    {
        SaveManager.Instance.state.interact = current;
        SaveManager.Instance.Save();
        InputManager.interact = current;
    }

    private void UpdateRotateKey(KeyCode current)
    {
        SaveManager.Instance.state.rotate = current;
        SaveManager.Instance.Save();
        InputManager.rotate = current;
    }

    private void UpdatePrecisionRotateKey(KeyCode current)
    {
        SaveManager.Instance.state.precisionRotate = current;
        SaveManager.Instance.Save();
        InputManager.precisionRotate = current;
    }


    private void UpdateInventoryKey(KeyCode current)
    {
        SaveManager.Instance.state.inventory = current;
        SaveManager.Instance.Save();
        InputManager.inventory = current;
    }


    private void UpdateMapKey(KeyCode current)
    {
        SaveManager.Instance.state.map = current;
        SaveManager.Instance.Save();
        InputManager.map = current;
    }


    private void UpdateLeftClickKey(KeyCode current)
    {
        SaveManager.Instance.state.leftClick = current;
        SaveManager.Instance.Save();
        InputManager.leftClick = current;
    }


    private void UpdateRightClickKey(KeyCode current)
    {
        SaveManager.Instance.state.rightClick = current;
        SaveManager.Instance.Save();
        InputManager.rightClick = current;
    }


    private void UpdateShadowQuality()
    {
        CurrentSettings.Instance.UpdateShadowQuality(this.shadowQuality.currentSetting);
    }


    private void UpdateShadowResolution()
    {
        CurrentSettings.Instance.UpdateShadowResolution(this.shadowResolution.currentSetting);
    }


    private void UpdateShadowDistance()
    {
        CurrentSettings.Instance.UpdateShadowDistance(this.shadowDistance.currentSetting);
    }


    private void UpdateShadowCascades()
    {
        CurrentSettings.Instance.UpdateShadowCascades(this.shadowCascades.currentSetting);
    }


    private void UpdateTextureRes()
    {
        CurrentSettings.Instance.UpdateTextureQuality(this.textureQuality.currentSetting);
    }


    private void UpdateAntiAliasing()
    {
        CurrentSettings.Instance.UpdateAntiAliasing(this.antiAliasing.currentSetting);
    }


    private void UpdateSoftParticles()
    {
        CurrentSettings.Instance.UpdateSoftParticles(this.IntToBool(this.softParticles.currentSetting));
    }


    private void UpdateBloom()
    {
        CurrentSettings.Instance.UpdateBloom(this.bloom.currentSetting);
    }


    private void UpdateMotionBlur()
    {
        CurrentSettings.Instance.UpdateMotionBlur(this.IntToBool(this.motionBlur.currentSetting));
    }


    private void UpdateAO()
    {
        CurrentSettings.Instance.UpdateAO(this.IntToBool(this.ao.currentSetting));
    }


    private void UpdateFullscreen()
    {
        CurrentSettings.Instance.UpdateFullscreen(this.IntToBool(this.fullscreen.currentSetting));
    }


    private void UpdateFullscreenMode()
    {
        CurrentSettings.Instance.UpdateFullscreenMode(this.fullscreenMode.currentSetting);
    }


    private void UpdateVSync()
    {
        CurrentSettings.Instance.UpdateVSync(this.vSync.currentSetting);
    }


    private void UpdateMaxFps()
    {
        CurrentSettings.Instance.UpdateMaxFps(this.fpsLimit.currentSetting);
    }


    private void UpdateVolume()
    {
        CurrentSettings.Instance.UpdateVolume(this.volume.currentSetting);
    }


    private void UpdateMusic()
    {
        CurrentSettings.Instance.UpdateMusic(this.music.currentSetting);
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
        return i != 0;
    }


    public void ResetSaveFile()
    {
        SaveManager.Instance.NewSave();
        SaveManager.Instance.Save();
        this.UpdateSave();
        CurrentSettings.Instance.UpdateSave();
    }


    public Button backBtn;


    [Header("Game")]
    public MyBoolSetting camShake;


    public SliderSetting fov;


    public SliderSetting sens;


    public MyBoolSetting invertedCarX;


    public MyBoolSetting invertedCarY;


    public MyBoolSetting invertedMouseX;


    public MyBoolSetting invertedMouseY;


    public MyBoolSetting invertedRotateX;


    public MyBoolSetting invertedRotateY;


    public MyBoolSetting grass;


    public MyBoolSetting tutorial;


    public MyBoolSetting disableBuildFx;


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
}
