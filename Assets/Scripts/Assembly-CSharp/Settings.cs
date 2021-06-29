using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

public class Settings : MonoBehaviour
{
    private void Start()
    {
        this.UpdateSave();
    }

    public GameObject settingsScroll;

    public GameObject boolSetting;

    public GameObject twoBoolSetting;

    public GameObject sliderSetting;

    public GameObject scrollSetting;

    public GameObject controlsSetting;

    public GameObject resolutionSetting;

    class SettingsPage : IDisposable
    {
        Settings settings;

        RectTransform content;

        public SettingsPage(GameObject tab)
        {
            settings = tab.GetComponentInParent<Settings>();
            var scroll = Instantiate(settings.settingsScroll);
            content = scroll.GetComponent<ScrollRect>().content;
            scroll.transform.SetParent(tab.transform, false);
        }

        class SettingsItem<T> : IDisposable where T : Setting
        {
            public T obj;
            SettingsPage page;
            public SettingsItem(SettingsPage page, GameObject gameObject, string name)
            {
                obj = Instantiate(gameObject).GetComponent<T>();
                obj.SetName(name);
                this.page = page;
            }

            public void Dispose()
            {
                var transform = (RectTransform)obj.transform;
                transform.SetParent(page.content, false);
                page.height += transform.sizeDelta.y;
                page.total++;
            }
        }

        float height = 0f;

        int total = 0;

        float maxScrollWidth;

        List<RectTransform> scrollSettings = new List<RectTransform>();

        public void AddControlSetting(string name, KeyCode defaultValue, Action<KeyCode> update)
        {
            using (var setting = new SettingsItem<ControlSetting>(this, settings.controlsSetting, name))
            {
                setting.obj.SetSetting(defaultValue);
                setting.obj.onClick.AddListener(() => update(setting.obj.currentKey));
            }
        }

        public void AddSliderSetting(string name, int defaultValue, int min, int max, Action<int> update)
        {
            using (var setting = new SettingsItem<SliderSetting>(this, settings.sliderSetting, name))
            {
                setting.obj.slider.minValue = min;
                setting.obj.slider.maxValue = max;
                setting.obj.SetSettings(defaultValue);
                setting.obj.onClick.AddListener(() => update(setting.obj.currentSetting));
            }
        }

        public void AddScrollSetting(string name, string[] values, int defaultIndex, Action<int> update)
        {
            using (var setting = new SettingsItem<ScrollSettings>(this, settings.scrollSetting, name))
            {
                foreach (var value in values)
                {
                    setting.obj.settingText.text = value;
                    scrollSettings.Add((RectTransform)setting.obj.settingText.transform);
                    maxScrollWidth = Math.Max(setting.obj.settingText.preferredWidth, maxScrollWidth);
                }
                setting.obj.SetSettings(values, defaultIndex);
                setting.obj.onClick.AddListener(() => update(setting.obj.currentSetting));
            }
        }

        public void AddBoolSetting(string name, bool defaultValue, Action<bool> update)
        {
            using (var setting = new SettingsItem<MyBoolSetting>(this, settings.boolSetting, name))
            {
                setting.obj.SetSetting(defaultValue);
                setting.obj.onClick.AddListener(() => update(settings.IntToBool(setting.obj.currentSetting)));
            }
        }

        public void AddTwoBoolSetting(string name, string label1, string label2, bool defaultValue1, bool defaultValue2, Action<bool, bool> update)
        {
            using (var setting = new SettingsItem<TwoBoolSetting>(this, settings.twoBoolSetting, name))
            {
                setting.obj.SetSetting(defaultValue1, defaultValue2);
                setting.obj.SetLabels(label1, label2);
                setting.obj.onClick.AddListener(() => update(settings.IntToBool(setting.obj.currentSetting & 1), settings.IntToBool(setting.obj.currentSetting & 2)));
            }
        }

        public void AddResolutionSetting(string name, Resolution[] resolutions, Resolution current)
        {
            using (var setting = new SettingsItem<ResolutionSetting>(this, settings.resolutionSetting, name))
            {
                setting.obj.SetSettings(resolutions, current);
            }
        }

        public void Dispose()
        {
            foreach (var setting in scrollSettings)
            {
                setting.sizeDelta = new Vector2(maxScrollWidth, setting.sizeDelta.y);
            }
            var group = content.GetComponent<VerticalLayoutGroup>();
            content.sizeDelta = new Vector2(content.sizeDelta.x, height + (total - 1) * group.spacing + group.padding.top + group.padding.bottom);
        }
    }

