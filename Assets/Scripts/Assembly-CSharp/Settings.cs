using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

// Token: 0x02000100 RID: 256
public class Settings : MonoBehaviour
{
	// Token: 0x0600077C RID: 1916 RVA: 0x00026386 File Offset: 0x00024586
	private void Start()
	{
		this.UpdateSave();
	}

	// Token: 0x0600077D RID: 1917 RVA: 0x00026390 File Offset: 0x00024590
	private void UpdateSave()
	{
		this.camShake.SetSetting(SaveManager.Instance.state.cameraShake);
		this.camShake.onClick.AddListener(new UnityAction(this.UpdateCamShake));
		this.fov.SetSettings(SaveManager.Instance.state.fov);
		this.fov.onClick.AddListener(new UnityAction(this.UpdateFov));
		this.sens.SetSettings(this.FloatToInt(SaveManager.Instance.state.sensMultiplier));
		this.sens.onClick.AddListener(new UnityAction(this.UpdateSens));
		this.invertedHor.SetSetting(SaveManager.Instance.state.invertedMouseHor);
		this.invertedHor.onClick.AddListener(new UnityAction(this.UpdateInverted));
		this.invertedVer.SetSetting(SaveManager.Instance.state.invertedMouseVert);
		this.invertedVer.onClick.AddListener(new UnityAction(this.UpdateInverted));
		this.grass.SetSetting(SaveManager.Instance.state.grass);
		this.grass.onClick.AddListener(new UnityAction(this.UpdateGrass));
		this.tutorial.SetSetting(SaveManager.Instance.state.tutorial);
		this.tutorial.onClick.AddListener(new UnityAction(this.UpdateTutorial));
		this.forward.SetSetting(SaveManager.Instance.state.forward, "Forward");
		this.forward.onClick.AddListener(new UnityAction(this.UpdateForwardKey));
		this.backward.SetSetting(SaveManager.Instance.state.backwards, "Backward");
		this.backward.onClick.AddListener(new UnityAction(this.UpdateBackwardKey));
		this.left.SetSetting(SaveManager.Instance.state.left, "Left");
		this.left.onClick.AddListener(new UnityAction(this.UpdateLeftKey));
		this.right.SetSetting(SaveManager.Instance.state.right, "Right");
		this.right.onClick.AddListener(new UnityAction(this.UpdateRightKey));
		this.jump.SetSetting(SaveManager.Instance.state.jump, "Jump");
		this.jump.onClick.AddListener(new UnityAction(this.UpdateJumpKey));
		this.sprint.SetSetting(SaveManager.Instance.state.sprint, "Sprint");
		this.sprint.onClick.AddListener(new UnityAction(this.UpdateSprintKey));
		this.interact.SetSetting(SaveManager.Instance.state.interact, "Interact");
		this.interact.onClick.AddListener(new UnityAction(this.UpdateInteractKey));
		this.inventory.SetSetting(SaveManager.Instance.state.inventory, "Inventory");
		this.inventory.onClick.AddListener(new UnityAction(this.UpdateInventoryKey));
		this.map.SetSetting(SaveManager.Instance.state.map, "Map");
		this.map.onClick.AddListener(new UnityAction(this.UpdateMapKey));
		this.leftClick.SetSetting(SaveManager.Instance.state.leftClick, "Left Click / Attack");
		this.leftClick.onClick.AddListener(new UnityAction(this.UpdateLeftClickKey));
		this.rightClick.SetSetting(SaveManager.Instance.state.rightClick, "Right Click / Build");
		this.rightClick.onClick.AddListener(new UnityAction(this.UpdateRightClickKey));
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

	// Token: 0x0600077E RID: 1918 RVA: 0x00026B98 File Offset: 0x00024D98
	private void UpdateCamShake()
	{
		CurrentSettings.Instance.UpdateCamShake(this.IntToBool(this.camShake.currentSetting));
	}

	// Token: 0x0600077F RID: 1919 RVA: 0x00026BB5 File Offset: 0x00024DB5
	private void UpdateInverted()
	{
		CurrentSettings.Instance.UpdateInverted(this.IntToBool(this.invertedHor.currentSetting), this.IntToBool(this.invertedVer.currentSetting));
	}

	// Token: 0x06000780 RID: 1920 RVA: 0x00026BE3 File Offset: 0x00024DE3
	private void UpdateGrass()
	{
		CurrentSettings.Instance.UpdateGrass(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000781 RID: 1921 RVA: 0x00026C00 File Offset: 0x00024E00
	private void UpdateTutorial()
	{
		CurrentSettings.Instance.UpdateTutorial(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000782 RID: 1922 RVA: 0x00026C1D File Offset: 0x00024E1D
	private void UpdateSens()
	{
		CurrentSettings.Instance.UpdateSens(this.IntToFloat(this.sens.currentSetting));
	}

	// Token: 0x06000783 RID: 1923 RVA: 0x00026C3A File Offset: 0x00024E3A
	private void UpdateFov()
	{
		CurrentSettings.Instance.UpdateFov((float)this.fov.currentSetting);
	}

	// Token: 0x06000784 RID: 1924 RVA: 0x00026C52 File Offset: 0x00024E52
	private void UpdateForwardKey()
	{
		SaveManager.Instance.state.forward = this.forward.currentKey;
		SaveManager.Instance.Save();
		InputManager.forward = this.forward.currentKey;
	}

	// Token: 0x06000785 RID: 1925 RVA: 0x00026C88 File Offset: 0x00024E88
	private void UpdateBackwardKey()
	{
		SaveManager.Instance.state.backwards = this.backward.currentKey;
		SaveManager.Instance.Save();
		InputManager.backwards = this.backward.currentKey;
	}

	// Token: 0x06000786 RID: 1926 RVA: 0x00026CBE File Offset: 0x00024EBE
	private void UpdateLeftKey()
	{
		SaveManager.Instance.state.left = this.left.currentKey;
		SaveManager.Instance.Save();
		InputManager.left = this.left.currentKey;
	}

	// Token: 0x06000787 RID: 1927 RVA: 0x00026CF4 File Offset: 0x00024EF4
	private void UpdateRightKey()
	{
		SaveManager.Instance.state.right = this.right.currentKey;
		SaveManager.Instance.Save();
		InputManager.right = this.right.currentKey;
	}

	// Token: 0x06000788 RID: 1928 RVA: 0x00026D2A File Offset: 0x00024F2A
	private void UpdateJumpKey()
	{
		SaveManager.Instance.state.jump = this.jump.currentKey;
		SaveManager.Instance.Save();
		InputManager.jump = this.jump.currentKey;
	}

	// Token: 0x06000789 RID: 1929 RVA: 0x00026D60 File Offset: 0x00024F60
	private void UpdateSprintKey()
	{
		SaveManager.Instance.state.sprint = this.sprint.currentKey;
		SaveManager.Instance.Save();
		InputManager.sprint = this.sprint.currentKey;
	}

	// Token: 0x0600078A RID: 1930 RVA: 0x00026D96 File Offset: 0x00024F96
	private void UpdateInteractKey()
	{
		SaveManager.Instance.state.interact = this.interact.currentKey;
		SaveManager.Instance.Save();
		InputManager.interact = this.interact.currentKey;
	}

	// Token: 0x0600078B RID: 1931 RVA: 0x00026DCC File Offset: 0x00024FCC
	private void UpdateInventoryKey()
	{
		SaveManager.Instance.state.inventory = this.inventory.currentKey;
		SaveManager.Instance.Save();
		InputManager.inventory = this.inventory.currentKey;
	}

	// Token: 0x0600078C RID: 1932 RVA: 0x00026E02 File Offset: 0x00025002
	private void UpdateMapKey()
	{
		SaveManager.Instance.state.map = this.map.currentKey;
		SaveManager.Instance.Save();
		InputManager.map = this.map.currentKey;
	}

	// Token: 0x0600078D RID: 1933 RVA: 0x00026E38 File Offset: 0x00025038
	private void UpdateLeftClickKey()
	{
		SaveManager.Instance.state.leftClick = this.leftClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.leftClick = this.leftClick.currentKey;
	}

	// Token: 0x0600078E RID: 1934 RVA: 0x00026E6E File Offset: 0x0002506E
	private void UpdateRightClickKey()
	{
		SaveManager.Instance.state.rightClick = this.rightClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.rightClick = this.rightClick.currentKey;
	}

	// Token: 0x0600078F RID: 1935 RVA: 0x00026EA4 File Offset: 0x000250A4
	private void UpdateShadowQuality()
	{
		CurrentSettings.Instance.UpdateShadowQuality(this.shadowQuality.currentSetting);
	}

	// Token: 0x06000790 RID: 1936 RVA: 0x00026EBB File Offset: 0x000250BB
	private void UpdateShadowResolution()
	{
		CurrentSettings.Instance.UpdateShadowResolution(this.shadowResolution.currentSetting);
	}

	// Token: 0x06000791 RID: 1937 RVA: 0x00026ED2 File Offset: 0x000250D2
	private void UpdateShadowDistance()
	{
		CurrentSettings.Instance.UpdateShadowDistance(this.shadowDistance.currentSetting);
	}

	// Token: 0x06000792 RID: 1938 RVA: 0x00026EE9 File Offset: 0x000250E9
	private void UpdateShadowCascades()
	{
		CurrentSettings.Instance.UpdateShadowCascades(this.shadowCascades.currentSetting);
	}

	// Token: 0x06000793 RID: 1939 RVA: 0x00026F00 File Offset: 0x00025100
	private void UpdateTextureRes()
	{
		CurrentSettings.Instance.UpdateTextureQuality(this.textureQuality.currentSetting);
	}

	// Token: 0x06000794 RID: 1940 RVA: 0x00026F17 File Offset: 0x00025117
	private void UpdateAntiAliasing()
	{
		CurrentSettings.Instance.UpdateAntiAliasing(this.antiAliasing.currentSetting);
	}

	// Token: 0x06000795 RID: 1941 RVA: 0x00026F2E File Offset: 0x0002512E
	private void UpdateSoftParticles()
	{
		CurrentSettings.Instance.UpdateSoftParticles(this.IntToBool(this.softParticles.currentSetting));
	}

	// Token: 0x06000796 RID: 1942 RVA: 0x00026F4B File Offset: 0x0002514B
	private void UpdateBloom()
	{
		CurrentSettings.Instance.UpdateBloom(this.bloom.currentSetting);
	}

	// Token: 0x06000797 RID: 1943 RVA: 0x00026F62 File Offset: 0x00025162
	private void UpdateMotionBlur()
	{
		CurrentSettings.Instance.UpdateMotionBlur(this.IntToBool(this.motionBlur.currentSetting));
	}

	// Token: 0x06000798 RID: 1944 RVA: 0x00026F7F File Offset: 0x0002517F
	private void UpdateAO()
	{
		CurrentSettings.Instance.UpdateAO(this.IntToBool(this.ao.currentSetting));
	}

	// Token: 0x06000799 RID: 1945 RVA: 0x00026F9C File Offset: 0x0002519C
	private void UpdateFullscreen()
	{
		CurrentSettings.Instance.UpdateFullscreen(this.IntToBool(this.fullscreen.currentSetting));
	}

	// Token: 0x0600079A RID: 1946 RVA: 0x00026FB9 File Offset: 0x000251B9
	private void UpdateFullscreenMode()
	{
		CurrentSettings.Instance.UpdateFullscreenMode(this.fullscreenMode.currentSetting);
	}

	// Token: 0x0600079B RID: 1947 RVA: 0x00026FD0 File Offset: 0x000251D0
	private void UpdateVSync()
	{
		CurrentSettings.Instance.UpdateVSync(this.vSync.currentSetting);
	}

	// Token: 0x0600079C RID: 1948 RVA: 0x00026FE7 File Offset: 0x000251E7
	private void UpdateMaxFps()
	{
		CurrentSettings.Instance.UpdateMaxFps(this.fpsLimit.currentSetting);
	}

	// Token: 0x0600079D RID: 1949 RVA: 0x00026FFE File Offset: 0x000251FE
	private void UpdateVolume()
	{
		CurrentSettings.Instance.UpdateVolume(this.volume.currentSetting);
	}

	// Token: 0x0600079E RID: 1950 RVA: 0x00027015 File Offset: 0x00025215
	private void UpdateMusic()
	{
		CurrentSettings.Instance.UpdateMusic(this.music.currentSetting);
	}

	// Token: 0x0600079F RID: 1951 RVA: 0x0002702C File Offset: 0x0002522C
	private float IntToFloat(int i)
	{
		return (float)i / 100f;
	}

	// Token: 0x060007A0 RID: 1952 RVA: 0x00027036 File Offset: 0x00025236
	private int FloatToInt(float f)
	{
		return (int)(f * 100f);
	}

	// Token: 0x060007A1 RID: 1953 RVA: 0x00027040 File Offset: 0x00025240
	private int BoolToInt(bool b)
	{
		if (b)
		{
			return 1;
		}
		return 0;
	}

	// Token: 0x060007A2 RID: 1954 RVA: 0x00027048 File Offset: 0x00025248
	private bool IntToBool(int i)
	{
		return i != 0;
	}

	// Token: 0x060007A3 RID: 1955 RVA: 0x00027050 File Offset: 0x00025250
	public void ResetSaveFile()
	{
		SaveManager.Instance.NewSave();
		SaveManager.Instance.Save();
		this.UpdateSave();
		CurrentSettings.Instance.UpdateSave();
	}

	// Token: 0x04000700 RID: 1792
	public Button backBtn;

	// Token: 0x04000701 RID: 1793
	[Header("Game")]
	public MyBoolSetting camShake;

	// Token: 0x04000702 RID: 1794
	public SliderSetting fov;

	// Token: 0x04000703 RID: 1795
	public SliderSetting sens;

	// Token: 0x04000704 RID: 1796
	public MyBoolSetting invertedHor;

	// Token: 0x04000705 RID: 1797
	public MyBoolSetting invertedVer;

	// Token: 0x04000706 RID: 1798
	public MyBoolSetting grass;

	// Token: 0x04000707 RID: 1799
	public MyBoolSetting tutorial;

	// Token: 0x04000708 RID: 1800
	[Header("Controls")]
	public ControlSetting forward;

	// Token: 0x04000709 RID: 1801
	public ControlSetting backward;

	// Token: 0x0400070A RID: 1802
	public ControlSetting left;

	// Token: 0x0400070B RID: 1803
	public ControlSetting right;

	// Token: 0x0400070C RID: 1804
	public ControlSetting jump;

	// Token: 0x0400070D RID: 1805
	public ControlSetting sprint;

	// Token: 0x0400070E RID: 1806
	public ControlSetting interact;

	// Token: 0x0400070F RID: 1807
	public ControlSetting inventory;

	// Token: 0x04000710 RID: 1808
	public ControlSetting map;

	// Token: 0x04000711 RID: 1809
	public ControlSetting leftClick;

	// Token: 0x04000712 RID: 1810
	public ControlSetting rightClick;

	// Token: 0x04000713 RID: 1811
	[Header("Graphics")]
	public ScrollSettings shadowQuality;

	// Token: 0x04000714 RID: 1812
	public ScrollSettings shadowResolution;

	// Token: 0x04000715 RID: 1813
	public ScrollSettings shadowDistance;

	// Token: 0x04000716 RID: 1814
	public ScrollSettings shadowCascades;

	// Token: 0x04000717 RID: 1815
	public ScrollSettings textureQuality;

	// Token: 0x04000718 RID: 1816
	public ScrollSettings antiAliasing;

	// Token: 0x04000719 RID: 1817
	public MyBoolSetting softParticles;

	// Token: 0x0400071A RID: 1818
	public ScrollSettings bloom;

	// Token: 0x0400071B RID: 1819
	public MyBoolSetting motionBlur;

	// Token: 0x0400071C RID: 1820
	public MyBoolSetting ao;

	// Token: 0x0400071D RID: 1821
	[Header("Video")]
	public ResolutionSetting resolution;

	// Token: 0x0400071E RID: 1822
	public MyBoolSetting fullscreen;

	// Token: 0x0400071F RID: 1823
	public ScrollSettings fullscreenMode;

	// Token: 0x04000720 RID: 1824
	public ScrollSettings vSync;

	// Token: 0x04000721 RID: 1825
	public SliderSetting fpsLimit;

	// Token: 0x04000722 RID: 1826
	[Header("Audio")]
	public SliderSetting volume;

	// Token: 0x04000723 RID: 1827
	[Header("Audio")]
	public SliderSetting music;

	// Token: 0x02000176 RID: 374
	public enum BoolSetting
	{
		// Token: 0x0400095E RID: 2398
		Off,
		// Token: 0x0400095F RID: 2399
		On
	}

	// Token: 0x02000177 RID: 375
	public enum VSync
	{
		// Token: 0x04000961 RID: 2401
		Off,
		// Token: 0x04000962 RID: 2402
		Always,
		// Token: 0x04000963 RID: 2403
		Half
	}

	// Token: 0x02000178 RID: 376
	public enum ShadowQuality
	{
		// Token: 0x04000965 RID: 2405
		Off,
		// Token: 0x04000966 RID: 2406
		Hard,
		// Token: 0x04000967 RID: 2407
		Soft
	}

	// Token: 0x02000179 RID: 377
	public enum ShadowResolution
	{
		// Token: 0x04000969 RID: 2409
		Low,
		// Token: 0x0400096A RID: 2410
		Medium,
		// Token: 0x0400096B RID: 2411
		High,
		// Token: 0x0400096C RID: 2412
		Ultra
	}

	// Token: 0x0200017A RID: 378
	public enum ShadowDistance
	{
		// Token: 0x0400096E RID: 2414
		Low,
		// Token: 0x0400096F RID: 2415
		Medium,
		// Token: 0x04000970 RID: 2416
		High,
		// Token: 0x04000971 RID: 2417
		Ultra
	}

	// Token: 0x0200017B RID: 379
	public enum ShadowCascades
	{
		// Token: 0x04000973 RID: 2419
		None,
		// Token: 0x04000974 RID: 2420
		Two,
		// Token: 0x04000975 RID: 2421
		Four
	}

	// Token: 0x0200017C RID: 380
	public enum TextureResolution
	{
		// Token: 0x04000977 RID: 2423
		Low,
		// Token: 0x04000978 RID: 2424
		Medium,
		// Token: 0x04000979 RID: 2425
		High,
		// Token: 0x0400097A RID: 2426
		Ultra
	}

	// Token: 0x0200017D RID: 381
	public enum AntiAliasing
	{
		// Token: 0x0400097C RID: 2428
		Off,
		// Token: 0x0400097D RID: 2429
		x2,
		// Token: 0x0400097E RID: 2430
		x4,
		// Token: 0x0400097F RID: 2431
		x8
	}

	// Token: 0x0200017E RID: 382
	public enum Bloom
	{
		// Token: 0x04000981 RID: 2433
		Off,
		// Token: 0x04000982 RID: 2434
		Fast,
		// Token: 0x04000983 RID: 2435
		Fancy
	}
}
