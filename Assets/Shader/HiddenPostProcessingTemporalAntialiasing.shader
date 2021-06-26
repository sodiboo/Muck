Shader "Hidden/PostProcessing/TemporalAntialiasing" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 63221
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 _CameraDepthTexture_TexelSize;
						vec2 _Jitter;
						vec4 _FinalBlendParameters;
						float _Sharpness;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _HistoryTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_CameraDepthTexture_TexelSize.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_CameraDepthTexture, u_xlat0.xy).yzxw;
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).yzxw;
					    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat0.x = float(-1.0);
					    u_xlat0.y = float(-1.0);
					    u_xlat1.x = float(0.0);
					    u_xlat1.y = float(0.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = float(1.0);
					    u_xlat1.y = float(-1.0);
					    u_xlat2 = _CameraDepthTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD1.xyxy;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.zw).yzxw;
					    u_xlat1.z = u_xlat3.x;
					    u_xlatb21 = u_xlat3.x>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat2.x = float(-1.0);
					    u_xlat2.y = float(1.0);
					    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy + _CameraDepthTexture_TexelSize.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlatb14 = u_xlat1.x>=u_xlat0.z;
					    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
					    u_xlat1.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat14.xx * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _CameraDepthTexture_TexelSize.xy + vs_TEXCOORD1.xy;
					    u_xlat0 = texture(_CameraMotionVectorsTexture, u_xlat0.xy);
					    u_xlat14.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat0.xy) + vs_TEXCOORD1.xy;
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_HistoryTex, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat14.x);
					    u_xlat7.x = u_xlat0.x * 100.0;
					    u_xlat0.x = u_xlat0.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat14.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
					    u_xlat2.xy = min(u_xlat2.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat14.xy;
					    u_xlat4 = texture(_MainTex, u_xlat14.xy);
					    u_xlat14.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat14.xy = min(u_xlat14.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat3 = texture(_MainTex, u_xlat14.xy);
					    u_xlat5 = u_xlat2 + u_xlat3;
					    u_xlat6 = u_xlat4 + u_xlat4;
					    u_xlat5 = u_xlat5 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat6);
					    u_xlat6 = (-u_xlat5) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat4;
					    u_xlat6 = u_xlat6 * vec4(_Sharpness);
					    u_xlat4 = u_xlat6 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat4;
					    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat4 = min(u_xlat4, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat5.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat14.x = dot(u_xlat5.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat21 = dot(u_xlat4.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
					    u_xlat5.xyz = min(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = max(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat7.xxx * abs(u_xlat14.xxx) + u_xlat2.xyz;
					    u_xlat7.xyz = (-u_xlat7.xxx) * abs(u_xlat14.xxx) + u_xlat5.xyz;
					    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat7.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
					    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
					    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
					    u_xlat2.x = min(u_xlat2.x, 1.0);
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
					    u_xlat1 = (-u_xlat4) + u_xlat1;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat0.x = u_xlat0.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat0.x = max(u_xlat0.x, _FinalBlendParameters.y);
					    u_xlat0.x = min(u_xlat0.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 92432
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2;
						vec4 _MainTex_TexelSize;
						vec4 unused_0_4;
						vec2 _Jitter;
						vec4 _FinalBlendParameters;
						float _Sharpness;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _HistoryTex;
					uniform  sampler2D _CameraMotionVectorsTexture;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat7;
					vec2 u_xlat12;
					float u_xlat13;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_Jitter.xy);
					    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat12.xy = (-_MainTex_TexelSize.xy) * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat12.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat12.xy = min(u_xlat12.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat1 = texture(_MainTex, u_xlat12.xy);
					    u_xlat12.xy = _MainTex_TexelSize.xy * vec2(0.5, 0.5) + u_xlat0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = max(u_xlat12.xy, vec2(0.0, 0.0));
					    u_xlat0.xy = min(u_xlat0.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3 = u_xlat0 + u_xlat1;
					    u_xlat4 = u_xlat2 + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(4.0, 4.0, 4.0, 4.0) + (-u_xlat4);
					    u_xlat4 = (-u_xlat3) * vec4(0.166666999, 0.166666999, 0.166666999, 0.166666999) + u_xlat2;
					    u_xlat4 = u_xlat4 * vec4(_Sharpness);
					    u_xlat2 = u_xlat4 * vec4(2.71828198, 2.71828198, 2.71828198, 2.71828198) + u_xlat2;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = min(u_xlat2, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    u_xlat3.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.142857, 0.142857, 0.142857);
					    u_xlat18 = dot(u_xlat3.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat19 = dot(u_xlat2.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat18 = u_xlat18 + (-u_xlat19);
					    u_xlat3.xyz = min(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1 = texture(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy);
					    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = (-u_xlat1.xy) + vs_TEXCOORD1.xy;
					    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					    u_xlat1.xy = min(u_xlat1.xy, vec2(_RenderViewportScaleFactor));
					    u_xlat4 = texture(_HistoryTex, u_xlat1.xy);
					    u_xlat1.x = sqrt(u_xlat13);
					    u_xlat7.x = u_xlat1.x * 100.0;
					    u_xlat1.x = u_xlat1.x * _FinalBlendParameters.z;
					    u_xlat7.x = min(u_xlat7.x, 1.0);
					    u_xlat7.x = u_xlat7.x * -3.75 + 4.0;
					    u_xlat3.xyz = (-u_xlat7.xxx) * abs(vec3(u_xlat18)) + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat7.xxx * abs(vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = (-u_xlat0.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat5.xyz = u_xlat3.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
					    u_xlat18 = min(u_xlat18, 1.0);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat4;
					    u_xlat7.x = (-_FinalBlendParameters.x) + _FinalBlendParameters.y;
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + _FinalBlendParameters.x;
					    u_xlat1.x = max(u_xlat1.x, _FinalBlendParameters.y);
					    u_xlat1.x = min(u_xlat1.x, _FinalBlendParameters.x);
					    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = min(u_xlat0, vec4(65472.0, 65472.0, 65472.0, 65472.0));
					    SV_Target0 = u_xlat0;
					    SV_Target1 = u_xlat0;
					    return;
					}"
				}
			}
		}
	}
}