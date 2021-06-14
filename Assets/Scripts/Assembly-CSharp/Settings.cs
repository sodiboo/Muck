using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

// Token: 0x0200011A RID: 282
public class Settings : MonoBehaviour
{
	// Token: 0x060006FF RID: 1791 RVA: 0x000066EB File Offset: 0x000048EB
	private void Start()
	{
		this.UpdateSave();
	}

	// Token: 0x06000700 RID: 1792 RVA: 0x00023A00 File Offset: 0x00021C00
	private void UpdateSave()
	{
		this.camShake.SetSetting(SaveManager.Instance.state.cameraShake);
		this.camShake.onClick.AddListener(new UnityAction(this.UpdateCamShake));
		this.fov.SetSettings(SaveManager.Instance.state.fov);
		this.fov.onClick.AddListener(new UnityAction(this.UpdateFov));
		this.sens.SetSettings(this.FloatToInt(SaveManager.Instance.state.sensMultiplier));
		this.sens.onClick.AddListener(new UnityAction(this.UpdateSens));
		this.inverted.SetSetting(SaveManager.Instance.state.invertedMouse);
		this.inverted.onClick.AddListener(new UnityAction(this.UpdateInverted));
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

	// Token: 0x06000701 RID: 1793 RVA: 0x000066F3 File Offset: 0x000048F3
	private void UpdateCamShake()
	{
		CurrentSettings.Instance.UpdateCamShake(this.IntToBool(this.camShake.currentSetting));
	}

	// Token: 0x06000702 RID: 1794 RVA: 0x00006710 File Offset: 0x00004910
	private void UpdateInverted()
	{
		CurrentSettings.Instance.UpdateInverted(this.IntToBool(this.inverted.currentSetting));
	}

	// Token: 0x06000703 RID: 1795 RVA: 0x0000672D File Offset: 0x0000492D
	private void UpdateGrass()
	{
		CurrentSettings.Instance.UpdateGrass(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000704 RID: 1796 RVA: 0x0000674A File Offset: 0x0000494A
	private void UpdateTutorial()
	{
		CurrentSettings.Instance.UpdateTutorial(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000705 RID: 1797 RVA: 0x00006767 File Offset: 0x00004967
	private void UpdateSens()
	{
		CurrentSettings.Instance.UpdateSens(this.IntToFloat(this.sens.currentSetting));
	}

	// Token: 0x06000706 RID: 1798 RVA: 0x00006784 File Offset: 0x00004984
	private void UpdateFov()
	{
		CurrentSettings.Instance.UpdateFov((float)this.fov.currentSetting);
	}

	// Token: 0x06000707 RID: 1799 RVA: 0x0000679C File Offset: 0x0000499C
	private void UpdateForwardKey()
	{
		SaveManager.Instance.state.forward = this.forward.currentKey;
		SaveManager.Instance.Save();
		InputManager.forward = this.forward.currentKey;
	}

	// Token: 0x06000708 RID: 1800 RVA: 0x000067D2 File Offset: 0x000049D2
	private void UpdateBackwardKey()
	{
		SaveManager.Instance.state.backwards = this.backward.currentKey;
		SaveManager.Instance.Save();
		InputManager.backwards = this.backward.currentKey;
	}

	// Token: 0x06000709 RID: 1801 RVA: 0x00006808 File Offset: 0x00004A08
	private void UpdateLeftKey()
	{
		SaveManager.Instance.state.left = this.left.currentKey;
		SaveManager.Instance.Save();
		InputManager.left = this.left.currentKey;
	}

	// Token: 0x0600070A RID: 1802 RVA: 0x0000683E File Offset: 0x00004A3E
	private void UpdateRightKey()
	{
		SaveManager.Instance.state.right = this.right.currentKey;
		SaveManager.Instance.Save();
		InputManager.right = this.right.currentKey;
	}

	// Token: 0x0600070B RID: 1803 RVA: 0x00006874 File Offset: 0x00004A74
	private void UpdateJumpKey()
	{
		SaveManager.Instance.state.jump = this.jump.currentKey;
		SaveManager.Instance.Save();
		InputManager.jump = this.jump.currentKey;
	}

	// Token: 0x0600070C RID: 1804 RVA: 0x000068AA File Offset: 0x00004AAA
	private void UpdateSprintKey()
	{
		SaveManager.Instance.state.sprint = this.sprint.currentKey;
		SaveManager.Instance.Save();
		InputManager.sprint = this.sprint.currentKey;
	}

	// Token: 0x0600070D RID: 1805 RVA: 0x000068E0 File Offset: 0x00004AE0
	private void UpdateInteractKey()
	{
		SaveManager.Instance.state.interact = this.interact.currentKey;
		SaveManager.Instance.Save();
		InputManager.interact = this.interact.currentKey;
	}

	// Token: 0x0600070E RID: 1806 RVA: 0x00006916 File Offset: 0x00004B16
	private void UpdateInventoryKey()
	{
		SaveManager.Instance.state.inventory = this.inventory.currentKey;
		SaveManager.Instance.Save();
		InputManager.inventory = this.inventory.currentKey;
	}

	// Token: 0x0600070F RID: 1807 RVA: 0x0000694C File Offset: 0x00004B4C
	private void UpdateMapKey()
	{
		SaveManager.Instance.state.map = this.map.currentKey;
		SaveManager.Instance.Save();
		InputManager.map = this.map.currentKey;
	}

	// Token: 0x06000710 RID: 1808 RVA: 0x00006982 File Offset: 0x00004B82
	private void UpdateLeftClickKey()
	{
		SaveManager.Instance.state.leftClick = this.leftClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.leftClick = this.leftClick.currentKey;
	}

	// Token: 0x06000711 RID: 1809 RVA: 0x000069B8 File Offset: 0x00004BB8
	private void UpdateRightClickKey()
	{
		SaveManager.Instance.state.rightClick = this.rightClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.rightClick = this.rightClick.currentKey;
	}

	// Token: 0x06000712 RID: 1810 RVA: 0x000069EE File Offset: 0x00004BEE
	private void UpdateShadowQuality()
	{
		CurrentSettings.Instance.UpdateShadowQuality(this.shadowQuality.currentSetting);
	}

	// Token: 0x06000713 RID: 1811 RVA: 0x00006A05 File Offset: 0x00004C05
	private void UpdateShadowResolution()
	{
		CurrentSettings.Instance.UpdateShadowResolution(this.shadowResolution.currentSetting);
	}

	// Token: 0x06000714 RID: 1812 RVA: 0x00006A1C File Offset: 0x00004C1C
	private void UpdateShadowDistance()
	{
		CurrentSettings.Instance.UpdateShadowDistance(this.shadowDistance.currentSetting);
	}

	// Token: 0x06000715 RID: 1813 RVA: 0x00006A33 File Offset: 0x00004C33
	private void UpdateShadowCascades()
	{
		CurrentSettings.Instance.UpdateShadowCascades(this.shadowCascades.currentSetting);
	}

	// Token: 0x06000716 RID: 1814 RVA: 0x00006A4A File Offset: 0x00004C4A
	private void UpdateTextureRes()
	{
		CurrentSettings.Instance.UpdateTextureQuality(this.textureQuality.currentSetting);
	}

	// Token: 0x06000717 RID: 1815 RVA: 0x00006A61 File Offset: 0x00004C61
	private void UpdateAntiAliasing()
	{
		CurrentSettings.Instance.UpdateAntiAliasing(this.antiAliasing.currentSetting);
	}

	// Token: 0x06000718 RID: 1816 RVA: 0x00006A78 File Offset: 0x00004C78
	private void UpdateSoftParticles()
	{
		CurrentSettings.Instance.UpdateSoftParticles(this.IntToBool(this.softParticles.currentSetting));
	}

	// Token: 0x06000719 RID: 1817 RVA: 0x00006A95 File Offset: 0x00004C95
	private void UpdateBloom()
	{
		CurrentSettings.Instance.UpdateBloom(this.bloom.currentSetting);
	}

	// Token: 0x0600071A RID: 1818 RVA: 0x00006AAC File Offset: 0x00004CAC
	private void UpdateMotionBlur()
	{
		CurrentSettings.Instance.UpdateMotionBlur(this.IntToBool(this.motionBlur.currentSetting));
	}

	// Token: 0x0600071B RID: 1819 RVA: 0x00006AC9 File Offset: 0x00004CC9
	private void UpdateAO()
	{
		CurrentSettings.Instance.UpdateAO(this.IntToBool(this.ao.currentSetting));
	}

	// Token: 0x0600071C RID: 1820 RVA: 0x00006AE6 File Offset: 0x00004CE6
	private void UpdateFullscreen()
	{
		CurrentSettings.Instance.UpdateFullscreen(this.IntToBool(this.fullscreen.currentSetting));
	}

	// Token: 0x0600071D RID: 1821 RVA: 0x00006B03 File Offset: 0x00004D03
	private void UpdateFullscreenMode()
	{
		CurrentSettings.Instance.UpdateFullscreenMode(this.fullscreenMode.currentSetting);
	}

	// Token: 0x0600071E RID: 1822 RVA: 0x00006B1A File Offset: 0x00004D1A
	private void UpdateVSync()
	{
		CurrentSettings.Instance.UpdateVSync(this.vSync.currentSetting);
	}

	// Token: 0x0600071F RID: 1823 RVA: 0x00006B31 File Offset: 0x00004D31
	private void UpdateMaxFps()
	{
		CurrentSettings.Instance.UpdateMaxFps(this.fpsLimit.currentSetting);
	}

	// Token: 0x06000720 RID: 1824 RVA: 0x00006B48 File Offset: 0x00004D48
	private void UpdateVolume()
	{
		CurrentSettings.Instance.UpdateVolume(this.volume.currentSetting);
	}

	// Token: 0x06000721 RID: 1825 RVA: 0x00006B5F File Offset: 0x00004D5F
	private void UpdateMusic()
	{
		CurrentSettings.Instance.UpdateMusic(this.music.currentSetting);
	}

	// Token: 0x06000722 RID: 1826 RVA: 0x00006B76 File Offset: 0x00004D76
	private float IntToFloat(int i)
	{
		return (float)i / 100f;
	}

	// Token: 0x06000723 RID: 1827 RVA: 0x00006B80 File Offset: 0x00004D80
	private int FloatToInt(float f)
	{
		return (int)(f * 100f);
	}

	// Token: 0x06000724 RID: 1828 RVA: 0x00006B8A File Offset: 0x00004D8A
	private int BoolToInt(bool b)
	{
		if (b)
		{
			return 1;
		}
		return 0;
	}

	// Token: 0x06000725 RID: 1829 RVA: 0x00006B92 File Offset: 0x00004D92
	private bool IntToBool(int i)
	{
		return i != 0;
	}

	// Token: 0x06000726 RID: 1830 RVA: 0x00006B9A File Offset: 0x00004D9A
	public void ResetSaveFile()
	{
		SaveManager.Instance.NewSave();
		SaveManager.Instance.Save();
		this.UpdateSave();
		CurrentSettings.Instance.UpdateSave();
	}

	// Token: 0x040006F7 RID: 1783
	public Button backBtn;

	// Token: 0x040006F8 RID: 1784
	[Header("Game")]
	public MyBoolSetting camShake;

	// Token: 0x040006F9 RID: 1785
	public SliderSetting fov;

	// Token: 0x040006FA RID: 1786
	public SliderSetting sens;

	// Token: 0x040006FB RID: 1787
	public MyBoolSetting inverted;

	// Token: 0x040006FC RID: 1788
	public MyBoolSetting grass;

	// Token: 0x040006FD RID: 1789
	public MyBoolSetting tutorial;

	// Token: 0x040006FE RID: 1790
	[Header("Controls")]
	public ControlSetting forward;

	// Token: 0x040006FF RID: 1791
	public ControlSetting backward;

	// Token: 0x04000700 RID: 1792
	public ControlSetting left;

	// Token: 0x04000701 RID: 1793
	public ControlSetting right;

	// Token: 0x04000702 RID: 1794
	public ControlSetting jump;

	// Token: 0x04000703 RID: 1795
	public ControlSetting sprint;

	// Token: 0x04000704 RID: 1796
	public ControlSetting interact;

	// Token: 0x04000705 RID: 1797
	public ControlSetting inventory;

	// Token: 0x04000706 RID: 1798
	public ControlSetting map;

	// Token: 0x04000707 RID: 1799
	public ControlSetting leftClick;

	// Token: 0x04000708 RID: 1800
	public ControlSetting rightClick;

	// Token: 0x04000709 RID: 1801
	[Header("Graphics")]
	public ScrollSettings shadowQuality;

	// Token: 0x0400070A RID: 1802
	public ScrollSettings shadowResolution;

	// Token: 0x0400070B RID: 1803
	public ScrollSettings shadowDistance;

	// Token: 0x0400070C RID: 1804
	public ScrollSettings shadowCascades;

	// Token: 0x0400070D RID: 1805
	public ScrollSettings textureQuality;

	// Token: 0x0400070E RID: 1806
	public ScrollSettings antiAliasing;

	// Token: 0x0400070F RID: 1807
	public MyBoolSetting softParticles;

	// Token: 0x04000710 RID: 1808
	public ScrollSettings bloom;

	// Token: 0x04000711 RID: 1809
	public MyBoolSetting motionBlur;

	// Token: 0x04000712 RID: 1810
	public MyBoolSetting ao;

	// Token: 0x04000713 RID: 1811
	[Header("Video")]
	public ResolutionSetting resolution;

	// Token: 0x04000714 RID: 1812
	public MyBoolSetting fullscreen;

	// Token: 0x04000715 RID: 1813
	public ScrollSettings fullscreenMode;

	// Token: 0x04000716 RID: 1814
	public ScrollSettings vSync;

	// Token: 0x04000717 RID: 1815
	public SliderSetting fpsLimit;

	// Token: 0x04000718 RID: 1816
	[Header("Audio")]
	public SliderSetting volume;

	// Token: 0x04000719 RID: 1817
	[Header("Audio")]
	public SliderSetting music;

	// Token: 0x0200011B RID: 283
	public enum BoolSetting
	{
		// Token: 0x0400071B RID: 1819
		Off,
		// Token: 0x0400071C RID: 1820
		On
	}

	// Token: 0x0200011C RID: 284
	public enum VSync
	{
		// Token: 0x0400071E RID: 1822
		Off,
		// Token: 0x0400071F RID: 1823
		Always,
		// Token: 0x04000720 RID: 1824
		Half
	}

	// Token: 0x0200011D RID: 285
	public enum ShadowQuality
	{
		// Token: 0x04000722 RID: 1826
		Off,
		// Token: 0x04000723 RID: 1827
		Hard,
		// Token: 0x04000724 RID: 1828
		Soft
	}

	// Token: 0x0200011E RID: 286
	public enum ShadowResolution
	{
		// Token: 0x04000726 RID: 1830
		Low,
		// Token: 0x04000727 RID: 1831
		Medium,
		// Token: 0x04000728 RID: 1832
		High,
		// Token: 0x04000729 RID: 1833
		Ultra
	}

	// Token: 0x0200011F RID: 287
	public enum ShadowDistance
	{
		// Token: 0x0400072B RID: 1835
		Low,
		// Token: 0x0400072C RID: 1836
		Medium,
		// Token: 0x0400072D RID: 1837
		High,
		// Token: 0x0400072E RID: 1838
		Ultra
	}

	// Token: 0x02000120 RID: 288
	public enum ShadowCascades
	{
		// Token: 0x04000730 RID: 1840
		None,
		// Token: 0x04000731 RID: 1841
		Two,
		// Token: 0x04000732 RID: 1842
		Four
	}

	// Token: 0x02000121 RID: 289
	public enum TextureResolution
	{
		// Token: 0x04000734 RID: 1844
		Low,
		// Token: 0x04000735 RID: 1845
		Medium,
		// Token: 0x04000736 RID: 1846
		High,
		// Token: 0x04000737 RID: 1847
		Ultra
	}

	// Token: 0x02000122 RID: 290
	public enum AntiAliasing
	{
		// Token: 0x04000739 RID: 1849
		Off,
		// Token: 0x0400073A RID: 1850
		x2,
		// Token: 0x0400073B RID: 1851
		x4,
		// Token: 0x0400073C RID: 1852
		x8
	}

	// Token: 0x02000123 RID: 291
	public enum Bloom
	{
		// Token: 0x0400073E RID: 1854
		Off,
		// Token: 0x0400073F RID: 1855
		Fast,
		// Token: 0x04000740 RID: 1856
		Fancy
	}
}
