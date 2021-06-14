using System;
using UnityEngine;

// Token: 0x0200001B RID: 27
public class CurrentSettings : MonoBehaviour
{
	// Token: 0x06000082 RID: 130 RVA: 0x00002562 File Offset: 0x00000762
	private void Awake()
	{
		if (CurrentSettings.Instance)
		{
		Destroy(base.gameObject);
			return;
		}
		CurrentSettings.Instance = this;
		Debug.LogError("new settings instance");
	}

	// Token: 0x06000083 RID: 131 RVA: 0x0000258C File Offset: 0x0000078C
	private void Start()
	{
		this.InitSettings();
	}

	// Token: 0x06000084 RID: 132 RVA: 0x00002594 File Offset: 0x00000794
	private void InitSettings()
	{
		this.UpdateSave();
	}

	// Token: 0x06000085 RID: 133 RVA: 0x000095B8 File Offset: 0x000077B8
	public void UpdateSave()
	{
		this.UpdateCamShake(SaveManager.Instance.state.cameraShake);
		this.UpdateFov((float)SaveManager.Instance.state.fov);
		this.UpdateSens(SaveManager.Instance.state.sensMultiplier);
		this.UpdateGrass(SaveManager.Instance.state.grass);
		this.UpdateTutorial(SaveManager.Instance.state.tutorial);
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

	// Token: 0x06000086 RID: 134 RVA: 0x0000259C File Offset: 0x0000079C
	public void UpdateCamShake(bool b)
	{
		SaveManager.Instance.state.cameraShake = b;
		SaveManager.Instance.Save();
		CurrentSettings.cameraShake = b;
	}

	// Token: 0x06000087 RID: 135 RVA: 0x000025BE File Offset: 0x000007BE
	public void UpdateSens(float i)
	{
		MonoBehaviour.print("updates sens to: " + i);
		SaveManager.Instance.state.sensMultiplier = i;
		SaveManager.Instance.Save();
		this.sensMultiplier = i;
		PlayerInput.sensMultiplier = i;
	}

	// Token: 0x06000088 RID: 136 RVA: 0x000097B4 File Offset: 0x000079B4
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

	// Token: 0x06000089 RID: 137 RVA: 0x000025FC File Offset: 0x000007FC
	public void UpdateInverted(bool b)
	{
		Debug.Log("Setting inverted to: " + b.ToString());
		SaveManager.Instance.state.invertedMouse = b;
		SaveManager.Instance.Save();
		CurrentSettings.inverted = b;
	}

	// Token: 0x0600008A RID: 138 RVA: 0x00002634 File Offset: 0x00000834
	public void UpdateGrass(bool b)
	{
		Debug.Log("Setting grass to: " + b.ToString());
		SaveManager.Instance.state.grass = b;
		SaveManager.Instance.Save();
		CurrentSettings.grass = b;
	}

	// Token: 0x0600008B RID: 139 RVA: 0x0000266C File Offset: 0x0000086C
	public void UpdateTutorial(bool b)
	{
		Debug.Log("Setting tutorial to: " + b.ToString());
		SaveManager.Instance.state.tutorial = b;
		SaveManager.Instance.Save();
		this.tutorial = b;
	}

	// Token: 0x0600008C RID: 140 RVA: 0x000026A5 File Offset: 0x000008A5
	public void UpdateShadowQuality(int i)
	{
		SaveManager.Instance.state.shadowQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.shadows = (ShadowQuality)i;
		MonoBehaviour.print("updating shadow quality");
	}

	// Token: 0x0600008D RID: 141 RVA: 0x000026D1 File Offset: 0x000008D1
	public void UpdateShadowResolution(int i)
	{
		SaveManager.Instance.state.shadowResolution = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowResolution = (ShadowResolution)i;
		MonoBehaviour.print("updating shadow res");
	}

	// Token: 0x0600008E RID: 142 RVA: 0x000026FD File Offset: 0x000008FD
	public void UpdateShadowCascades(int i)
	{
		SaveManager.Instance.state.shadowCascade = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowCascades = 2 * i;
		MonoBehaviour.print("updating shadow cascades");
	}

	// Token: 0x0600008F RID: 143 RVA: 0x0000272B File Offset: 0x0000092B
	public void UpdateShadowDistance(int i)
	{
		SaveManager.Instance.state.shadowDistance = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowDistance = (float)(i * 40);
		MonoBehaviour.print("updating shadow distance");
	}

	// Token: 0x06000090 RID: 144 RVA: 0x0000275B File Offset: 0x0000095B
	public void UpdateTextureQuality(int i)
	{
		SaveManager.Instance.state.textureQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.masterTextureLimit = 3 - i;
		MonoBehaviour.print("updating texture quality");
	}

	// Token: 0x06000091 RID: 145 RVA: 0x0000982C File Offset: 0x00007A2C
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

	// Token: 0x06000092 RID: 146 RVA: 0x00002789 File Offset: 0x00000989
	public void UpdateSoftParticles(bool b)
	{
		SaveManager.Instance.state.softParticles = b;
		SaveManager.Instance.Save();
		QualitySettings.softParticles = b;
		MonoBehaviour.print("updating soft particles");
	}

	// Token: 0x06000093 RID: 147 RVA: 0x000027B5 File Offset: 0x000009B5
	public void UpdateBloom(int i)
	{
		SaveManager.Instance.state.bloom = i;
		SaveManager.Instance.Save();
		PPController.Instance.SetBloom(i);
		MonoBehaviour.print("updating bloom");
	}

	// Token: 0x06000094 RID: 148 RVA: 0x000027E6 File Offset: 0x000009E6
	public void UpdateMotionBlur(bool b)
	{
		SaveManager.Instance.state.motionBlur = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetMotionBlur(b);
		MonoBehaviour.print("updating motion blur");
	}

	// Token: 0x06000095 RID: 149 RVA: 0x00002817 File Offset: 0x00000A17
	public void UpdateAO(bool b)
	{
		SaveManager.Instance.state.ambientOcclusion = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetAO(b);
		MonoBehaviour.print("updating AO");
	}

	// Token: 0x06000096 RID: 150 RVA: 0x0000988C File Offset: 0x00007A8C
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

	// Token: 0x06000097 RID: 151 RVA: 0x00002848 File Offset: 0x00000A48
	public void UpdateFullscreen(bool i)
	{
		SaveManager.Instance.state.fullscreen = i;
		SaveManager.Instance.Save();
		Screen.fullScreen = i;
		MonoBehaviour.print("updated fullscreen");
	}

	// Token: 0x06000098 RID: 152 RVA: 0x00002874 File Offset: 0x00000A74
	public void UpdateFullscreenMode(int i)
	{
		SaveManager.Instance.state.fullscreenMode = i;
		SaveManager.Instance.Save();
		Screen.fullScreenMode = (FullScreenMode)i;
		MonoBehaviour.print("updated fullscreenmode");
	}

	// Token: 0x06000099 RID: 153 RVA: 0x000028A0 File Offset: 0x00000AA0
	public void UpdateVSync(int i)
	{
		SaveManager.Instance.state.vSync = i;
		SaveManager.Instance.Save();
		QualitySettings.vSyncCount = i;
		MonoBehaviour.print("updated vsync");
	}

	// Token: 0x0600009A RID: 154 RVA: 0x000028CC File Offset: 0x00000ACC
	public void UpdateMaxFps(int i)
	{
		SaveManager.Instance.state.fpsLimit = i;
		SaveManager.Instance.Save();
		Application.targetFrameRate = i;
		MonoBehaviour.print("updated fps limit");
	}

	// Token: 0x0600009B RID: 155 RVA: 0x000028F8 File Offset: 0x00000AF8
	public void UpdateVolume(int i)
	{
		SaveManager.Instance.state.volume = i;
		SaveManager.Instance.Save();
		AudioListener.volume = (float)i / 10f;
		MonoBehaviour.print("updated volume");
	}

	// Token: 0x0600009C RID: 156 RVA: 0x0000292B File Offset: 0x00000B2B
	public void UpdateMusic(int i)
	{
		SaveManager.Instance.state.music = i;
		SaveManager.Instance.Save();
		MusicController.Instance.SetVolume((float)i / 10f);
		MonoBehaviour.print("updated music");
	}

	// Token: 0x0400008D RID: 141
	public static bool cameraShake;

	// Token: 0x0400008E RID: 142
	public static bool grass = true;

	// Token: 0x0400008F RID: 143
	public static bool inverted = false;

	// Token: 0x04000090 RID: 144
	public float sensMultiplier;

	// Token: 0x04000091 RID: 145
	public int fov = 85;

	// Token: 0x04000092 RID: 146
	public bool tutorial;

	// Token: 0x04000093 RID: 147
	public float volume;

	// Token: 0x04000094 RID: 148
	public float music;

	// Token: 0x04000095 RID: 149
	public static CurrentSettings Instance;
}
