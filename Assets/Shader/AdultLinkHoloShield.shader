Shader "AdultLink/HoloShield" {
	Properties {
		_Globalopacity ("Global opacity", Range(0, 1)) = 1
		_Maintexture ("Main texture", 2D) = "black" {}
		_Maintextureintensity ("Main texture intensity", Float) = 1
		_Mainpanningspeed ("Main panning speed", Vector) = (0,0,0,0)
		[Toggle] _Invertmaintexture ("Invert main texture", Range(0, 1)) = 0
		[HDR] _Maincolor ("Main color", Vector) = (0.7941176,0.1284602,0.1284602,0.666)
		_TessValue ("Max Tessellation", Range(1, 32)) = 1
		_TessMin ("Tess Min Distance", Float) = 10
		_TessMax ("Tess Max Distance", Float) = 25
		_TessPhongStrength ("Phong Tess Strength", Range(0, 1)) = 0.5
		[HDR] _Edgecolor ("Edge color", Vector) = (0.7941176,0.1284602,0.1284602,0.666)
		_Bias ("Bias", Float) = 0
		_Scale ("Scale", Float) = 1
		_Power ("Power", Range(0, 5)) = 2
		_Innerfresnelintensity ("Inner fresnel intensity", Range(0, 1)) = 0
		_Outerfresnelintensity ("Outer fresnel intensity", Range(0, 1)) = 1
		_Secondarytexture ("Secondary texture", 2D) = "black" {}
		_Secondarytextureintensity ("Secondary texture intensity", Float) = 1
		_Secondarypanningspeed ("Secondary panning speed", Vector) = (0,0,0,0)
		[Toggle] _Invertsecondarytexture ("Invert secondary texture", Range(0, 1)) = 0
		[HDR] _Secondarycolor ("Secondary color", Vector) = (0,0,0,0)
		[Toggle] _Enabledistortion ("Enable distortion", Range(0, 1)) = 0
		_Distortionscale ("Distortion scale", Range(0, 10)) = 1
		_Distortionspeed ("Distortion speed", Range(0, 5)) = 1
		_Extraroughness ("Extra roughness", Range(0, 10)) = 0
		[Toggle] _Enablepulsation ("Enable pulsation", Range(0, 1)) = 0
		_Pulsephase ("Pulse phase", Float) = 0
		_Pulsefrequency ("Pulse frequency", Float) = 3
		_Pulseamplitude ("Pulse amplitude", Float) = 1
		_Pulseoffset ("Pulse offset", Float) = 0
		[Toggle] _Enablenoise ("Enable noise", Range(0, 1)) = 0
		_Sharpennoise ("Sharpen noise", Range(0, 1)) = 0
		_Noisescale ("Noise scale", Float) = 50
		_Noisespeed ("Noise speed", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 7374
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 _Edgecolor;
						vec3 _Noisespeed;
						float _Noisescale;
						float _Enablenoise;
						float _Sharpennoise;
						float _Secondarytextureintensity;
						float _Invertsecondarytexture;
						vec2 _Secondarypanningspeed;
						vec4 _Secondarytexture_ST;
						vec4 _Secondarycolor;
						float _Maintextureintensity;
						float _Invertmaintexture;
						vec2 _Mainpanningspeed;
						vec4 _Maintexture_ST;
						vec4 _Maincolor;
						vec4 unused_0_24[2];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						vec4 unused_3_0[4];
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					UNITY_BINDING(5) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _Secondarytexture;
					UNITY_LOCATION(1) uniform  sampler2D _Maintexture;
					UNITY_LOCATION(2) uniform  samplerCube unity_SpecCube0;
					UNITY_LOCATION(3) uniform  samplerCube unity_SpecCube1;
					UNITY_LOCATION(4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec3 u_xlatb10;
					vec4 u_xlat11;
					bvec4 u_xlatb11;
					vec4 u_xlat12;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					vec2 u_xlat28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * _Power;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = _Scale * u_xlat40 + _Bias;
					    u_xlat2.x = (-u_xlat40) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat40 = _Outerfresnelintensity * u_xlat40 + u_xlat2.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToObject[3].xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_Noisescale, _Noisescale, _Noisescale));
					    u_xlat2.xyz = _Noisespeed.xyz * _Time.yyy + u_xlat2.xyz;
					    u_xlat41 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat41 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlatb4.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb4.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb4.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb4.x ? float(1.0) : 0.0;
					;
					    u_xlat4.x = (u_xlatb4.x) ? float(0.0) : float(1.0);
					    u_xlat4.y = (u_xlatb4.y) ? float(0.0) : float(1.0);
					    u_xlat4.z = (u_xlatb4.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.xyz = max(u_xlat4.yzx, u_xlat5.yzx);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat5.xyz = u_xlat5.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat7.xyz = u_xlat2.xyz + (-u_xlat4.zxy);
					    u_xlat7.xyz = u_xlat7.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat8.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat9.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat9.xyz = floor(u_xlat9.xyz);
					    u_xlat3.xyz = (-u_xlat9.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat9.x = float(0.0);
					    u_xlat9.w = float(1.0);
					    u_xlat9.y = u_xlat6.z;
					    u_xlat9.z = u_xlat4.y;
					    u_xlat9 = u_xlat3.zzzz + u_xlat9;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat9 = u_xlat3.yyyy + u_xlat9;
					    u_xlat10.x = float(0.0);
					    u_xlat10.w = float(1.0);
					    u_xlat10.y = u_xlat6.y;
					    u_xlat10.z = u_xlat4.x;
					    u_xlat9 = u_xlat9 + u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat3 = u_xlat3.xxxx + u_xlat9;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat6.x;
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat3;
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.xzyw * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat6 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat6 = -abs(u_xlat3.xzwy) + u_xlat6.xywz;
					    u_xlat9.xz = floor(u_xlat4.xy);
					    u_xlat9.yw = floor(u_xlat3.xz);
					    u_xlat9 = u_xlat9 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.xz = floor(u_xlat4.zw);
					    u_xlat10.yw = floor(u_xlat3.yw);
					    u_xlat10 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlatb11 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xywz);
					    u_xlat11.x = (u_xlatb11.x) ? float(-1.0) : float(-0.0);
					    u_xlat11.y = (u_xlatb11.y) ? float(-1.0) : float(-0.0);
					    u_xlat11.z = (u_xlatb11.z) ? float(-1.0) : float(-0.0);
					    u_xlat11.w = (u_xlatb11.w) ? float(-1.0) : float(-0.0);
					    u_xlat12.xz = u_xlat4.xy;
					    u_xlat12.yw = u_xlat3.xz;
					    u_xlat9 = u_xlat9.zwxy * u_xlat11.yyxx + u_xlat12.zwxy;
					    u_xlat3.xz = u_xlat4.zw;
					    u_xlat3 = u_xlat10 * u_xlat11.zzww + u_xlat3;
					    u_xlat4.xy = u_xlat9.zw;
					    u_xlat4.z = u_xlat6.x;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9.z = u_xlat6.y;
					    u_xlat10.y = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat11.xy = u_xlat3.xy;
					    u_xlat11.z = u_xlat6.w;
					    u_xlat10.z = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat6.xy = u_xlat3.zw;
					    u_xlat10.w = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3 = (-u_xlat10) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
					    u_xlat9.xyz = u_xlat3.yyy * u_xlat9.xyz;
					    u_xlat3.xyz = u_xlat3.zzz * u_xlat11.xyz;
					    u_xlat6.xyz = u_xlat3.www * u_xlat6.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.z = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat10.w = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat10 = (-u_xlat10) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat10 = max(u_xlat10, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.y = dot(u_xlat5.xyz, u_xlat9.xyz);
					    u_xlat2.z = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.w = dot(u_xlat8.xyz, u_xlat6.xyz);
					    u_xlat2.x = dot(u_xlat10, u_xlat2);
					    u_xlat2.x = u_xlat2.x * 42.0 + _Enablenoise;
					    u_xlat2.x = u_xlat2.x * _Enablenoise + (-_Enablenoise);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat15.x = (-u_xlat2.x) + 1.0;
					    u_xlat28.xy = (-vec2(_Sharpennoise, _Invertsecondarytexture)) + vec2(1.0, 1.0);
					    u_xlat3.x = dFdx(u_xlat15.x);
					    u_xlat16 = dFdy(u_xlat15.x);
					    u_xlat3.x = abs(u_xlat16) + abs(u_xlat3.x);
					    u_xlat15.x = u_xlat15.x / u_xlat3.x;
					    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
					    u_xlat15.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * _Sharpennoise;
					    u_xlat2.x = u_xlat2.x * u_xlat28.x + u_xlat15.x;
					    u_xlat3.xyz = vec3(u_xlat40) * _Edgecolor.xyz;
					    u_xlat15.xy = vs_TEXCOORD0.xy * _Secondarytexture_ST.xy + _Secondarytexture_ST.zw;
					    u_xlat15.xy = _Time.yy * _Secondarypanningspeed.xy + u_xlat15.xy;
					    u_xlat4.xyz = texture(_Secondarytexture, u_xlat15.xy).xyz;
					    u_xlat15.x = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat28.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat28.y;
					    u_xlat15.x = _Invertsecondarytexture * u_xlat28.x + u_xlat15.x;
					    u_xlat15.x = u_xlat15.x * _Secondarytextureintensity;
					    u_xlat15.xyz = u_xlat15.xxx * _Secondarycolor.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Maintexture_ST.xy + _Maintexture_ST.zw;
					    u_xlat4.xy = _Time.yy * vec2(_Mainpanningspeed.x, _Mainpanningspeed.y) + u_xlat4.xy;
					    u_xlat4.xyz = texture(_Maintexture, u_xlat4.xy).xyz;
					    u_xlat42 = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat4.x = (-u_xlat42) + 1.0;
					    u_xlat17 = (-_Invertmaintexture) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat17;
					    u_xlat42 = _Invertmaintexture * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 * _Maintextureintensity;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat15.xyz;
					    u_xlat2.xyz = vec3(u_xlat42) * _Maincolor.xyz + u_xlat2.xyz;
					    SV_Target0.w = u_xlat40 * _Globalopacity;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb40)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat40, u_xlat41);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat40 = min(u_xlat6.z, u_xlat40);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat40) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat40 = u_xlat5.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat7.xyz = vec3(u_xlat41) * u_xlat3.xyz;
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
					            u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat41 = min(u_xlat8.z, u_xlat41);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat41 = u_xlat3.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat41);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat3.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = abs(u_xlat39) + u_xlat1.x;
					    u_xlat13.x = u_xlat13.x + 9.99999975e-06;
					    u_xlat13.x = 0.5 / u_xlat13.x;
					    u_xlat13.x = u_xlat13.x * 0.999999881;
					    u_xlat13.x = max(u_xlat13.x, 9.99999975e-05);
					    u_xlat13.x = sqrt(u_xlat13.x);
					    u_xlat13.x = u_xlat1.x * u_xlat13.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat13.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat13.x = -abs(u_xlat39) + 1.0;
					    u_xlat26 = u_xlat13.x * u_xlat13.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat13.x = u_xlat13.x * -2.98023224e-08 + 0.220916301;
					    u_xlat13.xyz = u_xlat13.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat13.xyz;
					    SV_Target0.xyz = vec3(vec3(_Globalopacity, _Globalopacity, _Globalopacity)) * u_xlat2.xyz + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 _Edgecolor;
						vec3 _Noisespeed;
						float _Noisescale;
						float _Enablenoise;
						float _Sharpennoise;
						float _Secondarytextureintensity;
						float _Invertsecondarytexture;
						vec2 _Secondarypanningspeed;
						vec4 _Secondarytexture_ST;
						vec4 _Secondarycolor;
						float _Maintextureintensity;
						float _Invertmaintexture;
						vec2 _Mainpanningspeed;
						vec4 _Maintexture_ST;
						vec4 _Maincolor;
						vec4 unused_0_24[2];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						vec4 unused_3_0[4];
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					UNITY_BINDING(5) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _Secondarytexture;
					UNITY_LOCATION(1) uniform  sampler2D _Maintexture;
					UNITY_LOCATION(2) uniform  samplerCube unity_SpecCube0;
					UNITY_LOCATION(3) uniform  samplerCube unity_SpecCube1;
					UNITY_LOCATION(4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec3 u_xlatb10;
					vec4 u_xlat11;
					bvec4 u_xlatb11;
					vec4 u_xlat12;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * _Power;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = _Scale * u_xlat40 + _Bias;
					    u_xlat2.x = (-u_xlat40) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat40 = _Outerfresnelintensity * u_xlat40 + u_xlat2.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToObject[3].xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_Noisescale, _Noisescale, _Noisescale));
					    u_xlat2.xyz = _Noisespeed.xyz * _Time.yyy + u_xlat2.xyz;
					    u_xlat41 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat41 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlatb4.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb4.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb4.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb4.x ? float(1.0) : 0.0;
					;
					    u_xlat4.x = (u_xlatb4.x) ? float(0.0) : float(1.0);
					    u_xlat4.y = (u_xlatb4.y) ? float(0.0) : float(1.0);
					    u_xlat4.z = (u_xlatb4.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.xyz = max(u_xlat4.yzx, u_xlat5.yzx);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat5.xyz = u_xlat5.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat7.xyz = u_xlat2.xyz + (-u_xlat4.zxy);
					    u_xlat7.xyz = u_xlat7.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat8.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat9.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat9.xyz = floor(u_xlat9.xyz);
					    u_xlat3.xyz = (-u_xlat9.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat9.x = float(0.0);
					    u_xlat9.w = float(1.0);
					    u_xlat9.y = u_xlat6.z;
					    u_xlat9.z = u_xlat4.y;
					    u_xlat9 = u_xlat3.zzzz + u_xlat9;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat9 = u_xlat3.yyyy + u_xlat9;
					    u_xlat10.x = float(0.0);
					    u_xlat10.w = float(1.0);
					    u_xlat10.y = u_xlat6.y;
					    u_xlat10.z = u_xlat4.x;
					    u_xlat9 = u_xlat9 + u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat3 = u_xlat3.xxxx + u_xlat9;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat6.x;
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat3;
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.xzyw * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat6 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat6 = -abs(u_xlat3.xzwy) + u_xlat6.xywz;
					    u_xlat9.xz = floor(u_xlat4.xy);
					    u_xlat9.yw = floor(u_xlat3.xz);
					    u_xlat9 = u_xlat9 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.xz = floor(u_xlat4.zw);
					    u_xlat10.yw = floor(u_xlat3.yw);
					    u_xlat10 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlatb11 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xywz);
					    u_xlat11.x = (u_xlatb11.x) ? float(-1.0) : float(-0.0);
					    u_xlat11.y = (u_xlatb11.y) ? float(-1.0) : float(-0.0);
					    u_xlat11.z = (u_xlatb11.z) ? float(-1.0) : float(-0.0);
					    u_xlat11.w = (u_xlatb11.w) ? float(-1.0) : float(-0.0);
					    u_xlat12.xz = u_xlat4.xy;
					    u_xlat12.yw = u_xlat3.xz;
					    u_xlat9 = u_xlat9.zwxy * u_xlat11.yyxx + u_xlat12.zwxy;
					    u_xlat3.xz = u_xlat4.zw;
					    u_xlat3 = u_xlat10 * u_xlat11.zzww + u_xlat3;
					    u_xlat4.xy = u_xlat9.zw;
					    u_xlat4.z = u_xlat6.x;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9.z = u_xlat6.y;
					    u_xlat10.y = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat11.xy = u_xlat3.xy;
					    u_xlat11.z = u_xlat6.w;
					    u_xlat10.z = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat6.xy = u_xlat3.zw;
					    u_xlat10.w = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3 = (-u_xlat10) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
					    u_xlat9.xyz = u_xlat3.yyy * u_xlat9.xyz;
					    u_xlat3.xyz = u_xlat3.zzz * u_xlat11.xyz;
					    u_xlat6.xyz = u_xlat3.www * u_xlat6.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.z = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat10.w = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat10 = (-u_xlat10) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat10 = max(u_xlat10, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.y = dot(u_xlat5.xyz, u_xlat9.xyz);
					    u_xlat2.z = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.w = dot(u_xlat8.xyz, u_xlat6.xyz);
					    u_xlat2.x = dot(u_xlat10, u_xlat2);
					    u_xlat2.x = u_xlat2.x * 42.0 + _Enablenoise;
					    u_xlat15.xyz = (-vec3(_Enablenoise, _Sharpennoise, _Invertsecondarytexture)) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.x = u_xlat2.x * _Enablenoise + u_xlat15.x;
					    u_xlat15.x = (-u_xlat2.x) + 1.0;
					    u_xlat3.x = dFdx(u_xlat15.x);
					    u_xlat16 = dFdy(u_xlat15.x);
					    u_xlat3.x = abs(u_xlat16) + abs(u_xlat3.x);
					    u_xlat15.x = u_xlat15.x / u_xlat3.x;
					    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
					    u_xlat15.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * _Sharpennoise;
					    u_xlat2.x = u_xlat2.x * u_xlat15.y + u_xlat15.x;
					    u_xlat3.xyz = vec3(u_xlat40) * _Edgecolor.xyz;
					    u_xlat15.xy = vs_TEXCOORD0.xy * _Secondarytexture_ST.xy + _Secondarytexture_ST.zw;
					    u_xlat15.xy = _Time.yy * _Secondarypanningspeed.xy + u_xlat15.xy;
					    u_xlat4.xyz = texture(_Secondarytexture, u_xlat15.xy).xyz;
					    u_xlat15.x = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat28 = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat15.z;
					    u_xlat15.x = _Invertsecondarytexture * u_xlat28 + u_xlat15.x;
					    u_xlat15.x = u_xlat15.x * _Secondarytextureintensity;
					    u_xlat15.xyz = u_xlat15.xxx * _Secondarycolor.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Maintexture_ST.xy + _Maintexture_ST.zw;
					    u_xlat4.xy = _Time.yy * vec2(_Mainpanningspeed.x, _Mainpanningspeed.y) + u_xlat4.xy;
					    u_xlat4.xyz = texture(_Maintexture, u_xlat4.xy).xyz;
					    u_xlat42 = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat4.x = (-u_xlat42) + 1.0;
					    u_xlat17 = (-_Invertmaintexture) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat17;
					    u_xlat42 = _Invertmaintexture * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 * _Maintextureintensity;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat15.xyz;
					    u_xlat2.xyz = vec3(u_xlat42) * _Maincolor.xyz + u_xlat2.xyz;
					    SV_Target0.w = u_xlat40 * _Globalopacity;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb40)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat40, u_xlat41);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat40 = min(u_xlat6.z, u_xlat40);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat40) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat40 = u_xlat5.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat7.xyz = vec3(u_xlat41) * u_xlat3.xyz;
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
					            u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat41 = min(u_xlat8.z, u_xlat41);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat41 = u_xlat3.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat41);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat3.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = abs(u_xlat39) + u_xlat1.x;
					    u_xlat13.x = u_xlat13.x + 9.99999975e-06;
					    u_xlat13.x = 0.5 / u_xlat13.x;
					    u_xlat13.x = u_xlat13.x * 0.999999881;
					    u_xlat13.x = max(u_xlat13.x, 9.99999975e-05);
					    u_xlat13.x = sqrt(u_xlat13.x);
					    u_xlat13.x = u_xlat1.x * u_xlat13.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat13.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat13.x = -abs(u_xlat39) + 1.0;
					    u_xlat26 = u_xlat13.x * u_xlat13.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat13.x = u_xlat13.x * -2.98023224e-08 + 0.220916301;
					    u_xlat13.xyz = u_xlat13.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat13.xyz;
					    SV_Target0.xyz = vec3(vec3(_Globalopacity, _Globalopacity, _Globalopacity)) * u_xlat2.xyz + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 _Edgecolor;
						vec3 _Noisespeed;
						float _Noisescale;
						float _Enablenoise;
						float _Sharpennoise;
						float _Secondarytextureintensity;
						float _Invertsecondarytexture;
						vec2 _Secondarypanningspeed;
						vec4 _Secondarytexture_ST;
						vec4 _Secondarycolor;
						float _Maintextureintensity;
						float _Invertmaintexture;
						vec2 _Mainpanningspeed;
						vec4 _Maintexture_ST;
						vec4 _Maincolor;
						vec4 unused_0_24[2];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						vec4 unused_3_0[4];
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(5) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					UNITY_BINDING(6) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _Secondarytexture;
					UNITY_LOCATION(1) uniform  sampler2D _Maintexture;
					UNITY_LOCATION(2) uniform  samplerCube unity_SpecCube0;
					UNITY_LOCATION(3) uniform  samplerCube unity_SpecCube1;
					UNITY_LOCATION(4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 3) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec3 u_xlatb10;
					vec4 u_xlat11;
					bvec4 u_xlatb11;
					vec4 u_xlat12;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					vec2 u_xlat28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * _Power;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = _Scale * u_xlat40 + _Bias;
					    u_xlat2.x = (-u_xlat40) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat40 = _Outerfresnelintensity * u_xlat40 + u_xlat2.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToObject[3].xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_Noisescale, _Noisescale, _Noisescale));
					    u_xlat2.xyz = _Noisespeed.xyz * _Time.yyy + u_xlat2.xyz;
					    u_xlat41 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat41 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlatb4.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb4.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb4.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb4.x ? float(1.0) : 0.0;
					;
					    u_xlat4.x = (u_xlatb4.x) ? float(0.0) : float(1.0);
					    u_xlat4.y = (u_xlatb4.y) ? float(0.0) : float(1.0);
					    u_xlat4.z = (u_xlatb4.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.xyz = max(u_xlat4.yzx, u_xlat5.yzx);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat5.xyz = u_xlat5.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat7.xyz = u_xlat2.xyz + (-u_xlat4.zxy);
					    u_xlat7.xyz = u_xlat7.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat8.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat9.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat9.xyz = floor(u_xlat9.xyz);
					    u_xlat3.xyz = (-u_xlat9.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat9.x = float(0.0);
					    u_xlat9.w = float(1.0);
					    u_xlat9.y = u_xlat6.z;
					    u_xlat9.z = u_xlat4.y;
					    u_xlat9 = u_xlat3.zzzz + u_xlat9;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat9 = u_xlat3.yyyy + u_xlat9;
					    u_xlat10.x = float(0.0);
					    u_xlat10.w = float(1.0);
					    u_xlat10.y = u_xlat6.y;
					    u_xlat10.z = u_xlat4.x;
					    u_xlat9 = u_xlat9 + u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat3 = u_xlat3.xxxx + u_xlat9;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat6.x;
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat3;
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.xzyw * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat6 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat6 = -abs(u_xlat3.xzwy) + u_xlat6.xywz;
					    u_xlat9.xz = floor(u_xlat4.xy);
					    u_xlat9.yw = floor(u_xlat3.xz);
					    u_xlat9 = u_xlat9 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.xz = floor(u_xlat4.zw);
					    u_xlat10.yw = floor(u_xlat3.yw);
					    u_xlat10 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlatb11 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xywz);
					    u_xlat11.x = (u_xlatb11.x) ? float(-1.0) : float(-0.0);
					    u_xlat11.y = (u_xlatb11.y) ? float(-1.0) : float(-0.0);
					    u_xlat11.z = (u_xlatb11.z) ? float(-1.0) : float(-0.0);
					    u_xlat11.w = (u_xlatb11.w) ? float(-1.0) : float(-0.0);
					    u_xlat12.xz = u_xlat4.xy;
					    u_xlat12.yw = u_xlat3.xz;
					    u_xlat9 = u_xlat9.zwxy * u_xlat11.yyxx + u_xlat12.zwxy;
					    u_xlat3.xz = u_xlat4.zw;
					    u_xlat3 = u_xlat10 * u_xlat11.zzww + u_xlat3;
					    u_xlat4.xy = u_xlat9.zw;
					    u_xlat4.z = u_xlat6.x;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9.z = u_xlat6.y;
					    u_xlat10.y = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat11.xy = u_xlat3.xy;
					    u_xlat11.z = u_xlat6.w;
					    u_xlat10.z = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat6.xy = u_xlat3.zw;
					    u_xlat10.w = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3 = (-u_xlat10) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
					    u_xlat9.xyz = u_xlat3.yyy * u_xlat9.xyz;
					    u_xlat3.xyz = u_xlat3.zzz * u_xlat11.xyz;
					    u_xlat6.xyz = u_xlat3.www * u_xlat6.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.z = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat10.w = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat10 = (-u_xlat10) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat10 = max(u_xlat10, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.y = dot(u_xlat5.xyz, u_xlat9.xyz);
					    u_xlat2.z = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.w = dot(u_xlat8.xyz, u_xlat6.xyz);
					    u_xlat2.x = dot(u_xlat10, u_xlat2);
					    u_xlat2.x = u_xlat2.x * 42.0 + _Enablenoise;
					    u_xlat2.x = u_xlat2.x * _Enablenoise + (-_Enablenoise);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat15.x = (-u_xlat2.x) + 1.0;
					    u_xlat28.xy = (-vec2(_Sharpennoise, _Invertsecondarytexture)) + vec2(1.0, 1.0);
					    u_xlat3.x = dFdx(u_xlat15.x);
					    u_xlat16 = dFdy(u_xlat15.x);
					    u_xlat3.x = abs(u_xlat16) + abs(u_xlat3.x);
					    u_xlat15.x = u_xlat15.x / u_xlat3.x;
					    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
					    u_xlat15.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * _Sharpennoise;
					    u_xlat2.x = u_xlat2.x * u_xlat28.x + u_xlat15.x;
					    u_xlat3.xyz = vec3(u_xlat40) * _Edgecolor.xyz;
					    u_xlat15.xy = vs_TEXCOORD0.xy * _Secondarytexture_ST.xy + _Secondarytexture_ST.zw;
					    u_xlat15.xy = _Time.yy * _Secondarypanningspeed.xy + u_xlat15.xy;
					    u_xlat4.xyz = texture(_Secondarytexture, u_xlat15.xy).xyz;
					    u_xlat15.x = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat28.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat28.y;
					    u_xlat15.x = _Invertsecondarytexture * u_xlat28.x + u_xlat15.x;
					    u_xlat15.x = u_xlat15.x * _Secondarytextureintensity;
					    u_xlat15.xyz = u_xlat15.xxx * _Secondarycolor.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Maintexture_ST.xy + _Maintexture_ST.zw;
					    u_xlat4.xy = _Time.yy * vec2(_Mainpanningspeed.x, _Mainpanningspeed.y) + u_xlat4.xy;
					    u_xlat4.xyz = texture(_Maintexture, u_xlat4.xy).xyz;
					    u_xlat42 = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat4.x = (-u_xlat42) + 1.0;
					    u_xlat17 = (-_Invertmaintexture) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat17;
					    u_xlat42 = _Invertmaintexture * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 * _Maintextureintensity;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat15.xyz;
					    u_xlat2.xyz = vec3(u_xlat42) * _Maincolor.xyz + u_xlat2.xyz;
					    SV_Target0.w = u_xlat40 * _Globalopacity;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb40)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat40, u_xlat41);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat40 = min(u_xlat6.z, u_xlat40);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat40) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat40 = u_xlat5.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat7.xyz = vec3(u_xlat41) * u_xlat3.xyz;
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
					            u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat41 = min(u_xlat8.z, u_xlat41);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat41 = u_xlat3.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat41);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat3.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = abs(u_xlat39) + u_xlat1.x;
					    u_xlat13.x = u_xlat13.x + 9.99999975e-06;
					    u_xlat13.x = 0.5 / u_xlat13.x;
					    u_xlat13.x = u_xlat13.x * 0.999999881;
					    u_xlat13.x = max(u_xlat13.x, 9.99999975e-05);
					    u_xlat13.x = sqrt(u_xlat13.x);
					    u_xlat13.x = u_xlat1.x * u_xlat13.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat13.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat13.x = -abs(u_xlat39) + 1.0;
					    u_xlat26 = u_xlat13.x * u_xlat13.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat13.x = u_xlat13.x * -2.98023224e-08 + 0.220916301;
					    u_xlat13.xyz = u_xlat13.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat13.xyz;
					    u_xlat0.xyz = vec3(vec3(_Globalopacity, _Globalopacity, _Globalopacity)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 _Edgecolor;
						vec3 _Noisespeed;
						float _Noisescale;
						float _Enablenoise;
						float _Sharpennoise;
						float _Secondarytextureintensity;
						float _Invertsecondarytexture;
						vec2 _Secondarypanningspeed;
						vec4 _Secondarytexture_ST;
						vec4 _Secondarycolor;
						float _Maintextureintensity;
						float _Invertmaintexture;
						vec2 _Mainpanningspeed;
						vec4 _Maintexture_ST;
						vec4 _Maincolor;
						vec4 unused_0_24[2];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						vec4 unused_3_0[4];
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(5) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					UNITY_BINDING(6) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _Secondarytexture;
					UNITY_LOCATION(1) uniform  sampler2D _Maintexture;
					UNITY_LOCATION(2) uniform  samplerCube unity_SpecCube0;
					UNITY_LOCATION(3) uniform  samplerCube unity_SpecCube1;
					UNITY_LOCATION(4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 3) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec3 u_xlatb10;
					vec4 u_xlat11;
					bvec4 u_xlatb11;
					vec4 u_xlat12;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * _Power;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = _Scale * u_xlat40 + _Bias;
					    u_xlat2.x = (-u_xlat40) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat40 = _Outerfresnelintensity * u_xlat40 + u_xlat2.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToObject[3].xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_Noisescale, _Noisescale, _Noisescale));
					    u_xlat2.xyz = _Noisespeed.xyz * _Time.yyy + u_xlat2.xyz;
					    u_xlat41 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat41 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat41) + u_xlat2.xyz;
					    u_xlatb4.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb4.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb4.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb4.x ? float(1.0) : 0.0;
					;
					    u_xlat4.x = (u_xlatb4.x) ? float(0.0) : float(1.0);
					    u_xlat4.y = (u_xlatb4.y) ? float(0.0) : float(1.0);
					    u_xlat4.z = (u_xlatb4.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.xyz = max(u_xlat4.yzx, u_xlat5.yzx);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat5.xyz = u_xlat5.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat7.xyz = u_xlat2.xyz + (-u_xlat4.zxy);
					    u_xlat7.xyz = u_xlat7.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat8.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat9.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat9.xyz = floor(u_xlat9.xyz);
					    u_xlat3.xyz = (-u_xlat9.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat9.x = float(0.0);
					    u_xlat9.w = float(1.0);
					    u_xlat9.y = u_xlat6.z;
					    u_xlat9.z = u_xlat4.y;
					    u_xlat9 = u_xlat3.zzzz + u_xlat9;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat9 = u_xlat3.yyyy + u_xlat9;
					    u_xlat10.x = float(0.0);
					    u_xlat10.w = float(1.0);
					    u_xlat10.y = u_xlat6.y;
					    u_xlat10.z = u_xlat4.x;
					    u_xlat9 = u_xlat9 + u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = u_xlat9 * u_xlat10;
					    u_xlat10 = u_xlat9 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat10 = floor(u_xlat10);
					    u_xlat9 = (-u_xlat10) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat9;
					    u_xlat3 = u_xlat3.xxxx + u_xlat9;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat6.x;
					    u_xlat3 = u_xlat3 + u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat4 = u_xlat3 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat3 = (-u_xlat4) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat3;
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.xzyw * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat6 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat6 = -abs(u_xlat3.xzwy) + u_xlat6.xywz;
					    u_xlat9.xz = floor(u_xlat4.xy);
					    u_xlat9.yw = floor(u_xlat3.xz);
					    u_xlat9 = u_xlat9 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.xz = floor(u_xlat4.zw);
					    u_xlat10.yw = floor(u_xlat3.yw);
					    u_xlat10 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlatb11 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xywz);
					    u_xlat11.x = (u_xlatb11.x) ? float(-1.0) : float(-0.0);
					    u_xlat11.y = (u_xlatb11.y) ? float(-1.0) : float(-0.0);
					    u_xlat11.z = (u_xlatb11.z) ? float(-1.0) : float(-0.0);
					    u_xlat11.w = (u_xlatb11.w) ? float(-1.0) : float(-0.0);
					    u_xlat12.xz = u_xlat4.xy;
					    u_xlat12.yw = u_xlat3.xz;
					    u_xlat9 = u_xlat9.zwxy * u_xlat11.yyxx + u_xlat12.zwxy;
					    u_xlat3.xz = u_xlat4.zw;
					    u_xlat3 = u_xlat10 * u_xlat11.zzww + u_xlat3;
					    u_xlat4.xy = u_xlat9.zw;
					    u_xlat4.z = u_xlat6.x;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9.z = u_xlat6.y;
					    u_xlat10.y = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat11.xy = u_xlat3.xy;
					    u_xlat11.z = u_xlat6.w;
					    u_xlat10.z = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat6.xy = u_xlat3.zw;
					    u_xlat10.w = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3 = (-u_xlat10) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
					    u_xlat9.xyz = u_xlat3.yyy * u_xlat9.xyz;
					    u_xlat3.xyz = u_xlat3.zzz * u_xlat11.xyz;
					    u_xlat6.xyz = u_xlat3.www * u_xlat6.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.z = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat10.w = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat10 = (-u_xlat10) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat10 = max(u_xlat10, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.y = dot(u_xlat5.xyz, u_xlat9.xyz);
					    u_xlat2.z = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.w = dot(u_xlat8.xyz, u_xlat6.xyz);
					    u_xlat2.x = dot(u_xlat10, u_xlat2);
					    u_xlat2.x = u_xlat2.x * 42.0 + _Enablenoise;
					    u_xlat15.xyz = (-vec3(_Enablenoise, _Sharpennoise, _Invertsecondarytexture)) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.x = u_xlat2.x * _Enablenoise + u_xlat15.x;
					    u_xlat15.x = (-u_xlat2.x) + 1.0;
					    u_xlat3.x = dFdx(u_xlat15.x);
					    u_xlat16 = dFdy(u_xlat15.x);
					    u_xlat3.x = abs(u_xlat16) + abs(u_xlat3.x);
					    u_xlat15.x = u_xlat15.x / u_xlat3.x;
					    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
					    u_xlat15.x = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * _Sharpennoise;
					    u_xlat2.x = u_xlat2.x * u_xlat15.y + u_xlat15.x;
					    u_xlat3.xyz = vec3(u_xlat40) * _Edgecolor.xyz;
					    u_xlat15.xy = vs_TEXCOORD0.xy * _Secondarytexture_ST.xy + _Secondarytexture_ST.zw;
					    u_xlat15.xy = _Time.yy * _Secondarypanningspeed.xy + u_xlat15.xy;
					    u_xlat4.xyz = texture(_Secondarytexture, u_xlat15.xy).xyz;
					    u_xlat15.x = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat28 = (-u_xlat15.x) + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat15.z;
					    u_xlat15.x = _Invertsecondarytexture * u_xlat28 + u_xlat15.x;
					    u_xlat15.x = u_xlat15.x * _Secondarytextureintensity;
					    u_xlat15.xyz = u_xlat15.xxx * _Secondarycolor.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Maintexture_ST.xy + _Maintexture_ST.zw;
					    u_xlat4.xy = _Time.yy * vec2(_Mainpanningspeed.x, _Mainpanningspeed.y) + u_xlat4.xy;
					    u_xlat4.xyz = texture(_Maintexture, u_xlat4.xy).xyz;
					    u_xlat42 = dot(u_xlat4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat4.x = (-u_xlat42) + 1.0;
					    u_xlat17 = (-_Invertmaintexture) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat17;
					    u_xlat42 = _Invertmaintexture * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 * _Maintextureintensity;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat15.xyz;
					    u_xlat2.xyz = vec3(u_xlat42) * _Maincolor.xyz + u_xlat2.xyz;
					    SV_Target0.w = u_xlat40 * _Globalopacity;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb40)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat40, u_xlat41);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat40 = min(u_xlat6.z, u_xlat40);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat40) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat40 = u_xlat5.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat7.xyz = vec3(u_xlat41) * u_xlat3.xyz;
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
					            u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat41 = min(u_xlat8.z, u_xlat41);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat41 = u_xlat3.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat41);
					        u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat3.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = abs(u_xlat39) + u_xlat1.x;
					    u_xlat13.x = u_xlat13.x + 9.99999975e-06;
					    u_xlat13.x = 0.5 / u_xlat13.x;
					    u_xlat13.x = u_xlat13.x * 0.999999881;
					    u_xlat13.x = max(u_xlat13.x, 9.99999975e-05);
					    u_xlat13.x = sqrt(u_xlat13.x);
					    u_xlat13.x = u_xlat1.x * u_xlat13.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat13.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * u_xlat13.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat13.x = -abs(u_xlat39) + 1.0;
					    u_xlat26 = u_xlat13.x * u_xlat13.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat13.x = u_xlat13.x * -2.98023224e-08 + 0.220916301;
					    u_xlat13.xyz = u_xlat13.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat13.xyz;
					    u_xlat0.xyz = vec3(vec3(_Globalopacity, _Globalopacity, _Globalopacity)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
						vec4 unused_0_4;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
						vec4 unused_0_4;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
						vec4 unused_0_4;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
						vec4 unused_0_4;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
						vec4 _texcoord_ST;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec4 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    ds_TEXCOORD1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    ds_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
						vec4 _texcoord_ST;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec4 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat39 = u_xlat0.y * u_xlat0.y;
					    u_xlat39 = u_xlat0.x * u_xlat0.x + (-u_xlat39);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    ds_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
						vec4 _texcoord_ST;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec4 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD4;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec3 ds_TEXCOORD2;
					layout(location = 4) out vec4 ds_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    ds_TEXCOORD4 = u_xlat0.z;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    ds_TEXCOORD1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    ds_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
						vec4 _texcoord_ST;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec4 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD4;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec3 ds_TEXCOORD2;
					layout(location = 4) out vec3 ds_TEXCOORD3;
					layout(location = 5) out vec4 ds_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    ds_TEXCOORD4 = u_xlat0.z;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat39 = u_xlat0.y * u_xlat0.y;
					    u_xlat39 = u_xlat0.x * u_xlat0.x + (-u_xlat39);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    ds_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 97169
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 5) in  vec4 in_TEXCOORD2;
					layout(location = 6) in  vec4 in_TEXCOORD3;
					layout(location = 7) in  vec4 in_COLOR0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec4 vs_TANGENT0;
					layout(location = 2) out vec3 vs_NORMAL0;
					layout(location = 3) out vec4 vs_TEXCOORD0;
					layout(location = 4) out vec4 vs_TEXCOORD1;
					layout(location = 5) out vec4 vs_TEXCOORD2;
					layout(location = 6) out vec4 vs_TEXCOORD3;
					layout(location = 7) out vec4 vs_COLOR0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_TANGENT0 = in_TANGENT0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_TEXCOORD1 = in_TEXCOORD1;
					    vs_TEXCOORD2 = in_TEXCOORD2;
					    vs_TEXCOORD3 = in_TEXCOORD3;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = texture(_LightTexture0, vec2(u_xlat17)).x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_9[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, u_xlat1.xyz);
					    u_xlat13 = (-u_xlat13) + 1.0;
					    u_xlat13 = log2(u_xlat13);
					    u_xlat13 = u_xlat13 * _Power;
					    u_xlat13 = exp2(u_xlat13);
					    u_xlat13 = _Scale * u_xlat13 + _Bias;
					    u_xlat2.x = (-u_xlat13) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat13 = _Outerfresnelintensity * u_xlat13 + u_xlat2.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    SV_Target0.w = u_xlat13 * _Globalopacity;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler2D _LightTextureB0;
					UNITY_LOCATION(2) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					bool u_xlatb17;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb17 = 0.0<u_xlat3.z;
					    u_xlat17 = u_xlatb17 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat18 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat17 = u_xlat17 * u_xlat18;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.x = texture(_LightTextureB0, u_xlat3.xx).x;
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTextureB0;
					UNITY_LOCATION(1) uniform  samplerCube _LightTexture0;
					UNITY_LOCATION(2) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = texture(_LightTextureB0, vec2(u_xlat17)).x;
					    u_xlat3.x = texture(_LightTexture0, u_xlat3.xyz).w;
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat10;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, u_xlat1.xyz);
					    u_xlat13 = (-u_xlat13) + 1.0;
					    u_xlat13 = log2(u_xlat13);
					    u_xlat13 = u_xlat13 * _Power;
					    u_xlat13 = exp2(u_xlat13);
					    u_xlat13 = _Scale * u_xlat13 + _Bias;
					    u_xlat2.x = (-u_xlat13) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat13 = _Outerfresnelintensity * u_xlat13 + u_xlat2.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    SV_Target0.w = u_xlat13 * _Globalopacity;
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat10);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.x = texture(_LightTexture0, u_xlat2.xy).w;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(4) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD3;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = texture(_LightTexture0, vec2(u_xlat17)).x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_9[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(4) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD3;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, u_xlat1.xyz);
					    u_xlat13 = (-u_xlat13) + 1.0;
					    u_xlat13 = log2(u_xlat13);
					    u_xlat13 = u_xlat13 * _Power;
					    u_xlat13 = exp2(u_xlat13);
					    u_xlat13 = _Scale * u_xlat13 + _Bias;
					    u_xlat2.x = (-u_xlat13) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat13 = _Outerfresnelintensity * u_xlat13 + u_xlat2.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    SV_Target0.w = u_xlat13 * _Globalopacity;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.x;
					    u_xlat12 = u_xlat12 * (-u_xlat12);
					    u_xlat12 = exp2(u_xlat12);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(4) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler2D _LightTextureB0;
					UNITY_LOCATION(2) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD3;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					bool u_xlatb17;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb17 = 0.0<u_xlat3.z;
					    u_xlat17 = u_xlatb17 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat18 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat17 = u_xlat17 * u_xlat18;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.x = texture(_LightTextureB0, u_xlat3.xx).x;
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(4) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTextureB0;
					UNITY_LOCATION(1) uniform  samplerCube _LightTexture0;
					UNITY_LOCATION(2) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD3;
					layout(location = 2) in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, u_xlat2.xyz);
					    u_xlat16 = (-u_xlat16) + 1.0;
					    u_xlat16 = log2(u_xlat16);
					    u_xlat16 = u_xlat16 * _Power;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat16 = _Scale * u_xlat16 + _Bias;
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat17 = u_xlat17 * _Innerfresnelintensity;
					    u_xlat16 = _Outerfresnelintensity * u_xlat16 + u_xlat17;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    SV_Target0.w = u_xlat16 * _Globalopacity;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = texture(_LightTextureB0, vec2(u_xlat17)).x;
					    u_xlat3.x = texture(_LightTexture0, u_xlat3.xyz).w;
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_10[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					UNITY_BINDING(4) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					UNITY_LOCATION(0) uniform  sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat10;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, u_xlat1.xyz);
					    u_xlat13 = (-u_xlat13) + 1.0;
					    u_xlat13 = log2(u_xlat13);
					    u_xlat13 = u_xlat13 * _Power;
					    u_xlat13 = exp2(u_xlat13);
					    u_xlat13 = _Scale * u_xlat13 + _Bias;
					    u_xlat2.x = (-u_xlat13) + 1.0;
					    u_xlat2.x = u_xlat2.x * _Innerfresnelintensity;
					    u_xlat13 = _Outerfresnelintensity * u_xlat13 + u_xlat2.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    SV_Target0.w = u_xlat13 * _Globalopacity;
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat10);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.x = texture(_LightTexture0, u_xlat2.xy).w;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.x;
					    u_xlat12 = u_xlat12 * (-u_xlat12);
					    u_xlat12 = exp2(u_xlat12);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[17];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"hs_5_0
					
					#version 430
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
					layout(vertices=3) out;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform HGlobals {
						vec4 unused_0_0[21];
						float _TessValue;
						float _TessMin;
						float _TessMax;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec4 vs_TANGENT0[];
					layout(location = 1) out vec4 hs_TANGENT0[];
					layout(location = 2) in vec3 vs_NORMAL0[];
					layout(location = 2) out vec3 hs_NORMAL0[];
					layout(location = 3) in vec4 vs_TEXCOORD0[];
					layout(location = 3) out vec4 hs_TEXCOORD0[];
					layout(location = 4) in vec4 vs_TEXCOORD1[];
					layout(location = 4) out vec4 hs_TEXCOORD1[];
					layout(location = 5) in vec4 vs_TEXCOORD2[];
					layout(location = 5) out vec4 hs_TEXCOORD2[];
					layout(location = 6) in vec4 vs_TEXCOORD3[];
					layout(location = 6) out vec4 hs_TEXCOORD3[];
					layout(location = 7) in vec4 vs_COLOR0[];
					layout(location = 7) out vec4 hs_COLOR0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_TANGENT0[gl_InvocationID] = vs_TANGENT0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					    hs_TEXCOORD1[gl_InvocationID] = vs_TEXCOORD1[gl_InvocationID];
					    hs_TEXCOORD2[gl_InvocationID] = vs_TEXCOORD2[gl_InvocationID];
					    hs_TEXCOORD3[gl_InvocationID] = vs_TEXCOORD3[gl_InvocationID];
					    hs_COLOR0[gl_InvocationID] = vs_COLOR0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + (-_TessMin);
					    u_xlat2 = (-_TessMin) + _TessMax;
					    u_xlat0.x = u_xlat0.x / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 + (-_TessMin);
					    u_xlat4 = u_xlat4 / u_xlat2;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat0.z = max(u_xlat4, 0.00999999978);
					    u_xlat0.xz = min(u_xlat0.xz, vec2(1.0, 1.0));
					    u_xlat6 = u_xlat0.z * _TessValue;
					    u_xlat1.x = u_xlat0.x * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat0.x * _TessValue;
					    gl_TessLevelOuter[0] = u_xlat1.x * 0.5;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + (-_TessMin);
					    u_xlat2 = u_xlat1.x / u_xlat2;
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat2 = max(u_xlat2, 0.00999999978);
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat6 = u_xlat2 * _TessValue + u_xlat6;
					    u_xlat0.x = u_xlat2 * _TessValue + u_xlat0.x;
					    gl_TessLevelOuter[1] = u_xlat6 * 0.5;
					    gl_TessLevelOuter[2] = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.z * _TessValue + u_xlat0.x;
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    ds_TEXCOORD0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec4 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    ds_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec2 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    ds_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD3;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec3 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    ds_TEXCOORD3 = u_xlat2.z;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD3;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    ds_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    ds_TEXCOORD0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD3;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec4 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    ds_TEXCOORD3 = u_xlat2.z;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    ds_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out float ds_TEXCOORD3;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec3 ds_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    ds_TEXCOORD3 = u_xlat2.z;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"ds_5_0
					
					#version 430
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
					layout(triangles) in;
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform DGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_12[10];
						float _TessPhongStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					UNITY_BINDING(3) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec2 ds_TEXCOORD2;
					layout(location = 3) out float ds_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					bvec4 u_xlatb10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					float u_xlat13;
					float u_xlat39;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat13 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat13;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat39 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat39 = (-u_xlat39) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat39) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat39 = (-_TessPhongStrength) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39);
					    u_xlat0.xyz = vec3(vec3(_TessPhongStrength, _TessPhongStrength, _TessPhongStrength)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat2.xyz;
					    u_xlat39 = dot(u_xlat2.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat3.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4.xyz = floor(u_xlat4.xyz);
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat39 = dot(u_xlat3.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat2.xyz = vec3(u_xlat39) + u_xlat2.xyz;
					    u_xlatb3.xyz = greaterThanEqual(u_xlat2.zxyz, u_xlat2.xyzx).xyz;
					    u_xlat5.x = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat5.y = u_xlatb3.z ? float(1.0) : 0.0;
					    u_xlat5.z = u_xlatb3.x ? float(1.0) : 0.0;
					;
					    u_xlat3.x = (u_xlatb3.x) ? float(0.0) : float(1.0);
					    u_xlat3.y = (u_xlatb3.y) ? float(0.0) : float(1.0);
					    u_xlat3.z = (u_xlatb3.z) ? float(0.0) : float(1.0);
					    u_xlat6.xyz = min(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat3.xyz = max(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.y = u_xlat6.z;
					    u_xlat5.z = u_xlat3.z;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5 = u_xlat4.zzzz + u_xlat5;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat5 = u_xlat4.yyyy + u_xlat5;
					    u_xlat7.x = float(0.0);
					    u_xlat7.w = float(1.0);
					    u_xlat7.y = u_xlat6.y;
					    u_xlat7.z = u_xlat3.y;
					    u_xlat5 = u_xlat5 + u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat5 = u_xlat5 * u_xlat7;
					    u_xlat7 = u_xlat5 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat7 = floor(u_xlat7);
					    u_xlat5 = (-u_xlat7) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat5;
					    u_xlat4 = u_xlat4.xxxx + u_xlat5;
					    u_xlat5.x = float(0.0);
					    u_xlat5.w = float(1.0);
					    u_xlat5.y = u_xlat6.x;
					    u_xlat6.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat5.z = u_xlat3.x;
					    u_xlat3.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat4 = u_xlat4 + u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat5;
					    u_xlat5 = u_xlat4 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat4;
					    u_xlat5 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat5 = floor(u_xlat5);
					    u_xlat4 = (-u_xlat5) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat5 = u_xlat5.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat4 = u_xlat4 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat7.yw = u_xlat4.xy;
					    u_xlat7.xz = u_xlat5.yw;
					    u_xlat8.yw = floor(u_xlat4.xy);
					    u_xlat8.xz = floor(u_xlat5.yw);
					    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat5.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = -abs(u_xlat4.xywz) + u_xlat9.xywz;
					    u_xlatb10 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xywz);
					    u_xlat10.x = (u_xlatb10.x) ? float(-1.0) : float(-0.0);
					    u_xlat10.y = (u_xlatb10.y) ? float(-1.0) : float(-0.0);
					    u_xlat10.z = (u_xlatb10.z) ? float(-1.0) : float(-0.0);
					    u_xlat10.w = (u_xlatb10.w) ? float(-1.0) : float(-0.0);
					    u_xlat7 = u_xlat8.zwxy * u_xlat10.yyxx + u_xlat7.zwxy;
					    u_xlat8.xy = u_xlat7.zw;
					    u_xlat8.z = u_xlat9.x;
					    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat7.z = u_xlat9.y;
					    u_xlat11.y = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat12.yw = floor(u_xlat4.zw);
					    u_xlat5.yw = u_xlat4.zw;
					    u_xlat12.xz = floor(u_xlat5.xz);
					    u_xlat4 = u_xlat12 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat4 = u_xlat4 * u_xlat10.zzww + u_xlat5;
					    u_xlat9.xy = u_xlat4.zw;
					    u_xlat4.z = u_xlat9.w;
					    u_xlat11.z = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat11.w = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat5 = (-u_xlat11) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat7.y = dot(u_xlat6.xyz, u_xlat7.xyz);
					    u_xlat6.y = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.zzz;
					    u_xlat7.z = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat5.xxx * u_xlat8.xyz;
					    u_xlat4.xyz = u_xlat5.www * u_xlat9.xyz;
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.w = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat6.w = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2 = (-u_xlat6) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat39 = dot(u_xlat2, u_xlat7);
					    u_xlat39 = u_xlat39 * _Distortionscale;
					    u_xlat39 = u_xlat39 * 0.839999974;
					    u_xlat39 = _Distortionscale * -0.00999999978 + u_xlat39;
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat39 = sin(u_xlat39);
					    u_xlat39 = u_xlat39 * _Pulseamplitude;
					    u_xlat39 = u_xlat39 * 0.100000001 + _Pulseoffset;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Enablepulsation);
					    u_xlat2.xyz = vec3(_Enabledistortion) * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    ds_TEXCOORD3 = u_xlat2.z;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    ds_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			GpuProgramID 215235
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"vs_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[11];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					UNITY_BINDING(4) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					UNITY_BINDING(5) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD1;
					layout(location = 1) out vec3 vs_TEXCOORD2;
					layout(location = 2) out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					bvec4 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					float u_xlat23;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0.x = float(0.0);
					    u_xlat0.w = float(1.0);
					    u_xlat1.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * in_POSITION0.xyz + in_NORMAL0.xyz;
					    u_xlat1.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat1.xyz;
					    u_xlat34 = dot(u_xlat1.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat2.xyz = vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat3.xyz = (-u_xlat3.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat2.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat1.xyz = vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlatb2.xyz = greaterThanEqual(u_xlat1.zxyz, u_xlat1.xyzx).xyz;
					    u_xlat4.x = u_xlatb2.y ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb2.z ? float(1.0) : 0.0;
					    u_xlat4.z = u_xlatb2.x ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb2.x) ? float(0.0) : float(1.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.0) : float(1.0);
					    u_xlat2.z = (u_xlatb2.z) ? float(0.0) : float(1.0);
					    u_xlat5.xyz = min(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.xyz = max(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat0.y = u_xlat5.z;
					    u_xlat0.z = u_xlat2.z;
					    u_xlat0 = u_xlat0 + u_xlat3.zzzz;
					    u_xlat4 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat0 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat0 = u_xlat3.yyyy + u_xlat0;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat5.y;
					    u_xlat4.z = u_xlat2.y;
					    u_xlat0 = u_xlat0 + u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat0 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat0 = u_xlat3.xxxx + u_xlat0;
					    u_xlat3.x = float(0.0);
					    u_xlat3.w = float(1.0);
					    u_xlat3.y = u_xlat5.x;
					    u_xlat4.xyz = u_xlat1.xyz + (-u_xlat5.xyz);
					    u_xlat4.xyz = u_xlat4.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat3.z = u_xlat2.x;
					    u_xlat2.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat0 = u_xlat0 + u_xlat3;
					    u_xlat3 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat3 = u_xlat0 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat0;
					    u_xlat3 = u_xlat0 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat0;
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat0 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat0 = u_xlat0 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat5.yw = u_xlat0.xy;
					    u_xlat5.xz = u_xlat3.yw;
					    u_xlat6.yw = floor(u_xlat0.xy);
					    u_xlat6.xz = floor(u_xlat3.yw);
					    u_xlat6 = u_xlat6 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat7 = -abs(u_xlat3.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat7 = -abs(u_xlat0.xywz) + u_xlat7.xywz;
					    u_xlatb8 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xywz);
					    u_xlat8.x = (u_xlatb8.x) ? float(-1.0) : float(-0.0);
					    u_xlat8.y = (u_xlatb8.y) ? float(-1.0) : float(-0.0);
					    u_xlat8.z = (u_xlatb8.z) ? float(-1.0) : float(-0.0);
					    u_xlat8.w = (u_xlatb8.w) ? float(-1.0) : float(-0.0);
					    u_xlat5 = u_xlat6.zwxy * u_xlat8.yyxx + u_xlat5.zwxy;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.z = u_xlat7.x;
					    u_xlat9.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.z = u_xlat7.y;
					    u_xlat9.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.yw = floor(u_xlat0.zw);
					    u_xlat3.yw = u_xlat0.zw;
					    u_xlat10.xz = floor(u_xlat3.xz);
					    u_xlat0 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat8.zzww + u_xlat3;
					    u_xlat7.xy = u_xlat0.zw;
					    u_xlat0.z = u_xlat7.w;
					    u_xlat9.z = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9.w = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = (-u_xlat9) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat5.xyz = u_xlat3.yyy * u_xlat5.xyz;
					    u_xlat5.y = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.y = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz;
					    u_xlat5.z = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat4.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat3.xxx * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat7.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.w = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.w = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = (-u_xlat4) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0.x = dot(u_xlat0, u_xlat5);
					    u_xlat0.x = u_xlat0.x * _Distortionscale;
					    u_xlat0.x = u_xlat0.x * 0.839999974;
					    u_xlat0.x = _Distortionscale * -0.00999999978 + u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat33 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat33 = sin(u_xlat33);
					    u_xlat33 = u_xlat33 * _Pulseamplitude;
					    u_xlat33 = u_xlat33 * 0.100000001 + _Pulseoffset;
					    u_xlat1.xyz = vec3(u_xlat33) * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Enablepulsation);
					    u_xlat0.xyz = vec3(_Enabledistortion) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat33 = (-u_xlat33) * u_xlat33 + 1.0;
					    u_xlat33 = sqrt(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlatb33 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat33 = unity_LightShadowBias.x / u_xlat1.w;
					    u_xlat33 = min(u_xlat33, 0.0);
					    u_xlat33 = max(u_xlat33, -1.0);
					    u_xlat33 = u_xlat33 + u_xlat1.z;
					    u_xlat23 = min(u_xlat1.w, u_xlat33);
					    gl_Position.xyw = u_xlat1.xyw;
					    u_xlat1.x = (-u_xlat33) + u_xlat23;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat33;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat1.xyz = u_xlat0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"vs_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Enabledistortion;
						float _Extraroughness;
						float _Distortionspeed;
						float _Distortionscale;
						float _Enablepulsation;
						float _Pulsefrequency;
						float _Pulsephase;
						float _Pulseamplitude;
						float _Pulseoffset;
						vec4 unused_0_10[11];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					UNITY_BINDING(4) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					UNITY_BINDING(5) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD1;
					layout(location = 1) out vec3 vs_TEXCOORD2;
					layout(location = 2) out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					bvec4 u_xlatb8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0.x = float(0.0);
					    u_xlat0.w = float(1.0);
					    u_xlat1.xyz = vec3(vec3(_Extraroughness, _Extraroughness, _Extraroughness)) * in_POSITION0.xyz + in_NORMAL0.xyz;
					    u_xlat1.xyz = vec3(vec3(_Distortionspeed, _Distortionspeed, _Distortionspeed)) * _Time.yyy + u_xlat1.xyz;
					    u_xlat34 = dot(u_xlat1.xyz, vec3(0.333333343, 0.333333343, 0.333333343));
					    u_xlat2.xyz = vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat3.xyz = floor(u_xlat3.xyz);
					    u_xlat3.xyz = (-u_xlat3.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat2.xyz, vec3(0.166666672, 0.166666672, 0.166666672));
					    u_xlat1.xyz = vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlatb2.xyz = greaterThanEqual(u_xlat1.zxyz, u_xlat1.xyzx).xyz;
					    u_xlat4.x = u_xlatb2.y ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb2.z ? float(1.0) : 0.0;
					    u_xlat4.z = u_xlatb2.x ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb2.x) ? float(0.0) : float(1.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.0) : float(1.0);
					    u_xlat2.z = (u_xlatb2.z) ? float(0.0) : float(1.0);
					    u_xlat5.xyz = min(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.xyz = max(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat0.y = u_xlat5.z;
					    u_xlat0.z = u_xlat2.z;
					    u_xlat0 = u_xlat0 + u_xlat3.zzzz;
					    u_xlat4 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat0 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat0 = u_xlat3.yyyy + u_xlat0;
					    u_xlat4.x = float(0.0);
					    u_xlat4.w = float(1.0);
					    u_xlat4.y = u_xlat5.y;
					    u_xlat4.z = u_xlat2.y;
					    u_xlat0 = u_xlat0 + u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat4;
					    u_xlat4 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat4 = floor(u_xlat4);
					    u_xlat0 = (-u_xlat4) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat0 = u_xlat3.xxxx + u_xlat0;
					    u_xlat3.x = float(0.0);
					    u_xlat3.w = float(1.0);
					    u_xlat3.y = u_xlat5.x;
					    u_xlat4.xyz = u_xlat1.xyz + (-u_xlat5.xyz);
					    u_xlat4.xyz = u_xlat4.xyz + vec3(0.166666672, 0.166666672, 0.166666672);
					    u_xlat3.z = u_xlat2.x;
					    u_xlat2.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(0.333333343, 0.333333343, 0.333333343);
					    u_xlat0 = u_xlat0 + u_xlat3;
					    u_xlat3 = u_xlat0 * vec4(34.0, 34.0, 34.0, 34.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3 = u_xlat0 * vec4(0.00346020772, 0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(289.0, 289.0, 289.0, 289.0) + u_xlat0;
					    u_xlat3 = u_xlat0 * vec4(0.0204081628, 0.0204081628, 0.0204081628, 0.0204081628);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(49.0, 49.0, 49.0, 49.0) + u_xlat0;
					    u_xlat3 = u_xlat0 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149);
					    u_xlat3 = floor(u_xlat3);
					    u_xlat0 = (-u_xlat3) * vec4(7.0, 7.0, 7.0, 7.0) + u_xlat0;
					    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = u_xlat3.zxwy * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat0 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat0 = u_xlat0 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat5.yw = u_xlat0.xy;
					    u_xlat5.xz = u_xlat3.yw;
					    u_xlat6.yw = floor(u_xlat0.xy);
					    u_xlat6.xz = floor(u_xlat3.yw);
					    u_xlat6 = u_xlat6 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat7 = -abs(u_xlat3.ywxz) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat7 = -abs(u_xlat0.xywz) + u_xlat7.xywz;
					    u_xlatb8 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xywz);
					    u_xlat8.x = (u_xlatb8.x) ? float(-1.0) : float(-0.0);
					    u_xlat8.y = (u_xlatb8.y) ? float(-1.0) : float(-0.0);
					    u_xlat8.z = (u_xlatb8.z) ? float(-1.0) : float(-0.0);
					    u_xlat8.w = (u_xlatb8.w) ? float(-1.0) : float(-0.0);
					    u_xlat5 = u_xlat6.zwxy * u_xlat8.yyxx + u_xlat5.zwxy;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.z = u_xlat7.x;
					    u_xlat9.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.z = u_xlat7.y;
					    u_xlat9.y = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10.yw = floor(u_xlat0.zw);
					    u_xlat3.yw = u_xlat0.zw;
					    u_xlat10.xz = floor(u_xlat3.xz);
					    u_xlat0 = u_xlat10 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat8.zzww + u_xlat3;
					    u_xlat7.xy = u_xlat0.zw;
					    u_xlat0.z = u_xlat7.w;
					    u_xlat9.z = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9.w = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = (-u_xlat9) * vec4(0.853734732, 0.853734732, 0.853734732, 0.853734732) + vec4(1.79284286, 1.79284286, 1.79284286, 1.79284286);
					    u_xlat5.xyz = u_xlat3.yyy * u_xlat5.xyz;
					    u_xlat5.y = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat4.y = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz;
					    u_xlat5.z = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat4.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat3.xxx * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat7.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.w = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.w = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = (-u_xlat4) + vec4(0.600000024, 0.600000024, 0.600000024, 0.600000024);
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0.x = dot(u_xlat0, u_xlat5);
					    u_xlat0.x = u_xlat0.x * _Distortionscale;
					    u_xlat0.x = u_xlat0.x * 0.839999974;
					    u_xlat0.x = _Distortionscale * -0.00999999978 + u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat33 = _Time.y * _Pulsefrequency + _Pulsephase;
					    u_xlat33 = sin(u_xlat33);
					    u_xlat33 = u_xlat33 * _Pulseamplitude;
					    u_xlat33 = u_xlat33 * 0.100000001 + _Pulseoffset;
					    u_xlat1.xyz = vec3(u_xlat33) * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Enablepulsation);
					    u_xlat0.xyz = vec3(_Enabledistortion) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat33 = (-u_xlat33) * u_xlat33 + 1.0;
					    u_xlat33 = sqrt(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlatb33 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat33 = min(u_xlat1.w, u_xlat1.z);
					    u_xlat33 = (-u_xlat1.z) + u_xlat33;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat33 + u_xlat1.z;
					    gl_Position.xyw = u_xlat1.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat1.xyz = u_xlat0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[6];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_7[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_LOCATION(0) uniform  sampler3D _DitherMaskLOD;
					layout(location = 0) in  vec3 vs_TEXCOORD2;
					layout(location = 1) in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					float u_xlat3;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Power;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _Scale * u_xlat0.x + _Bias;
					    u_xlat1 = (-u_xlat0.x) + 1.0;
					    u_xlat1 = u_xlat1 * _Innerfresnelintensity;
					    u_xlat0.x = _Outerfresnelintensity * u_xlat0.x + u_xlat1;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0.x = texture(_DitherMaskLOD, u_xlat0.xyz).w;
					    u_xlat0.x = u_xlat0.x + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"ps_5_0
					
					#version 430
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
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[6];
						float _Globalopacity;
						float _Outerfresnelintensity;
						float _Bias;
						float _Scale;
						float _Power;
						float _Innerfresnelintensity;
						vec4 unused_0_7[10];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					UNITY_LOCATION(0) uniform  sampler3D _DitherMaskLOD;
					layout(location = 0) in  vec3 vs_TEXCOORD2;
					layout(location = 1) in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					float u_xlat3;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Power;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _Scale * u_xlat0.x + _Bias;
					    u_xlat1 = (-u_xlat0.x) + 1.0;
					    u_xlat1 = u_xlat1 * _Innerfresnelintensity;
					    u_xlat0.x = _Outerfresnelintensity * u_xlat0.x + u_xlat1;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0.x = texture(_DitherMaskLOD, u_xlat0.xyz).w;
					    u_xlat0.x = u_xlat0.x + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "AdultLink.HoloShieldEditor"
}