using System;

namespace UnityEngine.Rendering.PostProcessing
{
	// Token: 0x0200001B RID: 27
	[Serializable]
	public sealed class ColorGrading : PostProcessEffectSettings
	{
		// Token: 0x04000049 RID: 73
		[DisplayName("Mode")]
		[Tooltip("Select a color grading mode that fits your dynamic range and workflow. Use HDR if your camera is set to render in HDR and your target platform supports it. Use LDR for low-end mobiles or devices that don't support HDR. Use External if you prefer authoring a Log LUT in an external software.")]
		public GradingModeParameter gradingMode = new GradingModeParameter
		{
			value = GradingMode.HighDefinitionRange
		};

		// Token: 0x0400004A RID: 74
		[DisplayName("Lookup Texture")]
		[Tooltip("A custom 3D log-encoded texture.")]
		public TextureParameter externalLut = new TextureParameter
		{
			value = null
		};

		// Token: 0x0400004B RID: 75
		[DisplayName("Mode")]
		[Tooltip("Select a tonemapping algorithm to use at the end of the color grading process.")]
		public TonemapperParameter tonemapper = new TonemapperParameter
		{
			value = Tonemapper.None
		};

		// Token: 0x0400004C RID: 76
		[DisplayName("Toe Strength")]
		[Range(0f, 1f)]
		[Tooltip("Affects the transition between the toe and the mid section of the curve. A value of 0 means no toe, a value of 1 means a very hard transition.")]
		public FloatParameter toneCurveToeStrength = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400004D RID: 77
		[DisplayName("Toe Length")]
		[Range(0f, 1f)]
		[Tooltip("Affects how much of the dynamic range is in the toe. With a small value, the toe will be very short and quickly transition into the linear section, with a larger value, the toe will be longer.")]
		public FloatParameter toneCurveToeLength = new FloatParameter
		{
			value = 0.5f
		};

		// Token: 0x0400004E RID: 78
		[DisplayName("Shoulder Strength")]
		[Range(0f, 1f)]
		[Tooltip("Affects the transition between the mid section and the shoulder of the curve. A value of 0 means no shoulder, a value of 1 means a very hard transition.")]
		public FloatParameter toneCurveShoulderStrength = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400004F RID: 79
		[DisplayName("Shoulder Length")]
		[Min(0f)]
		[Tooltip("Affects how many F-stops (EV) to add to the dynamic range of the curve.")]
		public FloatParameter toneCurveShoulderLength = new FloatParameter
		{
			value = 0.5f
		};

		// Token: 0x04000050 RID: 80
		[DisplayName("Shoulder Angle")]
		[Range(0f, 1f)]
		[Tooltip("Affects how much overshoot to add to the shoulder.")]
		public FloatParameter toneCurveShoulderAngle = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000051 RID: 81
		[DisplayName("Gamma")]
		[Min(0.001f)]
		[Tooltip("Applies a gamma function to the curve.")]
		public FloatParameter toneCurveGamma = new FloatParameter
		{
			value = 1f
		};

		// Token: 0x04000052 RID: 82
		[DisplayName("Lookup Texture")]
		[Tooltip("Custom lookup texture (strip format, for example 256x16) to apply before the rest of the color grading operators. If none is provided, a neutral one will be generated internally.")]
		public TextureParameter ldrLut = new TextureParameter
		{
			value = null,
			defaultState = TextureParameterDefault.Lut2D
		};

		// Token: 0x04000053 RID: 83
		[DisplayName("Contribution")]
		[Range(0f, 1f)]
		[Tooltip("How much of the lookup texture will contribute to the color grading effect.")]
		public FloatParameter ldrLutContribution = new FloatParameter
		{
			value = 1f
		};

		// Token: 0x04000054 RID: 84
		[DisplayName("Temperature")]
		[Range(-100f, 100f)]
		[Tooltip("Sets the white balance to a custom color temperature.")]
		public FloatParameter temperature = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000055 RID: 85
		[DisplayName("Tint")]
		[Range(-100f, 100f)]
		[Tooltip("Sets the white balance to compensate for a green or magenta tint.")]
		public FloatParameter tint = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000056 RID: 86
		[DisplayName("Color Filter")]
		[ColorUsage(false, true)]
		[Tooltip("Tint the render by multiplying a color.")]
		public ColorParameter colorFilter = new ColorParameter
		{
			value = Color.white
		};

