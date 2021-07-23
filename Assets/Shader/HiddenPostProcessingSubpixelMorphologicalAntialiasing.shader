Shader "Hidden/PostProcessing/SubpixelMorphologicalAntialiasing" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 53444
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 120903
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 142247
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-1.0, 0.0, 0.0, -1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
					    vs_TEXCOORD3 = _MainTex_TexelSize.xyxy * vec4(-2.0, 0.0, 0.0, -2.0) + u_xlat0.xyxy;
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
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					float u_xlat12;
					vec2 u_xlat14;
					bvec2 u_xlatb14;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat18 = max(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = max(abs(u_xlat2.z), u_xlat18);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.zw);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat2.y = max(abs(u_xlat4.z), u_xlat18);
					    u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001)).xy;
					    u_xlat14.x = u_xlatb14.x ? float(1.0) : 0.0;
					    u_xlat14.y = u_xlatb14.y ? float(1.0) : 0.0;
					;
					    u_xlat18 = dot(u_xlat14.xy, vec2(1.0, 1.0));
					    u_xlatb18 = u_xlat18==0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat4.xyz = u_xlat0.xyz + (-u_xlat4.xyz);
					    u_xlat18 = max(abs(u_xlat4.y), abs(u_xlat4.x));
					    u_xlat4.x = max(abs(u_xlat4.z), u_xlat18);
					    u_xlat5 = texture(_MainTex, vs_TEXCOORD2.zw);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
					    u_xlat0.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.y = max(abs(u_xlat0.z), u_xlat0.x);
					    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.xy);
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat1.x = max(abs(u_xlat1.z), u_xlat12);
					    u_xlat4 = texture(_MainTex, vs_TEXCOORD3.zw);
					    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
					    u_xlat12 = max(abs(u_xlat3.y), abs(u_xlat3.x));
					    u_xlat1.y = max(abs(u_xlat3.z), u_xlat12);
					    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
					    u_xlatb0.xy = greaterThanEqual(u_xlat6.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
					    SV_Target0.xy = u_xlat0.xy;
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
			GpuProgramID 255539
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-8.0, 8.0, -8.0, 8.0) + u_xlat1;
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1 = textureLodOffset(_MainTex, u_xlat1.zy, 0.0, ivec2(1, 0)).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 325449
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-16.0, 16.0, -16.0, 16.0) + u_xlat1;
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					bool u_xlatb10;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.yxyy).xy;
					    if(u_xlatb0.x){
					        u_xlat1.xy = vs_TEXCOORD2.xy;
					        u_xlat1.z = 1.0;
					        u_xlat2.x = 0.0;
					        while(true){
					            u_xlatb0.x = vs_TEXCOORD4.x<u_xlat1.x;
					            u_xlatb10 = 0.828100026<u_xlat1.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat2.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat1.xy;
					            u_xlat1.z = u_xlat2.y;
					        }
					        u_xlat2.yz = u_xlat1.xz;
					        u_xlat0.xz = u_xlat2.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat1 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat1.w * -2.00787401 + 3.25;
					        u_xlat1.x = _MainTex_TexelSize.x * u_xlat0.x + u_xlat2.y;
					        u_xlat1.y = vs_TEXCOORD3.y;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat3.xy = vs_TEXCOORD2.zw;
					        u_xlat3.z = 1.0;
					        u_xlat4.x = 0.0;
					        while(true){
					            u_xlatb0.x = u_xlat3.x<vs_TEXCOORD4.y;
					            u_xlatb10 = 0.828100026<u_xlat3.z;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            u_xlatb10 = u_xlat4.x==0.0;
					            u_xlatb0.x = u_xlatb10 && u_xlatb0.x;
					            if(!u_xlatb0.x){break;}
					            u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					            u_xlat3.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat3.xy;
					            u_xlat3.z = u_xlat4.y;
					        }
					        u_xlat4.yz = u_xlat3.xz;
					        u_xlat0.xz = u_xlat4.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat3 = textureLod(_SearchTex, u_xlat0.xz, 0.0);
					        u_xlat0.x = u_xlat3.w * -2.00787401 + 3.25;
					        u_xlat1.z = (-_MainTex_TexelSize.x) * u_xlat0.x + u_xlat4.y;
					        u_xlat0.xz = _MainTex_TexelSize.zz * u_xlat1.xz + (-vs_TEXCOORD1.xx);
					        u_xlat0.xz = roundEven(u_xlat0.xz);
					        u_xlat0.xz = sqrt(abs(u_xlat0.xz));
					        u_xlat1 = textureLodOffset(_MainTex, u_xlat1.zy, 0.0, ivec2(1, 0)).yxzw;
					        u_xlat1.x = u_xlat2.x;
					        u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
					        u_xlat1.xy = roundEven(u_xlat1.xy);
					        u_xlat0.xz = u_xlat1.xy * vec2(16.0, 16.0) + u_xlat0.xz;
					        u_xlat0.xz = u_xlat0.xz * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat0.xz, 0.0);
					        SV_Target0.xy = u_xlat1.xy;
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    if(u_xlatb0.y){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb15 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2 = 0.828100026<u_xlat0.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            u_xlatb2 = u_xlat1.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb2;
					            if(!u_xlatb15){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb15 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb1 = 0.828100026<u_xlat2.z;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            u_xlatb1 = u_xlat3.x==0.0;
					            u_xlatb15 = u_xlatb15 && u_xlatb1;
					            if(!u_xlatb15){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat15 = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat15 + u_xlat3.y;
					        u_xlat0.xw = _MainTex_TexelSize.ww * u_xlat0.xz + (-vs_TEXCOORD1.yy);
					        u_xlat0.xw = roundEven(u_xlat0.xw);
					        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat2.x = u_xlat1.y;
					        u_xlat5.xy = u_xlat2.xy * vec2(4.0, 4.0);
					        u_xlat5.xy = roundEven(u_xlat5.xy);
					        u_xlat0.xy = u_xlat5.xy * vec2(16.0, 16.0) + u_xlat0.xw;
					        u_xlat0.xy = u_xlat0.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat0 = textureLod(_AreaTex, u_xlat0.xy, 0.0);
					        SV_Target0.zw = u_xlat0.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 369268
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.zw * _MainTex_TexelSize.zw;
					    u_xlat1 = _MainTex_TexelSize.xxyy * vec4(-0.25, 1.25, -0.125, -0.125) + u_xlat0.zzww;
					    u_xlat0 = _MainTex_TexelSize.xyxy * vec4(-0.125, -0.25, -0.125, 1.25) + u_xlat0;
					    vs_TEXCOORD2 = u_xlat1.xzyw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat1.zw = u_xlat0.yw;
					    vs_TEXCOORD4 = _MainTex_TexelSize.xxyy * vec4(-32.0, 32.0, -32.0, 32.0) + u_xlat1;
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AreaTex;
					uniform  sampler2D _SearchTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					bvec4 u_xlatb4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bool u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb7 = 0.0<u_xlat0.y;
					    if(u_xlatb7){
					        u_xlatb7 = 0.0<u_xlat0.x;
					        if(u_xlatb7){
					            u_xlat1.xy = _MainTex_TexelSize.xy * vec2(-1.0, 1.0);
					            u_xlat1.z = 1.0;
					            u_xlat2.xy = vs_TEXCOORD0.xy;
					            u_xlat3.x = 0.0;
					            u_xlat2.z = -1.0;
					            u_xlat4.x = 1.0;
					            while(true){
					                u_xlatb7 = u_xlat2.z<7.0;
					                u_xlatb14 = 0.899999976<u_xlat4.x;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					                u_xlat4.x = dot(u_xlat3.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat3.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat1.x = u_xlat7.x + u_xlat2.z;
					        } else {
					            u_xlat1.x = 0.0;
					            u_xlat4.x = 0.0;
					        }
					        u_xlat7.xy = _MainTex_TexelSize.xy * vec2(1.0, -1.0);
					        u_xlat7.z = 1.0;
					        u_xlat2.yz = vs_TEXCOORD0.xy;
					        u_xlat2.x = float(-1.0);
					        u_xlat23 = float(1.0);
					        while(true){
					            u_xlatb3 = u_xlat2.x<7.0;
					            u_xlatb10 = 0.899999976<u_xlat23;
					            u_xlatb3 = u_xlatb10 && u_xlatb3;
					            if(!u_xlatb3){break;}
					            u_xlat2.xyz = u_xlat7.zxy + u_xlat2.xyz;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.yz, 0.0);
					            u_xlat23 = dot(u_xlat3.xy, vec2(0.5, 0.5));
					        }
					        u_xlat4.y = u_xlat23;
					        u_xlat7.x = u_xlat1.x + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat1.y = (-u_xlat1.x) + 0.25;
					            u_xlat1.zw = u_xlat2.xx * vec2(1.0, -1.0) + vec2(0.0, -0.25);
					            u_xlat2 = u_xlat1.yxzw * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat3 = textureLodOffset(_MainTex, u_xlat2.xy, 0.0, ivec2(-1, 0));
					            u_xlat2 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, 0));
					            u_xlat3.z = u_xlat2.x;
					            u_xlat7.xy = u_xlat3.xz * vec2(5.0, 5.0) + vec2(-3.75, -3.75);
					            u_xlat7.xy = abs(u_xlat7.xy) * u_xlat3.xz;
					            u_xlat7.xy = roundEven(u_xlat7.xy);
					            u_xlat8.x = roundEven(u_xlat3.y);
					            u_xlat8.z = roundEven(u_xlat2.y);
					            u_xlat7.xy = u_xlat8.xz * vec2(2.0, 2.0) + u_xlat7.xy;
					            u_xlatb8.xz = greaterThanEqual(u_xlat4.xxyy, vec4(0.899999976, 0.0, 0.899999976, 0.899999976)).xz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.z) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat1.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat1 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					        } else {
					            u_xlat1.x = float(0.0);
					            u_xlat1.y = float(0.0);
					        }
					        u_xlat7.x = _MainTex_TexelSize.x * 0.25 + vs_TEXCOORD0.x;
					        u_xlat2.xy = (-_MainTex_TexelSize.xy);
					        u_xlat2.z = 1.0;
					        u_xlat10.x = u_xlat7.x;
					        u_xlat10.y = vs_TEXCOORD0.y;
					        u_xlat3.x = float(1.0);
					        u_xlat10.z = float(-1.0);
					        while(true){
					            u_xlatb14 = u_xlat10.z<7.0;
					            u_xlatb21 = 0.899999976<u_xlat3.x;
					            u_xlatb14 = u_xlatb21 && u_xlatb14;
					            if(!u_xlatb14){break;}
					            u_xlat10.xyz = u_xlat2.xyz + u_xlat10.xyz;
					            u_xlat4 = textureLod(_MainTex, u_xlat10.xy, 0.0);
					            u_xlat14.x = u_xlat4.x * 5.0 + -3.75;
					            u_xlat14.x = abs(u_xlat14.x) * u_xlat4.x;
					            u_xlat5.x = roundEven(u_xlat14.x);
					            u_xlat5.y = roundEven(u_xlat4.y);
					            u_xlat3.x = dot(u_xlat5.xy, vec2(0.5, 0.5));
					        }
					        u_xlat2.x = u_xlat10.z;
					        u_xlat4 = textureLodOffset(_MainTex, vs_TEXCOORD0.xy, 0.0, ivec2(1, 0));
					        u_xlatb14 = 0.0<u_xlat4.x;
					        if(u_xlatb14){
					            u_xlat4.xy = _MainTex_TexelSize.xy;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = u_xlat7.x;
					            u_xlat5.y = vs_TEXCOORD0.y;
					            u_xlat14.x = 0.0;
					            u_xlat5.z = -1.0;
					            u_xlat3.y = 1.0;
					            while(true){
					                u_xlatb15.x = u_xlat5.z<7.0;
					                u_xlatb22 = 0.899999976<u_xlat3.y;
					                u_xlatb15.x = u_xlatb22 && u_xlatb15.x;
					                if(!u_xlatb15.x){break;}
					                u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					                u_xlat6 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					                u_xlat15.x = u_xlat6.x * 5.0 + -3.75;
					                u_xlat15.x = abs(u_xlat15.x) * u_xlat6.x;
					                u_xlat14.y = roundEven(u_xlat15.x);
					                u_xlat14.x = roundEven(u_xlat6.y);
					                u_xlat3.y = dot(u_xlat14.yx, vec2(0.5, 0.5));
					            }
					            u_xlatb7 = 0.899999976<u_xlat14.x;
					            u_xlat7.x = u_xlatb7 ? 1.0 : float(0.0);
					            u_xlat2.z = u_xlat7.x + u_xlat5.z;
					        } else {
					            u_xlat2.z = 0.0;
					            u_xlat3.y = 0.0;
					        }
					        u_xlat7.x = u_xlat2.z + u_xlat2.x;
					        u_xlatb7 = 2.0<u_xlat7.x;
					        if(u_xlatb7){
					            u_xlat2.y = (-u_xlat2.x);
					            u_xlat4 = u_xlat2.yyzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat4.xy, 0.0, ivec2(-1, 0));
					            u_xlat6 = textureLodOffset(_MainTex, u_xlat4.xy, 0.0, ivec2(0, -1)).yzxw;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat4.zw, 0.0, ivec2(1, 0));
					            u_xlat6.x = u_xlat5.y;
					            u_xlat6.yw = u_xlat4.yx;
					            u_xlat7.xy = u_xlat6.xy * vec2(2.0, 2.0) + u_xlat6.zw;
					            u_xlatb15.xy = greaterThanEqual(u_xlat3.xyxy, vec4(0.899999976, 0.899999976, 0.899999976, 0.899999976)).xy;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb15.x) ? float(0.0) : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb15.y) ? float(0.0) : u_xlat7.y;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat7.xy = u_xlat7.xy * vec2(20.0, 20.0) + u_xlat2.xz;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.503125012, 0.000892857148);
					            u_xlat2 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlat1.xy = u_xlat1.xy + u_xlat2.yx;
					        }
					        u_xlatb7 = (-u_xlat1.y)==u_xlat1.x;
					        if(u_xlatb7){
					            u_xlat2.xy = vs_TEXCOORD2.xy;
					            u_xlat2.z = 1.0;
					            u_xlat3.x = 0.0;
					            while(true){
					                u_xlatb7 = vs_TEXCOORD4.x<u_xlat2.x;
					                u_xlatb14 = 0.828100026<u_xlat2.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat3.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					                u_xlat2.xy = _MainTex_TexelSize.xy * vec2(-2.0, -0.0) + u_xlat2.xy;
					                u_xlat2.z = u_xlat3.y;
					            }
					            u_xlat3.yz = u_xlat2.xz;
					            u_xlat7.xy = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					            u_xlat2 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat2.w * -2.00787401 + 3.25;
					            u_xlat2.x = _MainTex_TexelSize.x * u_xlat7.x + u_xlat3.y;
					            u_xlat2.y = vs_TEXCOORD3.y;
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					            u_xlat4.xy = vs_TEXCOORD2.zw;
					            u_xlat4.z = 1.0;
					            u_xlat5.x = 0.0;
					            while(true){
					                u_xlatb7 = u_xlat4.x<vs_TEXCOORD4.y;
					                u_xlatb14 = 0.828100026<u_xlat4.z;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                u_xlatb14 = u_xlat5.x==0.0;
					                u_xlatb7 = u_xlatb14 && u_xlatb7;
					                if(!u_xlatb7){break;}
					                u_xlat5 = textureLod(_MainTex, u_xlat4.xy, 0.0);
					                u_xlat4.xy = _MainTex_TexelSize.xy * vec2(2.0, 0.0) + u_xlat4.xy;
					                u_xlat4.z = u_xlat5.y;
					            }
					            u_xlat5.yz = u_xlat4.xz;
					            u_xlat7.xy = u_xlat5.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					            u_xlat4 = textureLod(_SearchTex, u_xlat7.xy, 0.0);
					            u_xlat7.x = u_xlat4.w * -2.00787401 + 3.25;
					            u_xlat2.z = (-_MainTex_TexelSize.x) * u_xlat7.x + u_xlat5.y;
					            u_xlat4 = _MainTex_TexelSize.zzzz * u_xlat2.zxzx + (-vs_TEXCOORD1.xxxx);
					            u_xlat4 = roundEven(u_xlat4);
					            u_xlat7.xy = sqrt(abs(u_xlat4.wz));
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat2.zy, 0.0, ivec2(1, 0)).yxzw;
					            u_xlat5.x = u_xlat3.x;
					            u_xlat15.xy = u_xlat5.xy * vec2(4.0, 4.0);
					            u_xlat15.xy = roundEven(u_xlat15.xy);
					            u_xlat7.xy = u_xlat15.xy * vec2(16.0, 16.0) + u_xlat7.xy;
					            u_xlat7.xy = u_xlat7.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					            u_xlat3 = textureLod(_AreaTex, u_xlat7.xy, 0.0);
					            u_xlatb4 = greaterThanEqual(abs(u_xlat4), abs(u_xlat4.wzwz));
					            u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					            u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					            u_xlat4.z = u_xlatb4.z ? float(0.75) : 0.0;
					            u_xlat4.w = u_xlatb4.w ? float(0.75) : 0.0;
					;
					            u_xlat7.x = u_xlat4.y + u_xlat4.x;
					            u_xlat7.xy = u_xlat4.zw / u_xlat7.xx;
					            u_xlat2.w = vs_TEXCOORD0.y;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat2.xw, 0.0, ivec2(0, 1));
					            u_xlat21 = (-u_xlat7.x) * u_xlat4.x + 1.0;
					            u_xlat4 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, 1));
					            u_xlat4.x = (-u_xlat7.y) * u_xlat4.x + u_xlat21;
					            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					            u_xlat5 = textureLodOffset(_MainTex, u_xlat2.xw, 0.0, ivec2(0, -2));
					            u_xlat7.x = (-u_xlat7.x) * u_xlat5.x + 1.0;
					            u_xlat2 = textureLodOffset(_MainTex, u_xlat2.zw, 0.0, ivec2(1, -2));
					            u_xlat4.y = (-u_xlat7.y) * u_xlat2.x + u_xlat7.x;
					            u_xlat4.y = clamp(u_xlat4.y, 0.0, 1.0);
					            SV_Target0.xy = u_xlat3.xy * u_xlat4.xy;
					        } else {
					            SV_Target0.xy = u_xlat1.xy;
					            u_xlat0.x = 0.0;
					        }
					    } else {
					        SV_Target0.xy = vec2(0.0, 0.0);
					    }
					    u_xlatb0 = 0.0<u_xlat0.x;
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD3.xy;
					        u_xlat0.z = 1.0;
					        u_xlat1.x = 0.0;
					        while(true){
					            u_xlatb21 = vs_TEXCOORD4.z<u_xlat0.y;
					            u_xlatb2.x = 0.828100026<u_xlat0.z;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            u_xlatb2.x = u_xlat1.x==0.0;
					            u_xlatb21 = u_xlatb21 && u_xlatb2.x;
					            if(!u_xlatb21){break;}
					            u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0).yxzw;
					            u_xlat0.xy = _MainTex_TexelSize.xy * vec2(-0.0, -2.0) + u_xlat0.xy;
					            u_xlat0.z = u_xlat1.y;
					        }
					        u_xlat1.yz = u_xlat0.yz;
					        u_xlat0.xy = u_xlat1.xz * vec2(0.5, -2.0) + vec2(0.0078125, 2.03125);
					        u_xlat0 = textureLod(_SearchTex, u_xlat0.xy, 0.0);
					        u_xlat0.x = u_xlat0.w * -2.00787401 + 3.25;
					        u_xlat0.x = _MainTex_TexelSize.y * u_xlat0.x + u_xlat1.y;
					        u_xlat0.y = vs_TEXCOORD2.x;
					        u_xlat1 = textureLod(_MainTex, u_xlat0.yx, 0.0);
					        u_xlat2.xy = vs_TEXCOORD3.zw;
					        u_xlat2.z = 1.0;
					        u_xlat3.x = 0.0;
					        while(true){
					            u_xlatb1 = u_xlat2.y<vs_TEXCOORD4.w;
					            u_xlatb15.x = 0.828100026<u_xlat2.z;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            u_xlatb15.x = u_xlat3.x==0.0;
					            u_xlatb1 = u_xlatb15.x && u_xlatb1;
					            if(!u_xlatb1){break;}
					            u_xlat3 = textureLod(_MainTex, u_xlat2.xy, 0.0).yxzw;
					            u_xlat2.xy = _MainTex_TexelSize.xy * vec2(0.0, 2.0) + u_xlat2.xy;
					            u_xlat2.z = u_xlat3.y;
					        }
					        u_xlat3.yz = u_xlat2.yz;
					        u_xlat1.xz = u_xlat3.xz * vec2(0.5, -2.0) + vec2(0.5234375, 2.03125);
					        u_xlat2 = textureLod(_SearchTex, u_xlat1.xz, 0.0);
					        u_xlat1.x = u_xlat2.w * -2.00787401 + 3.25;
					        u_xlat0.z = (-_MainTex_TexelSize.y) * u_xlat1.x + u_xlat3.y;
					        u_xlat2 = _MainTex_TexelSize.wwww * u_xlat0.zxzx + (-vs_TEXCOORD1.yyyy);
					        u_xlat2 = roundEven(u_xlat2);
					        u_xlat1.xz = sqrt(abs(u_xlat2.wz));
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.yz, 0.0, ivec2(0, 1));
					        u_xlat3.x = u_xlat1.y;
					        u_xlat8.xz = u_xlat3.xy * vec2(4.0, 4.0);
					        u_xlat8.xz = roundEven(u_xlat8.xz);
					        u_xlat1.xy = u_xlat8.xz * vec2(16.0, 16.0) + u_xlat1.xz;
					        u_xlat1.xy = u_xlat1.xy * vec2(0.00625000009, 0.0017857143) + vec2(0.00312500005, 0.000892857148);
					        u_xlat1 = textureLod(_AreaTex, u_xlat1.xy, 0.0);
					        u_xlatb2 = greaterThanEqual(abs(u_xlat2), abs(u_xlat2.wzwz));
					        u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					        u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
					        u_xlat2.z = u_xlatb2.z ? float(0.75) : 0.0;
					        u_xlat2.w = u_xlatb2.w ? float(0.75) : 0.0;
					;
					        u_xlat7.x = u_xlat2.y + u_xlat2.x;
					        u_xlat15.xy = u_xlat2.zw / u_xlat7.xx;
					        u_xlat0.w = vs_TEXCOORD0.x;
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.wx, 0.0, ivec2(1, 0));
					        u_xlat7.x = (-u_xlat15.x) * u_xlat2.y + 1.0;
					        u_xlat2 = textureLodOffset(_MainTex, u_xlat0.wz, 0.0, ivec2(1, 1));
					        u_xlat16.x = (-u_xlat15.y) * u_xlat2.y + u_xlat7.x;
					        u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.wx, 0.0, ivec2(-2, 0));
					        u_xlat0.x = (-u_xlat15.x) * u_xlat3.y + 1.0;
					        u_xlat3 = textureLodOffset(_MainTex, u_xlat0.wz, 0.0, ivec2(-2, 1));
					        u_xlat16.y = (-u_xlat15.y) * u_xlat3.y + u_xlat0.x;
					        u_xlat16.y = clamp(u_xlat16.y, 0.0, 1.0);
					        SV_Target0.zw = u_xlat1.xy * u_xlat16.xy;
					    } else {
					        SV_Target0.zw = vec2(0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 422248
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
						vec4 unused_0_0[28];
						vec4 _MainTex_TexelSize;
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(1.0, 0.0, 0.0, 1.0) + u_xlat0.xyxy;
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
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BlendTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_BlendTex, vs_TEXCOORD1.xy);
					    u_xlat1 = texture(_BlendTex, vs_TEXCOORD1.zw);
					    u_xlat2 = texture(_BlendTex, vs_TEXCOORD0.xy).ywzx;
					    u_xlat2.x = u_xlat0.w;
					    u_xlat2.y = u_xlat1.y;
					    u_xlat0.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb0 = u_xlat0.x<9.99999975e-06;
					    if(u_xlatb0){
					        SV_Target0 = textureLod(_MainTex, vs_TEXCOORD0.xy, 0.0);
					    } else {
					        u_xlat0.x = max(u_xlat0.w, u_xlat2.z);
					        u_xlat3 = max(u_xlat2.w, u_xlat2.y);
					        u_xlatb0 = u_xlat3<u_xlat0.x;
					        u_xlat1.x = u_xlatb0 ? u_xlat0.w : float(0.0);
					        u_xlat1.z = u_xlatb0 ? u_xlat2.z : float(0.0);
					        u_xlat1.yw = (bool(u_xlatb0)) ? vec2(0.0, 0.0) : u_xlat2.yw;
					        u_xlat2.x = (u_xlatb0) ? u_xlat0.w : u_xlat2.y;
					        u_xlat2.y = (u_xlatb0) ? u_xlat2.z : u_xlat2.w;
					        u_xlat0.x = dot(u_xlat2.xy, vec2(1.0, 1.0));
					        u_xlat0.xy = u_xlat2.xy / u_xlat0.xx;
					        u_xlat2 = _MainTex_TexelSize.xyxy * vec4(1.0, 1.0, -1.0, -1.0);
					        u_xlat1 = u_xlat1 * u_xlat2 + vs_TEXCOORD0.xyxy;
					        u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					        u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					        u_xlat1 = u_xlat0.yyyy * u_xlat1;
					        SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
					    }
					    return;
					}"
				}
			}
		}
	}
}