    private void UpdateSave()
    {
        var nav = GetComponentInChildren<TopNavigate>();
        foreach (var menu in nav.settingMenus)
        {
            while (menu.transform.childCount > 0) Destroy(menu.transform.GetChild(0));
        }

        using (var page = new SettingsPage(nav.settingMenus[0]))
        {
            page.AddBoolSetting("Camera Shake", SaveManager.Instance.state.cameraShake, UpdateCamShake);

            page.AddSliderSetting("FOV", SaveManager.Instance.state.fov, 50, 120, UpdateFov);
            page.AddSliderSetting("Sensitivity", FloatToInt(SaveManager.Instance.state.sensMultiplier), 0, 500, UpdateSens);

            page.AddTwoBoolSetting("Inverted Third Person Look", "X", "Y", SaveManager.Instance.state.invertedCarX, SaveManager.Instance.state.invertedCarY, UpdateInvertedCar);
            page.AddTwoBoolSetting("Inverted First Person Look", "X", "Y", SaveManager.Instance.state.invertedMouseX, SaveManager.Instance.state.invertedMouseY, UpdateInvertedMouse);
            page.AddTwoBoolSetting("Inverted Build Rotate", "X", "Y", SaveManager.Instance.state.invertedRotateX, SaveManager.Instance.state.invertedRotateY, UpdateInvertedRotate);

            page.AddBoolSetting("Grass", SaveManager.Instance.state.grass, UpdateGrass);
            page.AddBoolSetting("Tutorial", SaveManager.Instance.state.tutorial, UpdateTutorial);
            page.AddBoolSetting("Disable Crouching", SaveManager.Instance.state.disableCrouch, UpdateCrouch);
            page.AddBoolSetting("Disable Build Fx", SaveManager.Instance.state.disableBuildFx, UpdateBuildFx);
        }

        using (var page = new SettingsPage(nav.settingMenus[1]))
        {
            page.AddControlSetting("Forward", SaveManager.Instance.state.forward, UpdateForwardKey);
            page.AddControlSetting("Backward", SaveManager.Instance.state.backwards, UpdateBackwardKey);
            page.AddControlSetting("Left", SaveManager.Instance.state.left, UpdateLeftKey);
            page.AddControlSetting("Right", SaveManager.Instance.state.right, UpdateRightKey);
            page.AddControlSetting("Jump (Fly Up)", SaveManager.Instance.state.jump, UpdateJumpKey);
            page.AddControlSetting("Sprint", SaveManager.Instance.state.sprint, UpdateSprintKey);
            page.AddControlSetting("Crouch/Slide (Fly Down)", SaveManager.Instance.state.crouch, UpdateCrouchKey);
            page.AddControlSetting("Interact", SaveManager.Instance.state.interact, UpdateInteractKey);
            page.AddControlSetting("Rotate Build", SaveManager.Instance.state.rotate, UpdateRotateKey);
            page.AddControlSetting("Rotate Build Exactly", SaveManager.Instance.state.precisionRotate, UpdatePrecisionRotateKey);
            page.AddControlSetting("Inventory", SaveManager.Instance.state.inventory, UpdateInventoryKey);
            page.AddControlSetting("Map", SaveManager.Instance.state.map, UpdateMapKey);
            page.AddControlSetting("Attack/Eat", SaveManager.Instance.state.leftClick, UpdateLeftClickKey);
            page.AddControlSetting("Build", SaveManager.Instance.state.rightClick, UpdateRightClickKey);
        }

        using (var page = new SettingsPage(nav.settingMenus[2]))
        {
            page.AddScrollSetting("Shadow Quality", Enum.GetNames(typeof(Settings.ShadowQuality)), SaveManager.Instance.state.shadowQuality, UpdateShadowQuality);
            page.AddScrollSetting("Shadow Resolution", Enum.GetNames(typeof(Settings.ShadowResolution)), SaveManager.Instance.state.shadowResolution, UpdateShadowResolution);
            page.AddScrollSetting("Shadow Distance", Enum.GetNames(typeof(Settings.ShadowDistance)), SaveManager.Instance.state.shadowDistance, UpdateShadowDistance);
            page.AddScrollSetting("Shadow Cascades", Enum.GetNames(typeof(Settings.ShadowCascades)), SaveManager.Instance.state.shadowCascade, UpdateShadowCascades);
            page.AddScrollSetting("Texture Resolution", Enum.GetNames(typeof(Settings.TextureResolution)), SaveManager.Instance.state.textureQuality, UpdateTextureRes);
            page.AddScrollSetting("Anti Aliasing", Enum.GetNames(typeof(Settings.AntiAliasing)), SaveManager.Instance.state.antiAliasing, UpdateAntiAliasing);

            page.AddBoolSetting("Soft Particles", SaveManager.Instance.state.softParticles, UpdateSoftParticles);
            page.AddScrollSetting("Bloom", Enum.GetNames(typeof(Settings.Bloom)), SaveManager.Instance.state.bloom, UpdateBloom);

            page.AddBoolSetting("Motion Blur", SaveManager.Instance.state.motionBlur, UpdateMotionBlur);
            page.AddBoolSetting("Ambient Occlusion", SaveManager.Instance.state.ambientOcclusion, UpdateAO);
        }

        using (var page = new SettingsPage(nav.settingMenus[3]))
        {
            page.AddResolutionSetting("Resolution", Screen.resolutions, Screen.currentResolution);
            page.AddBoolSetting("Fullscreen", Screen.fullScreen, UpdateFullscreen);

            page.AddScrollSetting("Fullscreen Mode", Enum.GetNames(typeof(FullScreenMode)), SaveManager.Instance.state.fullscreenMode, UpdateFullscreenMode);
            page.AddScrollSetting("VSync", Enum.GetNames(typeof(Settings.VSync)), SaveManager.Instance.state.vSync, UpdateVSync);
            page.AddSliderSetting("Max FPS", SaveManager.Instance.state.fpsLimit, 30, 500, UpdateMaxFps);
        }

        using (var page = new SettingsPage(nav.settingMenus[4]))
        {
            page.AddSliderSetting("Master volume", SaveManager.Instance.state.volume, 0, 10, UpdateVolume);
            page.AddSliderSetting("Music volume", SaveManager.Instance.state.music, 0, 10, UpdateMusic);
        }
    }

