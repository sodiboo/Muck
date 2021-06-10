
using UnityEngine;

// Token: 0x02000017 RID: 23
public class CurrentSettings : MonoBehaviour
{
	// Token: 0x0600007A RID: 122 RVA: 0x00004874 File Offset: 0x00002A74
	private void Awake()
	{
		CurrentSettings.Instance = this;
	}

	// Token: 0x0600007B RID: 123 RVA: 0x0000487C File Offset: 0x00002A7C
	private void Start()
	{
		this.InitSettings();
	}

	// Token: 0x0600007C RID: 124 RVA: 0x00004884 File Offset: 0x00002A84
	private void InitSettings()
	{
		this.UpdateSave();
	}

	// Token: 0x0600007D RID: 125 RVA: 0x0000488C File Offset: 0x00002A8C
	public void UpdateSave()
	{
		this.UpdateCamShake(SaveManager.Instance.state.cameraShake);
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
		this.UpdateMaxFps(SaveManager.Instance.state.fpsLimit);
		this.UpdateVolume(SaveManager.Instance.state.volume);
		this.UpdateMusic(SaveManager.Instance.state.music);
	}

	// Token: 0x0600007E RID: 126 RVA: 0x00004A5D File Offset: 0x00002C5D
	public void UpdateCamShake(bool b)
	{
		SaveManager.Instance.state.cameraShake = b;
		SaveManager.Instance.Save();
		CurrentSettings.cameraShake = b;
	}

	// Token: 0x0600007F RID: 127 RVA: 0x00004A7F File Offset: 0x00002C7F
	public void UpdateSens(float i)
	{
		MonoBehaviour.print("updates sens to: " + i);
		SaveManager.Instance.state.sensMultiplier = i;
		SaveManager.Instance.Save();
		this.sensMultiplier = i;
		PlayerInput.sensMultiplier = i;
	}

	// Token: 0x06000080 RID: 128 RVA: 0x00004ABD File Offset: 0x00002CBD
	public void UpdateInverted(bool b)
	{
		Debug.Log("Setting inverted to: " + b.ToString());
		SaveManager.Instance.state.invertedMouse = b;
		SaveManager.Instance.Save();
		CurrentSettings.inverted = b;
	}

	// Token: 0x06000081 RID: 129 RVA: 0x00004AF5 File Offset: 0x00002CF5
	public void UpdateGrass(bool b)
	{
		Debug.Log("Setting grass to: " + b.ToString());
		SaveManager.Instance.state.grass = b;
		SaveManager.Instance.Save();
		CurrentSettings.grass = b;
	}

	// Token: 0x06000082 RID: 130 RVA: 0x00004B2D File Offset: 0x00002D2D
	public void UpdateTutorial(bool b)
	{
		Debug.Log("Setting tutorial to: " + b.ToString());
		SaveManager.Instance.state.tutorial = b;
		SaveManager.Instance.Save();
		this.tutorial = b;
	}

	// Token: 0x06000083 RID: 131 RVA: 0x00004B66 File Offset: 0x00002D66
	public void UpdateShadowQuality(int i)
	{
		SaveManager.Instance.state.shadowQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.shadows = (ShadowQuality)i;
		MonoBehaviour.print("updating shadow quality");
	}

	// Token: 0x06000084 RID: 132 RVA: 0x00004B92 File Offset: 0x00002D92
	public void UpdateShadowResolution(int i)
	{
		SaveManager.Instance.state.shadowResolution = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowResolution = (ShadowResolution)i;
		MonoBehaviour.print("updating shadow res");
	}

	// Token: 0x06000085 RID: 133 RVA: 0x00004BBE File Offset: 0x00002DBE
	public void UpdateShadowCascades(int i)
	{
		SaveManager.Instance.state.shadowCascade = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowCascades = 2 * i;
		MonoBehaviour.print("updating shadow cascades");
	}

	// Token: 0x06000086 RID: 134 RVA: 0x00004BEC File Offset: 0x00002DEC
	public void UpdateShadowDistance(int i)
	{
		SaveManager.Instance.state.shadowDistance = i;
		SaveManager.Instance.Save();
		QualitySettings.shadowDistance = (float)(i * 40);
		MonoBehaviour.print("updating shadow distance");
	}

