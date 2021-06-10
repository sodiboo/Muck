using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

// Token: 0x020000D8 RID: 216
public class Settings : MonoBehaviour
{
	// Token: 0x06000662 RID: 1634 RVA: 0x00020286 File Offset: 0x0001E486
	private void Start()
	{
		this.UpdateSave();
	}

	// Token: 0x06000663 RID: 1635 RVA: 0x00020290 File Offset: 0x0001E490
	private void UpdateSave()
	{
		this.camShake.SetSetting(SaveManager.Instance.state.cameraShake);
		this.camShake.onClick.AddListener(new UnityAction(this.UpdateCamShake));
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
		this.fpsLimit.SetSettings(SaveManager.Instance.state.fpsLimit);
		this.fpsLimit.onClick.AddListener(new UnityAction(this.UpdateMaxFps));
		this.volume.SetSettings(SaveManager.Instance.state.volume);
		this.volume.onClick.AddListener(new UnityAction(this.UpdateVolume));
		this.music.SetSettings(SaveManager.Instance.state.music);
		this.music.onClick.AddListener(new UnityAction(this.UpdateMusic));
	}

	// Token: 0x06000664 RID: 1636 RVA: 0x000209E7 File Offset: 0x0001EBE7
	private void UpdateCamShake()
	{
		CurrentSettings.Instance.UpdateCamShake(this.IntToBool(this.camShake.currentSetting));
	}

	// Token: 0x06000665 RID: 1637 RVA: 0x00020A04 File Offset: 0x0001EC04
	private void UpdateInverted()
	{
		CurrentSettings.Instance.UpdateInverted(this.IntToBool(this.inverted.currentSetting));
	}

