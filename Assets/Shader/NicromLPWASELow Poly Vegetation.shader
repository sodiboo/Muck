Shader "Nicrom/LPW/ASE/Low Poly Vegetation" {
	Properties {
		[Header(Surface)] [Space] [NoScaleOffset] _MainTex ("Main Texture", 2D) = "white" {}
		_Metallic ("Metallic", Range(0, 1)) = 0
		_Smoothness ("Smoothness", Range(0, 1)) = 0
		[Header(Main Bending)] [Space] _MBDefaultBending ("MB Default Bending", Float) = 0
		[Space] _MBAmplitude ("MB Amplitude", Float) = 1.5
		_MBAmplitudeOffset ("MB Amplitude Offset", Float) = 2
		[Space] _MBFrequency ("MB Frequency", Float) = 1.11
		_MBFrequencyOffset ("MB Frequency Offset", Float) = 0
		[Space] _MBPhase ("MB Phase", Float) = 1
		[Space] _MBWindDir ("MB Wind Dir", Range(0, 360)) = 0
		_MBWindDirOffset ("MB Wind Dir Offset", Range(0, 180)) = 20
		[Space] _MBMaxHeight ("MB Max Height", Float) = 10
		[Header(World Space Noise)] [Space] [NoScaleOffset] _NoiseTexture ("Noise Texture", 2D) = "bump" {}
		_NoiseTextureTilling ("Noise Tilling - Static (XY), Animated (ZW)", Vector) = (1,1,1,1)
		_NoisePannerSpeed ("Noise Panner Speed", Vector) = (0.05,0.03,0,0)
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 798
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat4;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat21 = u_xlat1.y * u_xlat1.y;
					    u_xlat21 = u_xlat1.x * u_xlat1.x + (-u_xlat21);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat4 = u_xlat4 * u_xlat2.xxxx + u_xlat5;
					    u_xlat4 = u_xlat3 * u_xlat2.zzzz + u_xlat4;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat21 = u_xlat2.y * u_xlat2.y;
					    u_xlat21 = u_xlat2.x * u_xlat2.x + (-u_xlat21);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat4;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat21 = u_xlat1.y * u_xlat1.y;
					    u_xlat21 = u_xlat1.x * u_xlat1.x + (-u_xlat21);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat4 = u_xlat4 * u_xlat2.xxxx + u_xlat5;
					    u_xlat4 = u_xlat3 * u_xlat2.zzzz + u_xlat4;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat21 = u_xlat2.y * u_xlat2.y;
					    u_xlat21 = u_xlat2.x * u_xlat2.x + (-u_xlat21);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat14;
					vec2 u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb34)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat35 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat34, u_xlat35);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat34 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat35 = (-_Smoothness) + 1.0;
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat35) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat35;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat35));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22.x = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22.x * u_xlat22.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22.x = u_xlat22.x * u_xlat23;
					    u_xlat22.x = u_xlat11.x * u_xlat22.x + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22.x;
					    u_xlat22.x = u_xlat35 * u_xlat35;
					    u_xlat22.x = max(u_xlat22.x, 0.00200000009);
					    u_xlat3.x = (-u_xlat22.x) + 1.0;
					    u_xlat14 = abs(u_xlat33) * u_xlat3.x + u_xlat22.x;
					    u_xlat3.x = u_xlat1.x * u_xlat3.x + u_xlat22.x;
					    u_xlat33 = abs(u_xlat33) * u_xlat3.x;
					    u_xlat33 = u_xlat1.x * u_xlat14 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat3.x = u_xlat22.x * u_xlat22.x;
					    u_xlat14 = u_xlat12 * u_xlat3.x + (-u_xlat12);
					    u_xlat12 = u_xlat14 * u_xlat12 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat3.x / u_xlat12;
					    u_xlat22.y = u_xlat33 * u_xlat12;
					    u_xlat22.xy = u_xlat22.xy * vec2(0.280000001, 3.14159274);
					    u_xlat33 = max(u_xlat22.y, 9.99999975e-05);
					    u_xlat11.z = sqrt(u_xlat33);
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat22.x = (-u_xlat22.x) * u_xlat35 + 1.0;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat11.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat7.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat22.xxx;
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					bool u_xlatb38;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat38 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat15.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat38, u_xlat15.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat38 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					    u_xlat3.x = (-_Smoothness) + 1.0;
					    u_xlat15.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat15.x = u_xlat15.x + u_xlat15.x;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-u_xlat15.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat38) * _LightColor0.xyz;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD3.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat37 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat37 = u_xlat37 * u_xlat3.x;
					    u_xlat37 = u_xlat37 * 6.0;
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, u_xlat37);
					    u_xlat38 = u_xlat6.w + -1.0;
					    u_xlat38 = unity_SpecCube0_HDR.w * u_xlat38 + 1.0;
					    u_xlat38 = u_xlat38 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat38);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat40);
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat40 = min(u_xlat9.z, u_xlat40);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat40) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, u_xlat37);
					        u_xlat37 = u_xlat8.w + -1.0;
					        u_xlat37 = unity_SpecCube1_HDR.w * u_xlat37 + 1.0;
					        u_xlat37 = u_xlat37 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat37 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat37) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat15.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = dot(u_xlat12.xx, u_xlat3.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat38 = u_xlat25 * u_xlat25;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat25 = u_xlat25 * u_xlat38;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = u_xlat3.x * u_xlat3.x;
					    u_xlat24.x = max(u_xlat24.x, 0.00200000009);
					    u_xlat38 = (-u_xlat24.x) + 1.0;
					    u_xlat15.x = abs(u_xlat36) * u_xlat38 + u_xlat24.x;
					    u_xlat38 = u_xlat1.x * u_xlat38 + u_xlat24.x;
					    u_xlat36 = abs(u_xlat36) * u_xlat38;
					    u_xlat36 = u_xlat1.x * u_xlat15.x + u_xlat36;
					    u_xlat36 = u_xlat36 + 9.99999975e-06;
					    u_xlat36 = 0.5 / u_xlat36;
					    u_xlat38 = u_xlat24.x * u_xlat24.x;
					    u_xlat15.x = u_xlat13 * u_xlat38 + (-u_xlat13);
					    u_xlat13 = u_xlat15.x * u_xlat13 + 1.0;
					    u_xlat38 = u_xlat38 * 0.318309873;
					    u_xlat13 = u_xlat13 * u_xlat13 + 1.00000001e-07;
					    u_xlat13 = u_xlat38 / u_xlat13;
					    u_xlat24.y = u_xlat36 * u_xlat13;
					    u_xlat24.xy = u_xlat24.xy * vec2(0.280000001, 3.14159274);
					    u_xlat36 = max(u_xlat24.y, 9.99999975e-05);
					    u_xlat12.z = sqrt(u_xlat36);
					    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
					    u_xlat24.x = (-u_xlat24.x) * u_xlat3.x + 1.0;
					    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat36 = u_xlat12.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat37) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat5.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat7.xyz * u_xlat24.xxx;
					    u_xlat1.xyw = (-u_xlat6.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyw + u_xlat6.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat14;
					vec2 u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat35 = sqrt(u_xlat35);
					    u_xlat35 = (-u_xlat34) + u_xlat35;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat35 + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat3.xy);
					    u_xlat35 = u_xlat35 + (-u_xlat3.x);
					    u_xlat34 = u_xlat34 * u_xlat35 + u_xlat3.x;
					    u_xlat35 = (-_Smoothness) + 1.0;
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat35) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat35;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat35));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22.x = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22.x * u_xlat22.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22.x = u_xlat22.x * u_xlat23;
					    u_xlat22.x = u_xlat11.x * u_xlat22.x + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22.x;
					    u_xlat22.x = u_xlat35 * u_xlat35;
					    u_xlat22.x = max(u_xlat22.x, 0.00200000009);
					    u_xlat3.x = (-u_xlat22.x) + 1.0;
					    u_xlat14 = abs(u_xlat33) * u_xlat3.x + u_xlat22.x;
					    u_xlat3.x = u_xlat1.x * u_xlat3.x + u_xlat22.x;
					    u_xlat33 = abs(u_xlat33) * u_xlat3.x;
					    u_xlat33 = u_xlat1.x * u_xlat14 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat3.x = u_xlat22.x * u_xlat22.x;
					    u_xlat14 = u_xlat12 * u_xlat3.x + (-u_xlat12);
					    u_xlat12 = u_xlat14 * u_xlat12 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat3.x / u_xlat12;
					    u_xlat22.y = u_xlat33 * u_xlat12;
					    u_xlat22.xy = u_xlat22.xy * vec2(0.280000001, 3.14159274);
					    u_xlat33 = max(u_xlat22.y, 9.99999975e-05);
					    u_xlat11.z = sqrt(u_xlat33);
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat22.x = (-u_xlat22.x) * u_xlat35 + 1.0;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat11.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat7.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat22.xxx;
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					bool u_xlatb38;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat38 = sqrt(u_xlat38);
					    u_xlat38 = (-u_xlat37) + u_xlat38;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb38){
					        u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat15.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15.x = u_xlat3.y * 0.25 + 0.75;
					        u_xlat4.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15.x, u_xlat4.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat3.x = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat15.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat15.xy);
					    u_xlat3.x = u_xlat3.x + (-u_xlat4.x);
					    u_xlat37 = u_xlat37 * u_xlat3.x + u_xlat4.x;
					    u_xlat3.x = (-_Smoothness) + 1.0;
					    u_xlat15.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat15.x = u_xlat15.x + u_xlat15.x;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-u_xlat15.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    if(u_xlatb38){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD3.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat37 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat37 = u_xlat37 * u_xlat3.x;
					    u_xlat37 = u_xlat37 * 6.0;
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, u_xlat37);
					    u_xlat38 = u_xlat6.w + -1.0;
					    u_xlat38 = unity_SpecCube0_HDR.w * u_xlat38 + 1.0;
					    u_xlat38 = u_xlat38 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat38);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat40);
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat40 = min(u_xlat9.z, u_xlat40);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat40) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, u_xlat37);
					        u_xlat37 = u_xlat8.w + -1.0;
					        u_xlat37 = unity_SpecCube1_HDR.w * u_xlat37 + 1.0;
					        u_xlat37 = u_xlat37 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat37 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat37) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat15.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = dot(u_xlat12.xx, u_xlat3.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat38 = u_xlat25 * u_xlat25;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat25 = u_xlat25 * u_xlat38;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = u_xlat3.x * u_xlat3.x;
					    u_xlat24.x = max(u_xlat24.x, 0.00200000009);
					    u_xlat38 = (-u_xlat24.x) + 1.0;
					    u_xlat15.x = abs(u_xlat36) * u_xlat38 + u_xlat24.x;
					    u_xlat38 = u_xlat1.x * u_xlat38 + u_xlat24.x;
					    u_xlat36 = abs(u_xlat36) * u_xlat38;
					    u_xlat36 = u_xlat1.x * u_xlat15.x + u_xlat36;
					    u_xlat36 = u_xlat36 + 9.99999975e-06;
					    u_xlat36 = 0.5 / u_xlat36;
					    u_xlat38 = u_xlat24.x * u_xlat24.x;
					    u_xlat15.x = u_xlat13 * u_xlat38 + (-u_xlat13);
					    u_xlat13 = u_xlat15.x * u_xlat13 + 1.0;
					    u_xlat38 = u_xlat38 * 0.318309873;
					    u_xlat13 = u_xlat13 * u_xlat13 + 1.00000001e-07;
					    u_xlat13 = u_xlat38 / u_xlat13;
					    u_xlat24.y = u_xlat36 * u_xlat13;
					    u_xlat24.xy = u_xlat24.xy * vec2(0.280000001, 3.14159274);
					    u_xlat36 = max(u_xlat24.y, 9.99999975e-05);
					    u_xlat12.z = sqrt(u_xlat36);
					    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
					    u_xlat24.x = (-u_xlat24.x) * u_xlat3.x + 1.0;
					    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat36 = u_xlat12.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat37) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat5.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat7.xyz * u_xlat24.xxx;
					    u_xlat1.xyw = (-u_xlat6.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyw + u_xlat6.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat14;
					vec2 u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb34)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat35 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat34, u_xlat35);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat34 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat35 = (-_Smoothness) + 1.0;
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat35) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat35;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat35));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22.x = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22.x * u_xlat22.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22.x = u_xlat22.x * u_xlat23;
					    u_xlat22.x = u_xlat11.x * u_xlat22.x + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22.x;
					    u_xlat22.x = u_xlat35 * u_xlat35;
					    u_xlat22.x = max(u_xlat22.x, 0.00200000009);
					    u_xlat3.x = (-u_xlat22.x) + 1.0;
					    u_xlat14 = abs(u_xlat33) * u_xlat3.x + u_xlat22.x;
					    u_xlat3.x = u_xlat1.x * u_xlat3.x + u_xlat22.x;
					    u_xlat33 = abs(u_xlat33) * u_xlat3.x;
					    u_xlat33 = u_xlat1.x * u_xlat14 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat3.x = u_xlat22.x * u_xlat22.x;
					    u_xlat14 = u_xlat12 * u_xlat3.x + (-u_xlat12);
					    u_xlat12 = u_xlat14 * u_xlat12 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat3.x / u_xlat12;
					    u_xlat22.y = u_xlat33 * u_xlat12;
					    u_xlat22.xy = u_xlat22.xy * vec2(0.280000001, 3.14159274);
					    u_xlat33 = max(u_xlat22.y, 9.99999975e-05);
					    u_xlat11.z = sqrt(u_xlat33);
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat22.x = (-u_xlat22.x) * u_xlat35 + 1.0;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat11.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat7.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat22.xxx;
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					bool u_xlatb38;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat38 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat15.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat38, u_xlat15.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat38 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					    u_xlat3.x = (-_Smoothness) + 1.0;
					    u_xlat15.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat15.x = u_xlat15.x + u_xlat15.x;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-u_xlat15.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat38) * _LightColor0.xyz;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD3.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat37 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat37 = u_xlat37 * u_xlat3.x;
					    u_xlat37 = u_xlat37 * 6.0;
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, u_xlat37);
					    u_xlat38 = u_xlat6.w + -1.0;
					    u_xlat38 = unity_SpecCube0_HDR.w * u_xlat38 + 1.0;
					    u_xlat38 = u_xlat38 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat38);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat40);
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat40 = min(u_xlat9.z, u_xlat40);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat40) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, u_xlat37);
					        u_xlat37 = u_xlat8.w + -1.0;
					        u_xlat37 = unity_SpecCube1_HDR.w * u_xlat37 + 1.0;
					        u_xlat37 = u_xlat37 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat37 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat37) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat15.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = dot(u_xlat12.xx, u_xlat3.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat38 = u_xlat25 * u_xlat25;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat25 = u_xlat25 * u_xlat38;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = u_xlat3.x * u_xlat3.x;
					    u_xlat24.x = max(u_xlat24.x, 0.00200000009);
					    u_xlat38 = (-u_xlat24.x) + 1.0;
					    u_xlat15.x = abs(u_xlat36) * u_xlat38 + u_xlat24.x;
					    u_xlat38 = u_xlat1.x * u_xlat38 + u_xlat24.x;
					    u_xlat36 = abs(u_xlat36) * u_xlat38;
					    u_xlat36 = u_xlat1.x * u_xlat15.x + u_xlat36;
					    u_xlat36 = u_xlat36 + 9.99999975e-06;
					    u_xlat36 = 0.5 / u_xlat36;
					    u_xlat38 = u_xlat24.x * u_xlat24.x;
					    u_xlat15.x = u_xlat13 * u_xlat38 + (-u_xlat13);
					    u_xlat13 = u_xlat15.x * u_xlat13 + 1.0;
					    u_xlat38 = u_xlat38 * 0.318309873;
					    u_xlat13 = u_xlat13 * u_xlat13 + 1.00000001e-07;
					    u_xlat13 = u_xlat38 / u_xlat13;
					    u_xlat24.y = u_xlat36 * u_xlat13;
					    u_xlat24.xy = u_xlat24.xy * vec2(0.280000001, 3.14159274);
					    u_xlat36 = max(u_xlat24.y, 9.99999975e-05);
					    u_xlat12.z = sqrt(u_xlat36);
					    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
					    u_xlat24.x = (-u_xlat24.x) * u_xlat3.x + 1.0;
					    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat36 = u_xlat12.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat37) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat5.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat7.xyz * u_xlat24.xxx;
					    u_xlat1.xyw = (-u_xlat6.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyw + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat36 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.x;
					    u_xlat36 = u_xlat36 * (-u_xlat36);
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat14;
					vec2 u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat35 = sqrt(u_xlat35);
					    u_xlat35 = (-u_xlat34) + u_xlat35;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat35 + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat3.xy);
					    u_xlat35 = u_xlat35 + (-u_xlat3.x);
					    u_xlat34 = u_xlat34 * u_xlat35 + u_xlat3.x;
					    u_xlat35 = (-_Smoothness) + 1.0;
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat35) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat35;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat35));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22.x = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22.x * u_xlat22.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22.x = u_xlat22.x * u_xlat23;
					    u_xlat22.x = u_xlat11.x * u_xlat22.x + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22.x;
					    u_xlat22.x = u_xlat35 * u_xlat35;
					    u_xlat22.x = max(u_xlat22.x, 0.00200000009);
					    u_xlat3.x = (-u_xlat22.x) + 1.0;
					    u_xlat14 = abs(u_xlat33) * u_xlat3.x + u_xlat22.x;
					    u_xlat3.x = u_xlat1.x * u_xlat3.x + u_xlat22.x;
					    u_xlat33 = abs(u_xlat33) * u_xlat3.x;
					    u_xlat33 = u_xlat1.x * u_xlat14 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat3.x = u_xlat22.x * u_xlat22.x;
					    u_xlat14 = u_xlat12 * u_xlat3.x + (-u_xlat12);
					    u_xlat12 = u_xlat14 * u_xlat12 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat3.x / u_xlat12;
					    u_xlat22.y = u_xlat33 * u_xlat12;
					    u_xlat22.xy = u_xlat22.xy * vec2(0.280000001, 3.14159274);
					    u_xlat33 = max(u_xlat22.y, 9.99999975e-05);
					    u_xlat11.z = sqrt(u_xlat33);
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat22.x = (-u_xlat22.x) * u_xlat35 + 1.0;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat11.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat7.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat22.xxx;
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					bool u_xlatb38;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat38 = sqrt(u_xlat38);
					    u_xlat38 = (-u_xlat37) + u_xlat38;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb38){
					        u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat15.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15.x = u_xlat3.y * 0.25 + 0.75;
					        u_xlat4.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15.x, u_xlat4.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat3.x = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat15.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat15.xy);
					    u_xlat3.x = u_xlat3.x + (-u_xlat4.x);
					    u_xlat37 = u_xlat37 * u_xlat3.x + u_xlat4.x;
					    u_xlat3.x = (-_Smoothness) + 1.0;
					    u_xlat15.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat15.x = u_xlat15.x + u_xlat15.x;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-u_xlat15.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    if(u_xlatb38){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD3.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat37 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat37 = u_xlat37 * u_xlat3.x;
					    u_xlat37 = u_xlat37 * 6.0;
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, u_xlat37);
					    u_xlat38 = u_xlat6.w + -1.0;
					    u_xlat38 = unity_SpecCube0_HDR.w * u_xlat38 + 1.0;
					    u_xlat38 = u_xlat38 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat38);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat40);
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat40 = min(u_xlat9.z, u_xlat40);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat40) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, u_xlat37);
					        u_xlat37 = u_xlat8.w + -1.0;
					        u_xlat37 = unity_SpecCube1_HDR.w * u_xlat37 + 1.0;
					        u_xlat37 = u_xlat37 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat37 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat37) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat15.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = dot(u_xlat12.xx, u_xlat3.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat38 = u_xlat25 * u_xlat25;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat25 = u_xlat25 * u_xlat38;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = u_xlat3.x * u_xlat3.x;
					    u_xlat24.x = max(u_xlat24.x, 0.00200000009);
					    u_xlat38 = (-u_xlat24.x) + 1.0;
					    u_xlat15.x = abs(u_xlat36) * u_xlat38 + u_xlat24.x;
					    u_xlat38 = u_xlat1.x * u_xlat38 + u_xlat24.x;
					    u_xlat36 = abs(u_xlat36) * u_xlat38;
					    u_xlat36 = u_xlat1.x * u_xlat15.x + u_xlat36;
					    u_xlat36 = u_xlat36 + 9.99999975e-06;
					    u_xlat36 = 0.5 / u_xlat36;
					    u_xlat38 = u_xlat24.x * u_xlat24.x;
					    u_xlat15.x = u_xlat13 * u_xlat38 + (-u_xlat13);
					    u_xlat13 = u_xlat15.x * u_xlat13 + 1.0;
					    u_xlat38 = u_xlat38 * 0.318309873;
					    u_xlat13 = u_xlat13 * u_xlat13 + 1.00000001e-07;
					    u_xlat13 = u_xlat38 / u_xlat13;
					    u_xlat24.y = u_xlat36 * u_xlat13;
					    u_xlat24.xy = u_xlat24.xy * vec2(0.280000001, 3.14159274);
					    u_xlat36 = max(u_xlat24.y, 9.99999975e-05);
					    u_xlat12.z = sqrt(u_xlat36);
					    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
					    u_xlat24.x = (-u_xlat24.x) * u_xlat3.x + 1.0;
					    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat36 = u_xlat12.z * u_xlat1.x;
					    u_xlat1.x = (-u_xlat37) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat5.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat2.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat7.xyz * u_xlat24.xxx;
					    u_xlat1.xyw = (-u_xlat6.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyw + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat36 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.x;
					    u_xlat36 = u_xlat36 * (-u_xlat36);
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 91064
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat1.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat1.xy;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
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
						vec4 unused_0_0[9];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat2.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat2.xy;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat1.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat1.xy;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SHADOWS_DEPTH" "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
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
						vec4 unused_0_0[9];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat2.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat2.xy;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD5 = u_xlat1.z;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "SHADOWS_CUBE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "SHADOWS_CUBE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_13[2];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat23));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat20);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat4.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat23 = u_xlat23 * u_xlat5.w;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat24));
					    u_xlat23 = u_xlat23 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat23 = u_xlat4.w * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb19)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat19, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat9.xyz = u_xlat6.xyz / u_xlat6.www;
					    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat9.z);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlatb2 = 0.0<u_xlat5.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat9.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat9.xy = u_xlat9.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat9.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, u_xlat9.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[5];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_5[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					bool u_xlatb13;
					float u_xlat22;
					float u_xlat24;
					vec2 u_xlat28;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat36);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb13 = u_xlat34<0.99000001;
					    if(u_xlatb13){
					        u_xlat6 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat6;
					        u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat6;
					        u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					        u_xlat13.xyz = u_xlat6.xyz / u_xlat6.www;
					        u_xlat6.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					        u_xlat6.xy = floor(u_xlat6.xy);
					        u_xlat13.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat6.xy);
					        u_xlat7 = u_xlat13.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
					        u_xlat8.xw = u_xlat7.xz * u_xlat7.xz;
					        u_xlat28.xy = u_xlat8.xw * vec2(0.5, 0.5) + (-u_xlat13.xy);
					        u_xlat7.xz = (-u_xlat13.xy) + vec2(1.0, 1.0);
					        u_xlat9.xy = min(u_xlat13.xy, vec2(0.0, 0.0));
					        u_xlat7.xz = (-u_xlat9.xy) * u_xlat9.xy + u_xlat7.xz;
					        u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
					        u_xlat13.xy = (-u_xlat13.xy) * u_xlat13.xy + u_xlat7.yw;
					        u_xlat9.x = u_xlat28.x;
					        u_xlat9.y = u_xlat7.x;
					        u_xlat9.z = u_xlat13.x;
					        u_xlat9.w = u_xlat8.x;
					        u_xlat9 = u_xlat9 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat8.x = u_xlat28.y;
					        u_xlat8.y = u_xlat7.z;
					        u_xlat8.z = u_xlat13.y;
					        u_xlat7 = u_xlat8 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat8 = u_xlat9.ywyw + u_xlat9.xzxz;
					        u_xlat10 = u_xlat7.yyww + u_xlat7.xxzz;
					        u_xlat13.xy = u_xlat9.yw / u_xlat8.zw;
					        u_xlat13.xy = u_xlat13.xy + vec2(-1.5, 0.5);
					        u_xlat28.xy = u_xlat7.yw / u_xlat10.yw;
					        u_xlat28.xy = u_xlat28.xy + vec2(-1.5, 0.5);
					        u_xlat7.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.xx;
					        u_xlat7.zw = u_xlat28.xy * _ShadowMapTexture_TexelSize.yy;
					        u_xlat8 = u_xlat8 * u_xlat10;
					        u_xlat9 = u_xlat6.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.xzyz;
					        vec3 txVec0 = vec3(u_xlat9.xy,u_xlat13.z);
					        u_xlat13.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        vec3 txVec1 = vec3(u_xlat9.zw,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat24 = u_xlat24 * u_xlat8.y;
					        u_xlat13.x = u_xlat8.x * u_xlat13.x + u_xlat24;
					        u_xlat6 = u_xlat6.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.xwyw;
					        vec3 txVec2 = vec3(u_xlat6.xy,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat13.x = u_xlat8.z * u_xlat24 + u_xlat13.x;
					        vec3 txVec3 = vec3(u_xlat6.zw,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat13.x = u_xlat8.w * u_xlat24 + u_xlat13.x;
					        u_xlat24 = (-_LightShadowData.x) + 1.0;
					        u_xlat13.x = u_xlat13.x * u_xlat24 + _LightShadowData.x;
					    } else {
					        u_xlat13.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat13.x) + u_xlat2.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x + u_xlat13.x;
					    u_xlatb2 = 0.0<u_xlat5.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat13.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat13.xy = u_xlat13.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, u_xlat13.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat5.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat5.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
					    u_xlat34 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat34));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat35) + 1.0;
					    u_xlat1.x = u_xlat22 * u_xlat22;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat22 = u_xlat22 * u_xlat1.x;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat1.x = -abs(u_xlat33) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat1.x * u_xlat12;
					    u_xlat11.x = u_xlat11.x * u_xlat1.x + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = u_xlat34 * u_xlat34;
					    u_xlat22 = max(u_xlat22, 0.00200000009);
					    u_xlat1.x = (-u_xlat22) + 1.0;
					    u_xlat12 = abs(u_xlat33) * u_xlat1.x + u_xlat22;
					    u_xlat1.x = u_xlat35 * u_xlat1.x + u_xlat22;
					    u_xlat33 = abs(u_xlat33) * u_xlat1.x;
					    u_xlat33 = u_xlat35 * u_xlat12 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat1.x = u_xlat3.x * u_xlat22 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat22 = u_xlat22 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat22 = u_xlat22 / u_xlat1.x;
					    u_xlat22 = u_xlat22 * u_xlat33;
					    u_xlat22 = u_xlat22 * 3.14159274;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = vec2(u_xlat35) * u_xlat11.xy;
					    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb33 = u_xlat33!=0.0;
					    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
					    u_xlat22 = u_xlat33 * u_xlat11.y;
					    u_xlat1.xyz = u_xlat11.xxx * u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat2.xyz * vec3(u_xlat22);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat9;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat19 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat20 = sqrt(u_xlat20);
					    u_xlat20 = (-u_xlat19) + u_xlat20;
					    u_xlat19 = unity_ShadowFadeCenterAndType.w * u_xlat20 + u_xlat19;
					    u_xlat19 = u_xlat19 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb20)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat20, u_xlat9);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat20 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat3.xy);
					    u_xlat20 = u_xlat20 + (-u_xlat3.x);
					    u_xlat19 = u_xlat19 * u_xlat20 + u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat19 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat20 = sqrt(u_xlat20);
					    u_xlat20 = (-u_xlat19) + u_xlat20;
					    u_xlat19 = unity_ShadowFadeCenterAndType.w * u_xlat20 + u_xlat19;
					    u_xlat19 = u_xlat19 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb20)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat20, u_xlat15.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat20 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat15.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat15.xy);
					    u_xlat20 = u_xlat20 + (-u_xlat4.x);
					    u_xlat19 = u_xlat19 * u_xlat20 + u_xlat4.x;
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat24 = max(abs(u_xlat9.y), abs(u_xlat9.x));
					    u_xlat24 = max(abs(u_xlat9.z), u_xlat24);
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.z);
					    u_xlat24 = max(u_xlat24, 9.99999975e-06);
					    u_xlat24 = u_xlat24 * _LightProjectionParams.w;
					    u_xlat24 = _LightProjectionParams.y / u_xlat24;
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.x);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    vec4 txVec0 = vec4(u_xlat9.xyz,u_xlat24);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
					    u_xlat25 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat25;
					    u_xlat25 = u_xlat25 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10.x, u_xlat27);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = u_xlat25<0.99000001;
					    if(u_xlatb10){
					        u_xlat10.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
					        u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.z);
					        u_xlat27 = max(u_xlat27, 9.99999975e-06);
					        u_xlat27 = u_xlat27 * _LightProjectionParams.w;
					        u_xlat27 = _LightProjectionParams.y / u_xlat27;
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.x);
					        u_xlat27 = (-u_xlat27) + 1.0;
					        u_xlat6.xyz = u_xlat10.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat27);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat10.xyz = u_xlat10.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat10.xyz,u_xlat27);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat10.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat18 = (-_LightShadowData.x) + 1.0;
					        u_xlat10.x = u_xlat10.x * u_xlat18 + _LightShadowData.x;
					    } else {
					        u_xlat10.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
					    u_xlat25 = u_xlat25 * u_xlat2.x + u_xlat10.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat25 = u_xlat25 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat25 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat25 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat26) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat26 * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat26 * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat3.x * u_xlat16 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat26) * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat24 = max(abs(u_xlat9.y), abs(u_xlat9.x));
					    u_xlat24 = max(abs(u_xlat9.z), u_xlat24);
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.z);
					    u_xlat24 = max(u_xlat24, 9.99999975e-06);
					    u_xlat24 = u_xlat24 * _LightProjectionParams.w;
					    u_xlat24 = _LightProjectionParams.y / u_xlat24;
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.x);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    vec4 txVec0 = vec4(u_xlat9.xyz,u_xlat24);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat5.w;
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
					    u_xlat25 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat25;
					    u_xlat25 = u_xlat25 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10.x, u_xlat27);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = u_xlat25<0.99000001;
					    if(u_xlatb10){
					        u_xlat10.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
					        u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.z);
					        u_xlat27 = max(u_xlat27, 9.99999975e-06);
					        u_xlat27 = u_xlat27 * _LightProjectionParams.w;
					        u_xlat27 = _LightProjectionParams.y / u_xlat27;
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.x);
					        u_xlat27 = (-u_xlat27) + 1.0;
					        u_xlat6.xyz = u_xlat10.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat27);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat10.xyz = u_xlat10.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat10.xyz,u_xlat27);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat10.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat18 = (-_LightShadowData.x) + 1.0;
					        u_xlat10.x = u_xlat10.x * u_xlat18 + _LightShadowData.x;
					    } else {
					        u_xlat10.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
					    u_xlat25 = u_xlat25 * u_xlat2.x + u_xlat10.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat5.w;
					    u_xlat25 = u_xlat25 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat25 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat25 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat26) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat26 * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat26 * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat3.x * u_xlat16 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat26) * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat23));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat20);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat4.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat23 = u_xlat23 * u_xlat5.w;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat24));
					    u_xlat23 = u_xlat23 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat23);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat23 = u_xlat4.w * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb19)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat19, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SHADOWS_DEPTH" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat9.xyz = u_xlat6.xyz / u_xlat6.www;
					    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat9.z);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlatb2 = 0.0<u_xlat5.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat9.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat9.xy = u_xlat9.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat9.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, u_xlat9.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[5];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_5[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					bool u_xlatb13;
					float u_xlat22;
					float u_xlat24;
					vec2 u_xlat28;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat36);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb13 = u_xlat34<0.99000001;
					    if(u_xlatb13){
					        u_xlat6 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat6;
					        u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat6;
					        u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					        u_xlat13.xyz = u_xlat6.xyz / u_xlat6.www;
					        u_xlat6.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					        u_xlat6.xy = floor(u_xlat6.xy);
					        u_xlat13.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat6.xy);
					        u_xlat7 = u_xlat13.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
					        u_xlat8.xw = u_xlat7.xz * u_xlat7.xz;
					        u_xlat28.xy = u_xlat8.xw * vec2(0.5, 0.5) + (-u_xlat13.xy);
					        u_xlat7.xz = (-u_xlat13.xy) + vec2(1.0, 1.0);
					        u_xlat9.xy = min(u_xlat13.xy, vec2(0.0, 0.0));
					        u_xlat7.xz = (-u_xlat9.xy) * u_xlat9.xy + u_xlat7.xz;
					        u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
					        u_xlat13.xy = (-u_xlat13.xy) * u_xlat13.xy + u_xlat7.yw;
					        u_xlat9.x = u_xlat28.x;
					        u_xlat9.y = u_xlat7.x;
					        u_xlat9.z = u_xlat13.x;
					        u_xlat9.w = u_xlat8.x;
					        u_xlat9 = u_xlat9 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat8.x = u_xlat28.y;
					        u_xlat8.y = u_xlat7.z;
					        u_xlat8.z = u_xlat13.y;
					        u_xlat7 = u_xlat8 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat8 = u_xlat9.ywyw + u_xlat9.xzxz;
					        u_xlat10 = u_xlat7.yyww + u_xlat7.xxzz;
					        u_xlat13.xy = u_xlat9.yw / u_xlat8.zw;
					        u_xlat13.xy = u_xlat13.xy + vec2(-1.5, 0.5);
					        u_xlat28.xy = u_xlat7.yw / u_xlat10.yw;
					        u_xlat28.xy = u_xlat28.xy + vec2(-1.5, 0.5);
					        u_xlat7.xy = u_xlat13.xy * _ShadowMapTexture_TexelSize.xx;
					        u_xlat7.zw = u_xlat28.xy * _ShadowMapTexture_TexelSize.yy;
					        u_xlat8 = u_xlat8 * u_xlat10;
					        u_xlat9 = u_xlat6.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.xzyz;
					        vec3 txVec0 = vec3(u_xlat9.xy,u_xlat13.z);
					        u_xlat13.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        vec3 txVec1 = vec3(u_xlat9.zw,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat24 = u_xlat24 * u_xlat8.y;
					        u_xlat13.x = u_xlat8.x * u_xlat13.x + u_xlat24;
					        u_xlat6 = u_xlat6.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.xwyw;
					        vec3 txVec2 = vec3(u_xlat6.xy,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat13.x = u_xlat8.z * u_xlat24 + u_xlat13.x;
					        vec3 txVec3 = vec3(u_xlat6.zw,u_xlat13.z);
					        u_xlat24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat13.x = u_xlat8.w * u_xlat24 + u_xlat13.x;
					        u_xlat24 = (-_LightShadowData.x) + 1.0;
					        u_xlat13.x = u_xlat13.x * u_xlat24 + _LightShadowData.x;
					    } else {
					        u_xlat13.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat13.x) + u_xlat2.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x + u_xlat13.x;
					    u_xlatb2 = 0.0<u_xlat5.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat13.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat13.xy = u_xlat13.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, u_xlat13.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat5.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat5.xyz = vec3(u_xlat34) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat34 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
					    u_xlat34 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, vec2(u_xlat34));
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat35) + 1.0;
					    u_xlat1.x = u_xlat22 * u_xlat22;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat22 = u_xlat22 * u_xlat1.x;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat1.x = -abs(u_xlat33) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat1.x * u_xlat12;
					    u_xlat11.x = u_xlat11.x * u_xlat1.x + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = u_xlat34 * u_xlat34;
					    u_xlat22 = max(u_xlat22, 0.00200000009);
					    u_xlat1.x = (-u_xlat22) + 1.0;
					    u_xlat12 = abs(u_xlat33) * u_xlat1.x + u_xlat22;
					    u_xlat1.x = u_xlat35 * u_xlat1.x + u_xlat22;
					    u_xlat33 = abs(u_xlat33) * u_xlat1.x;
					    u_xlat33 = u_xlat35 * u_xlat12 + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat1.x = u_xlat3.x * u_xlat22 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat22 = u_xlat22 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat22 = u_xlat22 / u_xlat1.x;
					    u_xlat22 = u_xlat22 * u_xlat33;
					    u_xlat22 = u_xlat22 * 3.14159274;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = vec2(u_xlat35) * u_xlat11.xy;
					    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb33 = u_xlat33!=0.0;
					    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
					    u_xlat22 = u_xlat33 * u_xlat11.y;
					    u_xlat1.xyz = u_xlat11.xxx * u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat2.xyz * vec3(u_xlat22);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat33);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[6];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat9;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat19 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat20 = sqrt(u_xlat20);
					    u_xlat20 = (-u_xlat19) + u_xlat20;
					    u_xlat19 = unity_ShadowFadeCenterAndType.w * u_xlat20 + u_xlat19;
					    u_xlat19 = u_xlat19 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb20)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat20, u_xlat9);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat20 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat3.xy);
					    u_xlat20 = u_xlat20 + (-u_xlat3.x);
					    u_xlat19 = u_xlat19 * u_xlat20 + u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" "SHADOWS_SCREEN" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat19 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat20 = sqrt(u_xlat20);
					    u_xlat20 = (-u_xlat19) + u_xlat20;
					    u_xlat19 = unity_ShadowFadeCenterAndType.w * u_xlat20 + u_xlat19;
					    u_xlat19 = u_xlat19 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb20)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat20, u_xlat15.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat20 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat15.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat15.xy);
					    u_xlat20 = u_xlat20 + (-u_xlat4.x);
					    u_xlat19 = u_xlat19 * u_xlat20 + u_xlat4.x;
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat3.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = u_xlat2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(_Metallic) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat19 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat19 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat3.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "SHADOWS_CUBE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat24 = max(abs(u_xlat9.y), abs(u_xlat9.x));
					    u_xlat24 = max(abs(u_xlat9.z), u_xlat24);
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.z);
					    u_xlat24 = max(u_xlat24, 9.99999975e-06);
					    u_xlat24 = u_xlat24 * _LightProjectionParams.w;
					    u_xlat24 = _LightProjectionParams.y / u_xlat24;
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.x);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    vec4 txVec0 = vec4(u_xlat9.xyz,u_xlat24);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
					    u_xlat25 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat25;
					    u_xlat25 = u_xlat25 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10.x, u_xlat27);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = u_xlat25<0.99000001;
					    if(u_xlatb10){
					        u_xlat10.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
					        u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.z);
					        u_xlat27 = max(u_xlat27, 9.99999975e-06);
					        u_xlat27 = u_xlat27 * _LightProjectionParams.w;
					        u_xlat27 = _LightProjectionParams.y / u_xlat27;
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.x);
					        u_xlat27 = (-u_xlat27) + 1.0;
					        u_xlat6.xyz = u_xlat10.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat27);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat10.xyz = u_xlat10.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat10.xyz,u_xlat27);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat10.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat18 = (-_LightShadowData.x) + 1.0;
					        u_xlat10.x = u_xlat10.x * u_xlat18 + _LightShadowData.x;
					    } else {
					        u_xlat10.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
					    u_xlat25 = u_xlat25 * u_xlat2.x + u_xlat10.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat25 = u_xlat25 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat25 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat25 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat26) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat26 * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat26 * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat3.x * u_xlat16 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat26) * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.x;
					    u_xlat24 = u_xlat24 * (-u_xlat24);
					    u_xlat24 = exp2(u_xlat24);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "SHADOWS_CUBE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat14;
					float u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9.x, u_xlat24);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat24 = max(abs(u_xlat9.y), abs(u_xlat9.x));
					    u_xlat24 = max(abs(u_xlat9.z), u_xlat24);
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.z);
					    u_xlat24 = max(u_xlat24, 9.99999975e-06);
					    u_xlat24 = u_xlat24 * _LightProjectionParams.w;
					    u_xlat24 = _LightProjectionParams.y / u_xlat24;
					    u_xlat24 = u_xlat24 + (-_LightProjectionParams.x);
					    u_xlat24 = (-u_xlat24) + 1.0;
					    vec4 txVec0 = vec4(u_xlat9.xyz,u_xlat24);
					    u_xlat9.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16 = (-_LightShadowData.x) + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat16 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat9.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat5.w;
					    u_xlat22 = u_xlat22 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat22 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat23 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat23) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat23 * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat23 * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat3.x * u_xlat14 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = vec2(u_xlat23) * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[5];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4 = texture(_MainTex, u_xlat4.xy);
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
					    u_xlat25 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat25;
					    u_xlat25 = u_xlat25 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10.x, u_xlat27);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = u_xlat25<0.99000001;
					    if(u_xlatb10){
					        u_xlat10.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
					        u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.z);
					        u_xlat27 = max(u_xlat27, 9.99999975e-06);
					        u_xlat27 = u_xlat27 * _LightProjectionParams.w;
					        u_xlat27 = _LightProjectionParams.y / u_xlat27;
					        u_xlat27 = u_xlat27 + (-_LightProjectionParams.x);
					        u_xlat27 = (-u_xlat27) + 1.0;
					        u_xlat6.xyz = u_xlat10.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat27);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat10.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat27);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat10.xyz = u_xlat10.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat10.xyz,u_xlat27);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat10.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat18 = (-_LightShadowData.x) + 1.0;
					        u_xlat10.x = u_xlat10.x * u_xlat18 + _LightShadowData.x;
					    } else {
					        u_xlat10.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
					    u_xlat25 = u_xlat25 * u_xlat2.x + u_xlat10.x;
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat5.w;
					    u_xlat25 = u_xlat25 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(_Metallic) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat25 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat25 = (-_Smoothness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat26) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat26 * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat26 * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat3.x * u_xlat16 + (-u_xlat3.x);
					    u_xlat1.x = u_xlat1.x * u_xlat3.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat26) * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.x;
					    u_xlat24 = u_xlat24 * (-u_xlat24);
					    u_xlat24 = exp2(u_xlat24);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }
			GpuProgramID 158010
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
						vec4 unused_0_14;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
						vec4 unused_0_14;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
						vec4 unused_0_14;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
						vec4 _texcoord_ST;
						vec4 unused_0_14;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat21 = u_xlat0.y * u_xlat0.y;
					    u_xlat21 = u_xlat0.x * u_xlat0.x + (-u_xlat21);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_4[2];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat2.xy);
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(_Metallic) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.w = 1.0;
					    SV_Target1.w = _Smoothness;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(_Metallic) * u_xlat2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = _Smoothness;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_4[2];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat2.xy);
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(_Metallic) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.w = 1.0;
					    SV_Target1.w = _Smoothness;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						float _Metallic;
						float _Smoothness;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(_Metallic) * u_xlat2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    SV_Target3.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = _Smoothness;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 197199
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat15;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlatb21 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat21 = unity_LightShadowBias.x / u_xlat1.w;
					    u_xlat21 = min(u_xlat21, 0.0);
					    u_xlat21 = max(u_xlat21, -1.0);
					    u_xlat21 = u_xlat21 + u_xlat1.z;
					    u_xlat15 = min(u_xlat1.w, u_xlat21);
					    gl_Position.xyw = u_xlat1.xyw;
					    u_xlat1.x = (-u_xlat21) + u_xlat15;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat21;
					    u_xlat1.xyz = u_xlat0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
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
						vec4 unused_0_0[4];
						float _MBWindDir;
						float _MBWindDirOffset;
						vec4 _NoiseTextureTilling;
						vec2 _NoisePannerSpeed;
						float _MBAmplitude;
						float _MBAmplitudeOffset;
						float _MBFrequency;
						float _MBFrequencyOffset;
						float _MBPhase;
						float _MBDefaultBending;
						float _MBMaxHeight;
						vec4 unused_0_12[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					uniform  sampler2D _NoiseTexture;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = unity_ObjectToWorld[3].z + unity_ObjectToWorld[3].x;
					    u_xlat1 = _NoiseTextureTilling.zwxy * unity_ObjectToWorld[3].xzxz;
					    u_xlat2 = textureLod(_NoiseTexture, u_xlat1.zw, 0.0);
					    u_xlat7 = _MBFrequencyOffset * u_xlat2.x + _MBFrequency;
					    u_xlat14.x = _MBAmplitudeOffset * u_xlat2.x + _MBAmplitude;
					    u_xlat0.x = _Time.y * u_xlat7 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MBPhase;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat14.x * u_xlat0.x + _MBDefaultBending;
					    u_xlat7 = in_POSITION0.y / _MBMaxHeight;
					    u_xlat0.x = u_xlat7 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0174532924;
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat7 = (-u_xlat2.x) + 1.0;
					    u_xlat14.x = _Time.y * 0.100000001;
					    u_xlat14.xy = u_xlat14.xx * _NoisePannerSpeed.xy + u_xlat1.xy;
					    u_xlat1 = textureLod(_NoiseTexture, u_xlat14.xy, 0.0);
					    u_xlat14.x = u_xlat1.x * 2.0 + -1.0;
					    u_xlat14.x = _MBWindDirOffset * u_xlat14.x + _MBWindDir;
					    u_xlat14.x = u_xlat14.x * -0.0174532924;
					    u_xlat1.x = sin(u_xlat14.x);
					    u_xlat3.x = cos(u_xlat14.x);
					    u_xlat1.xyz = u_xlat1.xxx * unity_WorldToObject[2].zxy;
					    u_xlat1.xyz = unity_WorldToObject[0].zxy * u_xlat3.xxx + u_xlat1.xyz;
					    u_xlat14.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
					    u_xlat3 = vec4(u_xlat7) * u_xlat1.yyyz;
					    u_xlat4.xy = u_xlat3.xw * u_xlat1.yz + u_xlat2.xx;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat4.zw = u_xlat3.zy * u_xlat1.xz + u_xlat0.wx;
					    u_xlat5.xy = u_xlat4.wy;
					    u_xlat5.z = u_xlat3.w * u_xlat1.x + (-u_xlat0.z);
					    u_xlat6.y = dot(u_xlat5.xz, in_POSITION0.xz);
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat2.z = u_xlat8 * u_xlat7 + u_xlat2.x;
					    u_xlat2.xy = u_xlat3.yz * u_xlat1.zx + (-u_xlat0.xw);
					    u_xlat2.w = u_xlat3.w * u_xlat1.x + u_xlat0.z;
					    u_xlat6.z = dot(u_xlat2.yz, in_POSITION0.xz);
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.y = in_POSITION0.y;
					    u_xlat6.x = dot(u_xlat4.xz, in_POSITION0.xz);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat6.xyz;
					    u_xlat1.z = dot(u_xlat2.ywz, u_xlat0.xyz);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlatb21 = in_POSITION0.y>=0.00999999978;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlatb21 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat21 = min(u_xlat1.w, u_xlat1.z);
					    u_xlat21 = (-u_xlat1.z) + u_xlat21;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat21 + u_xlat1.z;
					    gl_Position.xyw = u_xlat1.xyw;
					    u_xlat1.xyz = u_xlat0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "LPVegetation_MaterialInspector"
}