		// Token: 0x04000057 RID: 87
		[DisplayName("Hue Shift")]
		[Range(-180f, 180f)]
		[Tooltip("Shift the hue of all colors.")]
		public FloatParameter hueShift = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000058 RID: 88
		[DisplayName("Saturation")]
		[Range(-100f, 100f)]
		[Tooltip("Pushes the intensity of all colors.")]
		public FloatParameter saturation = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000059 RID: 89
		[DisplayName("Brightness")]
		[Range(-100f, 100f)]
		[Tooltip("Makes the image brighter or darker.")]
		public FloatParameter brightness = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400005A RID: 90
		[DisplayName("Post-exposure (EV)")]
		[Tooltip("Adjusts the overall exposure of the scene in EV units. This is applied after the HDR effect and right before tonemapping so it won't affect previous effects in the chain.")]
		public FloatParameter postExposure = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400005B RID: 91
		[DisplayName("Contrast")]
		[Range(-100f, 100f)]
		[Tooltip("Expands or shrinks the overall range of tonal values.")]
		public FloatParameter contrast = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400005C RID: 92
		[DisplayName("Red")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the red channel in the overall mix.")]
		public FloatParameter mixerRedOutRedIn = new FloatParameter
		{
			value = 100f
		};

		// Token: 0x0400005D RID: 93
		[DisplayName("Green")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the green channel in the overall mix.")]
		public FloatParameter mixerRedOutGreenIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400005E RID: 94
		[DisplayName("Blue")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the blue channel in the overall mix.")]
		public FloatParameter mixerRedOutBlueIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x0400005F RID: 95
		[DisplayName("Red")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the red channel in the overall mix.")]
		public FloatParameter mixerGreenOutRedIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000060 RID: 96
		[DisplayName("Green")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the green channel in the overall mix.")]
		public FloatParameter mixerGreenOutGreenIn = new FloatParameter
		{
			value = 100f
		};

		// Token: 0x04000061 RID: 97
		[DisplayName("Blue")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the blue channel in the overall mix.")]
		public FloatParameter mixerGreenOutBlueIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000062 RID: 98
		[DisplayName("Red")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the red channel in the overall mix.")]
		public FloatParameter mixerBlueOutRedIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000063 RID: 99
		[DisplayName("Green")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the green channel in the overall mix.")]
		public FloatParameter mixerBlueOutGreenIn = new FloatParameter
		{
			value = 0f
		};

		// Token: 0x04000064 RID: 100
		[DisplayName("Blue")]
		[Range(-200f, 200f)]
		[Tooltip("Modify influence of the blue channel in the overall mix.")]
		public FloatParameter mixerBlueOutBlueIn = new FloatParameter
		{
			value = 100f
		};

		// Token: 0x04000065 RID: 101
		[DisplayName("Lift")]
		[Tooltip("Controls the darkest portions of the render.")]
		[Trackball(TrackballAttribute.Mode.Lift)]
		public Vector4Parameter lift = new Vector4Parameter
		{
			value = new Vector4(1f, 1f, 1f, 0f)
		};

		// Token: 0x04000066 RID: 102
		[DisplayName("Gamma")]
		[Tooltip("Power function that controls mid-range tones.")]
		[Trackball(TrackballAttribute.Mode.Gamma)]
		public Vector4Parameter gamma = new Vector4Parameter
		{
			value = new Vector4(1f, 1f, 1f, 0f)
		};

		// Token: 0x04000067 RID: 103
		[DisplayName("Gain")]
		[Tooltip("Controls the lightest portions of the render.")]
		[Trackball(TrackballAttribute.Mode.Gain)]
		public Vector4Parameter gain = new Vector4Parameter
		{
			value = new Vector4(1f, 1f, 1f, 0f)
		};

		// Token: 0x04000068 RID: 104
		public SplineParameter masterCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(new Keyframe[]
			{
				new Keyframe(0f, 0f, 1f, 1f),
				new Keyframe(1f, 1f, 1f, 1f)
			}), 0f, false, new Vector2(0f, 1f))
		};

		// Token: 0x04000069 RID: 105
		public SplineParameter redCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(new Keyframe[]
			{
				new Keyframe(0f, 0f, 1f, 1f),
				new Keyframe(1f, 1f, 1f, 1f)
			}), 0f, false, new Vector2(0f, 1f))
		};

		// Token: 0x0400006A RID: 106
		public SplineParameter greenCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(new Keyframe[]
			{
				new Keyframe(0f, 0f, 1f, 1f),
				new Keyframe(1f, 1f, 1f, 1f)
			}), 0f, false, new Vector2(0f, 1f))
		};

		// Token: 0x0400006B RID: 107
		public SplineParameter blueCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(new Keyframe[]
			{
				new Keyframe(0f, 0f, 1f, 1f),
				new Keyframe(1f, 1f, 1f, 1f)
			}), 0f, false, new Vector2(0f, 1f))
		};

		// Token: 0x0400006C RID: 108
		public SplineParameter hueVsHueCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(), 0.5f, true, new Vector2(0f, 1f))
		};

		// Token: 0x0400006D RID: 109
		public SplineParameter hueVsSatCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(), 0.5f, true, new Vector2(0f, 1f))
		};

		// Token: 0x0400006E RID: 110
		public SplineParameter satVsSatCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(), 0.5f, false, new Vector2(0f, 1f))
		};

		// Token: 0x0400006F RID: 111
		public SplineParameter lumVsSatCurve = new SplineParameter
		{
			value = new Spline(new AnimationCurve(), 0.5f, false, new Vector2(0f, 1f))
		};
	}
}
