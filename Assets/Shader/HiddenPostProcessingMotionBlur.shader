Shader "Hidden/PostProcessing/MotionBlur" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 25479
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_0[20];
						vec4 unity_OrthoParams;
						vec4 _ZBufferParams;
						vec4 unused_0_3[7];
						vec4 _CameraMotionVectorsTexture_TexelSize;
						vec4 unused_0_5;
						float _VelocityScale;
						vec4 unused_0_7;
						float _RcpMaxBlurRadius;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.x = _VelocityScale * 0.5;
					    u_xlat0.xy = u_xlat0.xx * _CameraMotionVectorsTexture_TexelSize.zw;
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat4 = sqrt(u_xlat4);
					    u_xlat4 = u_xlat4 * unused_0_7.y;
					    u_xlat4 = max(u_xlat4, 1.0);
					    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
					    u_xlat0.xy = u_xlat0.xy * unused_0_7.yy + vec2(1.0, 1.0);
					    SV_Target0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    u_xlat0.x = (-unity_OrthoParams.w) + 1.0;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1.x * _ZBufferParams.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2 + _ZBufferParams.y;
					    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
					    SV_Target0.z = u_xlat2 / u_xlat0.x;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 95730
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_2[3];
						float _MaxBlurRadius;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.zw = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = u_xlat0 * vec4(_MaxBlurRadius);
					    u_xlat1.x = dot(u_xlat0.zw, u_xlat0.zw);
					    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb1 = u_xlat1.x<u_xlat4;
					    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.zw = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(_MaxBlurRadius);
					    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat1.zw : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 194360
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat0.xy;
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb6 = u_xlat6<u_xlat9;
					    SV_Target0.xy = (bool(u_xlatb6)) ? u_xlat1.xy : u_xlat0.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 233378
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_2[2];
						int _TileMaxLoop;
						vec2 _TileMaxOffs;
						vec4 unused_0_5;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					int u_xlati2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat10;
					vec2 u_xlat13;
					bool u_xlatb13;
					int u_xlati17;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = _MainTex_TexelSize.xy * vec2(_TileMaxOffs.x, _TileMaxOffs.y) + vs_TEXCOORD0.xy;
					    u_xlat1.y = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xw = _MainTex_TexelSize.xy;
					    u_xlat10.x = float(0.0);
					    u_xlat10.y = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<_TileMaxLoop ; u_xlati_loop_1++)
					    {
					        u_xlat7.x = float(u_xlati_loop_1);
					        u_xlat7.xy = u_xlat1.xy * u_xlat7.xx + u_xlat0.xy;
					        u_xlat3.xy = u_xlat10.xy;
					        for(int u_xlati_loop_2 = 0 ; u_xlati_loop_2<_TileMaxLoop ; u_xlati_loop_2++)
					        {
					            u_xlat13.x = float(u_xlati_loop_2);
					            u_xlat13.xy = u_xlat1.zw * u_xlat13.xx + u_xlat7.xy;
					            u_xlat4 = texture(_MainTex, u_xlat13.xy);
					            u_xlat13.x = dot(u_xlat3.xy, u_xlat3.xy);
					            u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
					            u_xlatb13 = u_xlat13.x<u_xlat18;
					            u_xlat3.xy = (bool(u_xlatb13)) ? u_xlat4.xy : u_xlat3.xy;
					        }
					        u_xlat10.xy = u_xlat3.xy;
					    }
					    SV_Target0.xy = u_xlat10.xy;
					    SV_Target0.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 280318
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat8 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb8 = u_xlat8<u_xlat12;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat2 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat2.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9.xy = u_xlat2.xy * vec2(1.00999999, 1.00999999);
					    u_xlat2.x = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat9.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat2 = (-_MainTex_TexelSize.xyxy) * vec4(-1.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat2.zw);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat1.zw);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat9.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlatb12 = u_xlat9.x<u_xlat12;
					    u_xlat9.xy = (bool(u_xlatb12)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat12 = dot(u_xlat9.xy, u_xlat9.xy);
					    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb12 = u_xlat2.x<u_xlat12;
					    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat9.xy : u_xlat1.xy;
					    u_xlat12 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlatb8 = u_xlat12<u_xlat8;
					    u_xlat0.xy = (bool(u_xlatb8)) ? u_xlat0.xy : u_xlat1.xy;
					    SV_Target0.xy = u_xlat0.xy * vec2(0.990099013, 0.990099013);
					    SV_Target0.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 348419
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
						vec4 unused_0_2[6];
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
						vec4 unused_0_2[5];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						vec2 _VelocityTex_TexelSize;
						vec2 _NeighborMaxTex_TexelSize;
						vec4 unused_0_7;
						float _MaxBlurRadius;
						float _LoopCount;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _VelocityTex;
					uniform  sampler2D _NeighborMaxTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec2 u_xlatb7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					float u_xlat14;
					float u_xlat21;
					vec2 u_xlat23;
					float u_xlat24;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat34;
					float u_xlat37;
					float u_xlat38;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(2.0, 0.0);
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat1.xy);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 52.9829178;
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 6.28318548;
					    u_xlat2.x = cos(u_xlat1.x);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1.xy = u_xlat2.xy * vec2(_NeighborMaxTex_TexelSize.x, _NeighborMaxTex_TexelSize.y);
					    u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_NeighborMaxTex, u_xlat1.xy);
					    u_xlat21 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb31 = u_xlat21<2.0;
					    if(u_xlatb31){
					        SV_Target0 = u_xlat0;
					        return;
					    }
					    u_xlat2 = textureLod(_VelocityTex, vs_TEXCOORD0.xy, 0.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_MaxBlurRadius);
					    u_xlat31 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat31 = sqrt(u_xlat31);
					    u_xlat3.xy = max(vec2(u_xlat31), vec2(0.5, 1.0));
					    u_xlat31 = float(1.0) / u_xlat2.z;
					    u_xlat32 = u_xlat3.x + u_xlat3.x;
					    u_xlatb32 = u_xlat21<u_xlat32;
					    u_xlat3.x = u_xlat21 / u_xlat3.x;
					    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
					    u_xlat2.xy = (bool(u_xlatb32)) ? u_xlat2.xy : u_xlat1.xy;
					    u_xlat32 = u_xlat21 * 0.5;
					    u_xlat32 = min(u_xlat32, _LoopCount);
					    u_xlat32 = floor(u_xlat32);
					    u_xlat3.x = float(1.0) / u_xlat32;
					    u_xlat23.xy = vs_TEXCOORD0.xy * _ScreenParams.xy;
					    u_xlat23.xy = floor(u_xlat23.xy);
					    u_xlat23.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat23.xy);
					    u_xlat3.z = fract(u_xlat23.x);
					    u_xlat23.xy = u_xlat3.zx * vec2(52.9829178, 0.25);
					    u_xlat23.x = fract(u_xlat23.x);
					    u_xlat23.x = u_xlat23.x + -0.5;
					    u_xlat4 = (-u_xlat3.x) * 0.5 + 1.0;
					    u_xlat5.w = 1.0;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    u_xlat6.w = float(0.0);
					    u_xlat14 = u_xlat4;
					    u_xlat24 = 0.0;
					    u_xlat34 = u_xlat3.y;
					    while(true){
					        u_xlatb7.x = u_xlat23.y>=u_xlat14;
					        if(u_xlatb7.x){break;}
					        u_xlat7.xy = vec2(u_xlat24) * vec2(0.25, 0.5);
					        u_xlat7.xy = fract(u_xlat7.xy);
					        u_xlatb7.xy = lessThan(vec4(0.499000013, 0.499000013, 0.0, 0.0), u_xlat7.xyxx).xy;
					        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
					        u_xlat37 = (u_xlatb7.y) ? (-u_xlat14) : u_xlat14;
					        u_xlat37 = u_xlat23.x * u_xlat3.x + u_xlat37;
					        u_xlat7.xz = vec2(u_xlat37) * u_xlat7.xz;
					        u_xlat8.xy = u_xlat7.xz * _MainTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat7.xz = u_xlat7.xz * _VelocityTex_TexelSize.xy + vs_TEXCOORD0.xy;
					        u_xlat8 = textureLod(_MainTex, u_xlat8.xy, 0.0);
					        u_xlat9 = textureLod(_VelocityTex, u_xlat7.xz, 0.0);
					        u_xlat7.xz = u_xlat9.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					        u_xlat7.xz = u_xlat7.xz * vec2(_MaxBlurRadius);
					        u_xlat38 = u_xlat2.z + (-u_xlat9.z);
					        u_xlat38 = u_xlat31 * u_xlat38;
					        u_xlat38 = u_xlat38 * 20.0;
					        u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
					        u_xlat7.x = sqrt(u_xlat7.x);
					        u_xlat7.x = (-u_xlat34) + u_xlat7.x;
					        u_xlat7.x = u_xlat38 * u_xlat7.x + u_xlat34;
					        u_xlat27 = (-u_xlat21) * abs(u_xlat37) + u_xlat7.x;
					        u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					        u_xlat27 = u_xlat27 / u_xlat7.x;
					        u_xlat37 = (-u_xlat14) + 1.20000005;
					        u_xlat27 = u_xlat37 * u_xlat27;
					        u_xlat5.xyz = u_xlat8.xyz;
					        u_xlat6 = u_xlat5 * vec4(u_xlat27) + u_xlat6;
					        u_xlat34 = max(u_xlat34, u_xlat7.x);
					        u_xlat5.x = (-u_xlat3.x) + u_xlat14;
					        u_xlat14 = (u_xlatb7.y) ? u_xlat5.x : u_xlat14;
					        u_xlat24 = u_xlat24 + 1.0;
					    }
					    u_xlat1.x = dot(vec2(u_xlat34), vec2(u_xlat32));
					    u_xlat1.x = 1.20000005 / u_xlat1.x;
					    u_xlat2.xyz = u_xlat0.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1 = u_xlat2 * u_xlat1.xxxx + u_xlat6;
					    SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
			}
		}
	}
}