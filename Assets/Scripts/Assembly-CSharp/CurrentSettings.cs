using System;
using UnityEngine;

// Token: 0x0200001F RID: 31
public class CurrentSettings : MonoBehaviour
{
	// Token: 0x060000B4 RID: 180 RVA: 0x00005664 File Offset: 0x00003864
	private void Awake()
	{
		if (CurrentSettings.Instance)
		{
			Destroy(base.gameObject);
			return;
		}
		CurrentSettings.Instance = this;
	}

	// Token: 0x060000B5 RID: 181 RVA: 0x00005684 File Offset: 0x00003884
	private void Start()
	{
		this.InitSettings();
	}

	// Token: 0x060000B6 RID: 182 RVA: 0x0000568C File Offset: 0x0000388C
	private void InitSettings()
	{
		this.UpdateSave();
	}

	// Token: 0x060000B7 RID: 183 RVA: 0x00005694 File Offset: 0x00003894
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

	// Token: 0x060000B8 RID: 184 RVA: 0x00005890 File Offset: 0x00003A90
	public void UpdateCamShake(bool b)
	{
		SaveManager.Instance.state.cameraShake = b;
		SaveManager.Instance.Save();
		CurrentSettings.cameraShake = b;
	}

	// Token: 0x060000B9 RID: 185 RVA: 0x000058B2 File Offset: 0x00003AB2
	public void UpdateSens(float i)
	{
		MonoBehaviour.print("updates sens to: " + i);
		SaveManager.Instance.state.sensMultiplier = i;
		SaveManager.Instance.Save();
		this.sensMultiplier = i;
		PlayerInput.sensMultiplier = i;
	}

	// Token: 0x060000BA RID: 186 RVA: 0x000058F0 File Offset: 0x00003AF0
	public void UpdateFov(float i)
	{
		int num = (int)i;
		SaveManager.Instance.state.fov = num;
		SaveManager.Instance.Save();
		this.fov = num;
		if (MoveCamera.Instance)
		{
			MoveCamera.Instance.UpdateFov((float)this.fov);
		}
	}

	// Token: 0x060000BB RID: 187 RVA: 0x00005940 File Offset: 0x00003B40
	public void UpdateInverted(bool hor, bool ver)
	{
		Debug.Log("Setting inverted to: " + hor.ToString() + ", ver: " + ver.ToString());
		SaveManager.Instance.state.invertedMouseHor = hor;
		SaveManager.Instance.state.invertedMouseVert = ver;
		SaveManager.Instance.Save();
		CurrentSettings.invertedHor = hor;
		CurrentSettings.invertedVer = ver;
	}

	// Token: 0x060000BC RID: 188 RVA: 0x000059A5 File Offset: 0x00003BA5
	public void UpdateGrass(bool b)
	{
		Debug.Log("Setting grass to: " + b.ToString());
		SaveManager.Instance.state.grass = b;
		SaveManager.Instance.Save();
		CurrentSettings.grass = b;
	}

	// Token: 0x060000BD RID: 189 RVA: 0x000059DD File Offset: 0x00003BDD
	public void UpdateTutorial(bool b)
	{
		Debug.Log("Setting tutorial to: " + b.ToString());
		SaveManager.Instance.state.tutorial = b;
		SaveManager.Instance.Save();
		this.tutorial = b;
	}

	// Token: 0x060000BE RID: 190 RVA: 0x00005A16 File Offset: 0x00003C16
	public void UpdateShadowQuality(int i)
	{
		SaveManager.Instance.state.shadowQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.shadows = (ShadowQuality)i;
		MonoBehaviour.print("updating shadow quality");
	}

	// Token: 0x060000BF RID: 191 RVA: 0x00005A42 File Offset: 0x00003C42
	public void UpdateShadowResolution(int i)
	{
		SaveManager.Instance.state.shadowResolution = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowResolution = (ShadowResolution)i;
		MonoBehaviour.print("updating shadow res");
	}

	// Token: 0x060000C0 RID: 192 RVA: 0x00005A6E File Offset: 0x00003C6E
	public void UpdateShadowCascades(int i)
	{
		SaveManager.Instance.state.shadowCascade = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowCascades = 2 * i;
		MonoBehaviour.print("updating shadow cascades");
	}

	// Token: 0x060000C1 RID: 193 RVA: 0x00005A9C File Offset: 0x00003C9C
	public void UpdateShadowDistance(int i)
	{
		SaveManager.Instance.state.shadowDistance = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowDistance = (float)(i * 40);
		MonoBehaviour.print("updating shadow distance");
	}

