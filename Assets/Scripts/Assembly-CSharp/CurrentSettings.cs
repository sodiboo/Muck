using System;
using UnityEngine;

public class CurrentSettings : MonoBehaviour
{
    private void Awake()
    {
        if (CurrentSettings.Instance)
        {
            Destroy(base.gameObject);
            return;
        }
        CurrentSettings.Instance = this;
    }

    private void Start()
    {
        this.InitSettings();
    }

    private void InitSettings()
    {
        this.UpdateSave();
    }

    public void UpdateSave()
    {
        this.UpdateCamShake(SaveManager.Instance.state.cameraShake);
        this.UpdateFov((float)SaveManager.Instance.state.fov);
        this.UpdateSens(SaveManager.Instance.state.sensMultiplier);
        UpdateInvertedCar(SaveManager.Instance.state.invertedCarX, SaveManager.Instance.state.invertedCarY);
        UpdateInvertedMouse(SaveManager.Instance.state.invertedMouseX, SaveManager.Instance.state.invertedMouseY);
        UpdateInvertedRotate(SaveManager.Instance.state.invertedRotateX, SaveManager.Instance.state.invertedRotateY);
        this.UpdateGrass(SaveManager.Instance.state.grass);
        this.UpdateTutorial(SaveManager.Instance.state.tutorial);
        this.UpdateBuildFx(SaveManager.Instance.state.disableBuildFx);
        this.UpdateShadowQuality(SaveManager.Instance.state.shadowQuality);
        this.UpdateShadowResolution(SaveManager.Instance.state.shadowResolution);
        this.UpdateShadowCascades(SaveManager.Instance.state.shadowCascade);
        this.UpdateShadowDistance(SaveManager.Instance.state.shadowDistance);
        this.UpdateTextureQuality(SaveManager.Instance.state.textureQuality);
        this.UpdateAntiAliasing(SaveManager.Instance.state.antiAliasing);
        this.UpdateSoftParticles(SaveManager.Instance.state.softParticles);
        this.UpdateBloom(SaveManager.Instance.state.bloom);
        this.UpdateMotionBlur(SaveManager.Instance.state.motionBlur);
        this.UpdateAO(SaveManager.Instance.state.ambientOcclusion);
        Vector2 resolution = SaveManager.Instance.state.resolution;
        int refreshRate = SaveManager.Instance.state.refreshRate;
        this.UpdateResolution((int)resolution.x, (int)resolution.y, refreshRate);
        this.UpdateFullscreen(SaveManager.Instance.state.fullscreen);
        this.UpdateVSync(SaveManager.Instance.state.vSync);
        this.UpdateFullscreenMode(SaveManager.Instance.state.fullscreenMode);
        this.UpdateMaxFps(SaveManager.Instance.state.fpsLimit);
        this.UpdateVolume(SaveManager.Instance.state.volume);
        this.UpdateMusic(SaveManager.Instance.state.music);
    }

    public void UpdateCamShake(bool b)
    {
        SaveManager.Instance.state.cameraShake = b;
        SaveManager.Instance.Save();
        CurrentSettings.cameraShake = b;
    }

    public void UpdateSens(float i)
    {
        MonoBehaviour.print("updates sens to: " + i);
        SaveManager.Instance.state.sensMultiplier = i;
        SaveManager.Instance.Save();
        this.sensMultiplier = i;
        PlayerInput.sensMultiplier = i;
    }

    public void UpdateFov(float i)
    {
        int num = (int)i;
        Debug.LogError("updates fov to: " + num);
        SaveManager.Instance.state.fov = num;
        SaveManager.Instance.Save();
        Debug.LogError("Save fov as: " + num);
        this.fov = num;
        if (MoveCamera.Instance)
        {
            MoveCamera.Instance.UpdateFov((float)this.fov);
        }
    }

    public void UpdateInvertedCar(bool x, bool y)
    {
        Debug.Log($"Setting inverted car to: {x},{y}");
        SaveManager.Instance.state.invertedCarX = x;
        SaveManager.Instance.state.invertedCarY = y;
        SaveManager.Instance.Save();
        CurrentSettings.invertedCar = (x, y);
    }

    public void UpdateInvertedMouse(bool x, bool y)
    {
        Debug.Log($"Setting inverted mouse to: {x},{y}");
        SaveManager.Instance.state.invertedMouseX = x;
        SaveManager.Instance.state.invertedMouseY = y;
        SaveManager.Instance.Save();
        CurrentSettings.invertedMouse = (x, y);
    }

    public void UpdateInvertedRotate(bool x, bool y) {
        Debug.Log($"Setting inverted rotate to: {x},{y}");
        SaveManager.Instance.state.invertedRotateX = x;
        SaveManager.Instance.state.invertedRotateY = y;
        SaveManager.Instance.Save();
        CurrentSettings.invertedRotate = (x, y);
    }

    public void UpdateGrass(bool b)
    {
        Debug.Log("Setting grass to: " + b.ToString());
        SaveManager.Instance.state.grass = b;
        SaveManager.Instance.Save();
        CurrentSettings.grass = b;
    }

    public void UpdateTutorial(bool b)
    {
        Debug.Log("Setting tutorial to: " + b.ToString());
        SaveManager.Instance.state.tutorial = b;
        SaveManager.Instance.Save();
        this.tutorial = b;
    }

    public void UpdateBuildFx(bool b)
    {
        Debug.Log("Setting disable build fx to: " + b.ToString());
        SaveManager.Instance.state.disableBuildFx = b;
        SaveManager.Instance.Save();
        this.disableBuildFx = b;
    }

