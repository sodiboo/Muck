Shader "Custom/Terrain" {
	Properties {
		testTexture ("Texture", 2D) = "white" {}
		testScale ("Scale", Float) = 1
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 61403
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_0_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
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
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
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
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_0_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
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
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD3 = u_xlat0.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
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
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat13;
					float u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					int u_xlati35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat2.x;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat36) + u_xlat4.x;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat4.x / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat4.xyz;
					    }
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb34)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat34, u_xlat13);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat34 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat2.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat34 = u_xlat5.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat7.xyz = vec3(u_xlat35) * u_xlat2.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat35 = min(u_xlat8.z, u_xlat35);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat7.xyz * vec3(u_xlat35) + u_xlat8.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat35 = u_xlat2.w + -1.0;
					        u_xlat35 = unity_SpecCube1_HDR.w * u_xlat35 + 1.0;
					        u_xlat35 = u_xlat35 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + (-u_xlat2.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat2.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat2.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat12 = u_xlat22 * u_xlat22;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat22 = u_xlat22 * u_xlat12;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat12 = -abs(u_xlat33) + 1.0;
					    u_xlat23 = u_xlat12 * u_xlat12;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat12 = u_xlat12 * u_xlat23;
					    u_xlat11.x = u_xlat11.x * u_xlat12 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = abs(u_xlat33) + u_xlat1.x;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = u_xlat1.xx * u_xlat11.xy;
					    u_xlat1.xzw = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat11.xyz = u_xlat4.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat33 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xzw * vec3(u_xlat33) + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
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
					vec3 u_xlat14;
					float u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					int u_xlati38;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat37 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat37 = u_xlat37 / u_xlat2.x;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat39 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat37 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat39) + u_xlat4.x;
					        u_xlat39 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat39);
					        u_xlat39 = u_xlat4.x / u_xlat39;
					        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat40 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat40 = (-u_xlat39) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat40) + u_xlat4.xyz;
					    }
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat14.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat14.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat39 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat14.x, u_xlat39);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat14.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD0.xyz * (-u_xlat14.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat39 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat2.x);
					        u_xlat5.x = min(u_xlat39, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD0.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat8.xyz = u_xlat2.xxx * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat9.y, u_xlat9.x);
					            u_xlat2.x = min(u_xlat9.z, u_xlat2.x);
					            u_xlat9.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat2.xxx + u_xlat9.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat38 = u_xlat2.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat2.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat2.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat2.xyz = vec3(u_xlat37) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat24 = u_xlat24 * 0.999999881;
					    u_xlat24 = max(u_xlat24, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat36 = u_xlat13 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					int u_xlati35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat2.x;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat36) + u_xlat4.x;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat4.x / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
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
					    u_xlat13.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat4.x);
					    u_xlat34 = u_xlat34 * u_xlat2.x + u_xlat4.x;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat2.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat34 = u_xlat5.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat7.xyz = vec3(u_xlat35) * u_xlat2.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat35 = min(u_xlat8.z, u_xlat35);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat7.xyz * vec3(u_xlat35) + u_xlat8.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat35 = u_xlat2.w + -1.0;
					        u_xlat35 = unity_SpecCube1_HDR.w * u_xlat35 + 1.0;
					        u_xlat35 = u_xlat35 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + (-u_xlat2.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat2.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat2.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat12 = u_xlat22 * u_xlat22;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat22 = u_xlat22 * u_xlat12;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat12 = -abs(u_xlat33) + 1.0;
					    u_xlat23 = u_xlat12 * u_xlat12;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat12 = u_xlat12 * u_xlat23;
					    u_xlat11.x = u_xlat11.x * u_xlat12 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = abs(u_xlat33) + u_xlat1.x;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = u_xlat1.xx * u_xlat11.xy;
					    u_xlat1.xzw = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat11.xyz = u_xlat4.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat33 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xzw * vec3(u_xlat33) + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
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
					vec3 u_xlat14;
					bool u_xlatb14;
					float u_xlat24;
					float u_xlat25;
					vec2 u_xlat26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					int u_xlati38;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat37 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat37 = u_xlat37 / u_xlat2.x;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat39 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat37 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat39) + u_xlat4.x;
					        u_xlat39 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat39);
					        u_xlat39 = u_xlat4.x / u_xlat39;
					        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat40 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat40 = (-u_xlat39) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat40) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat37) + u_xlat2.x;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb14 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb14)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat14.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat26.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat26.x, u_xlat14.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat14.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
					    u_xlat26.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat26.xy);
					    u_xlat14.x = u_xlat14.x + (-u_xlat4.x);
					    u_xlat37 = u_xlat37 * u_xlat14.x + u_xlat4.x;
					    u_xlat14.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD0.xyz * (-u_xlat14.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    if(u_xlatb2){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat39 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat2.x);
					        u_xlat5.x = min(u_xlat39, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD0.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat8.xyz = u_xlat2.xxx * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat9.y, u_xlat9.x);
					            u_xlat2.x = min(u_xlat9.z, u_xlat2.x);
					            u_xlat9.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat2.xxx + u_xlat9.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat38 = u_xlat2.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat2.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat2.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat2.xyz = vec3(u_xlat37) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat24 = u_xlat24 * 0.999999881;
					    u_xlat24 = max(u_xlat24, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat36 = u_xlat13 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					float u_xlat13;
					float u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					int u_xlati35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat2.x;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat36) + u_xlat4.x;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat4.x / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat4.xyz;
					    }
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb34)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat34, u_xlat13);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat34 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat2.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat34 = u_xlat5.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat7.xyz = vec3(u_xlat35) * u_xlat2.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat35 = min(u_xlat8.z, u_xlat35);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat7.xyz * vec3(u_xlat35) + u_xlat8.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat35 = u_xlat2.w + -1.0;
					        u_xlat35 = unity_SpecCube1_HDR.w * u_xlat35 + 1.0;
					        u_xlat35 = u_xlat35 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + (-u_xlat2.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat2.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat2.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat12 = u_xlat22 * u_xlat22;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat22 = u_xlat22 * u_xlat12;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat12 = -abs(u_xlat33) + 1.0;
					    u_xlat23 = u_xlat12 * u_xlat12;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat12 = u_xlat12 * u_xlat23;
					    u_xlat11.x = u_xlat11.x * u_xlat12 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = abs(u_xlat33) + u_xlat1.x;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = u_xlat1.xx * u_xlat11.xy;
					    u_xlat1.xzw = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat11.xyz = u_xlat4.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat33 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat33) + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD3 / _ProjectionParams.y;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
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
					vec3 u_xlat14;
					float u_xlat24;
					float u_xlat25;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					int u_xlati38;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat37 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat37 = u_xlat37 / u_xlat2.x;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat39 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat37 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat39) + u_xlat4.x;
					        u_xlat39 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat39);
					        u_xlat39 = u_xlat4.x / u_xlat39;
					        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat40 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat40 = (-u_xlat39) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat40) + u_xlat4.xyz;
					    }
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat14.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat14.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat39 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat14.x, u_xlat39);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat14.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD0.xyz * (-u_xlat14.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat39 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat2.x);
					        u_xlat5.x = min(u_xlat39, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD0.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat8.xyz = u_xlat2.xxx * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat9.y, u_xlat9.x);
					            u_xlat2.x = min(u_xlat9.z, u_xlat2.x);
					            u_xlat9.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat2.xxx + u_xlat9.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat38 = u_xlat2.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat2.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat2.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat2.xyz = vec3(u_xlat37) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat24 = u_xlat24 * 0.999999881;
					    u_xlat24 = max(u_xlat24, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat36 = u_xlat13 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD3 / _ProjectionParams.y;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat23;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					int u_xlati35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat2.x;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat36) + u_xlat4.x;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat4.x / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
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
					    u_xlat13.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat4.x);
					    u_xlat34 = u_xlat34 * u_xlat2.x + u_xlat4.x;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat2.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat34 = u_xlat5.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat7.xyz = vec3(u_xlat35) * u_xlat2.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat35 = min(u_xlat8.z, u_xlat35);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat7.xyz * vec3(u_xlat35) + u_xlat8.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat35 = u_xlat2.w + -1.0;
					        u_xlat35 = unity_SpecCube1_HDR.w * u_xlat35 + 1.0;
					        u_xlat35 = u_xlat35 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + (-u_xlat2.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat2.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat2.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat12 = u_xlat22 * u_xlat22;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat22 = u_xlat22 * u_xlat12;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat12 = -abs(u_xlat33) + 1.0;
					    u_xlat23 = u_xlat12 * u_xlat12;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat12 = u_xlat12 * u_xlat23;
					    u_xlat11.x = u_xlat11.x * u_xlat12 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = abs(u_xlat33) + u_xlat1.x;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = u_xlat1.xx * u_xlat11.xy;
					    u_xlat1.xzw = u_xlat11.xxx * u_xlat4.xyz;
					    u_xlat11.xyz = u_xlat4.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat33 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat33) + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD3 / _ProjectionParams.y;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
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
					vec3 u_xlat14;
					bool u_xlatb14;
					float u_xlat24;
					float u_xlat25;
					vec2 u_xlat26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					float u_xlat38;
					int u_xlati38;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat37 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat37 = u_xlat37 / u_xlat2.x;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat39 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat37 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat39) + u_xlat4.x;
					        u_xlat39 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat39);
					        u_xlat39 = u_xlat4.x / u_xlat39;
					        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat40 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat40 = (-u_xlat39) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat40) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat37) + u_xlat2.x;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb14 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb14)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat14.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat26.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat26.x, u_xlat14.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat14.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
					    u_xlat26.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat26.xy);
					    u_xlat14.x = u_xlat14.x + (-u_xlat4.x);
					    u_xlat37 = u_xlat37 * u_xlat14.x + u_xlat4.x;
					    u_xlat14.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD0.xyz * (-u_xlat14.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    if(u_xlatb2){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat39 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat2.x);
					        u_xlat5.x = min(u_xlat39, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD0.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat8.xyz = u_xlat2.xxx * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat9.y, u_xlat9.x);
					            u_xlat2.x = min(u_xlat9.z, u_xlat2.x);
					            u_xlat9.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * u_xlat2.xxx + u_xlat9.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat38 = u_xlat2.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat2.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat2.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat2.xyz = vec3(u_xlat37) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat24 = u_xlat24 * 0.999999881;
					    u_xlat24 = max(u_xlat24, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat4.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat36 = u_xlat13 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD3 / _ProjectionParams.y;
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
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 98921
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    vs_TEXCOORD0.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    vs_TEXCOORD0.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_2[41];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat26));
					    u_xlat25 = u_xlat25 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb22)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat22, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					bool u_xlatb26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = 0.0<u_xlat3.z;
					    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat26 = u_xlat26 * u_xlat5.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat26 = u_xlat26 * u_xlat3.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat26 = u_xlat3.w * u_xlat5.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat22 = u_xlat22 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD1.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD1.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD1.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat11.xyz = u_xlat6.xyz / u_xlat6.www;
					    vec3 txVec0 = vec3(u_xlat11.xy,u_xlat11.z);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlatb2 = 0.0<u_xlat4.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat11.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat11.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat11.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat4.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_7[7];
						float baseStartHeights[8];
						vec4 unused_0_9[7];
						float baseBlends[8];
						vec4 unused_0_11[7];
						float baseColourStrength[8];
						vec4 unused_0_13[7];
						float baseTextureScales[8];
						vec4 unused_0_15[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
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
					float u_xlat34;
					float u_xlat35;
					int u_xlati35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat35 = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat35;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat35 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat35 = u_xlat35 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat35);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat37 = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat37 = (-u_xlat36) + u_xlat37;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat37 / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat6.xyz;
					    }
					    u_xlat4 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
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
					        u_xlat6 = vs_TEXCOORD1.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD1.xxxx + u_xlat6;
					        u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD1.zzzz + u_xlat6;
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
					    u_xlatb2 = 0.0<u_xlat4.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat13.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat13.xy = u_xlat13.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat13.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat13.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat4.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat4.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat34) + 1.0;
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
					    u_xlat22 = abs(u_xlat33) + u_xlat34;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = vec2(u_xlat34) * u_xlat11.xy;
					    u_xlat1.xyz = u_xlat11.xxx * u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat2.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
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
					float u_xlat15;
					float u_xlat21;
					float u_xlat22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD1.xyz;
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
					    u_xlat9.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat9.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat4.x);
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat4.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat21;
					float u_xlat22;
					float u_xlat23;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat16 = (-u_xlat22) + u_xlat16;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat16 + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
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
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat23, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat16 = u_xlat16 + (-u_xlat4.x);
					    u_xlat22 = u_xlat22 * u_xlat16 + u_xlat4.x;
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat22 = u_xlat22 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					    u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					    u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					    u_xlat30 = max(u_xlat30, 9.99999975e-06);
					    u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					    u_xlat30 = _LightProjectionParams.y / u_xlat30;
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    vec4 txVec0 = vec4(u_xlat11.xyz,u_xlat30);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb11 = u_xlat28<0.99000001;
					    if(u_xlatb11){
					        u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					        u_xlat30 = max(u_xlat30, 9.99999975e-06);
					        u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					        u_xlat30 = _LightProjectionParams.y / u_xlat30;
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					        u_xlat30 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = u_xlat11.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat30);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat11.xyz = u_xlat11.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat11.xyz,u_xlat30);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat11.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat20 = (-_LightShadowData.x) + 1.0;
					        u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    } else {
					        u_xlat11.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					    u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					    u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					    u_xlat30 = max(u_xlat30, 9.99999975e-06);
					    u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					    u_xlat30 = _LightProjectionParams.y / u_xlat30;
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    vec4 txVec0 = vec4(u_xlat11.xyz,u_xlat30);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat4.w;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb11 = u_xlat28<0.99000001;
					    if(u_xlatb11){
					        u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					        u_xlat30 = max(u_xlat30, 9.99999975e-06);
					        u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					        u_xlat30 = _LightProjectionParams.y / u_xlat30;
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					        u_xlat30 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = u_xlat11.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat30);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat11.xyz = u_xlat11.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat11.xyz,u_xlat30);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat11.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat20 = (-_LightShadowData.x) + 1.0;
					        u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    } else {
					        u_xlat11.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat4.w;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat26));
					    u_xlat25 = u_xlat25 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb22)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat22, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					bool u_xlatb26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = 0.0<u_xlat3.z;
					    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat26 = u_xlat26 * u_xlat5.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat26 = u_xlat26 * u_xlat3.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					int u_xlati26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat25 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat26 = (-minHeight) + maxHeight;
					    u_xlat25 = u_xlat25 / u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat26 = u_xlat26 + abs(vs_TEXCOORD0.z);
					    u_xlat3.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat26);
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat27 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat28 = u_xlat25 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat28 = (-u_xlat27) + u_xlat28;
					        u_xlat27 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat27);
					        u_xlat27 = u_xlat28 / u_xlat27;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat5.w = float(u_xlati_loop_1);
					        u_xlat6 = texture(baseTextures, u_xlat5.yzw);
					        u_xlat7 = texture(baseTextures, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat3.yyy * u_xlat7.xyz;
					        u_xlat5 = texture(baseTextures, u_xlat5.xyw);
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx + u_xlat7.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat6.xyz;
					        u_xlat28 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
					        u_xlat28 = (-u_xlat27) + 1.0;
					        u_xlat5.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat5.xyz;
					        u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat5.xyz;
					    }
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb25)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat25, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat26 = u_xlat3.w * u_xlat5.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat3.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat25 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
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
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat16 = u_xlat16 * 0.999999881;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat22 = u_xlat22 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD1.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD1.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD1.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat11.xyz = u_xlat6.xyz / u_xlat6.www;
					    vec3 txVec0 = vec3(u_xlat11.xy,u_xlat11.z);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlatb2 = 0.0<u_xlat4.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat11.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat11.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat11.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat4.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.x;
					    u_xlat27 = u_xlat27 * (-u_xlat27);
					    u_xlat27 = exp2(u_xlat27);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat27);
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_7[7];
						float baseStartHeights[8];
						vec4 unused_0_9[7];
						float baseBlends[8];
						vec4 unused_0_11[7];
						float baseColourStrength[8];
						vec4 unused_0_13[7];
						float baseTextureScales[8];
						vec4 unused_0_15[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
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
					float u_xlat34;
					float u_xlat35;
					int u_xlati35;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * u_xlat2.xyz;
					    u_xlat34 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat35 = (-minHeight) + maxHeight;
					    u_xlat34 = u_xlat34 / u_xlat35;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat35 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat35 = u_xlat35 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat35);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat36 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat37 = u_xlat34 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat37 = (-u_xlat36) + u_xlat37;
					        u_xlat36 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat36);
					        u_xlat36 = u_xlat37 / u_xlat36;
					        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat37 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz;
					        u_xlat37 = (-u_xlat36) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat6.xyz;
					    }
					    u_xlat4 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat34) + u_xlat2.x;
					    u_xlat34 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat34;
					    u_xlat34 = u_xlat34 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
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
					        u_xlat6 = vs_TEXCOORD1.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat6 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD1.xxxx + u_xlat6;
					        u_xlat6 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD1.zzzz + u_xlat6;
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
					    u_xlatb2 = 0.0<u_xlat4.z;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat13.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat13.xy = u_xlat13.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat13.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat6.w;
					    u_xlat13.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat13.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat4.x;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat4.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat34) + 1.0;
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
					    u_xlat22 = abs(u_xlat33) + u_xlat34;
					    u_xlat22 = u_xlat22 + 9.99999975e-06;
					    u_xlat22 = 0.5 / u_xlat22;
					    u_xlat22 = u_xlat22 * 0.999999881;
					    u_xlat22 = max(u_xlat22, 9.99999975e-05);
					    u_xlat11.y = sqrt(u_xlat22);
					    u_xlat11.xy = vec2(u_xlat34) * u_xlat11.xy;
					    u_xlat1.xyz = u_xlat11.xxx * u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat2.xyz * u_xlat11.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						vec4 unused_0_2;
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_5[7];
						float baseStartHeights[8];
						vec4 unused_0_7[7];
						float baseBlends[8];
						vec4 unused_0_9[7];
						float baseColourStrength[8];
						vec4 unused_0_11[7];
						float baseTextureScales[8];
						vec4 unused_0_13[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
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
					float u_xlat15;
					float u_xlat21;
					float u_xlat22;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat22) + u_xlat2.x;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat9.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat9.xyz;
					        u_xlat9.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat9.xyz;
					        u_xlat9.xyz = u_xlat9.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat9.xyz : vs_TEXCOORD1.xyz;
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
					    u_xlat9.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat9.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat4.x);
					    u_xlat22 = u_xlat22 * u_xlat2.x + u_xlat4.x;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat21;
					float u_xlat22;
					float u_xlat23;
					int u_xlati23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat22 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat2.x = (-minHeight) + maxHeight;
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat2.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat2.x = u_xlat2.x + abs(vs_TEXCOORD0.z);
					    u_xlat2.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat2.xxx;
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat24 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat4.x = u_xlat22 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat4.x = (-u_xlat24) + u_xlat4.x;
					        u_xlat24 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat24);
					        u_xlat24 = u_xlat4.x / u_xlat24;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat4.w = float(u_xlati_loop_1);
					        u_xlat5 = texture(baseTextures, u_xlat4.yzw);
					        u_xlat6 = texture(baseTextures, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat2.yyy * u_xlat6.xyz;
					        u_xlat4 = texture(baseTextures, u_xlat4.xyw);
					        u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx + u_xlat6.xyz;
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.zzz + u_xlat5.xyz;
					        u_xlat25 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					        u_xlat25 = (-u_xlat24) + 1.0;
					        u_xlat4.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat4.xyz;
					        u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat25) + u_xlat4.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat22 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat16 = (-u_xlat22) + u_xlat16;
					    u_xlat22 = unity_ShadowFadeCenterAndType.w * u_xlat16 + u_xlat22;
					    u_xlat22 = u_xlat22 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
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
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat23, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat16 = u_xlat16 + (-u_xlat4.x);
					    u_xlat22 = u_xlat22 * u_xlat16 + u_xlat4.x;
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat22 = u_xlat22 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat14 = u_xlat14 * 0.999999881;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD4 / _ProjectionParams.y;
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					    u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					    u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					    u_xlat30 = max(u_xlat30, 9.99999975e-06);
					    u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					    u_xlat30 = _LightProjectionParams.y / u_xlat30;
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    vec4 txVec0 = vec4(u_xlat11.xyz,u_xlat30);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.x;
					    u_xlat27 = u_xlat27 * (-u_xlat27);
					    u_xlat27 = exp2(u_xlat27);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat27);
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb11 = u_xlat28<0.99000001;
					    if(u_xlatb11){
					        u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					        u_xlat30 = max(u_xlat30, 9.99999975e-06);
					        u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					        u_xlat30 = _LightProjectionParams.y / u_xlat30;
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					        u_xlat30 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = u_xlat11.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat30);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat11.xyz = u_xlat11.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat11.xyz,u_xlat30);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat11.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat20 = (-_LightShadowData.x) + 1.0;
					        u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    } else {
					        u_xlat11.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.x;
					    u_xlat27 = u_xlat27 * (-u_xlat27);
					    u_xlat27 = exp2(u_xlat27);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat27);
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					    u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					    u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					    u_xlat30 = max(u_xlat30, 9.99999975e-06);
					    u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					    u_xlat30 = _LightProjectionParams.y / u_xlat30;
					    u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    vec4 txVec0 = vec4(u_xlat11.xyz,u_xlat30);
					    u_xlat11.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat20 = (-_LightShadowData.x) + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat4.w;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.x;
					    u_xlat27 = u_xlat27 * (-u_xlat27);
					    u_xlat27 = exp2(u_xlat27);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat27);
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
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_6[7];
						float baseStartHeights[8];
						vec4 unused_0_8[7];
						float baseBlends[8];
						vec4 unused_0_10[7];
						float baseColourStrength[8];
						vec4 unused_0_12[7];
						float baseTextureScales[8];
						vec4 unused_0_14[6];
						float minHeight;
						float maxHeight;
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
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCube _ShadowMapTexture;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat18;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					int u_xlati29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat28 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat29 = (-minHeight) + maxHeight;
					    u_xlat28 = u_xlat28 / u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat29 = u_xlat29 + abs(vs_TEXCOORD0.z);
					    u_xlat4.xyz = abs(vs_TEXCOORD0.xyz) / vec3(u_xlat29);
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat30 = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat31 = u_xlat28 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat31 = (-u_xlat30) + u_xlat31;
					        u_xlat30 = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat30);
					        u_xlat30 = u_xlat31 / u_xlat30;
					        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat6.w = float(u_xlati_loop_1);
					        u_xlat7 = texture(baseTextures, u_xlat6.yzw);
					        u_xlat8 = texture(baseTextures, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat4.yyy * u_xlat8.xyz;
					        u_xlat6 = texture(baseTextures, u_xlat6.xyw);
					        u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx + u_xlat8.xyz;
					        u_xlat6.xyz = u_xlat6.xyz * u_xlat4.zzz + u_xlat7.xyz;
					        u_xlat31 = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat6.xyz = vec3(u_xlat31) * u_xlat6.xyz;
					        u_xlat31 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat6.xyz;
					        u_xlat6.xyz = vec3(u_xlat30) * u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat31) + u_xlat6.xyz;
					    }
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat6.x = unity_MatrixV[0].z;
					    u_xlat6.y = unity_MatrixV[1].z;
					    u_xlat6.z = unity_MatrixV[2].z;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
					    u_xlat28 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat28;
					    u_xlat28 = u_xlat28 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat11.x, u_xlat30);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb11 = u_xlat28<0.99000001;
					    if(u_xlatb11){
					        u_xlat11.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
					        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
					        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.z);
					        u_xlat30 = max(u_xlat30, 9.99999975e-06);
					        u_xlat30 = u_xlat30 * _LightProjectionParams.w;
					        u_xlat30 = _LightProjectionParams.y / u_xlat30;
					        u_xlat30 = u_xlat30 + (-_LightProjectionParams.x);
					        u_xlat30 = (-u_xlat30) + 1.0;
					        u_xlat6.xyz = u_xlat11.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat6.xyz,u_xlat30);
					        u_xlat6.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7.xyz = u_xlat11.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat7.xyz,u_xlat30);
					        u_xlat6.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat11.xyz = u_xlat11.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat11.xyz,u_xlat30);
					        u_xlat6.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat11.x = dot(u_xlat6, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat20 = (-_LightShadowData.x) + 1.0;
					        u_xlat11.x = u_xlat11.x * u_xlat20 + _LightShadowData.x;
					    } else {
					        u_xlat11.x = 1.0;
					    }
					    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
					    u_xlat28 = u_xlat28 * u_xlat2.x + u_xlat11.x;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat2.x = u_xlat2.x * u_xlat4.w;
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat3.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat18 = abs(u_xlat27) + u_xlat28;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat18 = u_xlat18 * 0.999999881;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = vec2(u_xlat28) * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.x;
					    u_xlat27 = u_xlat27 * (-u_xlat27);
					    u_xlat27 = exp2(u_xlat27);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat27);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 200
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			GpuProgramID 146476
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_3[7];
						float baseStartHeights[8];
						vec4 unused_0_5[7];
						float baseBlends[8];
						vec4 unused_0_7[7];
						float baseColourStrength[8];
						vec4 unused_0_9[7];
						float baseTextureScales[8];
						vec4 unused_0_11[6];
						float minHeight;
						float maxHeight;
						vec4 unused_0_14;
					};
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					float u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat8;
					int u_xlati19;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat6.x = (-minHeight) + maxHeight;
					    u_xlat0 = u_xlat0 / u_xlat6.x;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat6.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat6.x = u_xlat6.x + abs(vs_TEXCOORD0.z);
					    u_xlat6.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat6.xxx;
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat8.x = u_xlat0 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat8.x = (-u_xlat2.x) + u_xlat8.x;
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat2.x);
					        u_xlat2.x = u_xlat8.x / u_xlat2.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat3.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat3.w = float(u_xlati_loop_1);
					        u_xlat4 = texture(baseTextures, u_xlat3.yzw);
					        u_xlat5 = texture(baseTextures, u_xlat3.xzw);
					        u_xlat8.xyz = u_xlat6.yyy * u_xlat5.xyz;
					        u_xlat3 = texture(baseTextures, u_xlat3.xyw);
					        u_xlat8.xyz = u_xlat4.xyz * u_xlat6.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat8.xyz;
					        u_xlat3.x = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat3.xxx;
					        u_xlat3.x = (-u_xlat2.x) + 1.0;
					        u_xlat8.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xxx * u_xlat8.xyz;
					        u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    }
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
						vec4 unused_0_0[4];
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_3[7];
						float baseStartHeights[8];
						vec4 unused_0_5[7];
						float baseBlends[8];
						vec4 unused_0_7[7];
						float baseColourStrength[8];
						vec4 unused_0_9[7];
						float baseTextureScales[8];
						vec4 unused_0_11[6];
						float minHeight;
						float maxHeight;
						vec4 unused_0_14;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat8;
					float u_xlat19;
					int u_xlati19;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat6.x = (-minHeight) + maxHeight;
					    u_xlat0.x = u_xlat0.x / u_xlat6.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat6.x = u_xlat6.x + abs(vs_TEXCOORD0.z);
					    u_xlat6.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat6.xxx;
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat8.x = u_xlat0.x + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat8.x = (-u_xlat2.x) + u_xlat8.x;
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat2.x);
					        u_xlat2.x = u_xlat8.x / u_xlat2.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat3.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat3.w = float(u_xlati_loop_1);
					        u_xlat4 = texture(baseTextures, u_xlat3.yzw);
					        u_xlat5 = texture(baseTextures, u_xlat3.xzw);
					        u_xlat8.xyz = u_xlat6.yyy * u_xlat5.xyz;
					        u_xlat3 = texture(baseTextures, u_xlat3.xyw);
					        u_xlat8.xyz = u_xlat4.xyz * u_xlat6.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat8.xyz;
					        u_xlat3.x = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat3.xxx;
					        u_xlat3.x = (-u_xlat2.x) + 1.0;
					        u_xlat8.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xxx * u_xlat8.xyz;
					        u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    }
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat6.xyz : vs_TEXCOORD1.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6.x = u_xlat0.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat6.x = max(u_xlat6.x, u_xlat19);
					        u_xlat0.x = min(u_xlat2.x, u_xlat6.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					        u_xlat3.xyz = u_xlat0.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat0.xyz = u_xlat0.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xyz);
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat0, u_xlat4);
					    } else {
					        u_xlat0.xyz = vs_TEXCOORD0.xyz;
					        u_xlat0.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat0);
					        u_xlat2.y = dot(unity_SHAg, u_xlat0);
					        u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    }
					    u_xlat0.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
						vec4 unused_0_0[4];
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_3[7];
						float baseStartHeights[8];
						vec4 unused_0_5[7];
						float baseBlends[8];
						vec4 unused_0_7[7];
						float baseColourStrength[8];
						vec4 unused_0_9[7];
						float baseTextureScales[8];
						vec4 unused_0_11[6];
						float minHeight;
						float maxHeight;
						vec4 unused_0_14;
					};
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					float u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat8;
					int u_xlati19;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat6.x = (-minHeight) + maxHeight;
					    u_xlat0 = u_xlat0 / u_xlat6.x;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat6.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat6.x = u_xlat6.x + abs(vs_TEXCOORD0.z);
					    u_xlat6.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat6.xxx;
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat8.x = u_xlat0 + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat8.x = (-u_xlat2.x) + u_xlat8.x;
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat2.x);
					        u_xlat2.x = u_xlat8.x / u_xlat2.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat3.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat3.w = float(u_xlati_loop_1);
					        u_xlat4 = texture(baseTextures, u_xlat3.yzw);
					        u_xlat5 = texture(baseTextures, u_xlat3.xzw);
					        u_xlat8.xyz = u_xlat6.yyy * u_xlat5.xyz;
					        u_xlat3 = texture(baseTextures, u_xlat3.xyw);
					        u_xlat8.xyz = u_xlat4.xyz * u_xlat6.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat8.xyz;
					        u_xlat3.x = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat3.xxx;
					        u_xlat3.x = (-u_xlat2.x) + 1.0;
					        u_xlat8.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xxx * u_xlat8.xyz;
					        u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    }
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
						vec4 unused_0_0[4];
						int layerCount;
						vec3 baseColours[8];
						vec4 unused_0_3[7];
						float baseStartHeights[8];
						vec4 unused_0_5[7];
						float baseBlends[8];
						vec4 unused_0_7[7];
						float baseColourStrength[8];
						vec4 unused_0_9[7];
						float baseTextureScales[8];
						vec4 unused_0_11[6];
						float minHeight;
						float maxHeight;
						vec4 unused_0_14;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DArray baseTextures;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat8;
					float u_xlat19;
					int u_xlati19;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.y + (-minHeight);
					    u_xlat6.x = (-minHeight) + maxHeight;
					    u_xlat0.x = u_xlat0.x / u_xlat6.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = abs(vs_TEXCOORD0.y) + abs(vs_TEXCOORD0.x);
					    u_xlat6.x = u_xlat6.x + abs(vs_TEXCOORD0.z);
					    u_xlat6.xyz = abs(vs_TEXCOORD0.xyz) / u_xlat6.xxx;
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<layerCount ; u_xlati_loop_1++)
					    {
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * -0.5 + -9.99999975e-05;
					        u_xlat8.x = u_xlat0.x + (-baseStartHeights[u_xlati_loop_1]);
					        u_xlat8.x = (-u_xlat2.x) + u_xlat8.x;
					        u_xlat2.x = baseBlends[u_xlati_loop_1] * 0.5 + (-u_xlat2.x);
					        u_xlat2.x = u_xlat8.x / u_xlat2.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat3.xyz = vs_TEXCOORD1.xyz / vec3(baseTextureScales[u_xlati_loop_1]);
					        u_xlat3.w = float(u_xlati_loop_1);
					        u_xlat4 = texture(baseTextures, u_xlat3.yzw);
					        u_xlat5 = texture(baseTextures, u_xlat3.xzw);
					        u_xlat8.xyz = u_xlat6.yyy * u_xlat5.xyz;
					        u_xlat3 = texture(baseTextures, u_xlat3.xyw);
					        u_xlat8.xyz = u_xlat4.xyz * u_xlat6.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat8.xyz;
					        u_xlat3.x = 1.0 + (-baseColourStrength[u_xlati_loop_1]);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat3.xxx;
					        u_xlat3.x = (-u_xlat2.x) + 1.0;
					        u_xlat8.xyz = baseColours[u_xlati_loop_1].xyz * vec3(baseColourStrength[u_xlati_loop_1]) + u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xxx * u_xlat8.xyz;
					        u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    }
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat6.xyz : vs_TEXCOORD1.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6.x = u_xlat0.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat6.x = max(u_xlat6.x, u_xlat19);
					        u_xlat0.x = min(u_xlat2.x, u_xlat6.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					        u_xlat3.xyz = u_xlat0.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat0.xyz = u_xlat0.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xyz);
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat0, u_xlat4);
					    } else {
					        u_xlat0.xyz = vs_TEXCOORD0.xyz;
					        u_xlat0.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat0);
					        u_xlat2.y = dot(unity_SHAg, u_xlat0);
					        u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    }
					    u_xlat0.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}