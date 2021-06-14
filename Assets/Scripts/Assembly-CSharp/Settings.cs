using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;


public class Settings : MonoBehaviour
{

	private void Start()
	{
		this.UpdateSave();
	}


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


	private void UpdateCamShake()
	{
		CurrentSettings.Instance.UpdateCamShake(this.IntToBool(this.camShake.currentSetting));
	}


	private void UpdateInverted()
	{
		CurrentSettings.Instance.UpdateInverted(this.IntToBool(this.inverted.currentSetting));
	}


	private void UpdateGrass()
	{
		CurrentSettings.Instance.UpdateGrass(this.IntToBool(this.grass.currentSetting));
	}


	private void UpdateTutorial()
	{
		CurrentSettings.Instance.UpdateTutorial(this.IntToBool(this.grass.currentSetting));
	}


	private void UpdateSens()
	{
		CurrentSettings.Instance.UpdateSens(this.IntToFloat(this.sens.currentSetting));
	}


	private void UpdateFov()
	{
		CurrentSettings.Instance.UpdateFov((float)this.fov.currentSetting);
	}


	private void UpdateForwardKey()
	{
		SaveManager.Instance.state.forward = this.forward.currentKey;
		SaveManager.Instance.Save();
		InputManager.forward = this.forward.currentKey;
	}


	private void UpdateBackwardKey()
	{
		SaveManager.Instance.state.backwards = this.backward.currentKey;
		SaveManager.Instance.Save();
		InputManager.backwards = this.backward.currentKey;
	}


	private void UpdateLeftKey()
	{
		SaveManager.Instance.state.left = this.left.currentKey;
		SaveManager.Instance.Save();
		InputManager.left = this.left.currentKey;
	}


	private void UpdateRightKey()
	{
		SaveManager.Instance.state.right = this.right.currentKey;
		SaveManager.Instance.Save();
		InputManager.right = this.right.currentKey;
	}


	private void UpdateJumpKey()
	{
		SaveManager.Instance.state.jump = this.jump.currentKey;
		SaveManager.Instance.Save();
		InputManager.jump = this.jump.currentKey;
	}


	private void UpdateSprintKey()
	{
		SaveManager.Instance.state.sprint = this.sprint.currentKey;
		SaveManager.Instance.Save();
		InputManager.sprint = this.sprint.currentKey;
	}


	private void UpdateInteractKey()
	{
		SaveManager.Instance.state.interact = this.interact.currentKey;
		SaveManager.Instance.Save();
		InputManager.interact = this.interact.currentKey;
	}


	private void UpdateInventoryKey()
	{
		SaveManager.Instance.state.inventory = this.inventory.currentKey;
		SaveManager.Instance.Save();
		InputManager.inventory = this.inventory.currentKey;
	}


	private void UpdateMapKey()
	{
		SaveManager.Instance.state.map = this.map.currentKey;
		SaveManager.Instance.Save();
		InputManager.map = this.map.currentKey;
	}


	private void UpdateLeftClickKey()
	{
		SaveManager.Instance.state.leftClick = this.leftClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.leftClick = this.leftClick.currentKey;
	}


	private void UpdateRightClickKey()
	{
		SaveManager.Instance.state.rightClick = this.rightClick.currentKey;
		SaveManager.Instance.Save();
		InputManager.rightClick = this.rightClick.currentKey;
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


	public MyBoolSetting inverted;


	public MyBoolSetting grass;


	public MyBoolSetting tutorial;


	[Header("Controls")]
	public ControlSetting forward;


	public ControlSetting backward;


	public ControlSetting left;


	public ControlSetting right;


	public ControlSetting jump;


	public ControlSetting sprint;


	public ControlSetting interact;


	public ControlSetting inventory;


	public ControlSetting map;


	public ControlSetting leftClick;


	public ControlSetting rightClick;


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
