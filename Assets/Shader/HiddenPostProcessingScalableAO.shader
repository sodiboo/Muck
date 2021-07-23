Shader "Hidden/PostProcessing/ScalableAO" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 8321
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" "FOG_EXP2" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[13];
						vec4 _ProjectionParams;
						vec4 unused_0_3[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_7[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_9[4];
						vec4 _AOParams;
						vec4 unused_0_11[2];
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraDepthNormalsTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					vec2 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat14;
					int u_xlati14;
					bvec2 u_xlatb14;
					vec2 u_xlat18;
					ivec2 u_xlati18;
					bvec2 u_xlatb18;
					vec2 u_xlat22;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					int u_xlati30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
					    u_xlat18.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18.x = 2.0 / u_xlat18.x;
					    u_xlat10.xy = u_xlat1.xy * u_xlat18.xx;
					    u_xlat10.z = u_xlat18.x + -1.0;
					    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat18.x / u_xlat0.x;
					    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
					    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
					    u_xlati18.xy = ivec2(uvec2(u_xlati18.xy) & uvec2(1u, 1u));
					    u_xlati18.x = u_xlati18.y + u_xlati18.x;
					    u_xlat18.x = float(u_xlati18.x);
					    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18.x = u_xlat27 + u_xlat18.x;
					    u_xlat18.x = u_xlat18.x * 100000000.0;
					    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat4.x = unity_CameraProjection[0].x;
					    u_xlat4.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
					    u_xlat27 = (-u_xlat3.z) + 1.0;
					    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
					    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
					    u_xlat18.xy = floor(u_xlat18.xy);
					    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat18.x = u_xlat18.x * 52.9829178;
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat5.x = 12.9898005;
					    u_xlat27 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat29 = float(u_xlati_loop_1);
					        u_xlat29 = u_xlat29 * 1.00010002;
					        u_xlat29 = floor(u_xlat29);
					        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
					        u_xlat30 = u_xlat5.y * 78.2330017;
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
					        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = u_xlat30 * 6.28318548;
					        u_xlat7 = sin(u_xlat30);
					        u_xlat8.x = cos(u_xlat30);
					        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
					        u_xlat30 = sqrt(u_xlat30);
					        u_xlat8.y = u_xlat7;
					        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
					        u_xlat29 = u_xlat29 + 1.0;
					        u_xlat29 = u_xlat29 / _AOParams.w;
					        u_xlat29 = sqrt(u_xlat29);
					        u_xlat29 = u_xlat29 * _AOParams.y;
					        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
					        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
					        u_xlatb29 = u_xlat29>=0.0;
					        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
					        u_xlat22.xy = u_xlat14.yy * unity_CameraProjection[1].xy;
					        u_xlat22.xy = unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
					        u_xlat22.xy = unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
					        u_xlat29 = (-u_xlat14.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
					        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
					        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
					        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
					        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
					        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0);
					        u_xlat29 = u_xlat6.x * _ZBufferParams.x;
					        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
					        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
					        u_xlat29 = u_xlat30 / u_xlat29;
					        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
					        u_xlati30 = u_xlatb30 ? 1 : int(0);
					        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
					        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
					        u_xlati14 = u_xlatb14.x ? 1 : int(0);
					        u_xlati30 = u_xlati30 + u_xlati14;
					        u_xlat30 = float(u_xlati30);
					        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
					        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
					        u_xlat30 = u_xlat30 + u_xlat14.x;
					        u_xlat30 = u_xlat30 * 100000000.0;
					        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
					        u_xlat22.xy = u_xlat22.xy + (-unity_CameraProjection[2].xy);
					        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
					        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
					        u_xlat29 = (-u_xlat6.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
					        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
					        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
					        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
					        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
					        u_xlat29 = max(u_xlat29, 0.0);
					        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat30 = u_xlat30 + 9.99999975e-05;
					        u_xlat29 = u_xlat29 / u_xlat30;
					        u_xlat27 = u_xlat27 + u_xlat29;
					    }
					    u_xlat0.x = u_xlat27 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    SV_Target0.x = exp2(u_xlat0.x);
					    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[13];
						vec4 _ProjectionParams;
						vec4 unused_0_3[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_7[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_9[4];
						vec4 _AOParams;
						vec4 unused_0_11[2];
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraDepthNormalsTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					vec2 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat14;
					int u_xlati14;
					bvec2 u_xlatb14;
					vec2 u_xlat18;
					ivec2 u_xlati18;
					bvec2 u_xlatb18;
					vec2 u_xlat22;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					int u_xlati30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
					    u_xlat18.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18.x = 2.0 / u_xlat18.x;
					    u_xlat10.xy = u_xlat1.xy * u_xlat18.xx;
					    u_xlat10.z = u_xlat18.x + -1.0;
					    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat18.x / u_xlat0.x;
					    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
					    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
					    u_xlati18.xy = ivec2(uvec2(u_xlati18.xy) & uvec2(1u, 1u));
					    u_xlati18.x = u_xlati18.y + u_xlati18.x;
					    u_xlat18.x = float(u_xlati18.x);
					    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18.x = u_xlat27 + u_xlat18.x;
					    u_xlat18.x = u_xlat18.x * 100000000.0;
					    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat4.x = unity_CameraProjection[0].x;
					    u_xlat4.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
					    u_xlat27 = (-u_xlat3.z) + 1.0;
					    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
					    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
					    u_xlat18.xy = floor(u_xlat18.xy);
					    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat18.x = u_xlat18.x * 52.9829178;
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat5.x = 12.9898005;
					    u_xlat27 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat29 = float(u_xlati_loop_1);
					        u_xlat29 = u_xlat29 * 1.00010002;
					        u_xlat29 = floor(u_xlat29);
					        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
					        u_xlat30 = u_xlat5.y * 78.2330017;
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
					        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = u_xlat30 * 6.28318548;
					        u_xlat7 = sin(u_xlat30);
					        u_xlat8.x = cos(u_xlat30);
					        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
					        u_xlat30 = sqrt(u_xlat30);
					        u_xlat8.y = u_xlat7;
					        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
					        u_xlat29 = u_xlat29 + 1.0;
					        u_xlat29 = u_xlat29 / _AOParams.w;
					        u_xlat29 = sqrt(u_xlat29);
					        u_xlat29 = u_xlat29 * _AOParams.y;
					        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
					        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
					        u_xlatb29 = u_xlat29>=0.0;
					        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
					        u_xlat22.xy = u_xlat14.yy * unity_CameraProjection[1].xy;
					        u_xlat22.xy = unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
					        u_xlat22.xy = unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
					        u_xlat29 = (-u_xlat14.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
					        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
					        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
					        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
					        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
					        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0);
					        u_xlat29 = u_xlat6.x * _ZBufferParams.x;
					        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
					        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
					        u_xlat29 = u_xlat30 / u_xlat29;
					        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
					        u_xlati30 = u_xlatb30 ? 1 : int(0);
					        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
					        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
					        u_xlati14 = u_xlatb14.x ? 1 : int(0);
					        u_xlati30 = u_xlati30 + u_xlati14;
					        u_xlat30 = float(u_xlati30);
					        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
					        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
					        u_xlat30 = u_xlat30 + u_xlat14.x;
					        u_xlat30 = u_xlat30 * 100000000.0;
					        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
					        u_xlat22.xy = u_xlat22.xy + (-unity_CameraProjection[2].xy);
					        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
					        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
					        u_xlat29 = (-u_xlat6.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
					        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
					        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
					        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
					        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
					        u_xlat29 = max(u_xlat29, 0.0);
					        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat30 = u_xlat30 + 9.99999975e-05;
					        u_xlat29 = u_xlat29 / u_xlat30;
					        u_xlat27 = u_xlat27 + u_xlat29;
					    }
					    u_xlat0.x = u_xlat27 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    SV_Target0.x = exp2(u_xlat0.x);
					    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" }
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[13];
						vec4 _ProjectionParams;
						vec4 unused_0_3[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_7[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_9[2];
						vec3 _FogParams;
						vec4 unused_0_11;
						vec4 _AOParams;
						vec4 unused_0_13[2];
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraDepthNormalsTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					vec2 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat14;
					int u_xlati14;
					bvec2 u_xlatb14;
					vec2 u_xlat18;
					ivec2 u_xlati18;
					bvec2 u_xlatb18;
					vec2 u_xlat22;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					int u_xlati30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
					    u_xlat18.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18.x = 2.0 / u_xlat18.x;
					    u_xlat10.xy = u_xlat1.xy * u_xlat18.xx;
					    u_xlat10.z = u_xlat18.x + -1.0;
					    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat18.x / u_xlat0.x;
					    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
					    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
					    u_xlati18.xy = ivec2(uvec2(u_xlati18.xy) & uvec2(1u, 1u));
					    u_xlati18.x = u_xlati18.y + u_xlati18.x;
					    u_xlat18.x = float(u_xlati18.x);
					    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18.x = u_xlat27 + u_xlat18.x;
					    u_xlat18.x = u_xlat18.x * 100000000.0;
					    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat4.x = unity_CameraProjection[0].x;
					    u_xlat4.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
					    u_xlat27 = (-u_xlat3.z) + 1.0;
					    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
					    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
					    u_xlat18.xy = floor(u_xlat18.xy);
					    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat18.x = u_xlat18.x * 52.9829178;
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat5.x = 12.9898005;
					    u_xlat27 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat29 = float(u_xlati_loop_1);
					        u_xlat29 = u_xlat29 * 1.00010002;
					        u_xlat29 = floor(u_xlat29);
					        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
					        u_xlat30 = u_xlat5.y * 78.2330017;
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
					        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = u_xlat30 * 6.28318548;
					        u_xlat7 = sin(u_xlat30);
					        u_xlat8.x = cos(u_xlat30);
					        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
					        u_xlat30 = sqrt(u_xlat30);
					        u_xlat8.y = u_xlat7;
					        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
					        u_xlat29 = u_xlat29 + 1.0;
					        u_xlat29 = u_xlat29 / _AOParams.w;
					        u_xlat29 = sqrt(u_xlat29);
					        u_xlat29 = u_xlat29 * _AOParams.y;
					        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
					        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
					        u_xlatb29 = u_xlat29>=0.0;
					        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
					        u_xlat22.xy = u_xlat14.yy * unity_CameraProjection[1].xy;
					        u_xlat22.xy = unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
					        u_xlat22.xy = unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
					        u_xlat29 = (-u_xlat14.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
					        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
					        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
					        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
					        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
					        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0);
					        u_xlat29 = u_xlat6.x * _ZBufferParams.x;
					        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
					        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
					        u_xlat29 = u_xlat30 / u_xlat29;
					        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
					        u_xlati30 = u_xlatb30 ? 1 : int(0);
					        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
					        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
					        u_xlati14 = u_xlatb14.x ? 1 : int(0);
					        u_xlati30 = u_xlati30 + u_xlati14;
					        u_xlat30 = float(u_xlati30);
					        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
					        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
					        u_xlat30 = u_xlat30 + u_xlat14.x;
					        u_xlat30 = u_xlat30 * 100000000.0;
					        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
					        u_xlat22.xy = u_xlat22.xy + (-unity_CameraProjection[2].xy);
					        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
					        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
					        u_xlat29 = (-u_xlat6.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
					        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
					        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
					        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
					        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
					        u_xlat29 = max(u_xlat29, 0.0);
					        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat30 = u_xlat30 + 9.99999975e-05;
					        u_xlat29 = u_xlat29 / u_xlat30;
					        u_xlat27 = u_xlat27 + u_xlat29;
					    }
					    u_xlat0.x = u_xlat27 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat18.x = u_xlat2.x * _ZBufferParams.x;
					    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
					    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
					    u_xlat9 = u_xlat27 / u_xlat9;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat9 = u_xlat9 * _FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" "FOG_EXP2" }
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[13];
						vec4 _ProjectionParams;
						vec4 unused_0_3[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_7[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_9[2];
						vec3 _FogParams;
						vec4 unused_0_11;
						vec4 _AOParams;
						vec4 unused_0_13[2];
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraDepthNormalsTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					vec2 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat14;
					int u_xlati14;
					bvec2 u_xlatb14;
					vec2 u_xlat18;
					ivec2 u_xlati18;
					bvec2 u_xlatb18;
					vec2 u_xlat22;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					int u_xlati30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
					    u_xlat18.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18.x = 2.0 / u_xlat18.x;
					    u_xlat10.xy = u_xlat1.xy * u_xlat18.xx;
					    u_xlat10.z = u_xlat18.x + -1.0;
					    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat18.x / u_xlat0.x;
					    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
					    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
					    u_xlati18.xy = ivec2(uvec2(u_xlati18.xy) & uvec2(1u, 1u));
					    u_xlati18.x = u_xlati18.y + u_xlati18.x;
					    u_xlat18.x = float(u_xlati18.x);
					    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18.x = u_xlat27 + u_xlat18.x;
					    u_xlat18.x = u_xlat18.x * 100000000.0;
					    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat4.x = unity_CameraProjection[0].x;
					    u_xlat4.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
					    u_xlat27 = (-u_xlat3.z) + 1.0;
					    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
					    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
					    u_xlat18.xy = floor(u_xlat18.xy);
					    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat18.x = u_xlat18.x * 52.9829178;
					    u_xlat18.x = fract(u_xlat18.x);
					    u_xlat5.x = 12.9898005;
					    u_xlat27 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat29 = float(u_xlati_loop_1);
					        u_xlat29 = u_xlat29 * 1.00010002;
					        u_xlat29 = floor(u_xlat29);
					        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
					        u_xlat30 = u_xlat5.y * 78.2330017;
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
					        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
					        u_xlat30 = sin(u_xlat30);
					        u_xlat30 = u_xlat30 * 43758.5469;
					        u_xlat30 = fract(u_xlat30);
					        u_xlat30 = u_xlat18.x + u_xlat30;
					        u_xlat30 = u_xlat30 * 6.28318548;
					        u_xlat7 = sin(u_xlat30);
					        u_xlat8.x = cos(u_xlat30);
					        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
					        u_xlat30 = sqrt(u_xlat30);
					        u_xlat8.y = u_xlat7;
					        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
					        u_xlat29 = u_xlat29 + 1.0;
					        u_xlat29 = u_xlat29 / _AOParams.w;
					        u_xlat29 = sqrt(u_xlat29);
					        u_xlat29 = u_xlat29 * _AOParams.y;
					        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
					        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
					        u_xlatb29 = u_xlat29>=0.0;
					        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
					        u_xlat22.xy = u_xlat14.yy * unity_CameraProjection[1].xy;
					        u_xlat22.xy = unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
					        u_xlat22.xy = unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
					        u_xlat29 = (-u_xlat14.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
					        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
					        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
					        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
					        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
					        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0);
					        u_xlat29 = u_xlat6.x * _ZBufferParams.x;
					        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
					        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
					        u_xlat29 = u_xlat30 / u_xlat29;
					        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
					        u_xlati30 = u_xlatb30 ? 1 : int(0);
					        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
					        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
					        u_xlati14 = u_xlatb14.x ? 1 : int(0);
					        u_xlati30 = u_xlati30 + u_xlati14;
					        u_xlat30 = float(u_xlati30);
					        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
					        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
					        u_xlat30 = u_xlat30 + u_xlat14.x;
					        u_xlat30 = u_xlat30 * 100000000.0;
					        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
					        u_xlat22.xy = u_xlat22.xy + (-unity_CameraProjection[2].xy);
					        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
					        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
					        u_xlat29 = (-u_xlat6.z) + 1.0;
					        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
					        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
					        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
					        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
					        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
					        u_xlat29 = max(u_xlat29, 0.0);
					        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat30 = u_xlat30 + 9.99999975e-05;
					        u_xlat29 = u_xlat29 / u_xlat30;
					        u_xlat27 = u_xlat27 + u_xlat29;
					    }
					    u_xlat0.x = u_xlat27 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat18.x = u_xlat2.x * _ZBufferParams.x;
					    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
					    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
					    u_xlat9 = u_xlat27 / u_xlat9;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat9 = u_xlat9 * _FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.x = u_xlat9 * u_xlat0.x;
					    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 130050
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" "FOG_EXP2" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[8];
						mat4x4 unity_WorldToCamera;
						vec4 unused_0_3;
						vec4 _ProjectionParams;
						vec4 unused_0_5[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_9[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_11[4];
						vec4 _AOParams;
						vec4 unused_0_13[2];
					};
					uniform  sampler2D _CameraGBufferTexture2;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					vec3 u_xlat12;
					ivec2 u_xlati12;
					bvec2 u_xlatb12;
					vec2 u_xlat16;
					ivec2 u_xlati16;
					bvec2 u_xlatb16;
					vec2 u_xlat19;
					float u_xlat20;
					bvec2 u_xlatb20;
					float u_xlat24;
					bool u_xlatb24;
					int u_xlati25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraGBufferTexture2, u_xlat0.xy);
					    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlatb16.x = u_xlat16.x!=0.0;
					    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
					    u_xlat2.xyz = u_xlat1.yyy * unity_WorldToCamera[1].xyz;
					    u_xlat1.xyw = unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat16.x / u_xlat0.x;
					    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
					    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
					    u_xlati16.xy = ivec2(uvec2(u_xlati16.xy) & uvec2(1u, 1u));
					    u_xlati16.x = u_xlati16.y + u_xlati16.x;
					    u_xlat16.x = float(u_xlati16.x);
					    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16.x = u_xlat24 + u_xlat16.x;
					    u_xlat16.x = u_xlat16.x * 100000000.0;
					    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat3.x = unity_CameraProjection[0].x;
					    u_xlat3.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
					    u_xlat24 = (-u_xlat2.z) + 1.0;
					    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
					    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat16.x = u_xlat16.x * 52.9829178;
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat4.x = 12.9898005;
					    u_xlat24 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat26 = float(u_xlati_loop_1);
					        u_xlat26 = u_xlat26 * 1.00010002;
					        u_xlat26 = floor(u_xlat26);
					        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
					        u_xlat19.x = u_xlat4.y * 78.2330017;
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
					        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = u_xlat19.x * 6.28318548;
					        u_xlat6 = sin(u_xlat19.x);
					        u_xlat7.x = cos(u_xlat19.x);
					        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
					        u_xlat19.x = sqrt(u_xlat19.x);
					        u_xlat7.y = u_xlat6;
					        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
					        u_xlat26 = u_xlat26 + 1.0;
					        u_xlat26 = u_xlat26 / _AOParams.w;
					        u_xlat26 = sqrt(u_xlat26);
					        u_xlat26 = u_xlat26 * _AOParams.y;
					        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
					        u_xlatb26 = u_xlat26>=0.0;
					        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
					        u_xlat19.xy = u_xlat12.yy * unity_CameraProjection[1].xy;
					        u_xlat19.xy = unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
					        u_xlat26 = (-u_xlat12.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
					        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
					        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
					        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
					        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
					        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat5 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0);
					        u_xlat26 = u_xlat5.x * _ZBufferParams.x;
					        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
					        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
					        u_xlat26 = u_xlat12.x / u_xlat26;
					        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
					        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
					        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
					        u_xlati12.xy = ivec2(uvec2(u_xlati12.xy) & uvec2(1u, 1u));
					        u_xlati12.x = u_xlati12.y + u_xlati12.x;
					        u_xlat12.x = float(u_xlati12.x);
					        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
					        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
					        u_xlat12.x = u_xlat20 + u_xlat12.x;
					        u_xlat12.x = u_xlat12.x * 100000000.0;
					        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
					        u_xlat19.xy = u_xlat19.xy + (-unity_CameraProjection[2].xy);
					        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
					        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
					        u_xlat26 = (-u_xlat5.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
					        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
					        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
					        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
					        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
					        u_xlat26 = max(u_xlat26, 0.0);
					        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
					        u_xlat26 = u_xlat26 / u_xlat19.x;
					        u_xlat24 = u_xlat24 + u_xlat26;
					    }
					    u_xlat0.x = u_xlat24 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    SV_Target0.x = exp2(u_xlat0.x);
					    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[8];
						mat4x4 unity_WorldToCamera;
						vec4 unused_0_3;
						vec4 _ProjectionParams;
						vec4 unused_0_5[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_9[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_11[4];
						vec4 _AOParams;
						vec4 unused_0_13[2];
					};
					uniform  sampler2D _CameraGBufferTexture2;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					vec3 u_xlat12;
					ivec2 u_xlati12;
					bvec2 u_xlatb12;
					vec2 u_xlat16;
					ivec2 u_xlati16;
					bvec2 u_xlatb16;
					vec2 u_xlat19;
					float u_xlat20;
					bvec2 u_xlatb20;
					float u_xlat24;
					bool u_xlatb24;
					int u_xlati25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraGBufferTexture2, u_xlat0.xy);
					    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlatb16.x = u_xlat16.x!=0.0;
					    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
					    u_xlat2.xyz = u_xlat1.yyy * unity_WorldToCamera[1].xyz;
					    u_xlat1.xyw = unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat16.x / u_xlat0.x;
					    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
					    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
					    u_xlati16.xy = ivec2(uvec2(u_xlati16.xy) & uvec2(1u, 1u));
					    u_xlati16.x = u_xlati16.y + u_xlati16.x;
					    u_xlat16.x = float(u_xlati16.x);
					    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16.x = u_xlat24 + u_xlat16.x;
					    u_xlat16.x = u_xlat16.x * 100000000.0;
					    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat3.x = unity_CameraProjection[0].x;
					    u_xlat3.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
					    u_xlat24 = (-u_xlat2.z) + 1.0;
					    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
					    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat16.x = u_xlat16.x * 52.9829178;
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat4.x = 12.9898005;
					    u_xlat24 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat26 = float(u_xlati_loop_1);
					        u_xlat26 = u_xlat26 * 1.00010002;
					        u_xlat26 = floor(u_xlat26);
					        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
					        u_xlat19.x = u_xlat4.y * 78.2330017;
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
					        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = u_xlat19.x * 6.28318548;
					        u_xlat6 = sin(u_xlat19.x);
					        u_xlat7.x = cos(u_xlat19.x);
					        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
					        u_xlat19.x = sqrt(u_xlat19.x);
					        u_xlat7.y = u_xlat6;
					        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
					        u_xlat26 = u_xlat26 + 1.0;
					        u_xlat26 = u_xlat26 / _AOParams.w;
					        u_xlat26 = sqrt(u_xlat26);
					        u_xlat26 = u_xlat26 * _AOParams.y;
					        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
					        u_xlatb26 = u_xlat26>=0.0;
					        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
					        u_xlat19.xy = u_xlat12.yy * unity_CameraProjection[1].xy;
					        u_xlat19.xy = unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
					        u_xlat26 = (-u_xlat12.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
					        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
					        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
					        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
					        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
					        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat5 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0);
					        u_xlat26 = u_xlat5.x * _ZBufferParams.x;
					        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
					        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
					        u_xlat26 = u_xlat12.x / u_xlat26;
					        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
					        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
					        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
					        u_xlati12.xy = ivec2(uvec2(u_xlati12.xy) & uvec2(1u, 1u));
					        u_xlati12.x = u_xlati12.y + u_xlati12.x;
					        u_xlat12.x = float(u_xlati12.x);
					        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
					        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
					        u_xlat12.x = u_xlat20 + u_xlat12.x;
					        u_xlat12.x = u_xlat12.x * 100000000.0;
					        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
					        u_xlat19.xy = u_xlat19.xy + (-unity_CameraProjection[2].xy);
					        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
					        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
					        u_xlat26 = (-u_xlat5.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
					        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
					        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
					        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
					        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
					        u_xlat26 = max(u_xlat26, 0.0);
					        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
					        u_xlat26 = u_xlat26 / u_xlat19.x;
					        u_xlat24 = u_xlat24 + u_xlat26;
					    }
					    u_xlat0.x = u_xlat24 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    SV_Target0.x = exp2(u_xlat0.x);
					    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" }
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[8];
						mat4x4 unity_WorldToCamera;
						vec4 unused_0_3;
						vec4 _ProjectionParams;
						vec4 unused_0_5[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_9[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_11[2];
						vec3 _FogParams;
						vec4 unused_0_13;
						vec4 _AOParams;
						vec4 unused_0_15[2];
					};
					uniform  sampler2D _CameraGBufferTexture2;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					vec3 u_xlat12;
					ivec2 u_xlati12;
					bvec2 u_xlatb12;
					vec2 u_xlat16;
					ivec2 u_xlati16;
					bvec2 u_xlatb16;
					vec2 u_xlat19;
					float u_xlat20;
					bvec2 u_xlatb20;
					float u_xlat24;
					bool u_xlatb24;
					int u_xlati25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraGBufferTexture2, u_xlat0.xy);
					    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlatb16.x = u_xlat16.x!=0.0;
					    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
					    u_xlat2.xyz = u_xlat1.yyy * unity_WorldToCamera[1].xyz;
					    u_xlat1.xyw = unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat16.x / u_xlat0.x;
					    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
					    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
					    u_xlati16.xy = ivec2(uvec2(u_xlati16.xy) & uvec2(1u, 1u));
					    u_xlati16.x = u_xlati16.y + u_xlati16.x;
					    u_xlat16.x = float(u_xlati16.x);
					    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16.x = u_xlat24 + u_xlat16.x;
					    u_xlat16.x = u_xlat16.x * 100000000.0;
					    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat3.x = unity_CameraProjection[0].x;
					    u_xlat3.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
					    u_xlat24 = (-u_xlat2.z) + 1.0;
					    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
					    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat16.x = u_xlat16.x * 52.9829178;
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat4.x = 12.9898005;
					    u_xlat24 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat26 = float(u_xlati_loop_1);
					        u_xlat26 = u_xlat26 * 1.00010002;
					        u_xlat26 = floor(u_xlat26);
					        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
					        u_xlat19.x = u_xlat4.y * 78.2330017;
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
					        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = u_xlat19.x * 6.28318548;
					        u_xlat6 = sin(u_xlat19.x);
					        u_xlat7.x = cos(u_xlat19.x);
					        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
					        u_xlat19.x = sqrt(u_xlat19.x);
					        u_xlat7.y = u_xlat6;
					        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
					        u_xlat26 = u_xlat26 + 1.0;
					        u_xlat26 = u_xlat26 / _AOParams.w;
					        u_xlat26 = sqrt(u_xlat26);
					        u_xlat26 = u_xlat26 * _AOParams.y;
					        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
					        u_xlatb26 = u_xlat26>=0.0;
					        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
					        u_xlat19.xy = u_xlat12.yy * unity_CameraProjection[1].xy;
					        u_xlat19.xy = unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
					        u_xlat26 = (-u_xlat12.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
					        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
					        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
					        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
					        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
					        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat5 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0);
					        u_xlat26 = u_xlat5.x * _ZBufferParams.x;
					        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
					        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
					        u_xlat26 = u_xlat12.x / u_xlat26;
					        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
					        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
					        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
					        u_xlati12.xy = ivec2(uvec2(u_xlati12.xy) & uvec2(1u, 1u));
					        u_xlati12.x = u_xlati12.y + u_xlati12.x;
					        u_xlat12.x = float(u_xlati12.x);
					        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
					        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
					        u_xlat12.x = u_xlat20 + u_xlat12.x;
					        u_xlat12.x = u_xlat12.x * 100000000.0;
					        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
					        u_xlat19.xy = u_xlat19.xy + (-unity_CameraProjection[2].xy);
					        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
					        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
					        u_xlat26 = (-u_xlat5.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
					        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
					        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
					        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
					        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
					        u_xlat26 = max(u_xlat26, 0.0);
					        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
					        u_xlat26 = u_xlat26 / u_xlat19.x;
					        u_xlat24 = u_xlat24 + u_xlat26;
					    }
					    u_xlat0.x = u_xlat24 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat16.x = u_xlat2.x * _ZBufferParams.x;
					    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
					    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
					    u_xlat8 = u_xlat24 / u_xlat8;
					    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat8 = u_xlat8 * _FogParams.x;
					    u_xlat8 = u_xlat8 * (-u_xlat8);
					    u_xlat8 = exp2(u_xlat8);
					    SV_Target0.x = u_xlat8 * u_xlat0.x;
					    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "APPLY_FORWARD_FOG" "FOG_EXP2" }
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
						mat4x4 unity_CameraProjection;
						vec4 unused_0_1[8];
						mat4x4 unity_WorldToCamera;
						vec4 unused_0_3;
						vec4 _ProjectionParams;
						vec4 unused_0_5[2];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 _ScreenParams;
						vec4 unused_0_9[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_11[2];
						vec3 _FogParams;
						vec4 unused_0_13;
						vec4 _AOParams;
						vec4 unused_0_15[2];
					};
					uniform  sampler2D _CameraGBufferTexture2;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					vec3 u_xlat12;
					ivec2 u_xlati12;
					bvec2 u_xlatb12;
					vec2 u_xlat16;
					ivec2 u_xlati16;
					bvec2 u_xlatb16;
					vec2 u_xlat19;
					float u_xlat20;
					bvec2 u_xlatb20;
					float u_xlat24;
					bool u_xlatb24;
					int u_xlati25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_CameraGBufferTexture2, u_xlat0.xy);
					    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlatb16.x = u_xlat16.x!=0.0;
					    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
					    u_xlat2.xyz = u_xlat1.yyy * unity_WorldToCamera[1].xyz;
					    u_xlat1.xyw = unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat0 = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0);
					    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
					    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = u_xlat16.x / u_xlat0.x;
					    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
					    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
					    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
					    u_xlati16.xy = ivec2(uvec2(u_xlati16.xy) & uvec2(1u, 1u));
					    u_xlati16.x = u_xlati16.y + u_xlati16.x;
					    u_xlat16.x = float(u_xlati16.x);
					    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16.x = u_xlat24 + u_xlat16.x;
					    u_xlat16.x = u_xlat16.x * 100000000.0;
					    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
					    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xz = u_xlat0.xz + (-unity_CameraProjection[2].xy);
					    u_xlat3.x = unity_CameraProjection[0].x;
					    u_xlat3.y = unity_CameraProjection[1].y;
					    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
					    u_xlat24 = (-u_xlat2.z) + 1.0;
					    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
					    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
					    u_xlati0 = int(_AOParams.w);
					    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
					    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat16.x = u_xlat16.x * 52.9829178;
					    u_xlat16.x = fract(u_xlat16.x);
					    u_xlat4.x = 12.9898005;
					    u_xlat24 = 0.0;
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
					    {
					        u_xlat26 = float(u_xlati_loop_1);
					        u_xlat26 = u_xlat26 * 1.00010002;
					        u_xlat26 = floor(u_xlat26);
					        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
					        u_xlat19.x = u_xlat4.y * 78.2330017;
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
					        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
					        u_xlat19.x = sin(u_xlat19.x);
					        u_xlat19.x = u_xlat19.x * 43758.5469;
					        u_xlat19.x = fract(u_xlat19.x);
					        u_xlat19.x = u_xlat16.x + u_xlat19.x;
					        u_xlat19.x = u_xlat19.x * 6.28318548;
					        u_xlat6 = sin(u_xlat19.x);
					        u_xlat7.x = cos(u_xlat19.x);
					        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
					        u_xlat19.x = sqrt(u_xlat19.x);
					        u_xlat7.y = u_xlat6;
					        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
					        u_xlat26 = u_xlat26 + 1.0;
					        u_xlat26 = u_xlat26 / _AOParams.w;
					        u_xlat26 = sqrt(u_xlat26);
					        u_xlat26 = u_xlat26 * _AOParams.y;
					        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
					        u_xlatb26 = u_xlat26>=0.0;
					        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
					        u_xlat19.xy = u_xlat12.yy * unity_CameraProjection[1].xy;
					        u_xlat19.xy = unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
					        u_xlat19.xy = unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
					        u_xlat26 = (-u_xlat12.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
					        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
					        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
					        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
					        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
					        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat5 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0);
					        u_xlat26 = u_xlat5.x * _ZBufferParams.x;
					        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
					        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
					        u_xlat26 = u_xlat12.x / u_xlat26;
					        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
					        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
					        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
					        u_xlati12.xy = ivec2(uvec2(u_xlati12.xy) & uvec2(1u, 1u));
					        u_xlati12.x = u_xlati12.y + u_xlati12.x;
					        u_xlat12.x = float(u_xlati12.x);
					        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
					        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
					        u_xlat12.x = u_xlat20 + u_xlat12.x;
					        u_xlat12.x = u_xlat12.x * 100000000.0;
					        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
					        u_xlat19.xy = u_xlat19.xy + (-unity_CameraProjection[2].xy);
					        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
					        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
					        u_xlat26 = (-u_xlat5.z) + 1.0;
					        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
					        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
					        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
					        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
					        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
					        u_xlat26 = max(u_xlat26, 0.0);
					        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
					        u_xlat26 = u_xlat26 / u_xlat19.x;
					        u_xlat24 = u_xlat24 + u_xlat26;
					    }
					    u_xlat0.x = u_xlat24 * _AOParams.y;
					    u_xlat0.x = u_xlat0.x * _AOParams.x;
					    u_xlat0.x = u_xlat0.x / _AOParams.w;
					    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.600000024;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat16.x = u_xlat2.x * _ZBufferParams.x;
					    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
					    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
					    u_xlat8 = u_xlat24 / u_xlat8;
					    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
					    u_xlat8 = u_xlat8 * _FogParams.x;
					    u_xlat8 = u_xlat8 * (-u_xlat8);
					    u_xlat8 = exp2(u_xlat8);
					    SV_Target0.x = u_xlat8 * u_xlat0.x;
					    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 186726
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[3];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthNormalsTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat12;
					float u_xlat13;
					float u_xlat17;
					void main()
					{
					    u_xlat0.x = _MainTex_TexelSize.x;
					    u_xlat0.y = 0.0;
					    u_xlat1 = (-u_xlat0.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat0 = u_xlat0.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat3 = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = 2.0 / u_xlat13;
					    u_xlat9.xy = u_xlat3.xy * vec2(u_xlat13);
					    u_xlat9.z = u_xlat13 + -1.0;
					    u_xlat3.xyz = u_xlat9.xyz * vec3(1.0, 1.0, -1.0);
					    SV_Target0.yzw = u_xlat9.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat7.x = dot(u_xlat3.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat7.x = u_xlat7.x * u_xlat12;
					    u_xlat7.x = u_xlat7.x * 0.31621623;
					    u_xlat2.x = u_xlat7.x * u_xlat2.x;
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.x = u_xlat4.x * 0.227027029 + u_xlat2.x;
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat9.xyz = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat9.xyz);
					    u_xlat12 = u_xlat12 + -0.800000012;
					    u_xlat12 = u_xlat12 * 5.00000048;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat17 = u_xlat12 * -2.0 + 3.0;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * u_xlat17;
					    u_xlat17 = u_xlat12 * 0.31621623;
					    u_xlat7.x = u_xlat12 * 0.31621623 + u_xlat7.x;
					    u_xlat2.x = u_xlat4.x * u_xlat17 + u_xlat2.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = dot(u_xlat3.xyz, u_xlat6.xyz);
					    u_xlat6.x = u_xlat6.x + -0.800000012;
					    u_xlat6.x = u_xlat6.x * 5.00000048;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					    u_xlat6.x = u_xlat6.x * u_xlat6.x;
					    u_xlat6.x = u_xlat6.x * u_xlat11;
					    u_xlat11 = u_xlat6.x * 0.0702702701;
					    u_xlat6.x = u_xlat6.x * 0.0702702701 + u_xlat7.x;
					    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat2.x;
					    u_xlat5.xyz = u_xlat0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.x = dot(u_xlat3.xyz, u_xlat5.xyz);
					    u_xlat5.x = u_xlat5.x + -0.800000012;
					    u_xlat5.x = u_xlat5.x * 5.00000048;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat10 = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = u_xlat5.x * 0.0702702701;
					    u_xlat5.x = u_xlat5.x * 0.0702702701 + u_xlat6.x;
					    u_xlat5.x = u_xlat5.x + 0.227027029;
					    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat1.x;
					    SV_Target0.x = u_xlat0.x / u_xlat5.x;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 202765
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[12];
						mat4x4 unity_WorldToCamera;
						vec4 unused_0_2[10];
						float _RenderViewportScaleFactor;
						vec4 unused_0_4[3];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_6[3];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraGBufferTexture2;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb15 = u_xlat15!=0.0;
					    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(u_xlat15);
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToCamera[1].xyz;
					    u_xlat0.xyw = unity_WorldToCamera[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToCamera[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat1.x = _MainTex_TexelSize.x;
					    u_xlat1.y = 0.0;
					    u_xlat2 = (-u_xlat1.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat1 = u_xlat1.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat8.xyz = u_xlat3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat8.xyz);
					    u_xlat15 = u_xlat15 + -0.800000012;
					    u_xlat15 = u_xlat15 * 5.00000048;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat15 = u_xlat15 * u_xlat8.x;
					    u_xlat15 = u_xlat15 * 0.31621623;
					    u_xlat3.x = u_xlat15 * u_xlat3.x;
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat3.x = u_xlat4.x * 0.227027029 + u_xlat3.x;
					    u_xlat4 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat8.xyz = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat8.x = dot(u_xlat0.xyz, u_xlat8.xyz);
					    u_xlat8.x = u_xlat8.x + -0.800000012;
					    u_xlat8.x = u_xlat8.x * 5.00000048;
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					    u_xlat13 = u_xlat8.x * -2.0 + 3.0;
					    u_xlat8.x = u_xlat8.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat13;
					    u_xlat13 = u_xlat8.x * 0.31621623;
					    u_xlat15 = u_xlat8.x * 0.31621623 + u_xlat15;
					    u_xlat3.x = u_xlat4.x * u_xlat13 + u_xlat3.x;
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat0.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat7.x = u_xlat7.x * u_xlat12;
					    u_xlat12 = u_xlat7.x * 0.0702702701;
					    u_xlat15 = u_xlat7.x * 0.0702702701 + u_xlat15;
					    u_xlat2.x = u_xlat2.x * u_xlat12 + u_xlat3.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = dot(u_xlat0.xyz, u_xlat6.xyz);
					    SV_Target0.yzw = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = u_xlat6.x + -0.800000012;
					    u_xlat0.x = u_xlat0.x * 5.00000048;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5;
					    u_xlat5 = u_xlat0.x * 0.0702702701;
					    u_xlat0.x = u_xlat0.x * 0.0702702701 + u_xlat15;
					    u_xlat0.x = u_xlat0.x + 0.227027029;
					    u_xlat5 = u_xlat1.x * u_xlat5 + u_xlat2.x;
					    SV_Target0.x = u_xlat5 / u_xlat0.x;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 311286
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[3];
						vec4 _MainTex_TexelSize;
						vec4 _AOParams;
						vec4 unused_0_5[2];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat12;
					float u_xlat17;
					void main()
					{
					    u_xlat0.x = _MainTex_TexelSize.y / _AOParams.z;
					    u_xlat0.y = float(1.38461542);
					    u_xlat0.z = float(3.23076916);
					    u_xlat1 = vec4(-0.0, -2.76923084, -0.0, -6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat0 = vec4(0.0, 2.76923084, 0.0, 6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat8.xyz = u_xlat3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat8.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat7.x = u_xlat7.x * u_xlat12;
					    u_xlat7.x = u_xlat7.x * 0.31621623;
					    u_xlat2.x = u_xlat7.x * u_xlat2.x;
					    u_xlat2.x = u_xlat3.x * 0.227027029 + u_xlat2.x;
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat9.xyz = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat12 = dot(u_xlat8.xyz, u_xlat9.xyz);
					    u_xlat12 = u_xlat12 + -0.800000012;
					    u_xlat12 = u_xlat12 * 5.00000048;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat17 = u_xlat12 * -2.0 + 3.0;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * u_xlat17;
					    u_xlat17 = u_xlat12 * 0.31621623;
					    u_xlat7.x = u_xlat12 * 0.31621623 + u_xlat7.x;
					    u_xlat2.x = u_xlat4.x * u_xlat17 + u_xlat2.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat6.xyz);
					    u_xlat6.x = u_xlat6.x + -0.800000012;
					    u_xlat6.x = u_xlat6.x * 5.00000048;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					    u_xlat6.x = u_xlat6.x * u_xlat6.x;
					    u_xlat6.x = u_xlat6.x * u_xlat11;
					    u_xlat11 = u_xlat6.x * 0.0702702701;
					    u_xlat6.x = u_xlat6.x * 0.0702702701 + u_xlat7.x;
					    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat2.x;
					    u_xlat5.xyz = u_xlat0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.x = dot(u_xlat8.xyz, u_xlat5.xyz);
					    SV_Target0.yzw = u_xlat8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat5.x = u_xlat5.x + -0.800000012;
					    u_xlat5.x = u_xlat5.x * 5.00000048;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat10 = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = u_xlat5.x * 0.0702702701;
					    u_xlat5.x = u_xlat5.x * 0.0702702701 + u_xlat6.x;
					    u_xlat5.x = u_xlat5.x + 0.227027029;
					    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat1.x;
					    SV_Target0.x = u_xlat0.x / u_xlat5.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Blend Zero OneMinusSrcColor, Zero OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 356579
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[4];
						vec4 _AOParams;
						vec3 _AOColor;
						vec4 _SAOcclusionTexture_TexelSize;
					};
					uniform  sampler2D _SAOcclusionTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_SAOcclusionTexture, u_xlat0.xy);
					    u_xlat5.xyz = u_xlat0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
					    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_SAOcclusionTexture, u_xlat2.xy);
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat7.x = u_xlat7.x * u_xlat12;
					    u_xlat0.x = u_xlat2.x * u_xlat7.x + u_xlat0.x;
					    u_xlat1.zw = (-u_xlat1.yx);
					    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_SAOcclusionTexture, u_xlat1.xy);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_SAOcclusionTexture, u_xlat3.xy);
					    u_xlat3 = texture(_SAOcclusionTexture, u_xlat3.zw);
					    u_xlat2.xzw = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xzw);
					    u_xlat2.x = u_xlat2.x + -0.800000012;
					    u_xlat2.x = u_xlat2.x * 5.00000048;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12 = u_xlat2.x * -2.0 + 3.0;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat2.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat2.x + u_xlat7.x;
					    u_xlat0.x = u_xlat4.x * u_xlat17 + u_xlat0.x;
					    u_xlat7.xyz = u_xlat3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat17 = u_xlat7.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat7.x + u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat17 + u_xlat0.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat5.x = u_xlat5.x + -0.800000012;
					    u_xlat5.x = u_xlat5.x * 5.00000048;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat10 = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat5.x * u_xlat10;
					    u_xlat5.x = u_xlat10 * u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = u_xlat5.x + 1.0;
					    u_xlat0.x = u_xlat1.x * u_xlat15 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat5.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat5.x = max(u_xlat0.x, 1.1920929e-07);
					    u_xlat0.y = log2(u_xlat5.x);
					    u_xlat5.xy = u_xlat0.yx * vec2(0.416666657, 12.9200001);
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 1.05499995 + -0.0549999997;
					    u_xlatb0 = 0.00313080009>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? u_xlat5.y : u_xlat5.x;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.xyz = u_xlat0.xxx * _AOColor.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Blend Zero OneMinusSrcColor, Zero OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 448316
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[22];
						vec4 _ScreenParams;
						vec4 unused_0_2[3];
						float _RenderViewportScaleFactor;
						vec4 unused_0_4[4];
						vec4 _AOParams;
						vec3 _AOColor;
						vec4 unused_0_7;
					};
					uniform  sampler2D _SAOcclusionTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_SAOcclusionTexture, u_xlat0.xy);
					    u_xlat1.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat1.xy / _AOParams.zz;
					    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_SAOcclusionTexture, u_xlat2.xy);
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.xyz = u_xlat0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat7.x = u_xlat7.x * u_xlat12;
					    u_xlat0.x = u_xlat2.x * u_xlat7.x + u_xlat0.x;
					    u_xlat1.zw = (-u_xlat1.yx);
					    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_SAOcclusionTexture, u_xlat1.xy);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_SAOcclusionTexture, u_xlat3.xy);
					    u_xlat3 = texture(_SAOcclusionTexture, u_xlat3.zw);
					    u_xlat2.xzw = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xzw);
					    u_xlat2.x = u_xlat2.x + -0.800000012;
					    u_xlat2.x = u_xlat2.x * 5.00000048;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12 = u_xlat2.x * -2.0 + 3.0;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat2.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat2.x + u_xlat7.x;
					    u_xlat0.x = u_xlat4.x * u_xlat17 + u_xlat0.x;
					    u_xlat7.xyz = u_xlat3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat17 = u_xlat7.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat7.x + u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat17 + u_xlat0.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat5.x = u_xlat5.x + -0.800000012;
					    u_xlat5.x = u_xlat5.x * 5.00000048;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat10 = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat5.x * u_xlat10;
					    u_xlat5.x = u_xlat10 * u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = u_xlat5.x + 1.0;
					    u_xlat0.x = u_xlat1.x * u_xlat15 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat5.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat5.x = max(u_xlat0.x, 1.1920929e-07);
					    u_xlat0.y = log2(u_xlat5.x);
					    u_xlat5.xy = u_xlat0.yx * vec2(0.416666657, 12.9200001);
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 1.05499995 + -0.0549999997;
					    u_xlatb0 = 0.00313080009>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? u_xlat5.y : u_xlat5.x;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target1.xyz = u_xlat0.xxx * _AOColor.xyz;
					    SV_Target1.w = 0.0;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 519670
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[7];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[4];
						vec4 _AOParams;
						vec4 unused_0_4;
						vec4 _SAOcclusionTexture_TexelSize;
					};
					uniform  sampler2D _SAOcclusionTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0 = texture(_SAOcclusionTexture, u_xlat0.xy);
					    u_xlat5.xyz = u_xlat0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
					    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_SAOcclusionTexture, u_xlat2.xy);
					    u_xlat7.xyz = u_xlat2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat17 = u_xlat7.x * u_xlat12;
					    u_xlat7.x = u_xlat12 * u_xlat7.x + 1.0;
					    u_xlat0.x = u_xlat2.x * u_xlat17 + u_xlat0.x;
					    u_xlat1.zw = (-u_xlat1.yx);
					    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_SAOcclusionTexture, u_xlat1.xy);
					    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_SAOcclusionTexture, u_xlat3.xy);
					    u_xlat3 = texture(_SAOcclusionTexture, u_xlat3.zw);
					    u_xlat2.xzw = u_xlat4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xzw);
					    u_xlat2.x = u_xlat2.x + -0.800000012;
					    u_xlat2.x = u_xlat2.x * 5.00000048;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12 = u_xlat2.x * -2.0 + 3.0;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat2.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat2.x + u_xlat7.x;
					    u_xlat0.x = u_xlat4.x * u_xlat17 + u_xlat0.x;
					    u_xlat7.xyz = u_xlat3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = dot(u_xlat5.xyz, u_xlat7.xyz);
					    u_xlat7.x = u_xlat7.x + -0.800000012;
					    u_xlat7.x = u_xlat7.x * 5.00000048;
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat12 = u_xlat7.x * -2.0 + 3.0;
					    u_xlat7.x = u_xlat7.x * u_xlat7.x;
					    u_xlat17 = u_xlat7.x * u_xlat12;
					    u_xlat2.x = u_xlat12 * u_xlat7.x + u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat17 + u_xlat0.x;
					    u_xlat6.xyz = u_xlat1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat5.x = u_xlat5.x + -0.800000012;
					    u_xlat5.x = u_xlat5.x * 5.00000048;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat10 = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat5.x * u_xlat10;
					    u_xlat5.x = u_xlat10 * u_xlat5.x + u_xlat2.x;
					    u_xlat0.x = u_xlat1.x * u_xlat15 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat5.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat5.x = max(u_xlat0.x, 1.1920929e-07);
					    u_xlat0.y = log2(u_xlat5.x);
					    u_xlat5.xy = u_xlat0.yx * vec2(0.416666657, 12.9200001);
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 1.05499995 + -0.0549999997;
					    u_xlatb0 = 0.00313080009>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? u_xlat5.y : u_xlat5.x;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.xyz = (-u_xlat0.xxx) + vec3(1.0, 1.0, 1.0);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}