	// Token: 0x060000C2 RID: 194 RVA: 0x00005ACC File Offset: 0x00003CCC
	public void UpdateTextureQuality(int i)
	{
		SaveManager.Instance.state.textureQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.masterTextureLimit = 3 - i;
		MonoBehaviour.print("updating texture quality");
	}

	// Token: 0x060000C3 RID: 195 RVA: 0x00005AFC File Offset: 0x00003CFC
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

	// Token: 0x060000C4 RID: 196 RVA: 0x00005B5B File Offset: 0x00003D5B
	public void UpdateSoftParticles(bool b)
	{
		SaveManager.Instance.state.softParticles = b;
		SaveManager.Instance.Save();
		QualitySettings.softParticles = b;
		MonoBehaviour.print("updating soft particles");
	}

	// Token: 0x060000C5 RID: 197 RVA: 0x00005B87 File Offset: 0x00003D87
	public void UpdateBloom(int i)
	{
		SaveManager.Instance.state.bloom = i;
		SaveManager.Instance.Save();
		PPController.Instance.SetBloom(i);
		MonoBehaviour.print("updating bloom");
	}

	// Token: 0x060000C6 RID: 198 RVA: 0x00005BB8 File Offset: 0x00003DB8
	public void UpdateMotionBlur(bool b)
	{
		SaveManager.Instance.state.motionBlur = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetMotionBlur(b);
		MonoBehaviour.print("updating motion blur");
	}

	// Token: 0x060000C7 RID: 199 RVA: 0x00005BE9 File Offset: 0x00003DE9
	public void UpdateAO(bool b)
	{
		SaveManager.Instance.state.ambientOcclusion = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetAO(b);
		MonoBehaviour.print("updating AO");
	}

	// Token: 0x060000C8 RID: 200 RVA: 0x00005C1C File Offset: 0x00003E1C
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

	// Token: 0x060000C9 RID: 201 RVA: 0x00005CB2 File Offset: 0x00003EB2
	public void UpdateFullscreen(bool i)
	{
		SaveManager.Instance.state.fullscreen = i;
		SaveManager.Instance.Save();
		Screen.fullScreen = i;
		MonoBehaviour.print("updated fullscreen");
	}

	// Token: 0x060000CA RID: 202 RVA: 0x00005CDE File Offset: 0x00003EDE
	public void UpdateFullscreenMode(int i)
	{
		SaveManager.Instance.state.fullscreenMode = i;
		SaveManager.Instance.Save();
		Screen.fullScreenMode = (FullScreenMode)i;
		MonoBehaviour.print("updated fullscreenmode");
	}

	// Token: 0x060000CB RID: 203 RVA: 0x00005D0A File Offset: 0x00003F0A
	public void UpdateVSync(int i)
	{
		SaveManager.Instance.state.vSync = i;
		SaveManager.Instance.Save();
		QualitySettings.vSyncCount = i;
		MonoBehaviour.print("updated vsync");
	}

	// Token: 0x060000CC RID: 204 RVA: 0x00005D36 File Offset: 0x00003F36
	public void UpdateMaxFps(int i)
	{
		SaveManager.Instance.state.fpsLimit = i;
		SaveManager.Instance.Save();
		Application.targetFrameRate = i;
		MonoBehaviour.print("updated fps limit");
	}

	// Token: 0x060000CD RID: 205 RVA: 0x00005D62 File Offset: 0x00003F62
	public void UpdateVolume(int i)
	{
		SaveManager.Instance.state.volume = i;
		SaveManager.Instance.Save();
		AudioListener.volume = (float)i / 10f;
		MonoBehaviour.print("updated volume");
	}

	// Token: 0x060000CE RID: 206 RVA: 0x00005D98 File Offset: 0x00003F98
	public void UpdateMusic(int i)
	{
		SaveManager.Instance.state.music = i;
		SaveManager.Instance.Save();
		MusicController.Instance.SetVolume((float)i / 10f);
		this.music = (float)SaveManager.Instance.state.music / 10f;
		MonoBehaviour.print("updated music");
	}

	// Token: 0x040000C1 RID: 193
	public static bool cameraShake;

	// Token: 0x040000C2 RID: 194
	public static bool grass = true;

	// Token: 0x040000C3 RID: 195
	public static bool invertedHor = false;

	// Token: 0x040000C4 RID: 196
	public static bool invertedVer = false;

	// Token: 0x040000C5 RID: 197
	public float sensMultiplier;

	// Token: 0x040000C6 RID: 198
	public int fov = 85;

	// Token: 0x040000C7 RID: 199
	public bool tutorial;

	// Token: 0x040000C8 RID: 200
	public float volume;

	// Token: 0x040000C9 RID: 201
	public float music;

	// Token: 0x040000CA RID: 202
	public static CurrentSettings Instance;
}
