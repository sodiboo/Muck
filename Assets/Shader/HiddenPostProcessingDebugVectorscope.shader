Shader "Hidden/PostProcessing/Debug/Vectorscope" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 15523
			Program "vp" {
				SubProgram "d3d11 " {
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
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
						vec4 unused_0_0[28];
						vec3 _Params;
					};
					 struct _VectorscopeBuffer_type {
						uint[1] value;
					};
					
					layout(std430, binding = 0) readonly buffer _VectorscopeBuffer {
						_VectorscopeBuffer_type _VectorscopeBuffer_buf[];
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec2 u_xlat4;
					uvec2 u_xlatu4;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD0.xyxy * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, -0.5, 1.0, 0.0);
					    u_xlat4.xy = u_xlat0.zw * _Params.xy;
					    u_xlatu4.xy = uvec2(u_xlat4.xy);
					    u_xlat4.xy = vec2(u_xlatu4.xy);
					    u_xlat4.x = u_xlat4.y * _Params.x + u_xlat4.x;
					    u_xlatu4.x = uint(u_xlat4.x);
					    u_xlatu4.x = _VectorscopeBuffer_buf[u_xlatu4.x].value[(0 >> 2) + 0];
					    u_xlat4.x = float(u_xlatu4.x);
					    u_xlat4.x = u_xlat4.x * _Params.z + -0.00400000019;
					    u_xlat4.x = max(u_xlat4.x, 0.0);
					    u_xlat1.xy = u_xlat4.xx * vec2(6.19999981, 6.19999981) + vec2(0.5, 1.70000005);
					    u_xlat6 = u_xlat4.x * u_xlat1.x;
					    u_xlat4.x = u_xlat4.x * u_xlat1.y + 0.0599999987;
					    u_xlat4.x = u_xlat6 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat4.x = min(u_xlat4.x, 1.0);
					    u_xlat0.x = (-u_xlat0.x) * 0.344000012 + 0.5;
					    u_xlat1.y = (-u_xlat0.y) * 0.713999987 + u_xlat0.x;
					    u_xlat1.xz = vs_TEXCOORD0.yx * vec2(1.403, 1.773) + vec2(-0.201499999, -0.386500001);
					    SV_Target0.xyz = u_xlat4.xxx * (-u_xlat1.xyz) + u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}