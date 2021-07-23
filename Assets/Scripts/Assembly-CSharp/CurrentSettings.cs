using UnityEngine;

public class CurrentSettings : MonoBehaviour
{
    public static bool cameraShake;

    public static bool grass = true;

    public static bool invertedHor = false;

    public static bool invertedVer = false;

    public float sensMultiplier;

    public int fov = 85;

    public bool tutorial;

    public float volume;

    public float music;

    public static CurrentSettings Instance;

    private void Awake()
    {
        if ((bool)Instance)
        {
            Object.Destroy(base.gameObject);
        }
        else
        {
            Instance = this;
        }
    }

    private void Start()
    {
        InitSettings();
    }

    private void InitSettings()
    {
        UpdateSave();
    }

    public void UpdateSave()
    {
        UpdateCamShake(SaveManager.Instance.state.cameraShake);
        UpdateFov(SaveManager.Instance.state.fov);
        UpdateSens(SaveManager.Instance.state.sensMultiplier);
        UpdateGrass(SaveManager.Instance.state.grass);
        UpdateTutorial(SaveManager.Instance.state.tutorial);
        UpdateShadowQuality(SaveManager.Instance.state.shadowQuality);
        UpdateShadowResolution(SaveManager.Instance.state.shadowResolution);
        UpdateShadowCascades(SaveManager.Instance.state.shadowCascade);
        UpdateShadowDistance(SaveManager.Instance.state.shadowDistance);
        UpdateTextureQuality(SaveManager.Instance.state.textureQuality);
        UpdateAntiAliasing(SaveManager.Instance.state.antiAliasing);
        UpdateSoftParticles(SaveManager.Instance.state.softParticles);
        UpdateBloom(SaveManager.Instance.state.bloom);
        UpdateMotionBlur(SaveManager.Instance.state.motionBlur);
        UpdateAO(SaveManager.Instance.state.ambientOcclusion);
        Vector2 resolution = SaveManager.Instance.state.resolution;
        int refreshRate = SaveManager.Instance.state.refreshRate;
        UpdateResolution((int)resolution.x, (int)resolution.y, refreshRate);
        UpdateFullscreen(SaveManager.Instance.state.fullscreen);
        UpdateVSync(SaveManager.Instance.state.vSync);
        UpdateFullscreenMode(SaveManager.Instance.state.fullscreenMode);
        UpdateMaxFps(SaveManager.Instance.state.fpsLimit);
        UpdateVolume(SaveManager.Instance.state.volume);
        UpdateMusic(SaveManager.Instance.state.music);
    }

    public void UpdateCamShake(bool b)
    {
        SaveManager.Instance.state.cameraShake = b;
        SaveManager.Instance.Save();
        cameraShake = b;
    }

    public void UpdateSens(float i)
    {
        MonoBehaviour.print("updates sens to: " + i);
        SaveManager.Instance.state.sensMultiplier = i;
        SaveManager.Instance.Save();
        sensMultiplier = i;
        PlayerInput.sensMultiplier = i;
    }

    public void UpdateFov(float i)
    {
        int num = (int)i;
        SaveManager.Instance.state.fov = num;
        SaveManager.Instance.Save();
        fov = num;
        if ((bool)MoveCamera.Instance)
        {
            MoveCamera.Instance.UpdateFov(fov);
        }
    }

    public void UpdateInverted(bool hor, bool ver)
    {
        Debug.Log("Setting inverted to: " + hor + ", ver: " + ver);
        SaveManager.Instance.state.invertedMouseHor = hor;
        SaveManager.Instance.state.invertedMouseVert = ver;
        SaveManager.Instance.Save();
        invertedHor = hor;
        invertedVer = ver;
    }

    public void UpdateGrass(bool b)
    {
        Debug.Log("Setting grass to: " + b);
        SaveManager.Instance.state.grass = b;
        SaveManager.Instance.Save();
        grass = b;
    }

    public void UpdateTutorial(bool b)
    {
        Debug.Log("Setting tutorial to: " + b);
        SaveManager.Instance.state.tutorial = b;
        SaveManager.Instance.Save();
        tutorial = b;
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
        QualitySettings.shadowDistance = i * 40;
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
        SaveManager.Instance.state.resolution = new Vector2(width, height);
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
        music = (float)SaveManager.Instance.state.music / 10f;
        MonoBehaviour.print("updated music");
    }
}
