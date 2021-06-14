Shader "Skybox/Cubemap Extended" {
	Properties {
		[HideInInspector] _IsStandardPipeline ("_IsStandardPipeline", Float) = 1
		[StyledBanner(Skybox Cubemap Extended)] _SkyboxExtended ("< SkyboxExtended >", Float) = 1
		[StyledCategory(Cubemap, 5, 10)] _Cubemapp ("[ Cubemapp ]", Float) = 1
		[NoScaleOffset] _Tex ("Cubemap (HDR)", Cube) = "black" {}
		_Exposure ("Cubemap Exposure", Range(0, 8)) = 1
		[Gamma] _TintColor ("Cubemap Tint Color", Vector) = (0.5,0.5,0.5,1)
		_CubemapPosition ("Cubemap Position", Float) = 0
		[StyledCategory(Rotation)] _Rotationn ("[ Rotationn ]", Float) = 1
		[Toggle(_ENABLEROTATION_ON)] _EnableRotation ("Enable Rotation", Float) = 0
		[IntRange] [Space(10)] _Rotation ("Rotation", Range(0, 360)) = 0
		_RotationSpeed ("Rotation Speed", Float) = 1
		[StyledCategory(Fog)] _Fogg ("[ Fogg ]", Float) = 1
		[Toggle(_ENABLEFOG_ON)] _EnableFog ("Enable Fog", Float) = 0
		[StyledMessage(Info, The fog color is controlled by the fog color set in the Lighting panel., _EnableFog, 1, 10, 0)] _FogMessage ("# FogMessage", Float) = 0
		[Space(10)] _FogIntensity ("Fog Intensity", Range(0, 1)) = 1
		_FogHeight ("Fog Height", Range(0, 1)) = 1
		_FogSmoothness ("Fog Smoothness", Range(0.01, 1)) = 0.01
		_FogFill ("Fog Fill", Range(0, 1)) = 0.5
		[HideInInspector] _Tex_HDR ("DecodeInstructions", Vector) = (0,0,0,0)
		[ASEEnd] _FogPosition ("Fog Position", Float) = 0
	}
	SubShader {
		Tags { "QUEUE" = "Background" "RenderType" = "Background" }
		Pass {
			Name "Unlit"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Background" "RenderType" = "Background" }
			ZWrite Off
			Cull Off
			GpuProgramID 63236
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
						float _CubemapPosition;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[8];
						vec4 unity_OrthoParams;
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
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.x = unity_OrthoParams.y / unity_OrthoParams.x;
					    u_xlat0.x = u_xlat0.x + -1.0;
					    u_xlat0.x = unity_OrthoParams.w * u_xlat0.x + 1.0;
					    vs_TEXCOORD1.y = in_POSITION0.y * u_xlat0.x + (-_CubemapPosition);
					    vs_TEXCOORD1.xz = in_POSITION0.xz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2 = in_POSITION0;
					    return;
					}"
				}
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
						float _CubemapPosition;
						float _Rotation;
						float _RotationSpeed;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[7];
						vec4 unity_OrthoParams;
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
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.x = unity_OrthoParams.y / unity_OrthoParams.x;
					    u_xlat0.x = u_xlat0.x + -1.0;
					    u_xlat0.x = unity_OrthoParams.w * u_xlat0.x + 1.0;
					    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
					    u_xlat12 = _Time.y * _RotationSpeed + _Rotation;
					    u_xlat12 = (-u_xlat12) * 0.0174532924 + 1.0;
					    u_xlat1.x = sin(u_xlat12);
					    u_xlat2.x = cos(u_xlat12);
					    u_xlat3.xz = in_POSITION0.xz;
					    u_xlat3.y = 0.0;
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(0.0);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat2.x = 0.0;
					    u_xlat2.yz = in_POSITION0.zx * vec2(0.0, 1.0);
					    u_xlat3.xy = in_POSITION0.zx * vec2(1.0, 0.0);
					    u_xlat3.z = 0.0;
					    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD1.xz = u_xlat0.xz;
					    vs_TEXCOORD1.y = u_xlat0.y + (-_CubemapPosition);
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2 = in_POSITION0;
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
						vec4 unused_0_0[3];
						vec4 _Tex_HDR;
						vec4 unused_0_2[2];
						vec4 _TintColor;
						float _Exposure;
						vec4 unused_0_5;
					};
					uniform  samplerCube _Tex;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_Tex, vs_TEXCOORD1.xyz);
					    u_xlat3 = u_xlat0.w + -1.0;
					    u_xlat3 = _Tex_HDR.w * u_xlat3 + 1.0;
					    u_xlat3 = u_xlat3 * _Tex_HDR.x;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat3);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat0.w = 0.0;
					    u_xlat0 = u_xlat0 * _TintColor;
					    SV_Target0 = u_xlat0 * vec4(_Exposure);
					    return;
					}"
				}
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
						vec4 unused_0_0[3];
						vec4 _Tex_HDR;
						vec4 unused_0_2[2];
						vec4 _TintColor;
						float _Exposure;
						float _FogPosition;
						float _FogHeight;
						float _FogSmoothness;
						float _FogFill;
						float _FogIntensity;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_1_1;
					};
					uniform  samplerCube _Tex;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD2.y + (-_FogPosition);
					    u_xlat0 = abs(u_xlat0) / _FogHeight;
					    u_xlat0 = log2(u_xlat0);
					    u_xlat2.x = (-_FogSmoothness) + 1.0;
					    u_xlat0 = u_xlat0 * u_xlat2.x;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = min(u_xlat0, 1.0);
					    u_xlat0 = _FogFill * (-u_xlat0) + u_xlat0;
					    u_xlat0 = u_xlat0 + -1.0;
					    u_xlat0 = _FogIntensity * u_xlat0 + 1.0;
					    u_xlat1 = texture(_Tex, vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat1.w + -1.0;
					    u_xlat2.x = _Tex_HDR.w * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * _Tex_HDR.x;
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat2.xyz;
					    u_xlat1.w = 0.0;
					    u_xlat1 = u_xlat1 * _TintColor;
					    u_xlat1 = u_xlat1 * vec4(_Exposure) + (-unity_FogColor);
					    SV_Target0 = vec4(u_xlat0) * u_xlat1 + unity_FogColor;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Skybox/Cubemap"
	CustomEditor "SkyboxExtendedShaderGUI"
}