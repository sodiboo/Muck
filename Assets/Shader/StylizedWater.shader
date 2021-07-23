Shader "Stylized/Water" {
	Properties {
		[Header(Densities)] _DepthDensity ("Depth", Range(0, 1)) = 0.5
		_DistanceDensity ("Distance", Range(0, 1)) = 0.1
		[Header(Waves)] [NoScaleOffset] _WaveNormalMap ("Normal Map", 2D) = "bump" {}
		_WaveNormalScale ("Scale", Float) = 10
		_WaveNormalSpeed ("Speed", Float) = 1
		[Header(Base Color)] [HDR] _ShallowColor ("Shallow", Vector) = (0.44,0.95,0.36,1)
		[HDR] _DeepColor ("Deep", Vector) = (0,0.05,0.19,1)
		[HDR] _FarColor ("Far", Vector) = (0.04,0.27,0.75,1)
		[Header(Reflections)] _ReflectionContribution ("Contribution", Range(0, 1)) = 1
		[Header(Subsurface Scattering)] [HDR] _SSSColor ("Color", Vector) = (1,1,1,1)
		[Header(Foam)] _FoamContribution ("Contribution", Range(0, 1)) = 1
		[NoScaleOffset] _FoamTexture ("Texture", 2D) = "black" {}
		_FoamScale ("Scale", Float) = 1
		_FoamSpeed ("Speed", Float) = 1
		_FoamNoiseScale ("Noise Contribution", Range(0, 1)) = 0.5
		[Header(Sun Specular)] [HDR] _SunSpecularColor ("Color", Vector) = (1,1,1,1)
		_SunSpecularExponent ("Exponent", Float) = 1000
		[Header(Sparkle)] [NoScaleOffset] _SparklesNormalMap ("Normal Map", 2D) = "bump" {}
		_SparkleScale ("Scale", Float) = 10
		_SparkleSpeed ("Speed", Float) = 0.75
		[HDR] _SparkleColor ("Color", Vector) = (1,1,1,1)
		_SparkleExponent ("Exponent", Float) = 10000
		[Header(Edge Foam)] [HDR] _EdgeFoamColor ("Color", Vector) = (1,1,1,1)
		_EdgeFoamDepth ("Scale", Float) = 10
		[Header(Shadow Mapping)] [Toggle(SHADOWS)] _FancyShadows ("Enabled", Float) = 0
		_MaxShadowDistance ("Maximum Sample Distance", Float) = 50
		_ShadowColor ("Color", Vector) = (0.5,0.5,0.5,1)
		[Header(Vertex Waves #1)] _Wave1Direction ("Direction", Range(0, 1)) = 0
		_Wave1Amplitude ("Amplitude", Float) = 1
		_Wave1Wavelength ("Wavelength", Float) = 1
		_Wave1Speed ("Speed", Float) = 1
		[Header(Vertex Waves #2)] _Wave2Direction ("Direction", Range(0, 1)) = 0
		_Wave2Amplitude ("Amplitude", Float) = 1
		_Wave2Wavelength ("Wavelength", Float) = 1
		_Wave2Speed ("Speed", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		GrabPass {
			"_GrabTexture"
		}
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			GpuProgramID 7251
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[13];
						float _Wave1Direction;
						float _Wave1Amplitude;
						float _Wave1Wavelength;
						float _Wave1Speed;
						float _Wave2Direction;
						float _Wave2Amplitude;
						float _Wave2Wavelength;
						float _Wave2Speed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat3;
					float u_xlat5;
					void main()
					{
					    u_xlat0.x = _Wave2Direction * 3.14159274;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat1.y = u_xlat0.x;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xz, u_xlat1.xy);
					    u_xlat1.x = u_xlat1.x * 3.14159274;
					    u_xlat1.x = u_xlat1.x / _Wave2Wavelength;
					    u_xlat1.x = _Wave2Speed * _Time.y + u_xlat1.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _Wave2Amplitude;
					    u_xlat5 = _Wave1Direction * 3.14159274;
					    u_xlat2 = sin(u_xlat5);
					    u_xlat3.x = cos(u_xlat5);
					    u_xlat3.y = u_xlat2;
					    u_xlat5 = dot(u_xlat0.xz, u_xlat3.xy);
					    u_xlat5 = u_xlat5 * 3.14159274;
					    u_xlat5 = u_xlat5 / _Wave1Wavelength;
					    u_xlat5 = _Wave1Speed * _Time.y + u_xlat5;
					    u_xlat5 = sin(u_xlat5);
					    u_xlat1.x = _Wave1Amplitude * u_xlat5 + u_xlat1.x;
					    u_xlat0.w = u_xlat0.y + u_xlat1.x;
					    u_xlat1 = u_xlat0.wwww * unity_MatrixVP[1];
					    vs_TEXCOORD1.xyz = u_xlat0.xwz;
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_MatrixVP[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1.xyz = u_xlat0.xwy * vec3(0.5, 0.5, -0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.yy + u_xlat1.xz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[13];
						float _Wave1Direction;
						float _Wave1Amplitude;
						float _Wave1Wavelength;
						float _Wave1Speed;
						float _Wave2Direction;
						float _Wave2Amplitude;
						float _Wave2Wavelength;
						float _Wave2Speed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat3;
					float u_xlat5;
					void main()
					{
					    u_xlat0.x = _Wave2Direction * 3.14159274;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat1.y = u_xlat0.x;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xz, u_xlat1.xy);
					    u_xlat1.x = u_xlat1.x * 3.14159274;
					    u_xlat1.x = u_xlat1.x / _Wave2Wavelength;
					    u_xlat1.x = _Wave2Speed * _Time.y + u_xlat1.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _Wave2Amplitude;
					    u_xlat5 = _Wave1Direction * 3.14159274;
					    u_xlat2 = sin(u_xlat5);
					    u_xlat3.x = cos(u_xlat5);
					    u_xlat3.y = u_xlat2;
					    u_xlat5 = dot(u_xlat0.xz, u_xlat3.xy);
					    u_xlat5 = u_xlat5 * 3.14159274;
					    u_xlat5 = u_xlat5 / _Wave1Wavelength;
					    u_xlat5 = _Wave1Speed * _Time.y + u_xlat5;
					    u_xlat5 = sin(u_xlat5);
					    u_xlat1.x = _Wave1Amplitude * u_xlat5 + u_xlat1.x;
					    u_xlat0.w = u_xlat0.y + u_xlat1.x;
					    u_xlat1 = u_xlat0.wwww * unity_MatrixVP[1];
					    vs_TEXCOORD1.xyz = u_xlat0.xwz;
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_MatrixVP[3];
					    gl_Position = u_xlat0;
					    u_xlat1.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.x;
					    u_xlat1.x = u_xlat1.x * (-u_xlat1.x);
					    vs_TEXCOORD3 = exp2(u_xlat1.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1.xyz = u_xlat0.xwy * vec3(0.5, 0.5, -0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.yy + u_xlat1.xz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _DepthDensity;
						float _DistanceDensity;
						float _WaveNormalScale;
						float _WaveNormalSpeed;
						vec3 _ShallowColor;
						vec3 _DeepColor;
						vec3 _FarColor;
						float _ReflectionContribution;
						vec3 _SSSColor;
						float _FoamScale;
						float _FoamNoiseScale;
						float _FoamSpeed;
						float _FoamContribution;
						vec3 _SunSpecularColor;
						float _SunSpecularExponent;
						float _SparkleScale;
						float _SparkleSpeed;
						float _SparkleExponent;
						vec3 _SparkleColor;
						vec3 _EdgeFoamColor;
						float _EdgeFoamDepth;
						vec4 unused_0_22;
						float _Wave1Direction;
						float _Wave1Amplitude;
						float _Wave1Wavelength;
						float _Wave1Speed;
						float _Wave2Direction;
						float _Wave2Amplitude;
						float _Wave2Wavelength;
						float _Wave2Speed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _WaveNormalMap;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FoamTexture;
					uniform  sampler2D _SparklesNormalMap;
					uniform  samplerCube unity_SpecCube0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Wave2Direction * 3.14159274;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat1.y = u_xlat0.x;
					    u_xlat0 = vs_TEXCOORD1.xzxz + vec4(-0.00999999978, -0.0, -0.0, -0.00999999978);
					    u_xlat17 = dot(u_xlat0.zw, u_xlat1.xy);
					    u_xlat17 = u_xlat17 * 3.14159274;
					    u_xlat17 = u_xlat17 / _Wave2Wavelength;
					    u_xlat17 = _Wave2Speed * _Time.y + u_xlat17;
					    u_xlat17 = sin(u_xlat17);
					    u_xlat17 = u_xlat17 * _Wave2Amplitude;
					    u_xlat25 = _Wave1Direction * 3.14159274;
					    u_xlat2.x = sin(u_xlat25);
					    u_xlat3.x = cos(u_xlat25);
					    u_xlat3.y = u_xlat2.x;
					    u_xlat16 = dot(u_xlat0.zw, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = u_xlat16 / _Wave1Wavelength;
					    u_xlat16 = _Wave1Speed * _Time.y + u_xlat16;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = _Wave1Amplitude * u_xlat16 + u_xlat17;
					    u_xlat0.w = dot(vs_TEXCOORD1.xz, u_xlat1.xy);
					    u_xlat1.x = dot(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat3.xy);
					    u_xlat0.y = dot(vs_TEXCOORD1.xz, u_xlat3.xy);
					    u_xlat0.xyw = u_xlat0.xyw * vec3(3.14159274, 3.14159274, 3.14159274);
					    u_xlat0.xy = u_xlat0.xy / vec2(vec2(_Wave1Wavelength, _Wave1Wavelength));
					    u_xlat0.y = _Wave1Speed * _Time.y + u_xlat0.y;
					    u_xlat0.x = _Wave1Speed * _Time.y + u_xlat0.x;
					    u_xlat0.xy = sin(u_xlat0.xy);
					    u_xlat1.x = u_xlat1.x * 3.14159274;
					    u_xlat1.x = u_xlat1.x / _Wave2Wavelength;
					    u_xlat1.x = _Wave2Speed * _Time.y + u_xlat1.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _Wave2Amplitude;
					    u_xlat0.x = _Wave1Amplitude * u_xlat0.x + u_xlat1.x;
					    u_xlat24 = u_xlat0.w / _Wave2Wavelength;
					    u_xlat24 = _Wave2Speed * _Time.y + u_xlat24;
					    u_xlat24 = sin(u_xlat24);
					    u_xlat24 = u_xlat24 * _Wave2Amplitude;
					    u_xlat8 = _Wave1Amplitude * u_xlat0.y + u_xlat24;
					    u_xlat1.y = (-u_xlat16) + u_xlat8;
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.00999999978);
					    u_xlat16 = dot(u_xlat1.yz, u_xlat1.yz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.y = (-u_xlat0.x) + u_xlat8;
					    u_xlat0.xyz = vec3(u_xlat8) * _SSSColor.xyz;
					    u_xlat2.x = 0.00999999978;
					    u_xlat24 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.y = u_xlat24 * u_xlat2.y;
					    u_xlat2.xz = vec2(u_xlat24) * vec2(0.00999999978, 0.0);
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
					    u_xlat4 = vs_TEXCOORD1.xzxz / vec4(vec4(_WaveNormalScale, _WaveNormalScale, _WaveNormalScale, _WaveNormalScale));
					    u_xlat5 = u_xlat4.zwzw + vec4(0.418000013, 0.354999989, 0.86500001, 0.148000002);
					    u_xlat24 = _WaveNormalSpeed * _Time.y;
					    u_xlat5 = vec4(u_xlat24) * vec4(-0.707106769, -0.707106769, -0.707106769, 0.707106769) + u_xlat5;
					    u_xlat4 = vec4(u_xlat24) * vec4(0.707106769, 0.707106769, 0.707106769, -0.707106769) + u_xlat4;
					    u_xlat6 = texture(_WaveNormalMap, u_xlat5.xy);
					    u_xlat5 = texture(_WaveNormalMap, u_xlat5.zw);
					    u_xlat6.x = u_xlat6.w * u_xlat6.x;
					    u_xlat6.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat6.z = sqrt(u_xlat24);
					    u_xlat7 = texture(_WaveNormalMap, u_xlat4.xy);
					    u_xlat4.xy = u_xlat4.zw + vec2(0.651000023, 0.751999974);
					    u_xlat4 = texture(_WaveNormalMap, u_xlat4.xy);
					    u_xlat7.x = u_xlat7.w * u_xlat7.x;
					    u_xlat7.xy = u_xlat7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat7.xy, u_xlat7.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat7.z = sqrt(u_xlat24);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat5.z = sqrt(u_xlat24);
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat4.z = sqrt(u_xlat24);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat24);
					    u_xlat24 = sqrt(u_xlat24);
					    u_xlat24 = u_xlat24 * (-_DistanceDensity);
					    u_xlat24 = u_xlat24 * 1.44269502;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat25 = u_xlat25 + u_xlat25;
					    u_xlat3.xyz = u_xlat1.xyz * (-vec3(u_xlat25)) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, (-u_xlat2.xyz));
					    u_xlat9.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat2 = texture(unity_SpecCube0, u_xlat3.xyz);
					    u_xlat17 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat17 = log2(u_xlat17);
					    u_xlat17 = u_xlat17 * _SunSpecularExponent;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat1.z = min(u_xlat17, 1.0);
					    u_xlat25 = u_xlat1.x * u_xlat1.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat1.x = u_xlat25 * u_xlat1.x;
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat1.x = _ZBufferParams.z * hlslcc_FragCoord.z + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat3.xy);
					    u_xlat3 = texture(_GrabTexture, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat3.xyz * _ShallowColor.xyz + (-_DeepColor.xyz);
					    u_xlat25 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat25;
					    u_xlat1.w = abs(u_xlat1.x) * (-_DepthDensity);
					    u_xlat1.x = -abs(u_xlat1.x) / _EdgeFoamDepth;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.44269502, 1.44269502);
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xz = roundEven(u_xlat1.xz);
					    u_xlat25 = exp2(u_xlat1.w);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + _DeepColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + (-_FarColor.xyz);
					    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FarColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_ReflectionContribution, _ReflectionContribution, _ReflectionContribution)) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx + u_xlat2.xyz;
					    u_xlat2 = vs_TEXCOORD1.xzxz / vec4(vec4(_FoamScale, _FoamScale, _FoamScale, _FoamScale));
					    u_xlat2 = vec4(_FoamNoiseScale) * u_xlat4.xzxz + u_xlat2;
					    u_xlat3 = u_xlat2.zwzw + vec4(0.418000013, 0.354999989, 0.86500001, 0.148000002);
					    u_xlat9.x = _FoamSpeed * _Time.y;
					    u_xlat3 = u_xlat9.xxxx * vec4(-0.707106769, -0.707106769, -0.707106769, 0.707106769) + u_xlat3;
					    u_xlat2 = u_xlat9.xxxx * vec4(0.707106769, 0.707106769, 0.707106769, -0.707106769) + u_xlat2;
					    u_xlat4 = texture(_FoamTexture, u_xlat3.xy);
					    u_xlat3 = texture(_FoamTexture, u_xlat3.zw);
					    u_xlat5 = texture(_FoamTexture, u_xlat2.xy);
					    u_xlat9.xz = u_xlat2.zw + vec2(0.651000023, 0.751999974);
					    u_xlat2 = texture(_FoamTexture, u_xlat9.xz);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_FoamContribution, _FoamContribution, _FoamContribution));
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.25, 0.25, 0.25) + u_xlat0.xyz;
					    u_xlat9.x = _SparkleSpeed * _Time.y;
					    u_xlat2 = vs_TEXCOORD1.xzxz / vec4(_SparkleScale);
					    u_xlat3.xy = u_xlat9.xx * vec2(0.707106769, 0.707106769) + u_xlat2.zw;
					    u_xlat4.xyz = u_xlat9.xxx * vec3(-0.707106769, -0.707106769, 0.707106769);
					    u_xlat3 = texture(_SparklesNormalMap, u_xlat3.xy);
					    u_xlat9.x = dot(u_xlat3.xx, u_xlat3.ww);
					    u_xlat9.x = u_xlat9.x + -1.0;
					    u_xlat3 = u_xlat2.zwzw * vec4(3.0, 3.0, 4.0, 4.0) + u_xlat4.yzzy;
					    u_xlat5 = texture(_SparklesNormalMap, u_xlat3.xy);
					    u_xlat3 = texture(_SparklesNormalMap, u_xlat3.zw);
					    u_xlat25 = dot(u_xlat5.xx, u_xlat5.ww);
					    u_xlat5.x = u_xlat9.x + u_xlat25;
					    u_xlat6 = u_xlat2.zwzw * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat4.xxzy;
					    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 2.5, 2.5) + u_xlat4.xxyz;
					    u_xlat4 = texture(_SparklesNormalMap, u_xlat6.xy);
					    u_xlat6 = texture(_SparklesNormalMap, u_xlat6.zw);
					    u_xlat25 = u_xlat4.y * 2.0 + -1.0;
					    u_xlat5.y = u_xlat3.y * 2.0 + u_xlat25;
					    u_xlat3.xy = u_xlat5.xy + vec2(-1.0, -1.0);
					    u_xlat3.z = 1.0;
					    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
					    u_xlat4 = texture(_SparklesNormalMap, u_xlat2.zw);
					    u_xlat2 = texture(_SparklesNormalMap, u_xlat2.xy);
					    u_xlat25 = u_xlat2.y * 2.0 + -1.0;
					    u_xlat2.y = u_xlat6.y * 2.0 + u_xlat25;
					    u_xlat25 = dot(u_xlat4.xx, u_xlat4.ww);
					    u_xlat2.x = u_xlat9.x + u_xlat25;
					    u_xlat2.xy = u_xlat2.xy + vec2(-1.0, -1.0);
					    u_xlat2.z = 1.0;
					    u_xlat9.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat2.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat2.x * u_xlat3.x;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat25 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat9.x * 3.0;
					    u_xlat9.x = min(u_xlat9.x, 1.0);
					    u_xlat9.x = u_xlat9.x * u_xlat25;
					    u_xlat9.x = log2(u_xlat9.x);
					    u_xlat9.x = u_xlat9.x * _SparkleExponent;
					    u_xlat9.x = exp2(u_xlat9.x);
					    u_xlat9.x = min(u_xlat9.x, 1.0);
					    u_xlat9.x = ceil(u_xlat9.x);
					    u_xlat24 = u_xlat24 * u_xlat9.x;
					    u_xlat2.xyz = vec3(u_xlat24) * _SparkleColor.xyz;
					    u_xlat9.xyz = u_xlat1.zzz * _SunSpecularColor.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * _EdgeFoamColor.xyz + u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _DepthDensity;
						float _DistanceDensity;
						float _WaveNormalScale;
						float _WaveNormalSpeed;
						vec3 _ShallowColor;
						vec3 _DeepColor;
						vec3 _FarColor;
						float _ReflectionContribution;
						vec3 _SSSColor;
						float _FoamScale;
						float _FoamNoiseScale;
						float _FoamSpeed;
						float _FoamContribution;
						vec3 _SunSpecularColor;
						float _SunSpecularExponent;
						float _SparkleScale;
						float _SparkleSpeed;
						float _SparkleExponent;
						vec3 _SparkleColor;
						vec3 _EdgeFoamColor;
						float _EdgeFoamDepth;
						vec4 unused_0_22;
						float _Wave1Direction;
						float _Wave1Amplitude;
						float _Wave1Wavelength;
						float _Wave1Speed;
						float _Wave2Direction;
						float _Wave2Amplitude;
						float _Wave2Wavelength;
						float _Wave2Speed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					uniform  sampler2D _WaveNormalMap;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FoamTexture;
					uniform  sampler2D _SparklesNormalMap;
					uniform  samplerCube unity_SpecCube0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Wave2Direction * 3.14159274;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat1.y = u_xlat0.x;
					    u_xlat0 = vs_TEXCOORD1.xzxz + vec4(-0.00999999978, -0.0, -0.0, -0.00999999978);
					    u_xlat17 = dot(u_xlat0.zw, u_xlat1.xy);
					    u_xlat17 = u_xlat17 * 3.14159274;
					    u_xlat17 = u_xlat17 / _Wave2Wavelength;
					    u_xlat17 = _Wave2Speed * _Time.y + u_xlat17;
					    u_xlat17 = sin(u_xlat17);
					    u_xlat17 = u_xlat17 * _Wave2Amplitude;
					    u_xlat25 = _Wave1Direction * 3.14159274;
					    u_xlat2.x = sin(u_xlat25);
					    u_xlat3.x = cos(u_xlat25);
					    u_xlat3.y = u_xlat2.x;
					    u_xlat16 = dot(u_xlat0.zw, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = u_xlat16 / _Wave1Wavelength;
					    u_xlat16 = _Wave1Speed * _Time.y + u_xlat16;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = _Wave1Amplitude * u_xlat16 + u_xlat17;
					    u_xlat0.w = dot(vs_TEXCOORD1.xz, u_xlat1.xy);
					    u_xlat1.x = dot(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat3.xy);
					    u_xlat0.y = dot(vs_TEXCOORD1.xz, u_xlat3.xy);
					    u_xlat0.xyw = u_xlat0.xyw * vec3(3.14159274, 3.14159274, 3.14159274);
					    u_xlat0.xy = u_xlat0.xy / vec2(vec2(_Wave1Wavelength, _Wave1Wavelength));
					    u_xlat0.y = _Wave1Speed * _Time.y + u_xlat0.y;
					    u_xlat0.x = _Wave1Speed * _Time.y + u_xlat0.x;
					    u_xlat0.xy = sin(u_xlat0.xy);
					    u_xlat1.x = u_xlat1.x * 3.14159274;
					    u_xlat1.x = u_xlat1.x / _Wave2Wavelength;
					    u_xlat1.x = _Wave2Speed * _Time.y + u_xlat1.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _Wave2Amplitude;
					    u_xlat0.x = _Wave1Amplitude * u_xlat0.x + u_xlat1.x;
					    u_xlat24 = u_xlat0.w / _Wave2Wavelength;
					    u_xlat24 = _Wave2Speed * _Time.y + u_xlat24;
					    u_xlat24 = sin(u_xlat24);
					    u_xlat24 = u_xlat24 * _Wave2Amplitude;
					    u_xlat8 = _Wave1Amplitude * u_xlat0.y + u_xlat24;
					    u_xlat1.y = (-u_xlat16) + u_xlat8;
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.00999999978);
					    u_xlat16 = dot(u_xlat1.yz, u_xlat1.yz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.y = (-u_xlat0.x) + u_xlat8;
					    u_xlat0.xyz = vec3(u_xlat8) * _SSSColor.xyz;
					    u_xlat2.x = 0.00999999978;
					    u_xlat24 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.y = u_xlat24 * u_xlat2.y;
					    u_xlat2.xz = vec2(u_xlat24) * vec2(0.00999999978, 0.0);
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
					    u_xlat4 = vs_TEXCOORD1.xzxz / vec4(vec4(_WaveNormalScale, _WaveNormalScale, _WaveNormalScale, _WaveNormalScale));
					    u_xlat5 = u_xlat4.zwzw + vec4(0.418000013, 0.354999989, 0.86500001, 0.148000002);
					    u_xlat24 = _WaveNormalSpeed * _Time.y;
					    u_xlat5 = vec4(u_xlat24) * vec4(-0.707106769, -0.707106769, -0.707106769, 0.707106769) + u_xlat5;
					    u_xlat4 = vec4(u_xlat24) * vec4(0.707106769, 0.707106769, 0.707106769, -0.707106769) + u_xlat4;
					    u_xlat6 = texture(_WaveNormalMap, u_xlat5.xy);
					    u_xlat5 = texture(_WaveNormalMap, u_xlat5.zw);
					    u_xlat6.x = u_xlat6.w * u_xlat6.x;
					    u_xlat6.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat6.z = sqrt(u_xlat24);
					    u_xlat7 = texture(_WaveNormalMap, u_xlat4.xy);
					    u_xlat4.xy = u_xlat4.zw + vec2(0.651000023, 0.751999974);
					    u_xlat4 = texture(_WaveNormalMap, u_xlat4.xy);
					    u_xlat7.x = u_xlat7.w * u_xlat7.x;
					    u_xlat7.xy = u_xlat7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat7.xy, u_xlat7.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat7.z = sqrt(u_xlat24);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat5.z = sqrt(u_xlat24);
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat24 = min(u_xlat24, 1.0);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat4.z = sqrt(u_xlat24);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat4.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat24);
					    u_xlat24 = sqrt(u_xlat24);
					    u_xlat24 = u_xlat24 * (-_DistanceDensity);
					    u_xlat24 = u_xlat24 * 1.44269502;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat25 = u_xlat25 + u_xlat25;
					    u_xlat3.xyz = u_xlat1.xyz * (-vec3(u_xlat25)) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, (-u_xlat2.xyz));
					    u_xlat9.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat2 = texture(unity_SpecCube0, u_xlat3.xyz);
					    u_xlat17 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat17 = log2(u_xlat17);
					    u_xlat17 = u_xlat17 * _SunSpecularExponent;
					    u_xlat17 = exp2(u_xlat17);
					    u_xlat1.z = min(u_xlat17, 1.0);
					    u_xlat25 = u_xlat1.x * u_xlat1.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat1.x = u_xlat25 * u_xlat1.x;
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat1.x = _ZBufferParams.z * hlslcc_FragCoord.z + _ZBufferParams.w;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat3.xy);
					    u_xlat3 = texture(_GrabTexture, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat3.xyz * _ShallowColor.xyz + (-_DeepColor.xyz);
					    u_xlat25 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat1.x = (-u_xlat1.x) + u_xlat25;
					    u_xlat1.w = abs(u_xlat1.x) * (-_DepthDensity);
					    u_xlat1.x = -abs(u_xlat1.x) / _EdgeFoamDepth;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.44269502, 1.44269502);
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xz = roundEven(u_xlat1.xz);
					    u_xlat25 = exp2(u_xlat1.w);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + _DeepColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + (-_FarColor.xyz);
					    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FarColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_ReflectionContribution, _ReflectionContribution, _ReflectionContribution)) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx + u_xlat2.xyz;
					    u_xlat2 = vs_TEXCOORD1.xzxz / vec4(vec4(_FoamScale, _FoamScale, _FoamScale, _FoamScale));
					    u_xlat2 = vec4(_FoamNoiseScale) * u_xlat4.xzxz + u_xlat2;
					    u_xlat3 = u_xlat2.zwzw + vec4(0.418000013, 0.354999989, 0.86500001, 0.148000002);
					    u_xlat9.x = _FoamSpeed * _Time.y;
					    u_xlat3 = u_xlat9.xxxx * vec4(-0.707106769, -0.707106769, -0.707106769, 0.707106769) + u_xlat3;
					    u_xlat2 = u_xlat9.xxxx * vec4(0.707106769, 0.707106769, 0.707106769, -0.707106769) + u_xlat2;
					    u_xlat4 = texture(_FoamTexture, u_xlat3.xy);
					    u_xlat3 = texture(_FoamTexture, u_xlat3.zw);
					    u_xlat5 = texture(_FoamTexture, u_xlat2.xy);
					    u_xlat9.xz = u_xlat2.zw + vec2(0.651000023, 0.751999974);
					    u_xlat2 = texture(_FoamTexture, u_xlat9.xz);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_FoamContribution, _FoamContribution, _FoamContribution));
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.25, 0.25, 0.25) + u_xlat0.xyz;
					    u_xlat9.x = _SparkleSpeed * _Time.y;
					    u_xlat2 = vs_TEXCOORD1.xzxz / vec4(_SparkleScale);
					    u_xlat3.xy = u_xlat9.xx * vec2(0.707106769, 0.707106769) + u_xlat2.zw;
					    u_xlat4.xyz = u_xlat9.xxx * vec3(-0.707106769, -0.707106769, 0.707106769);
					    u_xlat3 = texture(_SparklesNormalMap, u_xlat3.xy);
					    u_xlat9.x = dot(u_xlat3.xx, u_xlat3.ww);
					    u_xlat9.x = u_xlat9.x + -1.0;
					    u_xlat3 = u_xlat2.zwzw * vec4(3.0, 3.0, 4.0, 4.0) + u_xlat4.yzzy;
					    u_xlat5 = texture(_SparklesNormalMap, u_xlat3.xy);
					    u_xlat3 = texture(_SparklesNormalMap, u_xlat3.zw);
					    u_xlat25 = dot(u_xlat5.xx, u_xlat5.ww);
					    u_xlat5.x = u_xlat9.x + u_xlat25;
					    u_xlat6 = u_xlat2.zwzw * vec4(2.0, 2.0, 2.0, 2.0) + u_xlat4.xxzy;
					    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 2.5, 2.5) + u_xlat4.xxyz;
					    u_xlat4 = texture(_SparklesNormalMap, u_xlat6.xy);
					    u_xlat6 = texture(_SparklesNormalMap, u_xlat6.zw);
					    u_xlat25 = u_xlat4.y * 2.0 + -1.0;
					    u_xlat5.y = u_xlat3.y * 2.0 + u_xlat25;
					    u_xlat3.xy = u_xlat5.xy + vec2(-1.0, -1.0);
					    u_xlat3.z = 1.0;
					    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
					    u_xlat4 = texture(_SparklesNormalMap, u_xlat2.zw);
					    u_xlat2 = texture(_SparklesNormalMap, u_xlat2.xy);
					    u_xlat25 = u_xlat2.y * 2.0 + -1.0;
					    u_xlat2.y = u_xlat6.y * 2.0 + u_xlat25;
					    u_xlat25 = dot(u_xlat4.xx, u_xlat4.ww);
					    u_xlat2.x = u_xlat9.x + u_xlat25;
					    u_xlat2.xy = u_xlat2.xy + vec2(-1.0, -1.0);
					    u_xlat2.z = 1.0;
					    u_xlat9.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat2.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat2.x * u_xlat3.x;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat25 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat9.x * 3.0;
					    u_xlat9.x = min(u_xlat9.x, 1.0);
					    u_xlat9.x = u_xlat9.x * u_xlat25;
					    u_xlat9.x = log2(u_xlat9.x);
					    u_xlat9.x = u_xlat9.x * _SparkleExponent;
					    u_xlat9.x = exp2(u_xlat9.x);
					    u_xlat9.x = min(u_xlat9.x, 1.0);
					    u_xlat9.x = ceil(u_xlat9.x);
					    u_xlat24 = u_xlat24 * u_xlat9.x;
					    u_xlat2.xyz = vec3(u_xlat24) * _SparkleColor.xyz;
					    u_xlat9.xyz = u_xlat1.zzz * _SunSpecularColor.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * _EdgeFoamColor.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat24 = vs_TEXCOORD3;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}