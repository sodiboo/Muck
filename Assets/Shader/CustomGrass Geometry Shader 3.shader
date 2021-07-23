Shader "Custom/Grass Geometry Shader 3" {
	Properties {
		_BottomColor ("Bottom Color", Vector) = (0,1,0,1)
		_TopColor ("Top Color", Vector) = (1,1,0,1)
		_GrassHeight ("Grass Height", Float) = 1
		_GrassWidth ("Grass Width", Float) = 0.06
		_RandomHeight ("Grass Height Randomness", Float) = 0.25
		_WindSpeed ("Wind Speed", Float) = 100
		_WindStrength ("Wind Strength", Float) = 0.05
		_Radius ("Interactor Radius", Float) = 0.3
		_Strength ("Interactor Strength", Float) = 5
		_Rad ("Blade Radius", Range(0, 1)) = 0.6
		_BladeForward ("Blade Forward Amount", Float) = 0.38
		_BladeCurve ("Blade Curvature Amount", Range(1, 4)) = 2
		_AmbientStrength ("Ambient Strength", Range(0, 1)) = 0.5
		_MinDist ("Min Distance", Float) = 40
		_MaxDist ("Max Distance", Float) = 60
	}
	SubShader {
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Geometry" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 11172
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec4 in_TEXCOORD0;
					layout(location = 3) in  vec4 in_COLOR0;
					layout(location = 0) out vec3 vs_NORMAL0;
					layout(location = 1) out vec2 vs_TEXCOORD0;
					layout(location = 2) out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0;
						vec4 unity_AmbientSky;
						vec4 unused_1_2[21];
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat1 * vec4(_AmbientStrength);
					    SV_Target0 = u_xlat0 * _LightColor0 + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0;
						vec4 unity_AmbientSky;
						vec4 unused_1_2[21];
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat1 * vec4(_AmbientStrength);
					    SV_Target0 = u_xlat0 * _LightColor0 + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0;
						vec4 unity_AmbientSky;
						vec4 unused_1_2[21];
					};
					UNITY_LOCATION(0) uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_COLOR0;
					layout(location = 2) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat1.x = texture(_ShadowMapTexture, u_xlat1.xy).x;
					    u_xlat5 = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * vec4(u_xlat5);
					    u_xlat2 = u_xlat2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat3 = u_xlat0 * _LightColor0;
					    u_xlat0 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat3 * u_xlat1.xxxx + u_xlat2;
					    SV_Target0 = u_xlat0 * vec4(_AmbientStrength) + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0;
						vec4 unity_AmbientSky;
						vec4 unused_1_2[21];
					};
					UNITY_LOCATION(0) uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_COLOR0;
					layout(location = 2) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat1.x = texture(_ShadowMapTexture, u_xlat1.xy).x;
					    u_xlat5 = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * vec4(u_xlat5);
					    u_xlat2 = u_xlat2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat3 = u_xlat0 * _LightColor0;
					    u_xlat0 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat3 * u_xlat1.xxxx + u_xlat2;
					    SV_Target0 = u_xlat0 * vec4(_AmbientStrength) + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					UNITY_BINDING(2) uniform UnityPerFrame {
						vec4 unused_2_0;
						vec4 unity_AmbientSky;
						vec4 unused_2_2[21];
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z;
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat0 = u_xlat0 * unity_FogParams.x;
					    u_xlat0 = u_xlat0 * (-u_xlat0);
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat3.x = vs_TEXCOORD0.y;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat1 = u_xlat3.xxxx * u_xlat1 + _BottomColor;
					    u_xlat2.xyz = vs_COLOR0.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat1 * unity_AmbientSky;
					    u_xlat2 = u_xlat2 * vec4(_AmbientStrength);
					    u_xlat1 = u_xlat1 * _LightColor0 + u_xlat2;
					    u_xlat3.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    SV_Target0.w = u_xlat1.w;
					    SV_Target0.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					UNITY_BINDING(2) uniform UnityPerFrame {
						vec4 unused_2_0;
						vec4 unity_AmbientSky;
						vec4 unused_2_2[21];
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat0 = u_xlat0 * _ProjectionParams.z;
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat0 = u_xlat0 * unity_FogParams.x;
					    u_xlat0 = u_xlat0 * (-u_xlat0);
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat3.x = vs_TEXCOORD0.y;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat1 = u_xlat3.xxxx * u_xlat1 + _BottomColor;
					    u_xlat2.xyz = vs_COLOR0.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat1 * unity_AmbientSky;
					    u_xlat2 = u_xlat2 * vec4(_AmbientStrength);
					    u_xlat1 = u_xlat1 * _LightColor0 + u_xlat2;
					    u_xlat3.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    SV_Target0.w = u_xlat1.w;
					    SV_Target0.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					UNITY_BINDING(2) uniform UnityPerFrame {
						vec4 unused_2_0;
						vec4 unity_AmbientSky;
						vec4 unused_2_2[21];
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					UNITY_LOCATION(0) uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_COLOR0;
					layout(location = 3) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat1.x = texture(_ShadowMapTexture, u_xlat1.xy).x;
					    u_xlat5 = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * vec4(u_xlat5);
					    u_xlat2 = u_xlat2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat3 = u_xlat0 * _LightColor0;
					    u_xlat0 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat3 * u_xlat1.xxxx + u_xlat2;
					    u_xlat0 = u_xlat0 * vec4(_AmbientStrength) + u_xlat1;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.w = u_xlat0.w;
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.x;
					    u_xlat12 = u_xlat12 * (-u_xlat12);
					    u_xlat12 = exp2(u_xlat12);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_2[5];
						vec4 _TopColor;
						vec4 _BottomColor;
						float _AmbientStrength;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					UNITY_BINDING(2) uniform UnityPerFrame {
						vec4 unused_2_0;
						vec4 unity_AmbientSky;
						vec4 unused_2_2[21];
					};
					UNITY_BINDING(3) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					UNITY_LOCATION(0) uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  float vs_TEXCOORD4;
					layout(location = 2) in  vec3 vs_COLOR0;
					layout(location = 3) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = _TopColor + (-_BottomColor);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _BottomColor;
					    u_xlat1.xyz = vs_COLOR0.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat1.x = texture(_ShadowMapTexture, u_xlat1.xy).x;
					    u_xlat5 = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * vec4(u_xlat5);
					    u_xlat2 = u_xlat2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat3 = u_xlat0 * _LightColor0;
					    u_xlat0 = u_xlat0 * unity_AmbientSky;
					    u_xlat1 = u_xlat3 * u_xlat1.xxxx + u_xlat2;
					    u_xlat0 = u_xlat0 * vec4(_AmbientStrength) + u_xlat1;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.w = u_xlat0.w;
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.x;
					    u_xlat12 = u_xlat12 * (-u_xlat12);
					    u_xlat12 = exp2(u_xlat12);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
			Program "gp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out vec3 gs_COLOR0;
					layout(location = 3) out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out vec3 gs_COLOR0;
					layout(location = 3) out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
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
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out vec3 gs_COLOR0;
					layout(location = 3) out vec3 gs_TEXCOORD3;
					layout(location = 4) out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
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
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out vec3 gs_COLOR0;
					layout(location = 3) out vec3 gs_TEXCOORD3;
					layout(location = 4) out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out float gs_TEXCOORD4;
					layout(location = 3) out vec3 gs_COLOR0;
					layout(location = 4) out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat11.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat8.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					UNITY_BINDING(2) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out float gs_TEXCOORD4;
					layout(location = 3) out vec3 gs_COLOR0;
					layout(location = 4) out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat11.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat8.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
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
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out float gs_TEXCOORD4;
					layout(location = 3) out vec3 gs_COLOR0;
					layout(location = 4) out vec3 gs_TEXCOORD3;
					layout(location = 5) out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_TEXCOORD4 = u_xlat14.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat10.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_5_0
					
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
					UNITY_BINDING(0) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
						vec4 unused_0_14[3];
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
						vec4 unused_2_1[47];
					};
					UNITY_BINDING(3) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					UNITY_BINDING(4) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec3 vs_NORMAL0 [1];
					layout(location = 1) in  vec2 vs_TEXCOORD0 [1];
					layout(location = 2) in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					layout(location = 0) out vec3 gs_NORMAL0;
					layout(location = 1) out vec2 gs_TEXCOORD0;
					layout(location = 2) out float gs_TEXCOORD4;
					layout(location = 3) out vec3 gs_COLOR0;
					layout(location = 4) out vec3 gs_TEXCOORD3;
					layout(location = 5) out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_TEXCOORD4 = u_xlat14.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat10.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			Tags { "LIGHTMODE" = "FORWARDADD" }
			Blend OneMinusDstColor One, OneMinusDstColor One
			ZWrite Off
			Cull Off
			GpuProgramID 90781
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat3 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat3);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat6 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat6 * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
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
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat7;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlatb4 = 0.0<u_xlat0.z;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat7.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat2 = texture(_LightTexture0, u_xlat7.xy);
					    u_xlat9 = u_xlat4.x * u_xlat2.w;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlat9 * u_xlat2.x;
					    u_xlat0.x = u_xlat1.x * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTextureB0, u_xlat1.xx);
					    u_xlat2 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0.x = u_xlat1.x * u_xlat2.w;
					    u_xlat0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_WorldToLight[3].xy;
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb4)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat4 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xy);
					    u_xlat0.x = u_xlat4 * u_xlat1.w;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat3 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat3);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat6 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat6 * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
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
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat7;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlatb4 = 0.0<u_xlat0.z;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat7.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat2 = texture(_LightTexture0, u_xlat7.xy);
					    u_xlat9 = u_xlat4.x * u_xlat2.w;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlat9 * u_xlat2.x;
					    u_xlat0.x = u_xlat1.x * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTextureB0, u_xlat1.xx);
					    u_xlat2 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0.x = u_xlat1.x * u_xlat2.w;
					    u_xlat0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" "_SHADOWS_SCREEN" }
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
						vec4 unused_0_4[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_WorldToLight[3].xy;
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb4)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat4 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xy);
					    u_xlat0.x = u_xlat4 * u_xlat1.w;
					    SV_Target0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
			Program "gp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec3 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat12.yyy * unity_WorldToLight[1].xyz;
					            u_xlat14.xyz = unity_WorldToLight[0].xyz * u_xlat12.xxx + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[2].xyz * u_xlat12.zzz + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[3].xyz * u_xlat12.www + u_xlat12.xyz;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat12.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xyz = u_xlat11.yyy * unity_WorldToLight[1].xyz;
					            u_xlat23.xyz = unity_WorldToLight[0].xyz * u_xlat11.xxx + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[2].xyz * u_xlat11.zzz + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[3].xyz * u_xlat11.www + u_xlat23.xyz;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat23.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xyz = u_xlat8.yyy * unity_WorldToLight[1].xyz;
					        u_xlat19.xyz = unity_WorldToLight[0].xyz * u_xlat8.xxx + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[2].xyz * u_xlat8.zzz + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[3].xyz * u_xlat8.www + u_xlat19.xyz;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5.xyz = u_xlat19.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14 = u_xlat12.yyyy * unity_WorldToLight[1];
					            u_xlat14 = unity_WorldToLight[0] * u_xlat12.xxxx + u_xlat14;
					            u_xlat14 = unity_WorldToLight[2] * u_xlat12.zzzz + u_xlat14;
					            u_xlat12 = unity_WorldToLight[3] * u_xlat12.wwww + u_xlat14;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5 = u_xlat12;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat13 = u_xlat11.yyyy * unity_WorldToLight[1];
					            u_xlat13 = unity_WorldToLight[0] * u_xlat11.xxxx + u_xlat13;
					            u_xlat13 = unity_WorldToLight[2] * u_xlat11.zzzz + u_xlat13;
					            u_xlat11 = unity_WorldToLight[3] * u_xlat11.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5 = u_xlat11;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat10 = u_xlat8.yyyy * unity_WorldToLight[1];
					        u_xlat10 = unity_WorldToLight[0] * u_xlat8.xxxx + u_xlat10;
					        u_xlat10 = unity_WorldToLight[2] * u_xlat8.zzzz + u_xlat10;
					        u_xlat8 = unity_WorldToLight[3] * u_xlat8.wwww + u_xlat10;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5 = u_xlat8;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec3 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat12.yyy * unity_WorldToLight[1].xyz;
					            u_xlat14.xyz = unity_WorldToLight[0].xyz * u_xlat12.xxx + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[2].xyz * u_xlat12.zzz + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[3].xyz * u_xlat12.www + u_xlat12.xyz;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat12.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xyz = u_xlat11.yyy * unity_WorldToLight[1].xyz;
					            u_xlat23.xyz = unity_WorldToLight[0].xyz * u_xlat11.xxx + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[2].xyz * u_xlat11.zzz + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[3].xyz * u_xlat11.www + u_xlat23.xyz;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat23.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xyz = u_xlat8.yyy * unity_WorldToLight[1].xyz;
					        u_xlat19.xyz = unity_WorldToLight[0].xyz * u_xlat8.xxx + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[2].xyz * u_xlat8.zzz + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[3].xyz * u_xlat8.www + u_xlat19.xyz;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5.xyz = u_xlat19.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec2 gs_TEXCOORD5;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xy = u_xlat12.yy * unity_WorldToLight[1].xy;
					            u_xlat12.xy = unity_WorldToLight[0].xy * u_xlat12.xx + u_xlat14.xy;
					            u_xlat12.xy = unity_WorldToLight[2].xy * u_xlat12.zz + u_xlat12.xy;
					            u_xlat12.xy = unity_WorldToLight[3].xy * u_xlat12.ww + u_xlat12.xy;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD5.xy = u_xlat12.xy;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xy = u_xlat11.yy * unity_WorldToLight[1].xy;
					            u_xlat23.xy = unity_WorldToLight[0].xy * u_xlat11.xx + u_xlat23.xy;
					            u_xlat23.xy = unity_WorldToLight[2].xy * u_xlat11.zz + u_xlat23.xy;
					            u_xlat23.xy = unity_WorldToLight[3].xy * u_xlat11.ww + u_xlat23.xy;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD5.xy = u_xlat23.xy;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xy = u_xlat8.yy * unity_WorldToLight[1].xy;
					        u_xlat19.xy = unity_WorldToLight[0].xy * u_xlat8.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_WorldToLight[2].xy * u_xlat8.zz + u_xlat19.xy;
					        u_xlat19.xy = unity_WorldToLight[3].xy * u_xlat8.ww + u_xlat19.xy;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD5.xy = u_xlat19.xy;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out float gs_TEXCOORD4;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec3 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat12.yyy * unity_WorldToLight[1].xyz;
					            u_xlat14.xyz = unity_WorldToLight[0].xyz * u_xlat12.xxx + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[2].xyz * u_xlat12.zzz + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[3].xyz * u_xlat12.www + u_xlat12.xyz;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat12.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xyz = u_xlat11.yyy * unity_WorldToLight[1].xyz;
					            u_xlat23.xyz = unity_WorldToLight[0].xyz * u_xlat11.xxx + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[2].xyz * u_xlat11.zzz + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[3].xyz * u_xlat11.www + u_xlat23.xyz;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat23.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xyz = u_xlat8.yyy * unity_WorldToLight[1].xyz;
					        u_xlat19.xyz = unity_WorldToLight[0].xyz * u_xlat8.xxx + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[2].xyz * u_xlat8.zzz + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[3].xyz * u_xlat8.www + u_xlat19.xyz;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat9.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5.xyz = u_xlat19.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out float gs_TEXCOORD4;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_TEXCOORD4 = u_xlat11.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat8.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "SPOT" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out float gs_TEXCOORD4;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14 = u_xlat12.yyyy * unity_WorldToLight[1];
					            u_xlat14 = unity_WorldToLight[0] * u_xlat12.xxxx + u_xlat14;
					            u_xlat14 = unity_WorldToLight[2] * u_xlat12.zzzz + u_xlat14;
					            u_xlat12 = unity_WorldToLight[3] * u_xlat12.wwww + u_xlat14;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5 = u_xlat12;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat13 = u_xlat11.yyyy * unity_WorldToLight[1];
					            u_xlat13 = unity_WorldToLight[0] * u_xlat11.xxxx + u_xlat13;
					            u_xlat13 = unity_WorldToLight[2] * u_xlat11.zzzz + u_xlat13;
					            u_xlat11 = unity_WorldToLight[3] * u_xlat11.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5 = u_xlat11;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat10 = u_xlat8.yyyy * unity_WorldToLight[1];
					        u_xlat10 = unity_WorldToLight[0] * u_xlat8.xxxx + u_xlat10;
					        u_xlat10 = unity_WorldToLight[2] * u_xlat8.zzzz + u_xlat10;
					        u_xlat8 = unity_WorldToLight[3] * u_xlat8.wwww + u_xlat10;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat9.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5 = u_xlat8;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out float gs_TEXCOORD4;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec3 gs_TEXCOORD5;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat12.yyy * unity_WorldToLight[1].xyz;
					            u_xlat14.xyz = unity_WorldToLight[0].xyz * u_xlat12.xxx + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[2].xyz * u_xlat12.zzz + u_xlat14.xyz;
					            u_xlat12.xyz = unity_WorldToLight[3].xyz * u_xlat12.www + u_xlat12.xyz;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat12.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xyz = u_xlat11.yyy * unity_WorldToLight[1].xyz;
					            u_xlat23.xyz = unity_WorldToLight[0].xyz * u_xlat11.xxx + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[2].xyz * u_xlat11.zzz + u_xlat23.xyz;
					            u_xlat23.xyz = unity_WorldToLight[3].xyz * u_xlat11.www + u_xlat23.xyz;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD5.xyz = u_xlat23.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xyz = u_xlat8.yyy * unity_WorldToLight[1].xyz;
					        u_xlat19.xyz = unity_WorldToLight[0].xyz * u_xlat8.xxx + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[2].xyz * u_xlat8.zzz + u_xlat19.xyz;
					        u_xlat19.xyz = unity_WorldToLight[3].xyz * u_xlat8.www + u_xlat19.xyz;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD4 = u_xlat9.z;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD5.xyz = u_xlat19.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec3 u_xlat19;
					vec3 u_xlat23;
					vec2 u_xlat30;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					int u_xlati47;
					float u_xlat48;
					int u_xlati48;
					float u_xlat49;
					bool u_xlatb49;
					float u_xlat51;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out float gs_TEXCOORD4;
					out vec2 gs_TEXCOORD0;
					out vec2 gs_TEXCOORD5;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat30.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat30.x = sqrt(u_xlat30.x);
					    u_xlat30.x = u_xlat30.x + (-_MinDist);
					    u_xlat30.x = u_xlat30.x / _MaxDist;
					    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
					    u_xlat45 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat46 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat45);
					    u_xlat47 = sin(u_xlat3.x);
					    u_xlat46 = u_xlat46 + u_xlat47;
					    u_xlat45 = u_xlat45 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat45 = sin(u_xlat45);
					    u_xlat4.x = u_xlat45 + u_xlat46;
					    u_xlat45 = cos(u_xlat3.z);
					    u_xlat46 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat45 + u_xlat46;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat30.y = u_xlat45 / _Radius;
					    u_xlat30.y = clamp(u_xlat30.y, 0.0, 1.0);
					    u_xlat30.xy = (-u_xlat30.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat30.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat45 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat30.y = sin(u_xlat45);
					    u_xlat30.xy = u_xlat30.xy * vec2(4.0, 43758.5469);
					    u_xlat45 = fract(u_xlat30.y);
					    u_xlat46 = (-_RandomHeight) + 1.0;
					    u_xlat47 = _RandomHeight + 1.0;
					    u_xlat46 = max(u_xlat45, u_xlat46);
					    u_xlat46 = min(u_xlat47, u_xlat46);
					    u_xlat0.x = u_xlat46 * u_xlat5.x;
					    u_xlat46 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati47 = 0;
					    while(true){
					        u_xlat48 = float(u_xlati47);
					        u_xlatb49 = u_xlat48>=u_xlat30.x;
					        if(u_xlatb49){break;}
					        u_xlat49 = u_xlat45 * 6.28318548 + u_xlat48;
					        u_xlat8.x = sin(u_xlat49);
					        u_xlat9.x = cos(u_xlat49);
					        u_xlat49 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat49 * -0.100000001;
					        u_xlat10.z = u_xlat49 * 0.0100000007 + u_xlat9.x;
					        u_xlat48 = (-u_xlat48) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat48 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat49 = float(u_xlati_loop_1);
					            u_xlat51 = u_xlat49 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat51;
					            u_xlat49 = (-u_xlat49) * 0.200000003 + 1.0;
					            u_xlat49 = u_xlat49 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat49 : u_xlat46;
					            u_xlat49 = log2(u_xlat51);
					            u_xlat49 = u_xlat49 * _BladeCurve;
					            u_xlat49 = exp2(u_xlat49);
					            u_xlat11.z = u_xlat0.y * u_xlat49;
					            u_xlat23.xyz = u_xlat5.xzw * vec3(u_xlat51) + gl_in[0].gl_Position.xyz;
					            u_xlat23.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat23.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat23.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat13 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xy = u_xlat12.yy * unity_WorldToLight[1].xy;
					            u_xlat12.xy = unity_WorldToLight[0].xy * u_xlat12.xx + u_xlat14.xy;
					            u_xlat12.xy = unity_WorldToLight[2].xy * u_xlat12.zz + u_xlat12.xy;
					            u_xlat12.xy = unity_WorldToLight[3].xy * u_xlat12.ww + u_xlat12.xy;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD4 = u_xlat13.z;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD5.xy = u_xlat12.xy;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat23.xyz = u_xlat23.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat23.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat23.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat23.zzzz + u_xlat11;
					            u_xlat12 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            u_xlat23.xy = u_xlat11.yy * unity_WorldToLight[1].xy;
					            u_xlat23.xy = unity_WorldToLight[0].xy * u_xlat11.xx + u_xlat23.xy;
					            u_xlat23.xy = unity_WorldToLight[2].xy * u_xlat11.zz + u_xlat23.xy;
					            u_xlat23.xy = unity_WorldToLight[3].xy * u_xlat11.ww + u_xlat23.xy;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD4 = u_xlat12.z;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat51;
					            gs_TEXCOORD5.xy = u_xlat23.xy;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat19.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat19.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat19.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat19.zzzz + u_xlat8;
					        u_xlat9 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat10 = u_xlat9.yyyy * unity_MatrixVP[1];
					        u_xlat10 = unity_MatrixVP[0] * u_xlat9.xxxx + u_xlat10;
					        u_xlat10 = unity_MatrixVP[2] * u_xlat9.zzzz + u_xlat10;
					        u_xlat9 = unity_MatrixVP[3] * u_xlat9.wwww + u_xlat10;
					        u_xlat19.xy = u_xlat8.yy * unity_WorldToLight[1].xy;
					        u_xlat19.xy = unity_WorldToLight[0].xy * u_xlat8.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_WorldToLight[2].xy * u_xlat8.zz + u_xlat19.xy;
					        u_xlat19.xy = unity_WorldToLight[3].xy * u_xlat8.ww + u_xlat19.xy;
					        gl_Position = u_xlat9;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD4 = u_xlat9.z;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_TEXCOORD5.xy = u_xlat19.xy;
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati47 = u_xlati47 + 1;
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			Tags { "LIGHTMODE" = "SHADOWCASTER" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 167943
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec3 vs_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_COLOR0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0.xyz = in_COLOR0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
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
			Program "gp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec4 u_xlat11;
					vec4 u_xlat12;
					vec4 u_xlat13;
					vec3 u_xlat18;
					vec3 u_xlat22;
					vec2 u_xlat28;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					int u_xlati44;
					float u_xlat45;
					int u_xlati45;
					float u_xlat46;
					bool u_xlatb46;
					float u_xlat48;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat28.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28.x = sqrt(u_xlat28.x);
					    u_xlat28.x = u_xlat28.x + (-_MinDist);
					    u_xlat28.x = u_xlat28.x / _MaxDist;
					    u_xlat28.x = clamp(u_xlat28.x, 0.0, 1.0);
					    u_xlat42 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat43 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat42);
					    u_xlat44 = sin(u_xlat3.x);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat42 = u_xlat42 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat42 = sin(u_xlat42);
					    u_xlat4.x = u_xlat42 + u_xlat43;
					    u_xlat42 = cos(u_xlat3.z);
					    u_xlat43 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat42 + u_xlat43;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat28.y = u_xlat42 / _Radius;
					    u_xlat28.y = clamp(u_xlat28.y, 0.0, 1.0);
					    u_xlat28.xy = (-u_xlat28.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat28.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat42 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat28.y = sin(u_xlat42);
					    u_xlat28.xy = u_xlat28.xy * vec2(4.0, 43758.5469);
					    u_xlat42 = fract(u_xlat28.y);
					    u_xlat43 = (-_RandomHeight) + 1.0;
					    u_xlat44 = _RandomHeight + 1.0;
					    u_xlat43 = max(u_xlat42, u_xlat43);
					    u_xlat43 = min(u_xlat44, u_xlat43);
					    u_xlat0.x = u_xlat43 * u_xlat5.x;
					    u_xlat43 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlati44 = 0;
					    while(true){
					        u_xlat45 = float(u_xlati44);
					        u_xlatb46 = u_xlat45>=u_xlat28.x;
					        if(u_xlatb46){break;}
					        u_xlat46 = u_xlat42 * 6.28318548 + u_xlat45;
					        u_xlat8.x = sin(u_xlat46);
					        u_xlat9.x = cos(u_xlat46);
					        u_xlat46 = (-u_xlat9.x) + 1.0;
					        u_xlat7.x = u_xlat8.x * -0.100000001;
					        u_xlat10.x = (-u_xlat8.x);
					        u_xlat7.y = u_xlat46 * -0.100000001;
					        u_xlat10.z = u_xlat46 * 0.0100000007 + u_xlat9.x;
					        u_xlat45 = (-u_xlat45) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat45 * _Rad;
					        u_xlat9.yz = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat10.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat46 = float(u_xlati_loop_1);
					            u_xlat48 = u_xlat46 * 0.200000003;
					            u_xlat11.y = u_xlat0.x * u_xlat48;
					            u_xlat46 = (-u_xlat46) * 0.200000003 + 1.0;
					            u_xlat46 = u_xlat46 * u_xlat5.y;
					            u_xlat11.x = (u_xlati_loop_1 != 0) ? u_xlat46 : u_xlat43;
					            u_xlat46 = log2(u_xlat48);
					            u_xlat46 = u_xlat46 * _BladeCurve;
					            u_xlat46 = exp2(u_xlat46);
					            u_xlat11.z = u_xlat0.y * u_xlat46;
					            u_xlat22.xyz = u_xlat5.xzw * vec3(u_xlat48) + gl_in[0].gl_Position.xyz;
					            u_xlat22.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat22.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat12.xyz = u_xlat6.yyx + u_xlat11.xyz;
					            u_xlat13.x = dot(u_xlat9.xyz, u_xlat12.xyz);
					            u_xlat13.y = dot(u_xlat7.xwy, u_xlat12.xyz);
					            u_xlat13.z = dot(u_xlat10.xyz, u_xlat12.xyz);
					            u_xlat12.xyz = u_xlat22.xyz + u_xlat13.xyz;
					            u_xlat13 = u_xlat12.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat12 = unity_ObjectToWorld[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = u_xlat12 + unity_ObjectToWorld[3];
					            u_xlat13 = u_xlat12.yyyy * unity_MatrixVP[1];
					            u_xlat13 = unity_MatrixVP[0] * u_xlat12.xxxx + u_xlat13;
					            u_xlat13 = unity_MatrixVP[2] * u_xlat12.zzzz + u_xlat13;
					            u_xlat12 = unity_MatrixVP[3] * u_xlat12.wwww + u_xlat13;
					            gl_Position = u_xlat12;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					            u_xlat11.w = (-u_xlat11.x);
					            u_xlat11.xyz = u_xlat6.yyx + u_xlat11.wyz;
					            u_xlat12.x = dot(u_xlat9.xyz, u_xlat11.xyz);
					            u_xlat12.y = dot(u_xlat7.xwy, u_xlat11.xyz);
					            u_xlat12.z = dot(u_xlat10.xyz, u_xlat11.xyz);
					            u_xlat22.xyz = u_xlat22.xyz + u_xlat12.xyz;
					            u_xlat11 = u_xlat22.yyyy * unity_ObjectToWorld[1];
					            u_xlat11 = unity_ObjectToWorld[0] * u_xlat22.xxxx + u_xlat11;
					            u_xlat11 = unity_ObjectToWorld[2] * u_xlat22.zzzz + u_xlat11;
					            u_xlat11 = u_xlat11 + unity_ObjectToWorld[3];
					            u_xlat12 = u_xlat11.yyyy * unity_MatrixVP[1];
					            u_xlat12 = unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat12;
					            u_xlat12 = unity_MatrixVP[2] * u_xlat11.zzzz + u_xlat12;
					            u_xlat11 = unity_MatrixVP[3] * u_xlat11.wwww + u_xlat12;
					            gl_Position = u_xlat11;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat48;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat8.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat10.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat18.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat8 = u_xlat18.yyyy * unity_ObjectToWorld[1];
					        u_xlat8 = unity_ObjectToWorld[0] * u_xlat18.xxxx + u_xlat8;
					        u_xlat8 = unity_ObjectToWorld[2] * u_xlat18.zzzz + u_xlat8;
					        u_xlat8 = u_xlat8 + unity_ObjectToWorld[3];
					        u_xlat9 = u_xlat8.yyyy * unity_MatrixVP[1];
					        u_xlat9 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat9;
					        u_xlat9 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat9;
					        u_xlat8 = unity_MatrixVP[3] * u_xlat8.wwww + u_xlat9;
					        gl_Position = u_xlat8;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati44 = u_xlati44 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_SHADOWS_SCREEN" }
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[4];
						float _GrassHeight;
						float _GrassWidth;
						float _WindSpeed;
						float _WindStrength;
						float _Radius;
						float _Strength;
						float _Rad;
						float _RandomHeight;
						float _BladeForward;
						float _BladeCurve;
						float _MinDist;
						float _MaxDist;
						vec3 _PositionMoving;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec3 vs_NORMAL0 [1];
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_COLOR0 [1];
					vec2 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					vec4 u_xlat13;
					vec4 u_xlat14;
					vec4 u_xlat15;
					vec3 u_xlat20;
					vec3 u_xlat26;
					vec2 u_xlat32;
					float u_xlat48;
					float u_xlat49;
					float u_xlat50;
					int u_xlati50;
					float u_xlat51;
					int u_xlati51;
					float u_xlat52;
					bool u_xlatb52;
					float u_xlat54;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec3 gs_COLOR0;
					out vec3 gs_TEXCOORD3;
					out vec4 gs_TEXCOORD6;
					layout(max_vertices = 51) out;
					void main()
					{
					    u_xlat0.x = dot(gl_in[0].gl_Position.yyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 43758.5469;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.y = u_xlat0.x * _BladeForward;
					    u_xlat1.xyz = vec3(1.0, 0.0, 0.0) * vs_NORMAL0[0].yzx;
					    u_xlat1.xyz = vs_NORMAL0[0].zxy * vec3(0.0, 1.0, 0.0) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat32.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat32.x = sqrt(u_xlat32.x);
					    u_xlat32.x = u_xlat32.x + (-_MinDist);
					    u_xlat32.x = u_xlat32.x / _MaxDist;
					    u_xlat32.x = clamp(u_xlat32.x, 0.0, 1.0);
					    u_xlat48 = _WindSpeed * _Time.x;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_WindSpeed, _WindSpeed)) + gl_in[0].gl_Position.xz;
					    u_xlat49 = sin(u_xlat3.x);
					    u_xlat3.xz = gl_in[0].gl_Position.zx * vec2(2.0, 2.0) + vec2(u_xlat48);
					    u_xlat50 = sin(u_xlat3.x);
					    u_xlat49 = u_xlat49 + u_xlat50;
					    u_xlat48 = u_xlat48 * 0.100000001 + gl_in[0].gl_Position.x;
					    u_xlat48 = sin(u_xlat48);
					    u_xlat4.x = u_xlat48 + u_xlat49;
					    u_xlat48 = cos(u_xlat3.z);
					    u_xlat49 = cos(u_xlat3.y);
					    u_xlat4.z = u_xlat48 + u_xlat49;
					    u_xlat4.y = 0.0;
					    u_xlat3.xyz = (-u_xlat2.xyz) + _PositionMoving.xyz;
					    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat48 = sqrt(u_xlat48);
					    u_xlat32.y = u_xlat48 / _Radius;
					    u_xlat32.y = clamp(u_xlat32.y, 0.0, 1.0);
					    u_xlat32.xy = (-u_xlat32.xy) + vec2(1.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xyz + (-_PositionMoving.xyz);
					    u_xlat3.xyz = u_xlat32.yyy * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Strength, _Strength, _Strength));
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(-0.800000012, -0.800000012, -0.800000012));
					    u_xlat3.xyz = min(u_xlat3.xyz, vec3(0.800000012, 0.800000012, 0.800000012));
					    u_xlat5.xy = vec2(_GrassHeight, _GrassWidth) * vs_TEXCOORD0[0].yx;
					    u_xlat48 = dot(gl_in[0].gl_Position.xyz, vec3(12.9898005, 78.2330017, 53.5390015));
					    u_xlat32.y = sin(u_xlat48);
					    u_xlat32.xy = u_xlat32.xy * vec2(4.0, 43758.5469);
					    u_xlat48 = fract(u_xlat32.y);
					    u_xlat49 = (-_RandomHeight) + 1.0;
					    u_xlat50 = _RandomHeight + 1.0;
					    u_xlat49 = max(u_xlat48, u_xlat49);
					    u_xlat49 = min(u_xlat50, u_xlat49);
					    u_xlat0.x = u_xlat49 * u_xlat5.x;
					    u_xlat49 = u_xlat5.y * 0.300000012;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.5, 1.0, 1.5) + gl_in[0].gl_Position.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * vec3(vec3(_WindStrength, _WindStrength, _WindStrength)) + u_xlat3.xyz;
					    u_xlat4.x = 1.0;
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat7.w = 1.0;
					    u_xlat8.x = float(0.5);
					    u_xlat8.z = float(0.5);
					    u_xlat8.y = _ProjectionParams.x;
					    u_xlat9.x = float(0.5);
					    u_xlat9.z = float(0.5);
					    u_xlat9.y = _ProjectionParams.x;
					    u_xlati50 = 0;
					    while(true){
					        u_xlat51 = float(u_xlati50);
					        u_xlatb52 = u_xlat51>=u_xlat32.x;
					        if(u_xlatb52){break;}
					        u_xlat52 = u_xlat48 * 6.28318548 + u_xlat51;
					        u_xlat10.x = sin(u_xlat52);
					        u_xlat11.x = cos(u_xlat52);
					        u_xlat52 = (-u_xlat11.x) + 1.0;
					        u_xlat7.x = u_xlat10.x * -0.100000001;
					        u_xlat12.x = (-u_xlat10.x);
					        u_xlat7.y = u_xlat52 * -0.100000001;
					        u_xlat12.z = u_xlat52 * 0.0100000007 + u_xlat11.x;
					        u_xlat51 = (-u_xlat51) * 0.25 + 1.0;
					        u_xlat6.x = u_xlat51 * _Rad;
					        u_xlat11.yz = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat12.y = u_xlat7.y;
					        for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<5 ; u_xlati_loop_1++)
					        {
					            u_xlat52 = float(u_xlati_loop_1);
					            u_xlat54 = u_xlat52 * 0.200000003;
					            u_xlat13.y = u_xlat0.x * u_xlat54;
					            u_xlat52 = (-u_xlat52) * 0.200000003 + 1.0;
					            u_xlat52 = u_xlat52 * u_xlat5.y;
					            u_xlat13.x = (u_xlati_loop_1 != 0) ? u_xlat52 : u_xlat49;
					            u_xlat52 = log2(u_xlat54);
					            u_xlat52 = u_xlat52 * _BladeCurve;
					            u_xlat52 = exp2(u_xlat52);
					            u_xlat13.z = u_xlat0.y * u_xlat52;
					            u_xlat26.xyz = u_xlat5.xzw * vec3(u_xlat54) + gl_in[0].gl_Position.xyz;
					            u_xlat26.xyz = (int(u_xlati_loop_1) != 0) ? u_xlat26.xyz : gl_in[0].gl_Position.xyz;
					            u_xlat14.xyz = u_xlat6.yyx + u_xlat13.xyz;
					            u_xlat15.x = dot(u_xlat11.xyz, u_xlat14.xyz);
					            u_xlat15.y = dot(u_xlat7.xwy, u_xlat14.xyz);
					            u_xlat15.z = dot(u_xlat12.xyz, u_xlat14.xyz);
					            u_xlat14.xyz = u_xlat26.xyz + u_xlat15.xyz;
					            u_xlat15 = u_xlat14.yyyy * unity_ObjectToWorld[1];
					            u_xlat15 = unity_ObjectToWorld[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat14 = unity_ObjectToWorld[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = u_xlat14 + unity_ObjectToWorld[3];
					            u_xlat15 = u_xlat14.yyyy * unity_MatrixVP[1];
					            u_xlat15 = unity_MatrixVP[0] * u_xlat14.xxxx + u_xlat15;
					            u_xlat15 = unity_MatrixVP[2] * u_xlat14.zzzz + u_xlat15;
					            u_xlat14 = unity_MatrixVP[3] * u_xlat14.wwww + u_xlat15;
					            u_xlat15.xyz = u_xlat8.zyz * u_xlat14.xyw;
					            u_xlat15.w = u_xlat15.y * 0.5;
					            u_xlat15.xy = u_xlat15.zz + u_xlat15.xw;
					            gl_Position = u_xlat14;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 0.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat15.xy;
					            gs_TEXCOORD6.zw = u_xlat14.zw;
					            EmitVertex();
					            u_xlat13.w = (-u_xlat13.x);
					            u_xlat13.xyz = u_xlat6.yyx + u_xlat13.wyz;
					            u_xlat14.x = dot(u_xlat11.xyz, u_xlat13.xyz);
					            u_xlat14.y = dot(u_xlat7.xwy, u_xlat13.xyz);
					            u_xlat14.z = dot(u_xlat12.xyz, u_xlat13.xyz);
					            u_xlat26.xyz = u_xlat26.xyz + u_xlat14.xyz;
					            u_xlat13 = u_xlat26.yyyy * unity_ObjectToWorld[1];
					            u_xlat13 = unity_ObjectToWorld[0] * u_xlat26.xxxx + u_xlat13;
					            u_xlat13 = unity_ObjectToWorld[2] * u_xlat26.zzzz + u_xlat13;
					            u_xlat13 = u_xlat13 + unity_ObjectToWorld[3];
					            u_xlat14 = u_xlat13.yyyy * unity_MatrixVP[1];
					            u_xlat14 = unity_MatrixVP[0] * u_xlat13.xxxx + u_xlat14;
					            u_xlat14 = unity_MatrixVP[2] * u_xlat13.zzzz + u_xlat14;
					            u_xlat13 = unity_MatrixVP[3] * u_xlat13.wwww + u_xlat14;
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat13.xyw;
					            u_xlat14.w = u_xlat14.y * 0.5;
					            u_xlat26.xy = u_xlat14.zz + u_xlat14.xw;
					            gl_Position = u_xlat13;
					            gs_NORMAL0.xyz = u_xlat1.xyz;
					            gs_TEXCOORD0.x = 1.0;
					            gs_TEXCOORD0.y = u_xlat54;
					            gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					            gs_TEXCOORD3.xyz = u_xlat2.xyz;
					            gs_TEXCOORD6.xy = u_xlat26.xy;
					            gs_TEXCOORD6.zw = u_xlat13.zw;
					            EmitVertex();
					        }
					        u_xlat6.xw = u_xlat0.xy + u_xlat6.zx;
					        u_xlat7.xy = u_xlat10.xx * vec2(0.100000001, 1.0);
					        u_xlat7.x = dot(u_xlat7.xy, u_xlat6.xw);
					        u_xlat4.yz = u_xlat12.yz;
					        u_xlat7.y = dot(u_xlat4.xy, u_xlat6.xw);
					        u_xlat7.z = dot(u_xlat4.yz, u_xlat6.xw);
					        u_xlat20.xyz = u_xlat3.xyz + u_xlat7.xyz;
					        u_xlat10 = u_xlat20.yyyy * unity_ObjectToWorld[1];
					        u_xlat10 = unity_ObjectToWorld[0] * u_xlat20.xxxx + u_xlat10;
					        u_xlat10 = unity_ObjectToWorld[2] * u_xlat20.zzzz + u_xlat10;
					        u_xlat10 = u_xlat10 + unity_ObjectToWorld[3];
					        u_xlat11 = u_xlat10.yyyy * unity_MatrixVP[1];
					        u_xlat11 = unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat11;
					        u_xlat11 = unity_MatrixVP[2] * u_xlat10.zzzz + u_xlat11;
					        u_xlat10 = unity_MatrixVP[3] * u_xlat10.wwww + u_xlat11;
					        u_xlat11.xyz = u_xlat9.xyz * u_xlat10.xyw;
					        u_xlat11.w = u_xlat11.y * 0.5;
					        u_xlat20.xy = u_xlat11.zz + u_xlat11.xw;
					        gl_Position = u_xlat10;
					        gs_NORMAL0.xyz = u_xlat1.xyz;
					        gs_TEXCOORD0.xy = vec2(0.5, 1.0);
					        gs_COLOR0.xyz = vs_COLOR0[0].xyz;
					        gs_TEXCOORD3.xyz = u_xlat2.xyz;
					        gs_TEXCOORD6.xy = u_xlat20.xy;
					        gs_TEXCOORD6.zw = u_xlat10.zw;
					        EmitVertex();
					        EndPrimitive();
					        u_xlati50 = u_xlati50 + 1;
					    }
					    return;
					}"
				}
			}
		}
	}
	Fallback "VertexLit"
}