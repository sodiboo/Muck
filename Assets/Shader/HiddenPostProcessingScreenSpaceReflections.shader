Shader "Hidden/PostProcessing/ScreenSpaceReflections" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 60921
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
						vec4 unused_0_0[5];
						vec4 _Test_TexelSize;
						mat4x4 _ViewMatrix;
						vec4 unused_0_3[4];
						mat4x4 _InverseProjectionMatrix;
						mat4x4 _ScreenSpaceProjectionMatrix;
						vec4 _Params;
						vec4 _Params2;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3;
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					UNITY_LOCATION(0) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(2) uniform  sampler2D _Noise;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					int u_xlati8;
					bool u_xlatb8;
					float u_xlat9;
					int u_xlati9;
					bool u_xlatb10;
					vec2 u_xlat18;
					float u_xlat27;
					int u_xlati27;
					bool u_xlatb27;
					float u_xlat28;
					void main()
					{
					    u_xlat0 = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy);
					    u_xlat27 = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb27 = u_xlat27==0.0;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2 = u_xlat1.yyyy * _InverseProjectionMatrix[1];
					    u_xlat1 = _InverseProjectionMatrix[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = _InverseProjectionMatrix[2] * vec4(u_xlat27) + u_xlat1;
					    u_xlat1 = u_xlat1 + _InverseProjectionMatrix[3];
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
					    u_xlatb27 = u_xlat1.z<(-_Params.z);
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = u_xlat0.yyy * _ViewMatrix[1].xyz;
					    u_xlat0.xyw = _ViewMatrix[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = _ViewMatrix[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat1.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlatb27 = 0.0<u_xlat0.z;
					    if(u_xlatb27){
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					        return;
					    }
					    u_xlat27 = u_xlat0.z * _Params.z + u_xlat1.z;
					    u_xlatb27 = (-_ProjectionParams.y)<u_xlat27;
					    u_xlat28 = (-u_xlat1.z) + (-_ProjectionParams.y);
					    u_xlat28 = u_xlat28 / u_xlat0.z;
					    u_xlat27 = (u_xlatb27) ? u_xlat28 : _Params.z;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.zzz * _ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.z = _ScreenSpaceProjectionMatrix[0].x * u_xlat1.x + u_xlat2.x;
					    u_xlat3.w = _ScreenSpaceProjectionMatrix[1].y * u_xlat1.y + u_xlat2.y;
					    u_xlat1.xyw = u_xlat0.zzz * _ScreenSpaceProjectionMatrix[2].xyw;
					    u_xlat3.x = _ScreenSpaceProjectionMatrix[0].x * u_xlat0.x + u_xlat1.x;
					    u_xlat3.y = _ScreenSpaceProjectionMatrix[1].y * u_xlat0.y + u_xlat1.y;
					    u_xlat2.zw = vec2(1.0) / vec2(u_xlat2.zz);
					    u_xlat2.xy = vec2(1.0) / vec2(u_xlat1.ww);
					    u_xlat4.w = u_xlat1.z * u_xlat2.w;
					    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
					    u_xlat0.xy = u_xlat3.zw * u_xlat2.zw + (-u_xlat5.zw);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat9 = max(_Test_TexelSize.y, _Test_TexelSize.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(u_xlat9) + u_xlat5.wz;
					    u_xlat5.zw = (-u_xlat3.wz) * u_xlat2.wz + u_xlat0.xy;
					    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
					    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
					    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
					    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati9 = (-u_xlati9) + u_xlati27;
					    u_xlat5.x = float(u_xlati9);
					    u_xlat9 = u_xlat5.x / u_xlat3.z;
					    u_xlat18.x = u_xlat0.z * u_xlat2.y + (-u_xlat4.w);
					    u_xlat5.w = u_xlat9 * u_xlat18.x;
					    u_xlat5.y = u_xlat9 * u_xlat3.w;
					    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
					    u_xlat5.z = u_xlat9 * u_xlat18.x;
					    u_xlat9 = u_xlat1.z * -0.00999999978;
					    u_xlat9 = min(u_xlat9, 1.0);
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Params2.yy;
					    u_xlat1.z = u_xlat1.y * _Params2.x;
					    u_xlat18.xy = u_xlat1.xz + _WorldSpaceCameraPos.xz;
					    u_xlat18.x = textureLod(_Noise, u_xlat18.xy, 0.0).w;
					    u_xlat9 = u_xlat9 * _Params2.z;
					    u_xlat1 = vec4(u_xlat9) * u_xlat5;
					    u_xlat4.xy = u_xlat3.xy;
					    u_xlat4.z = u_xlat2.w;
					    u_xlat2 = u_xlat1 * u_xlat18.xxxx + u_xlat4;
					    u_xlat3.x = intBitsToFloat(int(0xFFFFFFFFu));
					    u_xlat4.x = float(0.0);
					    u_xlat4.y = float(0.0);
					    u_xlat4.z = float(0.0);
					    u_xlat4.w = float(0.0);
					    u_xlat6 = u_xlat2;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    u_xlat7.w = float(0.0);
					    u_xlat18.x = float(0.0);
					    u_xlati27 = int(0);
					    u_xlati8 = 0;
					    while(true){
					        u_xlat1.x = float(u_xlati27);
					        u_xlatb1 = u_xlat1.x>=_Params2.w;
					        u_xlat8.x = 0.0;
					        if(u_xlatb1){break;}
					        u_xlat6 = u_xlat5 * vec4(u_xlat9) + u_xlat6;
					        u_xlat1.xy = u_xlat1.wz * vec2(0.5, 0.5) + u_xlat6.wz;
					        u_xlat1.x = u_xlat1.x / u_xlat1.y;
					        u_xlatb10 = u_xlat18.x<u_xlat1.x;
					        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
					        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
					        u_xlat3.yz = u_xlat1.xy * _Test_TexelSize.xy;
					        u_xlat1.x = textureLod(_CameraDepthTexture, u_xlat3.yz, 0.0).x;
					        u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					        u_xlat1.x = float(1.0) / u_xlat1.x;
					        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
					        u_xlat3.w = intBitsToFloat(u_xlati27 + 1);
					        u_xlat8 = bool(u_xlatb1) ? u_xlat3 : vec4(0.0, 0.0, 0.0, 0.0);
					        u_xlat4 = u_xlat8;
					        u_xlat7 = u_xlat8;
					        if(u_xlatb1){break;}
					        u_xlatb8 = u_xlatb1;
					        u_xlati27 = u_xlati27 + 1;
					        u_xlat4.x = float(0.0);
					        u_xlat4.y = float(0.0);
					        u_xlat4.z = float(0.0);
					        u_xlat4.w = float(0.0);
					        u_xlat7.x = float(0.0);
					        u_xlat7.y = float(0.0);
					        u_xlat7.z = float(0.0);
					        u_xlat7.w = float(0.0);
					    }
					    u_xlat0 = (floatBitsToInt(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
					    u_xlat27 = float(floatBitsToInt(u_xlat0.w));
					    SV_Target0.z = u_xlat27 / _Params2.w;
					    SV_Target0.w = uintBitsToFloat(floatBitsToUint(u_xlat0.x) & 1065353216u);
					    SV_Target0.xy = u_xlat0.yz;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 110939
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
						vec4 unused_0_0[4];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2[17];
						vec4 _Params;
						vec4 unused_0_4;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _Test;
					layout(location = 0) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					uvec4 u_xlatu0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlatu0.xy =  uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat0 = texelFetch(_Test, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlatb1 = u_xlat0.w==0.0;
					    if(u_xlatb1){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
					    u_xlat10 = min(u_xlat10, u_xlat2.x);
					    u_xlat10 = u_xlat10 * 2.19178081;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat9 = u_xlat0.w * u_xlat10;
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
					    u_xlat2.yz = abs(u_xlat0.xy) * _Params.xx;
					    u_xlat0.x = _MainTex_TexelSize.z * _MainTex_TexelSize.y;
					    u_xlat2.x = u_xlat0.x * u_xlat2.y;
					    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat3 = u_xlat0.x * u_xlat0.x;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.z;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 190959
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
						vec4 unused_0_0[4];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2[19];
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _History;
					UNITY_LOCATION(2) uniform  sampler2D _CameraMotionVectorsTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.z = 0.0;
					    u_xlat0.xyw = (-_MainTex_TexelSize.xyy);
					    u_xlat0 = u_xlat0 + vs_TEXCOORD0.xyxy;
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_MainTex, u_xlat0.zw, 0.0);
					    u_xlat2 = min(u_xlat0, u_xlat1);
					    u_xlat0 = max(u_xlat0, u_xlat1);
					    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    u_xlat1 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat3.x = (-_MainTex_TexelSize.x);
					    u_xlat3.y = float(0.0);
					    u_xlat13.y = float(0.0);
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat4);
					    u_xlat13.x = _MainTex_TexelSize.x;
					    u_xlat3.xy = u_xlat13.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					    u_xlat2 = min(u_xlat2, u_xlat3);
					    u_xlat0 = max(u_xlat0, u_xlat3);
					    u_xlat0 = max(u_xlat1, u_xlat0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat2.x = 0.0;
					    u_xlat2.y = _MainTex_TexelSize.y;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2.xy = vs_TEXCOORD0.xy + _MainTex_TexelSize.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat2 = textureLod(_MainTex, vs_TEXCOORD1.xy, 0.0);
					    u_xlat1 = min(u_xlat1, u_xlat2);
					    u_xlat3.xy = textureLod(_CameraMotionVectorsTexture, vs_TEXCOORD1.xy, 0.0).xy;
					    u_xlat13.xy = (-u_xlat3.xy) + vs_TEXCOORD0.xy;
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat3.x = (-_MainTex_TexelSize.z) * 0.00200000009 + u_xlat3.x;
					    u_xlat4 = textureLod(_History, u_xlat13.xy, 0.0);
					    u_xlat1 = max(u_xlat1, u_xlat4);
					    u_xlat0 = max(u_xlat0, u_xlat2);
					    u_xlat0 = min(u_xlat0, u_xlat1);
					    u_xlat1.x = _MainTex_TexelSize.z * 0.00150000001;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat3.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat6;
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat2.w = u_xlat1.x * 0.850000024;
					    u_xlat1 = u_xlat0 + (-u_xlat2);
					    u_xlat0.x = u_xlat0.w * -25.0 + 0.949999988;
					    u_xlat0.x = max(u_xlat0.x, 0.699999988);
					    u_xlat0.x = min(u_xlat0.x, 0.949999988);
					    SV_Target0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    return;
					}"
				}
			}
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 236279
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					 vec4 phase0_Output0_1;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0 = in_POSITION0.xyxy + vec4(1.0, 1.0, 1.0, 1.0);
					    phase0_Output0_1 = u_xlat0 * vec4(0.5, -0.5, 0.5, -0.5) + vec4(0.0, 1.0, 0.0, 1.0);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
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
						vec4 unused_0_0[10];
						mat4x4 _InverseViewMatrix;
						mat4x4 _InverseProjectionMatrix;
						vec4 unused_0_3[4];
						vec4 _Params;
						vec4 unused_0_5;
					};
					UNITY_BINDING(1) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					UNITY_LOCATION(1) uniform  sampler2D _CameraDepthTexture;
					UNITY_LOCATION(2) uniform  sampler2D _CameraReflectionsTexture;
					UNITY_LOCATION(3) uniform  sampler2D _CameraGBufferTexture0;
					UNITY_LOCATION(4) uniform  sampler2D _CameraGBufferTexture1;
					UNITY_LOCATION(5) uniform  sampler2D _CameraGBufferTexture2;
					UNITY_LOCATION(6) uniform  sampler2D _Resolve;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					uvec4 u_xlatu0;
					bool u_xlatb0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec2 u_xlat11;
					float u_xlat13;
					float u_xlat15;
					float u_xlat17;
					float u_xlat18;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = 0.999000013<u_xlat0.x;
					    if(u_xlatb0){
					        SV_Target0 = texture(_MainTex, vs_TEXCOORD1.xy);
					        return;
					    }
					    u_xlatu0.xy =  uvec2(ivec2(hlslcc_FragCoord.xy));
					    u_xlatu0.z = uint(0u);
					    u_xlatu0.w = uint(0u);
					    u_xlat1 = texelFetch(_CameraGBufferTexture0, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).w;
					    u_xlat2 = texelFetch(_CameraGBufferTexture1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
					    u_xlat0.xyz = texelFetch(_CameraGBufferTexture2, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).xyz;
					    u_xlat15 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat15 = max(u_xlat2.z, u_xlat15);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat6.x = textureLod(_CameraDepthTexture, vs_TEXCOORD0.xy, 0.0).x;
					    u_xlat11.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3 = u_xlat11.yyyy * _InverseProjectionMatrix[1];
					    u_xlat3 = _InverseProjectionMatrix[0] * u_xlat11.xxxx + u_xlat3;
					    u_xlat3 = _InverseProjectionMatrix[2] * u_xlat6.xxxx + u_xlat3;
					    u_xlat3 = u_xlat3 + _InverseProjectionMatrix[3];
					    u_xlat6.xyz = u_xlat3.xyz / u_xlat3.www;
					    u_xlat3.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat6.yyy * _InverseViewMatrix[1].xyz;
					    u_xlat3.xyz = _InverseViewMatrix[0].xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat6.xyz = _InverseViewMatrix[2].xyz * u_xlat6.zzz + u_xlat3.xyz;
					    u_xlat3.x = (-u_xlat2.w) + 1.0;
					    u_xlat8 = u_xlat3.x * u_xlat3.x;
					    u_xlat13 = _Params.w + -1.0;
					    u_xlat13 = u_xlat8 * u_xlat13 + 1.0;
					    u_xlat4 = textureLod(_Resolve, vs_TEXCOORD1.xy, u_xlat13);
					    u_xlat13 = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat18 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + (-u_xlat6.xyz);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    u_xlat0.x = dot((-u_xlat6.xyz), u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = max(u_xlat8, 0.00200000009);
					    u_xlat5.x = u_xlat5.x * 0.280000001;
					    u_xlat5.x = (-u_xlat5.x) * u_xlat3.x + 1.0;
					    u_xlat10 = (-u_xlat15) + u_xlat2.w;
					    u_xlat10 = u_xlat10 + 1.0;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat4.xyz * u_xlat5.xxx;
					    u_xlat5.x = -abs(u_xlat13) + 1.0;
					    u_xlat15 = u_xlat5.x * u_xlat5.x;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat5.x = u_xlat5.x * u_xlat15;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(u_xlat10);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = texture(_CameraReflectionsTexture, vs_TEXCOORD1.xy).xyz;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17 = u_xlat4.w * u_xlat4.w;
					    u_xlat4.x = u_xlat17 * 3.0;
					    u_xlat17 = u_xlat17 * 3.0 + -0.5;
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat9 = u_xlat17 * -2.0 + 3.0;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat17 = u_xlat17 * u_xlat9;
					    u_xlat17 = u_xlat17 * u_xlat4.x;
					    u_xlat17 = u_xlat17 * _Params.y;
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat17 = (-u_xlat17) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat17;
					    u_xlat5.xyz = u_xlat6.xyz * u_xlat5.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat1) + u_xlat3.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
			}
		}
	}
}