	// Token: 0x06000087 RID: 135 RVA: 0x00004C1C File Offset: 0x00002E1C
	public void UpdateTextureQuality(int i)
	{
		SaveManager.Instance.state.textureQuality = i;
		SaveManager.Instance.Save();
		QualitySettings.masterTextureLimit = 3 - i;
		MonoBehaviour.print("updating texture quality");
	}

	// Token: 0x06000088 RID: 136 RVA: 0x00004C4C File Offset: 0x00002E4C
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

	// Token: 0x06000089 RID: 137 RVA: 0x00004CAB File Offset: 0x00002EAB
	public void UpdateSoftParticles(bool b)
	{
		SaveManager.Instance.state.softParticles = b;
		SaveManager.Instance.Save();
		QualitySettings.softParticles = b;
		MonoBehaviour.print("updating soft particles");
	}

	// Token: 0x0600008A RID: 138 RVA: 0x00004CD7 File Offset: 0x00002ED7
	public void UpdateBloom(int i)
	{
		SaveManager.Instance.state.bloom = i;
		SaveManager.Instance.Save();
		PPController.Instance.SetBloom(i);
		MonoBehaviour.print("updating bloom");
	}

	// Token: 0x0600008B RID: 139 RVA: 0x00004D08 File Offset: 0x00002F08
	public void UpdateMotionBlur(bool b)
	{
		SaveManager.Instance.state.motionBlur = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetMotionBlur(b);
		MonoBehaviour.print("updating motion blur");
	}

	// Token: 0x0600008C RID: 140 RVA: 0x00004D39 File Offset: 0x00002F39
	public void UpdateAO(bool b)
	{
		SaveManager.Instance.state.ambientOcclusion = b;
		SaveManager.Instance.Save();
		PPController.Instance.SetAO(b);
		MonoBehaviour.print("updating AO");
	}

	// Token: 0x0600008D RID: 141 RVA: 0x00004D6C File Offset: 0x00002F6C
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

	// Token: 0x0600008E RID: 142 RVA: 0x00004E02 File Offset: 0x00003002
	public void UpdateFullscreen(bool i)
	{
		SaveManager.Instance.state.fullscreen = i;
		SaveManager.Instance.Save();
		Screen.fullScreen = i;
		MonoBehaviour.print("updated fullscreen");
	}

	// Token: 0x0600008F RID: 143 RVA: 0x00004E2E File Offset: 0x0000302E
	public void UpdateVSync(int i)
	{
		SaveManager.Instance.state.vSync = i;
		SaveManager.Instance.Save();
		QualitySettings.vSyncCount = i;
		MonoBehaviour.print("updated vsync");
	}

	// Token: 0x06000090 RID: 144 RVA: 0x00004E5A File Offset: 0x0000305A
	public void UpdateMaxFps(int i)
	{
		SaveManager.Instance.state.fpsLimit = i;
		SaveManager.Instance.Save();
		Application.targetFrameRate = i;
		MonoBehaviour.print("updated fps limit");
	}

	// Token: 0x06000091 RID: 145 RVA: 0x00004E86 File Offset: 0x00003086
	public void UpdateVolume(int i)
	{
		SaveManager.Instance.state.volume = i;
		SaveManager.Instance.Save();
		AudioListener.volume = (float)i / 10f;
		MonoBehaviour.print("updated volume");
	}

	// Token: 0x06000092 RID: 146 RVA: 0x00004EB9 File Offset: 0x000030B9
	public void UpdateMusic(int i)
	{
		SaveManager.Instance.state.music = i;
		SaveManager.Instance.Save();
		MusicController.Instance.SetVolume((float)i / 10f);
		MonoBehaviour.print("updated music");
	}

	// Token: 0x0400007E RID: 126
	public static bool cameraShake;

	// Token: 0x0400007F RID: 127
	public static bool grass = true;

	// Token: 0x04000080 RID: 128
	public static bool inverted = false;

	// Token: 0x04000081 RID: 129
	public float sensMultiplier;

	// Token: 0x04000082 RID: 130
	public bool tutorial;

	// Token: 0x04000083 RID: 131
	public float volume;

	// Token: 0x04000084 RID: 132
	public float music;

	// Token: 0x04000085 RID: 133
	public static CurrentSettings Instance;
}