    public void UpdateShadowQuality(int i)
    {
        SaveManager.Instance.state.shadowQuality = i;
        SaveManager.Instance.Save();
        QualitySettings.shadows = (ShadowQuality)i;
        MonoBehaviour.print("updating shadow quality");
    }

    public void UpdateShadowResolution(int i)
    {
        SaveManager.Instance.state.shadowResolution = i;
        SaveManager.Instance.Save();
        QualitySettings.shadowResolution = (ShadowResolution)i;
        MonoBehaviour.print("updating shadow res");
    }

    public void UpdateShadowCascades(int i)
    {
        SaveManager.Instance.state.shadowCascade = i;
        SaveManager.Instance.Save();
        QualitySettings.shadowCascades = 2 * i;
        MonoBehaviour.print("updating shadow cascades");
    }

    public void UpdateShadowDistance(int i)
    {
        SaveManager.Instance.state.shadowDistance = i;
        SaveManager.Instance.Save();
        QualitySettings.shadowDistance = (float)(i * 40);
        MonoBehaviour.print("updating shadow distance");
    }

    public void UpdateTextureQuality(int i)
    {
        SaveManager.Instance.state.textureQuality = i;
        SaveManager.Instance.Save();
        QualitySettings.masterTextureLimit = 3 - i;
        MonoBehaviour.print("updating texture quality");
    }

    public void UpdateAntiAliasing(int i)
    {
        SaveManager.Instance.state.antiAliasing = i;
        SaveManager.Instance.Save();
        int antiAliasing = 0;
        switch (i)
        {
            case 0:
                antiAliasing = 0;
                break;
            case 1:
                antiAliasing = 2;
                break;
            case 2:
                antiAliasing = 4;
                break;
            case 3:
                antiAliasing = 8;
                break;
        }
        QualitySettings.antiAliasing = antiAliasing;
        MonoBehaviour.print("updating AA");
    }

    public void UpdateSoftParticles(bool b)
    {
        SaveManager.Instance.state.softParticles = b;
        SaveManager.Instance.Save();
        QualitySettings.softParticles = b;
        MonoBehaviour.print("updating soft particles");
    }

    public void UpdateBloom(int i)
    {
        SaveManager.Instance.state.bloom = i;
        SaveManager.Instance.Save();
        PPController.Instance.SetBloom(i);
        MonoBehaviour.print("updating bloom");
    }

    public void UpdateMotionBlur(bool b)
    {
        SaveManager.Instance.state.motionBlur = b;
        SaveManager.Instance.Save();
        PPController.Instance.SetMotionBlur(b);
        MonoBehaviour.print("updating motion blur");
    }

    public void UpdateAO(bool b)
    {
        SaveManager.Instance.state.ambientOcclusion = b;
        SaveManager.Instance.Save();
        PPController.Instance.SetAO(b);
        MonoBehaviour.print("updating AO");
    }

    public void UpdateResolution(int width, int height, int refreshRate)
    {
        if (SaveManager.Instance.state.resolution == Vector2.zero)
        {
            Resolution currentResolution = Screen.currentResolution;
            width = currentResolution.width;
            height = currentResolution.height;
            refreshRate = currentResolution.refreshRate;
            MonoBehaviour.print("finding custom res");
        }
        Screen.SetResolution(width, height, SaveManager.Instance.state.fullscreen, refreshRate);
        SaveManager.Instance.state.resolution = new Vector2((float)width, (float)height);
        SaveManager.Instance.Save();
        MonoBehaviour.print("Updated screen resoltion");
    }

    public void UpdateFullscreen(bool i)
    {
        SaveManager.Instance.state.fullscreen = i;
        SaveManager.Instance.Save();
        Screen.fullScreen = i;
        MonoBehaviour.print("updated fullscreen");
    }

    public void UpdateFullscreenMode(int i)
    {
        SaveManager.Instance.state.fullscreenMode = i;
        SaveManager.Instance.Save();
        Screen.fullScreenMode = (FullScreenMode)i;
        MonoBehaviour.print("updated fullscreenmode");
    }

    public void UpdateVSync(int i)
    {
        SaveManager.Instance.state.vSync = i;
        SaveManager.Instance.Save();
        QualitySettings.vSyncCount = i;
        MonoBehaviour.print("updated vsync");
    }

    public void UpdateMaxFps(int i)
    {
        SaveManager.Instance.state.fpsLimit = i;
        SaveManager.Instance.Save();
        Application.targetFrameRate = i;
        MonoBehaviour.print("updated fps limit");
    }

    public void UpdateVolume(int i)
    {
        SaveManager.Instance.state.volume = i;
        SaveManager.Instance.Save();
        AudioListener.volume = (float)i / 10f;
        MonoBehaviour.print("updated volume");
    }

    public void UpdateMusic(int i)
    {
        SaveManager.Instance.state.music = i;
        SaveManager.Instance.Save();
        MusicController.Instance.SetVolume((float)i / 10f);
		this.music = (float)SaveManager.Instance.state.music / 10f;
        MonoBehaviour.print("updated music");
    }

    public static bool cameraShake;

    public static bool grass = true;

    public static (bool x, bool y) invertedCar = (true, true);
    public static (bool x, bool y) invertedMouse = (false, false);
    public static (bool x, bool y) invertedRotate = (true, true);


    public float sensMultiplier;

    public int fov = 85;

    public bool tutorial;

    public bool disableBuildFx;

    public float volume;

    public float music;

    public static CurrentSettings Instance;
}
