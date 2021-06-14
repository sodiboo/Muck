Shader "Custom/Outline Fill" {
	Properties {
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 0
		_OutlineColor ("Outline Color", Vector) = (1,1,1,1)
		_OutlineWidth ("Outline Width", Range(0, 10)) = 2
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent+110" "RenderType" = "Transparent" }
		Pass {
			Name "Fill"
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent+110" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			Stencil {
				Ref 1
				Comp NotEqual
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 62649
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
						vec4 unused_0_0[2];
						vec4 _OutlineColor;
						float _OutlineWidth;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						mat4x4 unity_MatrixInvV;
						vec4 unused_2_4[6];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec3 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
					    u_xlat9 = dot(in_TEXCOORD3.xyz, in_TEXCOORD3.xyz);
					    u_xlatb9 = u_xlat9!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb9)) ? in_TEXCOORD3.xyz : in_NORMAL0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat2.xyz;
					    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat2.xyz;
					    u_xlat0.z = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * (-u_xlat1.zzz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_OutlineWidth);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00100000005, 0.00100000005, 0.00100000005) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + glstate_matrix_projection[3];
					    vs_COLOR0 = _OutlineColor;
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
					
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_COLOR0;
					    return;
					}"
				}
			}
		}
	}
}