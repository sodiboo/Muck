Shader "Hidden/PostProcessing/DepthOfField" {
	Properties {
	}
	SubShader {
		Pass {
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 38108
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						float _RcpMaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 74593
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[2];
						vec3 _TaaParams;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraMotionVectorsTexture;
					UNITY_LOCATION(2) uniform  sampler2D _CoCTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat5;
					bool u_xlatb5;
					bool u_xlatb6;
					float u_xlat8;
					bool u_xlatb9;
					vec2 u_xlat11;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
					    u_xlatb5 = u_xlat12<u_xlat1.x;
					    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
					    u_xlat12 = max(u_xlat12, u_xlat1.x);
					    u_xlat12 = max(u_xlat0.z, u_xlat12);
					    u_xlatb9 = u_xlat0.z<u_xlat2.z;
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat11.xy = (-u_xlat3.xy);
					    u_xlat2.xy = bool(u_xlatb5) ? u_xlat11.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlatb6 = u_xlat5.z<u_xlat0.z;
					    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat12 = max(u_xlat12, u_xlat5.z);
					    u_xlat12 = max(u_xlat2.x, u_xlat12);
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
					    u_xlatb5 = u_xlat2.x<u_xlat0.z;
					    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlat0.x = min(u_xlat12, u_xlat0.x);
					    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 155771
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						vec4 unused_0_6;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CoCTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.z, u_xlat13);
					    u_xlat13 = u_xlat13 + 1.0;
					    u_xlat8 = texture(_CoCTex, u_xlat0.zw).x;
					    u_xlat8 = u_xlat8 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat8) / u_xlat13;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
					    u_xlat0.x = texture(_CoCTex, u_xlat0.xy).x;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4.x = max(u_xlat2.y, u_xlat2.x);
					    u_xlat4.x = max(u_xlat2.z, u_xlat4.x);
					    u_xlat4.x = u_xlat4.x + 1.0;
					    u_xlat4.x = abs(u_xlat0.x) / u_xlat4.x;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat1.xyz;
					    u_xlat4.x = u_xlat12 + u_xlat4.x;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
					    u_xlat12 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat12 = max(u_xlat3.z, u_xlat12);
					    u_xlat12 = u_xlat12 + 1.0;
					    u_xlat13 = texture(_CoCTex, u_xlat2.xy).x;
					    u_xlat13 = u_xlat13 * 2.0 + -1.0;
					    u_xlat12 = abs(u_xlat13) / u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat4.x = u_xlat12 + u_xlat4.x;
					    u_xlat3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
					    u_xlat12 = texture(_CoCTex, u_xlat2.zw).x;
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat12) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat4.x = u_xlat4.x + u_xlat2.x;
					    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat4.xxx;
					    u_xlat4.x = min(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat8, u_xlat13);
					    u_xlat8 = max(u_xlat12, u_xlat8);
					    u_xlat4.x = min(u_xlat12, u_xlat4.x);
					    u_xlat4.x = min(u_xlat4.x, u_xlat0.x);
					    u_xlat0.x = max(u_xlat8, u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<(-u_xlat4.x);
					    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat4.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * abs(u_xlat0.x);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat4.x * -2.0 + 3.0;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat0.xyz = max(abs(u_xlat0.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb1.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat1.xyzx).xyz;
					    SV_Target0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
					    SV_Target0.y = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.y;
					    SV_Target0.z = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.z;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 222627
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[16];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 313855
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[22];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 364199
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[43];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 412682
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[71];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 473214
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[3];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 581092
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2;
						float _MaxCoC;
						vec4 unused_0_4;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					uniform  sampler2D _DepthOfFieldTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec3 u_xlatb3;
					float u_xlat5;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb3.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
					    u_xlat0.y = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.y;
					    u_xlat0.z = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.z;
					    u_xlat1 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat1.x = u_xlat1.x + -0.5;
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat5 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.x = u_xlat1.x * _MaxCoC + (-u_xlat5);
					    u_xlat5 = float(1.0) / u_xlat5;
					    u_xlat1.x = u_xlat5 * u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5 = u_xlat1.x * -2.0 + 3.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat1.x * u_xlat5;
					    u_xlat2 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat1.x = u_xlat5 * u_xlat1.x + u_xlat2.w;
					    u_xlat1.x = (-u_xlat9) * u_xlat2.w + u_xlat1.x;
					    u_xlat5 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat2.w = max(u_xlat2.z, u_xlat5);
					    u_xlat2 = (-u_xlat0) + u_xlat2;
					    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
					    u_xlat1.xyz = max(abs(u_xlat0.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.w = u_xlat0.w;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 608515
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = u_xlat0.x + (-_Distance);
					    u_xlat2 = u_xlat2 * _LensCoeff;
					    u_xlat0.x = u_xlat2 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat2 = u_xlat0.x;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat6 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat6 = u_xlat6 + 0.5;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
	SubShader {
		Pass {
			Name "CoC Calculation"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 703831
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						float _RcpMaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat1 = u_xlat0.x + (-_Distance);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat1 = u_xlat1 * _LensCoeff;
					    u_xlat0.x = u_xlat1 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = u_xlat0.x * _RcpMaxCoC + 0.5;
					    SV_Target0 = u_xlat0.xxxx;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "CoC Temporal Filter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 732018
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[2];
						vec3 _TaaParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraMotionVectorsTexture;
					uniform  sampler2D _CoCTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat6;
					float u_xlat10;
					bool u_xlatb11;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CoCTex, u_xlat1.xy);
					    u_xlat1 = texture(_CoCTex, u_xlat1.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
					    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
					    u_xlat6.xy = u_xlat6.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_CoCTex, u_xlat6.xy);
					    u_xlatb15 = u_xlat2.x<u_xlat3.x;
					    u_xlat4.z = (u_xlatb15) ? u_xlat2.x : u_xlat3.x;
					    u_xlat6.x = max(u_xlat2.x, u_xlat3.x);
					    u_xlat6.x = max(u_xlat1.x, u_xlat6.x);
					    u_xlatb11 = u_xlat1.x<u_xlat4.z;
					    u_xlat0.z = u_xlat1.x;
					    u_xlat1.xw = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
					    u_xlat2.xy = (-u_xlat1.xw);
					    u_xlat4.xy = bool(u_xlatb15) ? u_xlat2.xy : vec2(0.0, 0.0);
					    u_xlat0.xyz = (bool(u_xlatb11)) ? u_xlat0.xyz : u_xlat4.xyz;
					    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy).yzxw;
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlatb15 = u_xlat4.z<u_xlat0.z;
					    u_xlat4.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
					    u_xlat6.x = max(u_xlat6.x, u_xlat4.z);
					    u_xlat6.x = max(u_xlat2.x, u_xlat6.x);
					    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat4.xyz : u_xlat0.xyz;
					    u_xlatb15 = u_xlat2.x<u_xlat0.z;
					    u_xlat10 = min(u_xlat2.x, u_xlat0.z);
					    u_xlat0.xy = (bool(u_xlatb15)) ? u_xlat1.xw : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat2.xy) + vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = max(u_xlat10, u_xlat2.x);
					    u_xlat0.x = min(u_xlat6.x, u_xlat0.x);
					    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
					    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat3.xxxx;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Downsample and Prefilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 793451
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						vec4 unused_0_6;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.zw);
					    u_xlat16 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat16 = max(u_xlat1.z, u_xlat16);
					    u_xlat16 = u_xlat16 + 1.0;
					    u_xlat2 = texture(_CoCTex, u_xlat0.zw);
					    u_xlat10 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat10) / u_xlat16;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = texture(_CoCTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat5.x = max(u_xlat2.y, u_xlat2.x);
					    u_xlat5.x = max(u_xlat2.z, u_xlat5.x);
					    u_xlat5.x = u_xlat5.x + 1.0;
					    u_xlat5.x = abs(u_xlat0.x) / u_xlat5.x;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat5.xxx + u_xlat1.xyz;
					    u_xlat5.x = u_xlat15 + u_xlat5.x;
					    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat15 = max(u_xlat3.y, u_xlat3.x);
					    u_xlat15 = max(u_xlat3.z, u_xlat15);
					    u_xlat15 = u_xlat15 + 1.0;
					    u_xlat4 = texture(_CoCTex, u_xlat2.xy);
					    u_xlat16 = u_xlat4.x * 2.0 + -1.0;
					    u_xlat15 = abs(u_xlat16) / u_xlat15;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat1.xyz;
					    u_xlat5.x = u_xlat15 + u_xlat5.x;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_CoCTex, u_xlat2.zw);
					    u_xlat15 = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.x = max(u_xlat3.y, u_xlat3.x);
					    u_xlat2.x = max(u_xlat3.z, u_xlat2.x);
					    u_xlat2.x = u_xlat2.x + 1.0;
					    u_xlat2.x = abs(u_xlat15) / u_xlat2.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat5.x = u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat5.xxx;
					    u_xlat5.x = min(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat10, u_xlat16);
					    u_xlat10 = max(u_xlat15, u_xlat10);
					    u_xlat5.x = min(u_xlat15, u_xlat5.x);
					    u_xlat5.x = min(u_xlat5.x, u_xlat0.x);
					    u_xlat0.x = max(u_xlat10, u_xlat0.x);
					    u_xlatb10 = u_xlat0.x<(-u_xlat5.x);
					    u_xlat0.x = (u_xlatb10) ? u_xlat5.x : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _MaxCoC;
					    u_xlat5.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * abs(u_xlat0.x);
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat5.x * -2.0 + 3.0;
					    u_xlat5.x = u_xlat5.x * u_xlat5.x;
					    u_xlat0.x = u_xlat5.x * u_xlat0.x;
					    u_xlat5.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat0.xyz = max(abs(u_xlat0.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb1.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat1.xyzx).xyz;
					    SV_Target0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
					    SV_Target0.y = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.y;
					    SV_Target0.z = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.z;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (small)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 890411
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[16];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
						ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
						ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
						ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
						ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
						ImmCB_0_0_0[6] = vec2(1.0, 0.0);
						ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
						ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
						ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
						ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
						ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
						ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
						ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
						ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.196349546;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (medium)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 966469
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[22];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
						ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
						ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
						ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
						ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
						ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
						ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
						ImmCB_0_0_0[8] = vec2(1.0, 0.0);
						ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.142799661;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1035014
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[43];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
						ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
						ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
						ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
						ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
						ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
						ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
						ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
						ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
						ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
						ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
						ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
						ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
						ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
						ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
						ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
						ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
						ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
						ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
						ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
						ImmCB_0_0_0[22] = vec2(1.0, 0.0);
						ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
						ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
						ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
						ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
						ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
						ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
						ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
						ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
						ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
						ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
						ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
						ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
						ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
						ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
						ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0730602965;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Bokeh Filter (very large)"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1051185
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
						vec4 unused_0_2[5];
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
					vec2 ImmCB_0_0_0[71];
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						float _MaxCoC;
						float _RcpAspect;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					int u_xlati6;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
						ImmCB_0_0_0[0] = vec2(0.0, 0.0);
						ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
						ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
						ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
						ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
						ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
						ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
						ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
						ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
						ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
						ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
						ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
						ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
						ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
						ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
						ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
						ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
						ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
						ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
						ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
						ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
						ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
						ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
						ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
						ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
						ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
						ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
						ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
						ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
						ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
						ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
						ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
						ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
						ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
						ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
						ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
						ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
						ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
						ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
						ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
						ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
						ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
						ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
						ImmCB_0_0_0[43] = vec2(1.0, 0.0);
						ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
						ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
						ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
						ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
						ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
						ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
						ImmCB_0_0_0[50] = vec2(0.0, 1.0);
						ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
						ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
						ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
						ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
						ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
						ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
						ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
						ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
						ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
						ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
						ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
						ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
						ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
						ImmCB_0_0_0[64] = vec2(0.0, -1.0);
						ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
						ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
						ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
						ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
						ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
						ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat3.x = float(0.0);
					    u_xlat3.y = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
					    {
					        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
					        u_xlat12 = dot(u_xlat4.yz, u_xlat4.yz);
					        u_xlat12 = sqrt(u_xlat12);
					        u_xlat4.x = u_xlat4.y * _RcpAspect;
					        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
					        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat4 = texture(_MainTex, u_xlat4.xy);
					        u_xlat5 = min(u_xlat0.w, u_xlat4.w);
					        u_xlat5 = max(u_xlat5, 0.0);
					        u_xlat5 = (-u_xlat12) + u_xlat5;
					        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
					        u_xlat5 = u_xlat5 / u_xlat0.x;
					        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					        u_xlat12 = (-u_xlat12) + (-u_xlat4.w);
					        u_xlat12 = _MainTex_TexelSize.y * 2.0 + u_xlat12;
					        u_xlat12 = u_xlat12 / u_xlat0.x;
					        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					        u_xlatb22 = (-u_xlat4.w)>=_MainTex_TexelSize.y;
					        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					        u_xlat12 = u_xlat12 * u_xlat22;
					        u_xlat1.xyz = u_xlat4.xyz;
					        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
					        u_xlat3 = u_xlat1 * vec4(u_xlat12) + u_xlat3;
					    }
					    u_xlatb0 = u_xlat2.w==0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
					    u_xlatb18 = u_xlat3.w==0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat3.w;
					    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
					    u_xlat18 = u_xlat3.w * 0.0442477837;
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat18;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Postfilter"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1120897
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4[3];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat0 = u_xlat0 + u_xlat2;
					    u_xlat0 = u_xlat1 + u_xlat0;
					    SV_Target0 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Combine"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1218761
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2;
						float _MaxCoC;
						vec4 unused_0_4;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CoCTex;
					uniform  sampler2D _DepthOfFieldTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec3 u_xlatb3;
					float u_xlat5;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat1.xyz = max(abs(u_xlat1.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb3.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
					    u_xlat0.y = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.y;
					    u_xlat0.z = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.z;
					    u_xlat1 = texture(_CoCTex, vs_TEXCOORD1.xy);
					    u_xlat1.x = u_xlat1.x + -0.5;
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat5 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
					    u_xlat1.x = u_xlat1.x * _MaxCoC + (-u_xlat5);
					    u_xlat5 = float(1.0) / u_xlat5;
					    u_xlat1.x = u_xlat5 * u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5 = u_xlat1.x * -2.0 + 3.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat1.x * u_xlat5;
					    u_xlat2 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
					    u_xlat1.x = u_xlat5 * u_xlat1.x + u_xlat2.w;
					    u_xlat1.x = (-u_xlat9) * u_xlat2.w + u_xlat1.x;
					    u_xlat5 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat2.w = max(u_xlat2.z, u_xlat5);
					    u_xlat2 = (-u_xlat0) + u_xlat2;
					    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
					    u_xlat1.xyz = max(abs(u_xlat0.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat0.xyzx).xyz;
					    SV_Target0.w = u_xlat0.w;
					    SV_Target0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat1.x;
					    SV_Target0.y = (u_xlatb0.y) ? u_xlat2.y : u_xlat1.y;
					    SV_Target0.z = (u_xlatb0.z) ? u_xlat2.z : u_xlat1.z;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Debug Overlay"
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 1269419
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
						vec4 unused_0_2[5];
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[8];
						float _Distance;
						float _LensCoeff;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = u_xlat0.x + (-_Distance);
					    u_xlat2 = u_xlat2 * _LensCoeff;
					    u_xlat0.x = u_xlat2 / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 80.0;
					    u_xlat2 = u_xlat0.x;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
					    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat6 = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat6 = u_xlat6 + 0.5;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}