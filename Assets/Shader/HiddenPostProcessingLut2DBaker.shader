Shader "Hidden/PostProcessing/Lut2DBaker" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 57050
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
						vec4 unused_0_2[19];
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						float _Brightness;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_13[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 112774
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
						vec4 unused_0_2[19];
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
						vec4 _Lut2D_Params;
						vec4 _UserLut2D_Params;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						float _Brightness;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_13[7];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = _UserLut2D_Params.y;
					    u_xlat1.yz = vs_TEXCOORD1.xy + (-_Lut2D_Params.yz);
					    u_xlat2.x = u_xlat1.y * _Lut2D_Params.x;
					    u_xlat1.x = fract(u_xlat2.x);
					    u_xlat2.x = u_xlat1.x / _Lut2D_Params.x;
					    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
					    u_xlat2.xyz = u_xlat1.xzw * _Lut2D_Params.www;
					    u_xlat3.xyz = u_xlat2.zxy * _UserLut2D_Params.zzz;
					    u_xlat7 = floor(u_xlat3.x);
					    u_xlat3.xw = _UserLut2D_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _UserLut2D_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat7 * _UserLut2D_Params.y + u_xlat3.y;
					    u_xlat7 = u_xlat2.z * _UserLut2D_Params.z + (-u_xlat7);
					    u_xlat0.y = float(0.0);
					    u_xlat12.y = float(0.25);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat3 = texture(_MainTex, u_xlat3.xz);
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = (-u_xlat1.xzw) * _Lut2D_Params.www + u_xlat3.xyz;
					    u_xlat1.xyz = _UserLut2D_Params.www * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(-0.217637643, -0.217637643, -0.217637643);
					    u_xlat1.xyz = u_xlat1.xyz * _HueSatCon.zzz + vec3(0.217637643, 0.217637643, 0.217637643);
					    u_xlat2.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorBalance.xyz;
					    u_xlat2.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
					    u_xlat2.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
					    u_xlat2.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _ColorFilter.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, _ChannelMixerRed.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, _ChannelMixerGreen.xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, _ChannelMixerBlue.xyz);
					    u_xlat1.xyz = u_xlat2.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
					    u_xlat1.xyz = u_xlat1.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat2.xyz * _InvGamma.xyz;
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat2.xy = u_xlat1.zy;
					    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
					    u_xlat2.z = float(-1.0);
					    u_xlat2.w = float(0.666666687);
					    u_xlat3.z = float(1.0);
					    u_xlat3.w = float(-1.0);
					    u_xlat2 = u_xlat0.xxxx * u_xlat3.xywz + u_xlat2.xywz;
					    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3.z = u_xlat2.w;
					    u_xlat2.w = u_xlat1.x;
					    u_xlat13.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat3.xyw = u_xlat2.wyx;
					    u_xlat3 = (-u_xlat2) + u_xlat3;
					    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
					    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat6.x = u_xlat0.x * 6.0 + 9.99999975e-05;
					    u_xlat8 = (-u_xlat2.y) + u_xlat2.w;
					    u_xlat6.x = u_xlat8 / u_xlat6.x;
					    u_xlat6.x = u_xlat6.x + u_xlat2.z;
					    u_xlat12.x = abs(u_xlat6.x);
					    u_xlat3 = textureLod(_Curves, u_xlat12.xy, 0.0).yxzw;
					    u_xlat4.x = u_xlat12.x + _HueSatCon.x;
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat3.x + u_xlat3.x;
					    u_xlat12.x = u_xlat2.x + 9.99999975e-05;
					    u_xlat1.x = u_xlat0.x / u_xlat12.x;
					    u_xlat1.y = float(0.25);
					    u_xlat13.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat1.xy, 0.0).zxyw;
					    u_xlat5 = textureLod(_Curves, u_xlat13.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat3.xx, u_xlat6.xx);
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat0.x = dot(_HueSatCon.yy, u_xlat0.xx);
					    u_xlat4.y = 0.25;
					    u_xlat3 = textureLod(_Curves, u_xlat4.xy, 0.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + u_xlat3.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat2.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw).wxyz;
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    u_xlat1.z = u_xlat0.w;
					    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
					    u_xlat1.y = u_xlat2.w;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz + vec3(0.00390625, 0.00390625, 0.00390625);
					    u_xlat0.w = 0.75;
					    u_xlat1 = texture(_Curves, u_xlat0.xw);
					    SV_Target0.x = u_xlat1.x;
					    SV_Target0.x = clamp(SV_Target0.x, 0.0, 1.0);
					    u_xlat1 = texture(_Curves, u_xlat0.yw);
					    u_xlat0 = texture(_Curves, u_xlat0.zw);
					    SV_Target0.z = u_xlat0.z;
					    SV_Target0.z = clamp(SV_Target0.z, 0.0, 1.0);
					    SV_Target0.y = u_xlat1.y;
					    SV_Target0.y = clamp(SV_Target0.y, 0.0, 1.0);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 175109
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_ACES" }
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_NEUTRAL" }
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
						vec4 unused_0_2[19];
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
					Keywords { "TONEMAPPING_CUSTOM" }
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
						vec4 unused_0_2[19];
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_ACES" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.386036009, -0.386036009, -0.386036009);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
					    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(65504.0, 65504.0, 65504.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(1.525878e-05, 1.525878e-05, 1.525878e-05);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat2.xyz = log2(u_xlat0.xyz);
					    u_xlatb0.xyz = lessThan(u_xlat0.xyzx, vec4(3.05175708e-05, 3.05175708e-05, 3.05175708e-05, 0.0)).xyz;
					    u_xlat2.xyz = u_xlat2.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.413588405, 0.413588405, 0.413588405);
					    u_xlatb1 = lessThan(u_xlat0.xxyy, vec4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
					    u_xlat0.xyw = u_xlat0.xyz * vec3(17.5200005, 17.5200005, 17.5200005) + vec3(-9.72000027, -9.72000027, -9.72000027);
					    u_xlatb2.xy = lessThan(u_xlat0.zzzz, vec4(-0.301369876, 1.46799636, 0.0, 0.0)).xy;
					    u_xlat0.xyz = exp2(u_xlat0.xyw);
					    u_xlat7.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
					    u_xlat7.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
					    u_xlat0.xyw = u_xlat0.xyz + vec3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
					    u_xlat12 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
					    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
					    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat7.x;
					    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat7.z;
					    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat12;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7.x;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat4.x + -0.5;
					    u_xlat6.x = u_xlat6.x + u_xlat15.x;
					    u_xlatb12 = 1.0<u_xlat6.x;
					    u_xlat7.xy = u_xlat6.xx + vec2(1.0, -1.0);
					    u_xlat12 = (u_xlatb12) ? u_xlat7.y : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat7.x : u_xlat12;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7.x = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7.x;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat7.x = dot(vec3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
					    u_xlat7.y = dot(vec3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
					    u_xlat7.z = dot(vec3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
					    u_xlat0.xyz = (-u_xlat7.yxz) + u_xlat7.zyx;
					    u_xlat0.xy = u_xlat0.xy * u_xlat7.zy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = u_xlat7.x * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat7.y + u_xlat7.z;
					    u_xlat6.x = u_xlat7.x + u_xlat6.x;
					    u_xlat0.x = u_xlat0.x * 1.75 + u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.333333343;
					    u_xlat6.x = 0.0799999982 / u_xlat6.x;
					    u_xlat12 = min(u_xlat7.y, u_xlat7.x);
					    u_xlat12 = min(u_xlat7.z, u_xlat12);
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat18 = max(u_xlat7.y, u_xlat7.x);
					    u_xlat18 = max(u_xlat7.z, u_xlat18);
					    u_xlat2.xy = max(vec2(u_xlat18), vec2(9.99999975e-05, 0.00999999978));
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat6.y = u_xlat12 / u_xlat2.y;
					    u_xlat6.xz = u_xlat6.xy + vec2(-0.5, -0.400000006);
					    u_xlat1.x = u_xlat6.z * 2.5;
					    u_xlat18 = u_xlat6.z * intBitsToFloat(int(0x7F800000u)) + 0.5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x + 1.0;
					    u_xlat18 = u_xlat18 * 0.0250000004;
					    u_xlat6.x = u_xlat6.x * u_xlat18;
					    u_xlatb1.x = u_xlat0.x>=0.479999989;
					    u_xlatb0.x = 0.159999996>=u_xlat0.x;
					    u_xlat6.x = (u_xlatb1.x) ? 0.0 : u_xlat6.x;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat18 : u_xlat6.x;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat2.yzw = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat6.x = (-u_xlat7.x) * u_xlat0.x + 0.0299999993;
					    u_xlat18 = u_xlat7.y * u_xlat0.x + (-u_xlat2.w);
					    u_xlat18 = u_xlat18 * 1.73205078;
					    u_xlat1.x = u_xlat2.y * 2.0 + (-u_xlat2.z);
					    u_xlat0.x = (-u_xlat7.z) * u_xlat0.x + u_xlat1.x;
					    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat7.x = min(abs(u_xlat0.x), abs(u_xlat18));
					    u_xlat1.x = u_xlat1.x * u_xlat7.x;
					    u_xlat7.x = u_xlat1.x * u_xlat1.x;
					    u_xlat13 = u_xlat7.x * 0.0208350997 + -0.0851330012;
					    u_xlat13 = u_xlat7.x * u_xlat13 + 0.180141002;
					    u_xlat13 = u_xlat7.x * u_xlat13 + -0.330299497;
					    u_xlat7.x = u_xlat7.x * u_xlat13 + 0.999866009;
					    u_xlat13 = u_xlat7.x * u_xlat1.x;
					    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
					    u_xlatb19 = abs(u_xlat0.x)<abs(u_xlat18);
					    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat7.x + u_xlat13;
					    u_xlatb7 = u_xlat0.x<(-u_xlat0.x);
					    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
					    u_xlat1.x = u_xlat7.x + u_xlat1.x;
					    u_xlat7.x = min(u_xlat0.x, u_xlat18);
					    u_xlat0.x = max(u_xlat0.x, u_xlat18);
					    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb18 = u_xlat7.x<(-u_xlat7.x);
					    u_xlatb0.x = u_xlatb0.x && u_xlatb18;
					    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 57.2957802;
					    u_xlatb1.xy = equal(u_xlat2.zwzz, u_xlat2.yzyy).xy;
					    u_xlatb18 = u_xlatb1.y && u_xlatb1.x;
					    u_xlat0.x = (u_xlatb18) ? 0.0 : u_xlat0.x;
					    u_xlatb18 = u_xlat0.x<0.0;
					    u_xlat1.x = u_xlat0.x + 360.0;
					    u_xlat0.x = (u_xlatb18) ? u_xlat1.x : u_xlat0.x;
					    u_xlatb18 = 180.0<u_xlat0.x;
					    u_xlat1.xy = u_xlat0.xx + vec2(360.0, -360.0);
					    u_xlat18 = (u_xlatb18) ? u_xlat1.y : u_xlat0.x;
					    u_xlatb0.x = u_xlat0.x<-180.0;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat18;
					    u_xlat0.x = u_xlat0.x * 0.0148148146;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat18 = u_xlat0.x * -2.0 + 3.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat18;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat6.y * u_xlat0.x;
					    u_xlat0.x = u_xlat6.x * u_xlat0.x;
					    u_xlat2.x = u_xlat0.x * 0.180000007 + u_xlat2.y;
					    u_xlat0.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
					    u_xlat0.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
					    u_xlat0.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(278.508514, 278.508514, 278.508514) + vec3(10.7771997, 10.7771997, 10.7771997);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(293.604492, 293.604492, 293.604492) + vec3(88.7121964, 88.7121964, 88.7121964);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(80.6889038, 80.6889038, 80.6889038);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
					    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
					    u_xlat18 = max(u_xlat1.y, 0.0);
					    u_xlat18 = min(u_xlat18, 65504.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * 0.981100023;
					    u_xlat1.y = exp2(u_xlat18);
					    u_xlat18 = (-u_xlat0.x) + 1.0;
					    u_xlat0.z = (-u_xlat0.y) + u_xlat18;
					    u_xlat6.x = max(u_xlat0.y, 9.99999975e-05);
					    u_xlat6.x = u_xlat1.y / u_xlat6.x;
					    u_xlat1.xz = u_xlat6.xx * u_xlat0.xz;
					    u_xlat0.x = dot(vec3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
					    u_xlat18 = dot(u_xlat0.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
					    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.930000007, 0.930000007, 0.930000007) + vec3(u_xlat18);
					    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
					    u_xlat0.x = dot(vec3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
					    u_xlat0.y = dot(vec3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
					    u_xlat0.z = dot(vec3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
					    u_xlat1.x = dot(vec3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_NEUTRAL" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 unused_0_12[7];
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.0695999935, 0.0695999935, 0.0695999935);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.262677222, 0.262677222, 0.262677222) + vec3(0.289999992, 0.289999992, 0.289999992);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + vec3(0.0816000104, 0.0816000104, 0.0816000104);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(0.00543999998, 0.00543999998, 0.00543999998);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0666666627, -0.0666666627, -0.0666666627);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.31338608, 1.31338608, 1.31338608);
					    SV_Target0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TONEMAPPING_CUSTOM" }
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
						vec4 _Lut2D_Params;
						vec4 unused_0_2;
						vec3 _ColorBalance;
						vec3 _ColorFilter;
						vec3 _HueSatCon;
						vec3 _ChannelMixerRed;
						vec3 _ChannelMixerGreen;
						vec3 _ChannelMixerBlue;
						vec3 _Lift;
						vec3 _InvGamma;
						vec3 _Gain;
						vec4 _CustomToneCurve;
						vec4 _ToeSegmentA;
						vec4 _ToeSegmentB;
						vec4 _MidSegmentA;
						vec4 _MidSegmentB;
						vec4 _ShoSegmentA;
						vec4 _ShoSegmentB;
					};
					uniform  sampler2D _Curves;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat12;
					bool u_xlatb12;
					bvec2 u_xlatb13;
					vec2 u_xlat14;
					vec2 u_xlat15;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
					    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
					    u_xlat0.x = fract(u_xlat1.x);
					    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
					    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.413588405, -0.413588405, -0.413588405);
					    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.0275523961, 0.0275523961, 0.0275523961);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
					    u_xlat1.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorBalance.xyz;
					    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
					    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
					    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _ColorFilter.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, _ChannelMixerRed.xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, _ChannelMixerGreen.xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, _ChannelMixerBlue.xyz);
					    u_xlat0.xyz = u_xlat1.xyz * _Gain.xyz + _Lift.xyz;
					    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
					    u_xlat0.xyz = u_xlat0.xyz * vec3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat1.xy = u_xlat0.zy;
					    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
					    u_xlat1.z = float(-1.0);
					    u_xlat1.w = float(0.666666687);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat1 = vec4(u_xlat18) * u_xlat2.xywz + u_xlat1.xywz;
					    u_xlatb18 = u_xlat0.x>=u_xlat1.x;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat2.z = u_xlat1.w;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat3.x = dot(u_xlat0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat2.xyw = u_xlat1.wyx;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat0 = vec4(u_xlat18) * u_xlat2 + u_xlat1;
					    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
					    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat7 = u_xlat1.x * 6.0 + 9.99999975e-05;
					    u_xlat6.x = (-u_xlat0.y) + u_xlat0.w;
					    u_xlat6.x = u_xlat6.x / u_xlat7;
					    u_xlat6.x = u_xlat6.x + u_xlat0.z;
					    u_xlat2.x = abs(u_xlat6.x);
					    u_xlat15.x = u_xlat2.x + _HueSatCon.x;
					    u_xlat3.y = float(0.25);
					    u_xlat15.y = float(0.25);
					    u_xlat4 = textureLod(_Curves, u_xlat15.xy, 0.0);
					    u_xlat5 = textureLod(_Curves, u_xlat3.xy, 0.0).wxyz;
					    u_xlat5.x = u_xlat5.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat15.x + u_xlat4.x;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(-0.5, 0.5, -1.5);
					    u_xlatb7 = 1.0<u_xlat6.x;
					    u_xlat18 = (u_xlatb7) ? u_xlat6.z : u_xlat6.x;
					    u_xlatb6 = u_xlat6.x<0.0;
					    u_xlat6.x = (u_xlatb6) ? u_xlat6.y : u_xlat18;
					    u_xlat6.xyz = u_xlat6.xxx + vec3(1.0, 0.666666687, 0.333333343);
					    u_xlat6.xyz = fract(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
					    u_xlat6.xyz = abs(u_xlat6.xyz) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat7 = u_xlat0.x + 9.99999975e-05;
					    u_xlat14.x = u_xlat1.x / u_xlat7;
					    u_xlat6.xyz = u_xlat14.xxx * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat0.xxx;
					    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + (-u_xlat1.xxx);
					    u_xlat2.y = float(0.25);
					    u_xlat14.y = float(0.25);
					    u_xlat3 = textureLod(_Curves, u_xlat2.xy, 0.0).yxzw;
					    u_xlat2 = textureLod(_Curves, u_xlat14.xy, 0.0).zxyw;
					    u_xlat2.x = u_xlat2.x;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat18 = u_xlat3.x + u_xlat3.x;
					    u_xlat18 = dot(u_xlat2.xx, vec2(u_xlat18));
					    u_xlat18 = u_xlat18 * u_xlat5.x;
					    u_xlat18 = dot(_HueSatCon.yy, vec2(u_xlat18));
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat1.xxx;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * _CustomToneCurve.xxx;
					    u_xlatb13.xy = lessThan(u_xlat1.zzzz, _CustomToneCurve.yzyz).xy;
					    u_xlatb2 = lessThan(u_xlat1.xxyy, _CustomToneCurve.yzyz);
					    u_xlat3 = (u_xlatb13.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb13.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat12 = u_xlat0.z * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat12 = u_xlat3.z * u_xlat12;
					    u_xlat18 = log2(u_xlat12);
					    u_xlatb12 = 0.0<u_xlat12;
					    u_xlat1.xy = (u_xlatb13.y) ? _MidSegmentB.xy : _ShoSegmentB.xy;
					    u_xlat1.xy = (u_xlatb13.x) ? _ToeSegmentB.xy : u_xlat1.xy;
					    u_xlat18 = u_xlat18 * u_xlat1.y;
					    u_xlat18 = u_xlat18 * 0.693147182 + u_xlat1.x;
					    u_xlat18 = u_xlat18 * 1.44269502;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
					    u_xlat1.z = u_xlat12 * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.y) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat3 = (u_xlatb2.x) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.x * _CustomToneCurve.x + (-u_xlat3.x);
					    u_xlat0.x = u_xlat3.z * u_xlat0.x;
					    u_xlat12 = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat4.x = (u_xlatb2.y) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.y = (u_xlatb2.y) ? _MidSegmentB.y : _ShoSegmentB.y;
					    u_xlat4.z = (u_xlatb2.w) ? _MidSegmentB.x : _ShoSegmentB.x;
					    u_xlat4.w = (u_xlatb2.w) ? _MidSegmentB.y : _ShoSegmentB.y;
					    {
					        vec4 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? _ToeSegmentB.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb2.x) ? _ToeSegmentB.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb2.z) ? _ToeSegmentB.x : u_xlat4.z;
					        hlslcc_movcTemp.w = (u_xlatb2.z) ? _ToeSegmentB.y : u_xlat4.w;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat12 = u_xlat12 * u_xlat4.y;
					    u_xlat12 = u_xlat12 * 0.693147182 + u_xlat4.x;
					    u_xlat12 = u_xlat12 * 1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlatb0 ? u_xlat12 : float(0.0);
					    u_xlat1.x = u_xlat0.x * u_xlat3.w + u_xlat3.y;
					    u_xlat3 = (u_xlatb2.w) ? _MidSegmentA : _ShoSegmentA;
					    u_xlat2 = (u_xlatb2.z) ? _ToeSegmentA : u_xlat3;
					    u_xlat0.x = u_xlat0.y * _CustomToneCurve.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat2.z * u_xlat0.x;
					    u_xlat6.x = log2(u_xlat0.x);
					    u_xlatb0 = 0.0<u_xlat0.x;
					    u_xlat6.x = u_xlat6.x * u_xlat4.w;
					    u_xlat6.x = u_xlat6.x * 0.693147182 + u_xlat4.z;
					    u_xlat6.x = u_xlat6.x * 1.44269502;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = u_xlatb0 ? u_xlat6.x : float(0.0);
					    u_xlat1.y = u_xlat0.x * u_xlat2.w + u_xlat2.y;
					    SV_Target0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}