    private void UpdateCamShake(bool current)
    {
        CurrentSettings.Instance.UpdateCamShake(current);
    }

    private void UpdateInvertedCar(bool x, bool y)
    {
        CurrentSettings.Instance.UpdateInvertedCar(x, y);
    }

    private void UpdateInvertedMouse(bool x, bool y)
    {
        CurrentSettings.Instance.UpdateInvertedMouse(x, y);
    }

    private void UpdateInvertedRotate(bool x, bool y)
    {
        CurrentSettings.Instance.UpdateInvertedRotate(x, y);
    }

    private void UpdateGrass(bool current)
    {
        CurrentSettings.Instance.UpdateGrass(current);
    }

    private void UpdateTutorial(bool current)
    {
        CurrentSettings.Instance.UpdateTutorial(current);
    }

    private void UpdateCrouch(bool current)
    {
        CurrentSettings.Instance.UpdateCrouch(current);
    }

    private void UpdateBuildFx(bool current)
    {
        CurrentSettings.Instance.UpdateBuildFx(current);
    }

    private void UpdateSens(int current)
    {
        CurrentSettings.Instance.UpdateSens(IntToFloat(current));
    }

    private void UpdateFov(int current)
    {
        CurrentSettings.Instance.UpdateFov(current);
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

    private void UpdateShadowQuality(int current)
    {
        CurrentSettings.Instance.UpdateShadowQuality(current);
    }

    private void UpdateShadowResolution(int current)
    {
        CurrentSettings.Instance.UpdateShadowResolution(current);
    }

    private void UpdateShadowDistance(int current)
    {
        CurrentSettings.Instance.UpdateShadowDistance(current);
    }

    private void UpdateShadowCascades(int current)
    {
        CurrentSettings.Instance.UpdateShadowCascades(current);
    }

    private void UpdateTextureRes(int current)
    {
        CurrentSettings.Instance.UpdateTextureQuality(current);
    }

    private void UpdateAntiAliasing(int current)
    {
        CurrentSettings.Instance.UpdateAntiAliasing(current);
    }

    private void UpdateBloom(int current)
    {
        CurrentSettings.Instance.UpdateBloom(current);
    }

    private void UpdateSoftParticles(bool current)
    {
        CurrentSettings.Instance.UpdateSoftParticles(current);
    }

    private void UpdateMotionBlur(bool current)
    {
        CurrentSettings.Instance.UpdateMotionBlur(current);
    }

    private void UpdateAO(bool current)
    {
        CurrentSettings.Instance.UpdateAO(current);
    }

    private void UpdateFullscreen(bool current)
    {
        CurrentSettings.Instance.UpdateFullscreen(current);
    }

    private void UpdateFullscreenMode(int current)
    {
        CurrentSettings.Instance.UpdateFullscreenMode(current);
    }

    private void UpdateVSync(int current)
    {
        CurrentSettings.Instance.UpdateVSync(current);
    }

    private void UpdateMaxFps(int current)
    {
        CurrentSettings.Instance.UpdateMaxFps(current);
    }

    private void UpdateVolume(int current)
    {
        CurrentSettings.Instance.UpdateVolume(current);
    }

    private void UpdateMusic(int current)
    {
        CurrentSettings.Instance.UpdateMusic(current);
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

    public enum BoolSetting
    {
        Off,
        On,
    }

    public enum VSync
    {
        Off,
        Always,
        Half,
    }

    public enum ShadowQuality
    {
        Off,
        Hard,
        Soft,
    }

    public enum ShadowResolution
    {
        Low,
        Medium,
        High,
        Ultra,
    }

    public enum ShadowDistance
    {
        Low,
        Medium,
        High,
        Ultra,
    }

    public enum ShadowCascades
    {
        None,
        Two,
        Four,
    }

    public enum TextureResolution
    {
        Low,
        Medium,
        High,
        Ultra,
    }

    public enum AntiAliasing
    {
        Off,
        x2,
        x4,
        x8,
    }

    public enum Bloom
    {
        Off,
        Fast,
        Fancy,
    }
}