	// Token: 0x06000666 RID: 1638 RVA: 0x00020A21 File Offset: 0x0001EC21
	private void UpdateGrass()
	{
		CurrentSettings.Instance.UpdateGrass(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000667 RID: 1639 RVA: 0x00020A3E File Offset: 0x0001EC3E
	private void UpdateTutorial()
	{
		CurrentSettings.Instance.UpdateTutorial(this.IntToBool(this.grass.currentSetting));
	}

	// Token: 0x06000668 RID: 1640 RVA: 0x00020A5B File Offset: 0x0001EC5B
	private void UpdateSens()
	{
		CurrentSettings.Instance.UpdateSens(this.IntToFloat(this.sens.currentSetting));
	}

	// Token: 0x06000669 RID: 1641 RVA: 0x00020A78 File Offset: 0x0001EC78
	private void UpdateForwardKey()
	{
		SaveManager.Instance.state.forward = this.forward.currentKey;
		SaveManager.Instance.Save();
		InputManager.forward = this.forward.currentKey;
	}

	// Token: 0x0600066A RID: 1642 RVA: 0x00020AAE File Offset: 0x0001ECAE
	private void UpdateBackwardKey()
	{
		SaveManager.Instance.state.backwards = this.backward.currentKey;
		SaveManager.Instance.Save();
		InputManager.backwards = this.backward.currentKey;
	}

	// Token: 0x0600066B RID: 1643 RVA: 0x00020AE4 File Offset: 0x0001ECE4
	private void UpdateLeftKey()
	{
		SaveManager.Instance.state.left = this.left.currentKey;
		SaveManager.Instance.Save();
		InputManager.left = this.left.currentKey;
	}

	// Token: 0x0600066C RID: 1644 RVA: 0x00020B1A File Offset: 0x0001ED1A
	private void UpdateRightKey()
	{
		SaveManager.Instance.state.right = this.right.currentKey;
		SaveManager.Instance.Save();
		InputManager.right = this.right.currentKey;
	}

	// Token: 0x0600066D RID: 1645 RVA: 0x00020B50 File Offset: 0x0001ED50
	private void UpdateJumpKey()
	{
		SaveManager.Instance.state.jump = this.jump.currentKey;
		SaveManager.Instance.Save();
		InputManager.jump = this.jump.currentKey;
	}

	// Token: 0x0600066E RID: 1646 RVA: 0x00020B86 File Offset: 0x0001ED86
	private void UpdateSprintKey()
	{
		SaveManager.Instance.state.sprint = this.sprint.currentKey;
		SaveManager.Instance.Save();
		InputManager.sprint = this.sprint.currentKey;
	}

	// Token: 0x0600066F RID: 1647 RVA: 0x00020BBC File Offset: 0x0001EDBC
	private void UpdateInteractKey()
	{
		SaveManager.Instance.state.interact = this.interact.currentKey;
		SaveManager.Instance.Save();
		InputManager.interact = this.interact.currentKey;
	}

	// Token: 0x06000670 RID: 1648 RVA: 0x00020BF2 File Offset: 0x0001EDF2
	private void UpdateInventoryKey()
	{
		SaveManager.Instance.state.inventory = this.inventory.currentKey;
		SaveManager.Instance.Save();
		InputManager.inventory = this.inventory.currentKey;
	}

	// Token: 0x06000671 RID: 1649 RVA: 0x00020C28 File Offset: 0x0001EE28
	private void UpdateMapKey()
	{
		SaveManager.Instance.state.map = this.map.currentKey;
		SaveManager.Instance.Save();
		InputManager.map = this.map.currentKey;
	}

	// Token: 0x06000672 RID: 1650 RVA: 0x00020C5E File Offset: 0x0001EE5E
	private void UpdateLeftClickKey()
	{
		SaveManager.Instance.state.leftClick = this.leftClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.leftClick = this.leftClick.currentKey;
	}

	// Token: 0x06000673 RID: 1651 RVA: 0x00020C94 File Offset: 0x0001EE94
	private void UpdateRightClickKey()
	{
		SaveManager.Instance.state.rightClick = this.rightClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.rightClick = this.rightClick.currentKey;
	}

	// Token: 0x06000674 RID: 1652 RVA: 0x00020CCA File Offset: 0x0001EECA
	private void UpdateShadowQuality()
	{
		CurrentSettings.Instance.UpdateShadowQuality(this.shadowQuality.currentSetting);
	}

	// Token: 0x06000675 RID: 1653 RVA: 0x00020CE1 File Offset: 0x0001EEE1
	private void UpdateShadowResolution()
	{
		CurrentSettings.Instance.UpdateShadowResolution(this.shadowResolution.currentSetting);
	}

	// Token: 0x06000676 RID: 1654 RVA: 0x00020CF8 File Offset: 0x0001EEF8
	private void UpdateShadowDistance()
	{
		CurrentSettings.Instance.UpdateShadowDistance(this.shadowDistance.currentSetting);
	}

	// Token: 0x06000677 RID: 1655 RVA: 0x00020D0F File Offset: 0x0001EF0F
	private void UpdateShadowCascades()
	{
		CurrentSettings.Instance.UpdateShadowCascades(this.shadowCascades.currentSetting);
	}

	// Token: 0x06000678 RID: 1656 RVA: 0x00020D26 File Offset: 0x0001EF26
	private void UpdateTextureRes()
	{
		CurrentSettings.Instance.UpdateTextureQuality(this.textureQuality.currentSetting);
	}

	// Token: 0x06000679 RID: 1657 RVA: 0x00020D3D File Offset: 0x0001EF3D
	private void UpdateAntiAliasing()
	{
		CurrentSettings.Instance.UpdateAntiAliasing(this.antiAliasing.currentSetting);
	}

	// Token: 0x0600067A RID: 1658 RVA: 0x00020D54 File Offset: 0x0001EF54
	private void UpdateSoftParticles()
	{
		CurrentSettings.Instance.UpdateSoftParticles(this.IntToBool(this.softParticles.currentSetting));
	}

	// Token: 0x0600067B RID: 1659 RVA: 0x00020D71 File Offset: 0x0001EF71
	private void UpdateBloom()
	{
		CurrentSettings.Instance.UpdateBloom(this.bloom.currentSetting);
	}

	// Token: 0x0600067C RID: 1660 RVA: 0x00020D88 File Offset: 0x0001EF88
	private void UpdateMotionBlur()
	{
		CurrentSettings.Instance.UpdateMotionBlur(this.IntToBool(this.motionBlur.currentSetting));
	}

	// Token: 0x0600067D RID: 1661 RVA: 0x00020DA5 File Offset: 0x0001EFA5
	private void UpdateAO()
	{
		CurrentSettings.Instance.UpdateAO(this.IntToBool(this.ao.currentSetting));
	}

	// Token: 0x0600067E RID: 1662 RVA: 0x00020DC2 File Offset: 0x0001EFC2
	private void UpdateFullscreen()
	{
		CurrentSettings.Instance.UpdateFullscreen(this.IntToBool(this.fullscreen.currentSetting));
	}

	// Token: 0x0600067F RID: 1663 RVA: 0x00020DDF File Offset: 0x0001EFDF
	private void UpdateVSync()
	{
		CurrentSettings.Instance.UpdateVSync(this.vSync.currentSetting);
	}

	// Token: 0x06000680 RID: 1664 RVA: 0x00020DF6 File Offset: 0x0001EFF6
	private void UpdateMaxFps()
	{
		CurrentSettings.Instance.UpdateMaxFps(this.fpsLimit.currentSetting);
	}

	// Token: 0x06000681 RID: 1665 RVA: 0x00020E0D File Offset: 0x0001F00D
	private void UpdateVolume()
	{
		CurrentSettings.Instance.UpdateVolume(this.volume.currentSetting);
	}

	// Token: 0x06000682 RID: 1666 RVA: 0x00020E24 File Offset: 0x0001F024
	private void UpdateMusic()
	{
		CurrentSettings.Instance.UpdateMusic(this.music.currentSetting);
	}

	// Token: 0x06000683 RID: 1667 RVA: 0x00020E3B File Offset: 0x0001F03B
	private float IntToFloat(int i)
	{
		return (float)i / 100f;
	}

	// Token: 0x06000684 RID: 1668 RVA: 0x00020E45 File Offset: 0x0001F045
	private int FloatToInt(float f)
	{
		return (int)f * 100;
	}

	// Token: 0x06000685 RID: 1669 RVA: 0x00020E4C File Offset: 0x0001F04C
	private int BoolToInt(bool b)
	{
		if (b)
		{
			return 1;
		}
		return 0;
	}

	// Token: 0x06000686 RID: 1670 RVA: 0x00020E54 File Offset: 0x0001F054
	private bool IntToBool(int i)
	{
		return i != 0;
	}

	// Token: 0x06000687 RID: 1671 RVA: 0x00020E5C File Offset: 0x0001F05C
	public void ResetSaveFile()
	{
		SaveManager.Instance.NewSave();
		SaveManager.Instance.Save();
		this.UpdateSave();
		CurrentSettings.Instance.UpdateSave();
	}

	// Token: 0x040005D9 RID: 1497
	public Button backBtn;

	// Token: 0x040005DA RID: 1498
	[Header("Game")]
	public MyBoolSetting camShake;

	// Token: 0x040005DB RID: 1499
	public SliderSetting sens;

	// Token: 0x040005DC RID: 1500
	public MyBoolSetting inverted;

	// Token: 0x040005DD RID: 1501
	public MyBoolSetting grass;

	// Token: 0x040005DE RID: 1502
	public MyBoolSetting tutorial;

	// Token: 0x040005DF RID: 1503
	[Header("Controls")]
	public ControlSetting forward;

	// Token: 0x040005E0 RID: 1504
	public ControlSetting backward;

	// Token: 0x040005E1 RID: 1505
	public ControlSetting left;

	// Token: 0x040005E2 RID: 1506
	public ControlSetting right;

	// Token: 0x040005E3 RID: 1507
	public ControlSetting jump;

	// Token: 0x040005E4 RID: 1508
	public ControlSetting sprint;

	// Token: 0x040005E5 RID: 1509
	public ControlSetting interact;

	// Token: 0x040005E6 RID: 1510
	public ControlSetting inventory;

	// Token: 0x040005E7 RID: 1511
	public ControlSetting map;

	// Token: 0x040005E8 RID: 1512
	public ControlSetting leftClick;

	// Token: 0x040005E9 RID: 1513
	public ControlSetting rightClick;

	// Token: 0x040005EA RID: 1514
	[Header("Graphics")]
	public ScrollSettings shadowQuality;

	// Token: 0x040005EB RID: 1515
	public ScrollSettings shadowResolution;

	// Token: 0x040005EC RID: 1516
	public ScrollSettings shadowDistance;

	// Token: 0x040005ED RID: 1517
	public ScrollSettings shadowCascades;

	// Token: 0x040005EE RID: 1518
	public ScrollSettings textureQuality;

	// Token: 0x040005EF RID: 1519
	public ScrollSettings antiAliasing;

	// Token: 0x040005F0 RID: 1520
	public MyBoolSetting softParticles;

	// Token: 0x040005F1 RID: 1521
	public ScrollSettings bloom;

	// Token: 0x040005F2 RID: 1522
	public MyBoolSetting motionBlur;

	// Token: 0x040005F3 RID: 1523
	public MyBoolSetting ao;

	// Token: 0x040005F4 RID: 1524
	[Header("Video")]
	public ResolutionSetting resolution;

	// Token: 0x040005F5 RID: 1525
	public MyBoolSetting fullscreen;

	// Token: 0x040005F6 RID: 1526
	public ScrollSettings vSync;

	// Token: 0x040005F7 RID: 1527
	public SliderSetting fpsLimit;

	// Token: 0x040005F8 RID: 1528
	[Header("Audio")]
	public SliderSetting volume;

	// Token: 0x040005F9 RID: 1529
	[Header("Audio")]
	public SliderSetting music;

	// Token: 0x02000135 RID: 309
	public enum BoolSetting
	{
		// Token: 0x040007D7 RID: 2007
		Off,
		// Token: 0x040007D8 RID: 2008
		On
	}

	// Token: 0x02000136 RID: 310
	public enum VSync
	{
		// Token: 0x040007DA RID: 2010
		Off,
		// Token: 0x040007DB RID: 2011
		Always,
		// Token: 0x040007DC RID: 2012
		Half
	}

	// Token: 0x02000137 RID: 311
	public enum ShadowQuality
	{
		// Token: 0x040007DE RID: 2014
		Off,
		// Token: 0x040007DF RID: 2015
		Hard,
		// Token: 0x040007E0 RID: 2016
		Soft
	}

	// Token: 0x02000138 RID: 312
	public enum ShadowResolution
	{
		// Token: 0x040007E2 RID: 2018
		Low,
		// Token: 0x040007E3 RID: 2019
		Medium,
		// Token: 0x040007E4 RID: 2020
		High,
		// Token: 0x040007E5 RID: 2021
		Ultra
	}

	// Token: 0x02000139 RID: 313
	public enum ShadowDistance
	{
		// Token: 0x040007E7 RID: 2023
		Low,
		// Token: 0x040007E8 RID: 2024
		Medium,
		// Token: 0x040007E9 RID: 2025
		High,
		// Token: 0x040007EA RID: 2026
		Ultra
	}

	// Token: 0x0200013A RID: 314
	public enum ShadowCascades
	{
		// Token: 0x040007EC RID: 2028
		None,
		// Token: 0x040007ED RID: 2029
		Two,
		// Token: 0x040007EE RID: 2030
		Four
	}

	// Token: 0x0200013B RID: 315
	public enum TextureResolution
	{
		// Token: 0x040007F0 RID: 2032
		Low,
		// Token: 0x040007F1 RID: 2033
		Medium,
		// Token: 0x040007F2 RID: 2034
		High,
		// Token: 0x040007F3 RID: 2035
		Ultra
	}

	// Token: 0x0200013C RID: 316
	public enum AntiAliasing
	{
		// Token: 0x040007F5 RID: 2037
		Off,
		// Token: 0x040007F6 RID: 2038
		x2,
		// Token: 0x040007F7 RID: 2039
		x4,
		// Token: 0x040007F8 RID: 2040
		x8
	}

	// Token: 0x0200013D RID: 317
	public enum Bloom
	{
		// Token: 0x040007FA RID: 2042
		Off,
		// Token: 0x040007FB RID: 2043
		Fast,
		// Token: 0x040007FC RID: 2044
		Fancy
	}
}
