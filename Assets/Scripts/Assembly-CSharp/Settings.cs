using UnityEngine;
using UnityEngine.UI;

public class Settings : MonoBehaviour
{
	public Button backBtn;
	public MyBoolSetting camShake;
	public SliderSetting fov;
	public SliderSetting sens;
	public MyBoolSetting invertedHor;
	public MyBoolSetting invertedVer;
	public MyBoolSetting grass;
	public MyBoolSetting tutorial;
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
	public ResolutionSetting resolution;
	public MyBoolSetting fullscreen;
	public ScrollSettings fullscreenMode;
	public ScrollSettings vSync;
	public SliderSetting fpsLimit;
	public SliderSetting volume;
	public SliderSetting music;
}
