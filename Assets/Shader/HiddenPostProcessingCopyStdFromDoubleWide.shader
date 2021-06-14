Shader "Hidden/PostProcessing/CopyStdFromDoubleWide" {
	Properties {
		_MainTex ("", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 12684
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
						vec4 _UVScaleOffset;
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
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
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 125565
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
						vec4 _UVScaleOffset;
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
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
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec4 u_xlati1;
					bvec4 u_xlatb1;
					bvec4 u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
					    u_xlati1 = ivec4((uvec4(u_xlatb1) * 0xffffffffu) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlati1 = ivec4(uvec4(u_xlati1) | (uvec4(u_xlatb2) * 0xffffffffu));
					    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
					    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
					    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
					    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
					    return;
					}"
				}
			}
		}
	}
}