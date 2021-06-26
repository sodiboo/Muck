using System;

namespace UnityEngine.Rendering.PostProcessing
{
	[Serializable]
	public class ColorGrading : PostProcessEffectSettings
	{
		public GradingModeParameter gradingMode;
		public TextureParameter externalLut;
		public TonemapperParameter tonemapper;
		public FloatParameter toneCurveToeStrength;
		public FloatParameter toneCurveToeLength;
		public FloatParameter toneCurveShoulderStrength;
		public FloatParameter toneCurveShoulderLength;
		public FloatParameter toneCurveShoulderAngle;
		public FloatParameter toneCurveGamma;
		public TextureParameter ldrLut;
		public FloatParameter ldrLutContribution;
		public FloatParameter temperature;
		public FloatParameter tint;
		public ColorParameter colorFilter;
		public FloatParameter hueShift;
		public FloatParameter saturation;
		public FloatParameter brightness;
		public FloatParameter postExposure;
		public FloatParameter contrast;
		public FloatParameter mixerRedOutRedIn;
		public FloatParameter mixerRedOutGreenIn;
		public FloatParameter mixerRedOutBlueIn;
		public FloatParameter mixerGreenOutRedIn;
		public FloatParameter mixerGreenOutGreenIn;
		public FloatParameter mixerGreenOutBlueIn;
		public FloatParameter mixerBlueOutRedIn;
		public FloatParameter mixerBlueOutGreenIn;
		public FloatParameter mixerBlueOutBlueIn;
		public Vector4Parameter lift;
		public Vector4Parameter gamma;
		public Vector4Parameter gain;
		public SplineParameter masterCurve;
		public SplineParameter redCurve;
		public SplineParameter greenCurve;
		public SplineParameter blueCurve;
		public SplineParameter hueVsHueCurve;
		public SplineParameter hueVsSatCurve;
		public SplineParameter satVsSatCurve;
		public SplineParameter lumVsSatCurve;
	}
}
