Shader "Hidden/PostProcessing/FinalPass" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 26315
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					layout(location = 0) in  vec3 in_POSITION0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.063000001;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0311999992);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                    u_xlati5.xy = ~(u_xlati15.xy);
					                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                    if(u_xlati20 != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat5.xy = u_xlat4.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat5.xy = u_xlat10.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                        u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                        u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                        u_xlati5.xy = ~(u_xlati15.xy);
					                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                        u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                        u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                        if(u_xlati20 != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat5.xy = u_xlat4.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat5.xy = u_xlat10.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                            u_xlati5.xy = ~(u_xlati15.xy);
					                            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                            if(u_xlati20 != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat5.xy = u_xlat4.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat5.xy = u_xlat10.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                u_xlati5.xy = ~(u_xlati15.xy);
					                                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                if(u_xlati20 != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat5.xy = u_xlat4.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat5.xy = u_xlat10.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                    u_xlati5.xy = ~(u_xlati15.xy);
					                                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                    if(u_xlati20 != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat5.xy = u_xlat4.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat5.xy = u_xlat10.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                        u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                        u_xlati5.xy = ~(u_xlati15.xy);
					                                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                        u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                        u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                        if(u_xlati20 != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat5.xy = u_xlat4.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat5.xy = u_xlat10.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                                            u_xlat12 = (-u_xlat8.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat8.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat8.x * 8.0 + u_xlat10.x;
					                                            u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                                            u_xlat12 = u_xlat8.y * 8.0 + u_xlat10.z;
					                                            u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.063000001;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0311999992);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                    u_xlati5.xy = ~(u_xlati15.xy);
					                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                    if(u_xlati20 != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat5.xy = u_xlat4.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat5.xy = u_xlat10.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                        u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                        u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                        u_xlati5.xy = ~(u_xlati15.xy);
					                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                        u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                        u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                        if(u_xlati20 != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat5.xy = u_xlat4.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat5.xy = u_xlat10.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                            u_xlati5.xy = ~(u_xlati15.xy);
					                            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                            if(u_xlati20 != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat5.xy = u_xlat4.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat5.xy = u_xlat10.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                u_xlati5.xy = ~(u_xlati15.xy);
					                                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                if(u_xlati20 != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat5.xy = u_xlat4.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat5.xy = u_xlat10.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                    u_xlati5.xy = ~(u_xlati15.xy);
					                                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                    if(u_xlati20 != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat5.xy = u_xlat4.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat5.xy = u_xlat10.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                        u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                        u_xlati5.xy = ~(u_xlati15.xy);
					                                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                        u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                        u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                        if(u_xlati20 != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat5.xy = u_xlat4.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat5.xy = u_xlat10.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                                            u_xlat12 = (-u_xlat8.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat8.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat8.x * 8.0 + u_xlat10.x;
					                                            u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                                            u_xlat12 = u_xlat8.y * 8.0 + u_xlat10.z;
					                                            u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.063000001;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0311999992);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                    u_xlati5.xy = ~(u_xlati15.xy);
					                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                    if(u_xlati20 != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat5.xy = u_xlat4.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat5.xy = u_xlat10.xz;
					                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                        }
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                        u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                        u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                        u_xlati5.xy = ~(u_xlati15.xy);
					                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                        u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                        u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                        if(u_xlati20 != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat5.xy = u_xlat4.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat5.xy = u_xlat10.xz;
					                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                            }
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                            u_xlati5.xy = ~(u_xlati15.xy);
					                            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                            if(u_xlati20 != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat5.xy = u_xlat4.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat5.xy = u_xlat10.xz;
					                                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                }
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                u_xlati5.xy = ~(u_xlati15.xy);
					                                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                if(u_xlati20 != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat5.xy = u_xlat4.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat5.xy = u_xlat10.xz;
					                                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                    }
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                    u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                    u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                    u_xlati5.xy = ~(u_xlati15.xy);
					                                    u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                    u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					                                    u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                    u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					                                    u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                    if(u_xlati20 != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat5.xy = u_xlat4.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat5.xy = u_xlat10.xz;
					                                            u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                            u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                        }
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                                        u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                                        u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                                        u_xlati5.xy = ~(u_xlati15.xy);
					                                        u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                                        u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                                        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                                        u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                                        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                                        if(u_xlati20 != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat5.xy = u_xlat4.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat5.xy = u_xlat10.xz;
					                                                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                                                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                                            }
					                                            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                                            u_xlat12 = (-u_xlat8.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat8.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat8.x * 8.0 + u_xlat10.x;
					                                            u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                                            u_xlat12 = u_xlat8.y * 8.0 + u_xlat10.z;
					                                            u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.063000001;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0311999992);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                    u_xlati10.xz = ~(u_xlati15.xy);
					                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                    if(u_xlati10.x != 0) {
					                        if(u_xlati15.x == 0) {
					                            u_xlat10.xz = u_xlat4.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        if(u_xlati15.y == 0) {
					                            u_xlat10.xz = u_xlat5.xz;
					                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                        }
					                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                        u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                        u_xlati10.xz = ~(u_xlati15.xy);
					                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                        u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                        u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                        if(u_xlati10.x != 0) {
					                            if(u_xlati15.x == 0) {
					                                u_xlat10.xz = u_xlat4.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            if(u_xlati15.y == 0) {
					                                u_xlat10.xz = u_xlat5.xz;
					                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                            }
					                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                            u_xlati10.xz = ~(u_xlati15.xy);
					                            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                            if(u_xlati10.x != 0) {
					                                if(u_xlati15.x == 0) {
					                                    u_xlat10.xz = u_xlat4.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                if(u_xlati15.y == 0) {
					                                    u_xlat10.xz = u_xlat5.xz;
					                                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                }
					                                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                u_xlati10.xz = ~(u_xlati15.xy);
					                                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                if(u_xlati10.x != 0) {
					                                    if(u_xlati15.x == 0) {
					                                        u_xlat10.xz = u_xlat4.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    if(u_xlati15.y == 0) {
					                                        u_xlat10.xz = u_xlat5.xz;
					                                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                    }
					                                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                    u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                    u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					                                    u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                    u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					                                    u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                    u_xlati10.xz = ~(u_xlati15.xy);
					                                    u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                    u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					                                    u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                    u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					                                    u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                    if(u_xlati10.x != 0) {
					                                        if(u_xlati15.x == 0) {
					                                            u_xlat10.xz = u_xlat4.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        if(u_xlati15.y == 0) {
					                                            u_xlat10.xz = u_xlat5.xz;
					                                            u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                            u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                        }
					                                        u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                        u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                        u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                                        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                                        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                                        u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                                        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                                        u_xlati10.xz = ~(u_xlati15.xy);
					                                        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                                        u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                                        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                                        u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                                        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                                        if(u_xlati10.x != 0) {
					                                            if(u_xlati15.x == 0) {
					                                                u_xlat10.xz = u_xlat4.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            if(u_xlati15.y == 0) {
					                                                u_xlat10.xz = u_xlat5.xz;
					                                                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                                                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                                            }
					                                            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                                            u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                                            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                                            u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                                            u_xlat12 = (-u_xlat14.x) * 8.0 + u_xlat4.x;
					                                            u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                                            u_xlat12 = (-u_xlat14.y) * 8.0 + u_xlat4.z;
					                                            u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                                            u_xlat12 = u_xlat14.x * 8.0 + u_xlat5.x;
					                                            u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                                            u_xlat12 = u_xlat14.y * 8.0 + u_xlat5.z;
					                                            u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).w;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).w;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).w;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).w;
					    u_xlat14.x = max(u_xlat1.w, u_xlat12);
					    u_xlat20 = min(u_xlat1.w, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).w;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).w;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).w;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).w;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.w * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.w * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat8 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.w) + u_xlat12;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlat12 = u_xlat1.w + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).w;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).w;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.w;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).w;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0.x = texture(_DitheringTex, u_xlat0.xy).w;
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat6.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.165999994;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0625);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                    u_xlat12 = (-u_xlat8.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat8.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat8.x * 12.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                    u_xlat12 = u_xlat8.y * 12.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.165999994;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0625);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                    u_xlat12 = (-u_xlat8.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat8.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat8.x * 12.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                    u_xlat12 = u_xlat8.y * 12.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					int u_xlati2;
					bvec2 u_xlatb2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					ivec2 u_xlati5;
					vec2 u_xlat6;
					vec2 u_xlat8;
					ivec2 u_xlati8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					float u_xlat14;
					bool u_xlatb14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					int u_xlati20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat19 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat8.x = max(u_xlat1.y, u_xlat12);
					    u_xlat14 = min(u_xlat1.y, u_xlat12);
					    u_xlat8.x = max(u_xlat18, u_xlat8.x);
					    u_xlat14 = min(u_xlat18, u_xlat14);
					    u_xlat20 = max(u_xlat19, u_xlat2.x);
					    u_xlat3.x = min(u_xlat19, u_xlat2.x);
					    u_xlat8.x = max(u_xlat8.x, u_xlat20);
					    u_xlat14 = min(u_xlat14, u_xlat3.x);
					    u_xlat20 = u_xlat8.x * 0.165999994;
					    u_xlat8.x = (-u_xlat14) + u_xlat8.x;
					    u_xlat14 = max(u_xlat20, 0.0625);
					    u_xlatb14 = u_xlat8.x>=u_xlat14;
					    if(u_xlatb14){
					        u_xlat14 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat19;
					        u_xlat9.x = u_xlat18 + u_xlat2.x;
					        u_xlat8.x = float(1.0) / u_xlat8.x;
					        u_xlat15.x = u_xlat6.x + u_xlat9.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat9.x = u_xlat1.y * -2.0 + u_xlat9.x;
					        u_xlat21 = u_xlat20 + u_xlat3.x;
					        u_xlat3.x = u_xlat14 + u_xlat3.x;
					        u_xlat4.x = u_xlat18 * -2.0 + u_xlat21;
					        u_xlat3.x = u_xlat19 * -2.0 + u_xlat3.x;
					        u_xlat14 = u_xlat0.x + u_xlat14;
					        u_xlat0.x = u_xlat20 + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat4.x);
					        u_xlat20 = abs(u_xlat9.x) * 2.0 + abs(u_xlat3.x);
					        u_xlat3.x = u_xlat2.x * -2.0 + u_xlat14;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat3.x);
					        u_xlat0.x = u_xlat20 + abs(u_xlat0.x);
					        u_xlat14 = u_xlat21 + u_xlat14;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat15.x * 2.0 + u_xlat14;
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat2.x;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat2.x = (-u_xlat1.y) + u_xlat19;
					        u_xlat14 = (-u_xlat1.y) + u_xlat12;
					        u_xlat19 = u_xlat1.y + u_xlat19;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb20 = abs(u_xlat2.x)>=abs(u_xlat14);
					        u_xlat2.x = max(abs(u_xlat14), abs(u_xlat2.x));
					        u_xlat18 = (u_xlatb20) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat8.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat8.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat8.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat3.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat3.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat3.x;
					        u_xlat3.y = (u_xlatb0) ? u_xlat3.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat8.xy) + u_xlat3.xy;
					        u_xlat5.xy = u_xlat8.xy + u_xlat3.xy;
					        u_xlat3.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat9.xy = u_xlat4.xy;
					        u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
					        u_xlat9.xy = u_xlat9.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat9.x = textureLod(_MainTex, u_xlat9.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat15.xy = u_xlat5.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat12 = (u_xlatb20) ? u_xlat19 : u_xlat12;
					        u_xlat19 = u_xlat2.x * 0.25;
					        u_xlat2.x = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat3.x;
					        u_xlati2 = int((u_xlat2.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat9.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = (-u_xlat8.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					        u_xlat20 = (-u_xlat8.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat20;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati20 = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat10.x = u_xlat8.x * 1.5 + u_xlat5.x;
					        u_xlat10.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat10.x;
					        u_xlat5.x = u_xlat8.y * 1.5 + u_xlat5.y;
					        u_xlat10.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat5.x;
					        if(u_xlati20 != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat5.xy = u_xlat4.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat5.xy = u_xlat10.xz;
					                u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					            }
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					            u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					            u_xlat20 = (-u_xlat8.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					            u_xlat20 = (-u_xlat8.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					            u_xlati5.xy = ~(u_xlati15.xy);
					            u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					            u_xlat5.x = u_xlat8.x * 2.0 + u_xlat10.x;
					            u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					            u_xlat5.x = u_xlat8.y * 2.0 + u_xlat10.z;
					            u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					            if(u_xlati20 != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat5.xy = u_xlat4.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat5.xy = u_xlat10.xz;
					                    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                    u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                }
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat20;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy) * 0xFFFFFFFFu);
					                u_xlat20 = (-u_xlat8.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat20;
					                u_xlat20 = (-u_xlat8.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat20;
					                u_xlati5.xy = ~(u_xlati15.xy);
					                u_xlati20 = int(uint(u_xlati5.y) | uint(u_xlati5.x));
					                u_xlat5.x = u_xlat8.x * 4.0 + u_xlat10.x;
					                u_xlat10.x = (u_xlati15.y != 0) ? u_xlat10.x : u_xlat5.x;
					                u_xlat5.x = u_xlat8.y * 4.0 + u_xlat10.z;
					                u_xlat10.z = (u_xlati15.y != 0) ? u_xlat10.z : u_xlat5.x;
					                if(u_xlati20 != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat5.xy = u_xlat4.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat5.xy = u_xlat10.xz;
					                        u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
					                        u_xlat5.xy = u_xlat5.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat5.xy, 0.0).y;
					                    }
					                    u_xlat20 = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat20;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat19)).xy;
					                    u_xlat12 = (-u_xlat8.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat8.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat8.x * 12.0 + u_xlat10.x;
					                    u_xlat10.x = (u_xlatb15.y) ? u_xlat10.x : u_xlat12;
					                    u_xlat12 = u_xlat8.y * 12.0 + u_xlat10.z;
					                    u_xlat10.z = (u_xlatb15.y) ? u_xlat10.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat19 = u_xlat10.x + (-vs_TEXCOORD0.x);
					        u_xlat8.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat8.x;
					        u_xlat8.x = u_xlat10.z + (-vs_TEXCOORD0.y);
					        u_xlat19 = (u_xlatb0) ? u_xlat19 : u_xlat8.x;
					        u_xlati8.xy = ivec2(uvec2(lessThan(u_xlat3.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat20 = u_xlat12 + u_xlat19;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati2), u_xlati8.xyxx).xy;
					        u_xlat14 = float(1.0) / u_xlat20;
					        u_xlatb20 = u_xlat12<u_xlat19;
					        u_xlat12 = min(u_xlat12, u_xlat19);
					        u_xlatb19 = (u_xlatb20) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat14) + 0.5;
					        u_xlat12 = u_xlatb19 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					    }
					    u_xlat0.x = texture(_MainTex, vs_TEXCOORD1.xy).w;
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat6.x = texture(_DitheringTex, u_xlat6.xy).w;
					    u_xlat6.x = u_xlat6.x * 2.0 + -1.0;
					    u_xlat12 = u_xlat6.x * 3.40282347e+38 + 0.5;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat6.x = -abs(u_xlat6.x) + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    SV_Target0.xyz = u_xlat6.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					UNITY_LOCATION(0) uniform  sampler2D _DitheringTex;
					UNITY_LOCATION(1) uniform  sampler2D _MainTex;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat6;
					float u_xlat8;
					int u_xlati8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec3 u_xlat10;
					ivec3 u_xlati10;
					float u_xlat12;
					vec2 u_xlat14;
					ivec2 u_xlati14;
					vec2 u_xlat15;
					ivec2 u_xlati15;
					bvec2 u_xlatb15;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat12 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1)).y;
					    u_xlat18 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0)).y;
					    u_xlat2.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1)).y;
					    u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0)).y;
					    u_xlat14.x = max(u_xlat1.y, u_xlat12);
					    u_xlat20 = min(u_xlat1.y, u_xlat12);
					    u_xlat14.x = max(u_xlat18, u_xlat14.x);
					    u_xlat20 = min(u_xlat18, u_xlat20);
					    u_xlat3.x = max(u_xlat8, u_xlat2.x);
					    u_xlat9.x = min(u_xlat8, u_xlat2.x);
					    u_xlat14.x = max(u_xlat14.x, u_xlat3.x);
					    u_xlat20 = min(u_xlat20, u_xlat9.x);
					    u_xlat3.x = u_xlat14.x * 0.165999994;
					    u_xlat14.x = (-u_xlat20) + u_xlat14.x;
					    u_xlat20 = max(u_xlat3.x, 0.0625);
					    u_xlatb20 = u_xlat14.x>=u_xlat20;
					    if(u_xlatb20){
					        u_xlat20 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1)).y;
					        u_xlat3.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1)).y;
					        u_xlat9.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1)).y;
					        u_xlat0.x = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1)).y;
					        u_xlat6.x = u_xlat12 + u_xlat2.x;
					        u_xlat15.x = u_xlat18 + u_xlat8;
					        u_xlat14.x = float(1.0) / u_xlat14.x;
					        u_xlat21 = u_xlat6.x + u_xlat15.x;
					        u_xlat6.x = u_xlat1.y * -2.0 + u_xlat6.x;
					        u_xlat15.x = u_xlat1.y * -2.0 + u_xlat15.x;
					        u_xlat4.x = u_xlat3.x + u_xlat9.x;
					        u_xlat9.x = u_xlat20 + u_xlat9.x;
					        u_xlat10.x = u_xlat18 * -2.0 + u_xlat4.x;
					        u_xlat9.x = u_xlat2.x * -2.0 + u_xlat9.x;
					        u_xlat20 = u_xlat0.x + u_xlat20;
					        u_xlat0.x = u_xlat3.x + u_xlat0.x;
					        u_xlat6.x = abs(u_xlat6.x) * 2.0 + abs(u_xlat10.x);
					        u_xlat3.x = abs(u_xlat15.x) * 2.0 + abs(u_xlat9.x);
					        u_xlat9.x = u_xlat8 * -2.0 + u_xlat20;
					        u_xlat0.x = u_xlat12 * -2.0 + u_xlat0.x;
					        u_xlat6.x = u_xlat6.x + abs(u_xlat9.x);
					        u_xlat0.x = u_xlat3.x + abs(u_xlat0.x);
					        u_xlat20 = u_xlat4.x + u_xlat20;
					        u_xlatb0 = u_xlat6.x>=u_xlat0.x;
					        u_xlat6.x = u_xlat21 * 2.0 + u_xlat20;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat8;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat18;
					        u_xlat18 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat6.x = u_xlat6.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat8 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat20 = (-u_xlat1.y) + u_xlat12;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlat12 = u_xlat1.y + u_xlat12;
					        u_xlatb3 = abs(u_xlat8)>=abs(u_xlat20);
					        u_xlat8 = max(abs(u_xlat20), abs(u_xlat8));
					        u_xlat18 = (u_xlatb3) ? (-u_xlat18) : u_xlat18;
					        u_xlat6.x = u_xlat14.x * abs(u_xlat6.x);
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					        u_xlat14.x = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat14.y = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat9.xy = vec2(u_xlat18) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat9.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat9.x;
					        u_xlat9.y = (u_xlatb0) ? u_xlat9.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat14.xy) + u_xlat9.xy;
					        u_xlat5.xy = u_xlat14.xy + u_xlat9.xy;
					        u_xlat9.x = u_xlat6.x * -2.0 + 3.0;
					        u_xlat15.xy = u_xlat4.xy;
					        u_xlat15.xy = clamp(u_xlat15.xy, 0.0, 1.0);
					        u_xlat15.xy = u_xlat15.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat15.x = textureLod(_MainTex, u_xlat15.xy, 0.0).y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat16.xy = u_xlat5.xy;
					        u_xlat16.xy = clamp(u_xlat16.xy, 0.0, 1.0);
					        u_xlat16.xy = u_xlat16.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat21 = textureLod(_MainTex, u_xlat16.xy, 0.0).y;
					        u_xlat12 = (u_xlatb3) ? u_xlat2.x : u_xlat12;
					        u_xlat2.x = u_xlat8 * 0.25;
					        u_xlat8 = (-u_xlat12) * 0.5 + u_xlat1.y;
					        u_xlat6.x = u_xlat6.x * u_xlat9.x;
					        u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat12) * 0.5 + u_xlat15.x;
					        u_xlat3.y = (-u_xlat12) * 0.5 + u_xlat21;
					        u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat16.x = (-u_xlat14.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat16.x;
					        u_xlat22 = (-u_xlat14.y) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.y : u_xlat22;
					        u_xlati10.xz = ~(u_xlati15.xy);
					        u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					        u_xlat22 = u_xlat14.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					        u_xlat22 = u_xlat14.y * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.y : u_xlat22;
					        if(u_xlati10.x != 0) {
					            if(u_xlati15.x == 0) {
					                u_xlat10.xz = u_xlat4.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            if(u_xlati15.y == 0) {
					                u_xlat10.xz = u_xlat5.xz;
					                u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					            }
					            u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					            u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					            u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat10.x = (-u_xlat14.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					            u_xlat10.x = (-u_xlat14.y) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					            u_xlati10.xz = ~(u_xlati15.xy);
					            u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					            u_xlat22 = u_xlat14.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					            u_xlat22 = u_xlat14.y * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					            if(u_xlati10.x != 0) {
					                if(u_xlati15.x == 0) {
					                    u_xlat10.xz = u_xlat4.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                if(u_xlati15.y == 0) {
					                    u_xlat10.xz = u_xlat5.xz;
					                    u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                    u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                    u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                }
					                u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                u_xlat15.x = (-u_xlat12) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat15.x;
					                u_xlati15.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat10.x = (-u_xlat14.x) * 4.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati15.x != 0) ? u_xlat4.x : u_xlat10.x;
					                u_xlat10.x = (-u_xlat14.y) * 4.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati15.x != 0) ? u_xlat4.z : u_xlat10.x;
					                u_xlati10.xz = ~(u_xlati15.xy);
					                u_xlati10.x = int(uint(u_xlati10.z) | uint(u_xlati10.x));
					                u_xlat22 = u_xlat14.x * 4.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati15.y != 0) ? u_xlat5.x : u_xlat22;
					                u_xlat22 = u_xlat14.y * 4.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati15.y != 0) ? u_xlat5.z : u_xlat22;
					                if(u_xlati10.x != 0) {
					                    if(u_xlati15.x == 0) {
					                        u_xlat10.xz = u_xlat4.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.x = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    if(u_xlati15.y == 0) {
					                        u_xlat10.xz = u_xlat5.xz;
					                        u_xlat10.xz = clamp(u_xlat10.xz, 0.0, 1.0);
					                        u_xlat10.xz = u_xlat10.xz * vec2(_RenderViewportScaleFactor);
					                        u_xlat3.y = textureLod(_MainTex, u_xlat10.xz, 0.0).y;
					                    }
					                    u_xlat10.x = (-u_xlat12) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati15.x != 0) ? u_xlat3.x : u_xlat10.x;
					                    u_xlat12 = (-u_xlat12) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati15.y != 0) ? u_xlat3.y : u_xlat12;
					                    u_xlatb15.xy = greaterThanEqual(abs(u_xlat3.xyxy), u_xlat2.xxxx).xy;
					                    u_xlat12 = (-u_xlat14.x) * 12.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlatb15.x) ? u_xlat4.x : u_xlat12;
					                    u_xlat12 = (-u_xlat14.y) * 12.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlatb15.x) ? u_xlat4.z : u_xlat12;
					                    u_xlat12 = u_xlat14.x * 12.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlatb15.y) ? u_xlat5.x : u_xlat12;
					                    u_xlat12 = u_xlat14.y * 12.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlatb15.y) ? u_xlat5.z : u_xlat12;
					                }
					            }
					        }
					        u_xlat12 = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat14.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat12 = (u_xlatb0) ? u_xlat12 : u_xlat14.x;
					        u_xlat2.xz = u_xlat5.xz + (-vs_TEXCOORD0.xy);
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.x : u_xlat2.z;
					        u_xlati14.xy = ivec2(uvec2(lessThan(u_xlat3.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat12 + u_xlat2.x;
					        u_xlatb8.xy = notEqual(ivec4(u_xlati8), u_xlati14.xyxx).xy;
					        u_xlat20 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat12<u_xlat2.x;
					        u_xlat12 = min(u_xlat12, u_xlat2.x);
					        u_xlatb2 = (u_xlatb3) ? u_xlatb8.x : u_xlatb8.y;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat12 = u_xlat12 * (-u_xlat20) + 0.5;
					        u_xlat12 = u_xlatb2 ? u_xlat12 : float(0.0);
					        u_xlat6.x = max(u_xlat6.x, u_xlat12);
					        u_xlat6.xy = u_xlat6.xx * vec2(u_xlat18) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat6.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat6.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat18 = texture(_DitheringTex, u_xlat2.xy).w;
					    u_xlat18 = u_xlat18 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat18 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat18 = -abs(u_xlat18) + 1.0;
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat18) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
			}
		}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 111372
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" }
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
						vec4 _UVTransform;
						vec4 unused_0_3[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					#extension GL_AMD_vertex_shader_layer : require
					
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
						float _DepthSlice;
						vec4 _UVTransform;
						vec4 unused_0_4[2];
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
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    gl_Layer = int(uint(_DepthSlice));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 _UVTransform;
						vec4 _PosScaleOffset;
						vec4 unused_0_4[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy * _PosScaleOffset.xy + _PosScaleOffset.zw;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _UVTransform.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + _UVTransform.zw;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_0[29];
						vec4 _Dithering_Coords;
						vec4 unused_0_2;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat2 = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2 = sqrt(u_xlat2);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_KEEP_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.063000001;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0311999992);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                    u_xlati24.xy = ~(u_xlati4.xy);
					                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                    if(u_xlati24.x != 0) {
					                        if(u_xlati4.x == 0) {
					                            u_xlat24.xy = u_xlat25.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        } else {
					                            u_xlat7.x = u_xlat3.y;
					                        }
					                        if(u_xlati4.y == 0) {
					                            u_xlat24.xy = u_xlat6.xy;
					                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                        }
					                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                        u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                        u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                        u_xlati24.xy = ~(u_xlati4.xy);
					                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                        u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                        u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                        if(u_xlati24.x != 0) {
					                            if(u_xlati4.x == 0) {
					                                u_xlat24.xy = u_xlat25.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            } else {
					                                u_xlat7.x = u_xlat3.y;
					                            }
					                            if(u_xlati4.y == 0) {
					                                u_xlat24.xy = u_xlat6.xy;
					                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                            }
					                            u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                            u_xlati24.xy = ~(u_xlati4.xy);
					                            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                            if(u_xlati24.x != 0) {
					                                if(u_xlati4.x == 0) {
					                                    u_xlat24.xy = u_xlat25.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                } else {
					                                    u_xlat7.x = u_xlat3.y;
					                                }
					                                if(u_xlati4.y == 0) {
					                                    u_xlat24.xy = u_xlat6.xy;
					                                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                }
					                                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                u_xlati24.xy = ~(u_xlati4.xy);
					                                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                if(u_xlati24.x != 0) {
					                                    if(u_xlati4.x == 0) {
					                                        u_xlat24.xy = u_xlat25.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    } else {
					                                        u_xlat7.x = u_xlat3.y;
					                                    }
					                                    if(u_xlati4.y == 0) {
					                                        u_xlat24.xy = u_xlat6.xy;
					                                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                    }
					                                    u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                    u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                    u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                    u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					                                    u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                    u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					                                    u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                    u_xlati24.xy = ~(u_xlati4.xy);
					                                    u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                    u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					                                    u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                    u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					                                    u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                    if(u_xlati24.x != 0) {
					                                        if(u_xlati4.x == 0) {
					                                            u_xlat24.xy = u_xlat25.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        } else {
					                                            u_xlat7.x = u_xlat3.y;
					                                        }
					                                        if(u_xlati4.y == 0) {
					                                            u_xlat24.xy = u_xlat6.xy;
					                                            u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                            u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                            u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                        }
					                                        u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                        u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                                        u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                        u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                                        u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                                        u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                                        u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                                        u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                                        u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                                        u_xlati24.xy = ~(u_xlati4.xy);
					                                        u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                                        u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                                        u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                                        u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                                        u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                                        if(u_xlati24.x != 0) {
					                                            if(u_xlati4.x == 0) {
					                                                u_xlat24.xy = u_xlat25.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            } else {
					                                                u_xlat7.x = u_xlat3.y;
					                                            }
					                                            if(u_xlati4.y == 0) {
					                                                u_xlat24.xy = u_xlat6.xy;
					                                                u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                                                u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                                                u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                                            }
					                                            u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                                            u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                                            u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                                            u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                                            u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                                            u_xlat30 = (-u_xlat20) * 8.0 + u_xlat25.x;
					                                            u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                                            u_xlat30 = (-u_xlat32) * 8.0 + u_xlat25.y;
					                                            u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                                            u_xlat20 = u_xlat20 * 8.0 + u_xlat6.x;
					                                            u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                                            u_xlat20 = u_xlat32 * 8.0 + u_xlat6.y;
					                                            u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                                        }
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					vec2 u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					float u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.w, u_xlat2.w);
					    u_xlat30 = min(u_xlat1.w, u_xlat2.w);
					    u_xlat20 = max(u_xlat20, u_xlat3.w);
					    u_xlat30 = min(u_xlat30, u_xlat3.w);
					    u_xlat2.x = max(u_xlat4.w, u_xlat5.w);
					    u_xlat12.x = min(u_xlat4.w, u_xlat5.w);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat12.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.w + u_xlat4.w;
					        u_xlat10.x = u_xlat3.w + u_xlat5.w;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.w * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.w + u_xlat8.w;
					        u_xlat12.x = u_xlat6.w + u_xlat8.w;
					        u_xlat22 = u_xlat3.w * -2.0 + u_xlat2.x;
					        u_xlat12.x = u_xlat4.w * -2.0 + u_xlat12.x;
					        u_xlat3.x = u_xlat6.w + u_xlat9.w;
					        u_xlat13.x = u_xlat7.w + u_xlat9.w;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat22);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat12.x);
					        u_xlat12.x = u_xlat5.w * -2.0 + u_xlat3.x;
					        u_xlat12.y = u_xlat2.w * -2.0 + u_xlat13.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat12.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.w : u_xlat5.w;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.w : u_xlat3.w;
					        u_xlat12.x = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.w);
					        u_xlat22 = (-u_xlat1.w) + u_xlat30;
					        u_xlat32 = (-u_xlat1.w) + u_xlat2.x;
					        u_xlat30 = u_xlat1.w + u_xlat30;
					        u_xlat2.x = u_xlat1.w + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22)>=abs(u_xlat32);
					        u_xlat22 = max(abs(u_xlat32), abs(u_xlat22));
					        u_xlat12.x = (u_xlatb3) ? (-u_xlat12.x) : u_xlat12.x;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = u_xlat12.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22 * 0.25;
					        u_xlat22 = (-u_xlat30) * 0.5 + u_xlat1.w;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.w;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.w;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).wxyz;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).wxyz;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * u_xlat12.xx + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.xyz = u_xlat0.xyz;
					    }
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat0 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_KEEP_ALPHA" "FXAA_LOW" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    }
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.w * 2.0 + -1.0;
					    u_xlat10.x = u_xlat0.x * 3.40282347e+38 + 0.5;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    SV_Target0.xyz = u_xlat0.xxx * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_INSTANCING_ENABLED" }
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
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FXAA_LOW" "FXAA_NO_ALPHA" "STEREO_DOUBLEWIDE_TARGET" }
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
						vec4 unused_0_2[2];
						vec4 _Dithering_Coords;
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _DitheringTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					ivec4 u_xlati2;
					bvec3 u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					ivec2 u_xlati4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec2 u_xlat10;
					float u_xlat12;
					vec2 u_xlat13;
					float u_xlat14;
					float u_xlat20;
					vec2 u_xlat22;
					int u_xlati22;
					vec2 u_xlat23;
					bvec2 u_xlatb23;
					vec2 u_xlat24;
					ivec2 u_xlati24;
					vec2 u_xlat25;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					float u_xlat34;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    u_xlat1 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					    u_xlat2 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, 1));
					    u_xlat3 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 0));
					    u_xlat4 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(0, -1));
					    u_xlat5 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 0));
					    u_xlat20 = max(u_xlat1.y, u_xlat2.y);
					    u_xlat30 = min(u_xlat1.y, u_xlat2.y);
					    u_xlat20 = max(u_xlat20, u_xlat3.y);
					    u_xlat30 = min(u_xlat30, u_xlat3.y);
					    u_xlat2.x = max(u_xlat4.y, u_xlat5.y);
					    u_xlat22.x = min(u_xlat4.y, u_xlat5.y);
					    u_xlat20 = max(u_xlat20, u_xlat2.x);
					    u_xlat30 = min(u_xlat30, u_xlat22.x);
					    u_xlat2.x = u_xlat20 * 0.165999994;
					    u_xlat20 = (-u_xlat30) + u_xlat20;
					    u_xlat30 = max(u_xlat2.x, 0.0625);
					    u_xlatb30 = u_xlat20>=u_xlat30;
					    if(u_xlatb30){
					        u_xlat6 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, -1));
					        u_xlat7 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, 1));
					        u_xlat8 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(1, -1));
					        u_xlat9 = textureLodOffset(_MainTex, u_xlat0.xy, 0.0, ivec2(-1, 1));
					        u_xlat0.x = u_xlat2.y + u_xlat4.y;
					        u_xlat10.x = u_xlat3.y + u_xlat5.y;
					        u_xlat20 = float(1.0) / u_xlat20;
					        u_xlat30 = u_xlat10.x + u_xlat0.x;
					        u_xlat0.x = u_xlat1.y * -2.0 + u_xlat0.x;
					        u_xlat10.x = u_xlat1.y * -2.0 + u_xlat10.x;
					        u_xlat2.x = u_xlat7.y + u_xlat8.y;
					        u_xlat22.x = u_xlat6.y + u_xlat8.y;
					        u_xlat32 = u_xlat3.y * -2.0 + u_xlat2.x;
					        u_xlat22.x = u_xlat4.y * -2.0 + u_xlat22.x;
					        u_xlat3.x = u_xlat6.y + u_xlat9.y;
					        u_xlat23.x = u_xlat7.y + u_xlat9.y;
					        u_xlat0.x = abs(u_xlat0.x) * 2.0 + abs(u_xlat32);
					        u_xlat0.y = abs(u_xlat10.x) * 2.0 + abs(u_xlat22.x);
					        u_xlat22.x = u_xlat5.y * -2.0 + u_xlat3.x;
					        u_xlat22.y = u_xlat2.y * -2.0 + u_xlat23.x;
					        u_xlat0.xy = u_xlat0.xy + abs(u_xlat22.xy);
					        u_xlat2.x = u_xlat2.x + u_xlat3.x;
					        u_xlatb0 = u_xlat0.x>=u_xlat0.y;
					        u_xlat10.x = u_xlat30 * 2.0 + u_xlat2.x;
					        u_xlat30 = (u_xlatb0) ? u_xlat4.y : u_xlat5.y;
					        u_xlat2.x = (u_xlatb0) ? u_xlat2.y : u_xlat3.y;
					        u_xlat12 = (u_xlatb0) ? _MainTex_TexelSize.y : _MainTex_TexelSize.x;
					        u_xlat10.x = u_xlat10.x * 0.0833333358 + (-u_xlat1.y);
					        u_xlat22.x = (-u_xlat1.y) + u_xlat30;
					        u_xlat32 = (-u_xlat1.y) + u_xlat2.x;
					        u_xlat30 = u_xlat1.y + u_xlat30;
					        u_xlat2.x = u_xlat1.y + u_xlat2.x;
					        u_xlatb3 = abs(u_xlat22.x)>=abs(u_xlat32);
					        u_xlat22.x = max(abs(u_xlat32), abs(u_xlat22.x));
					        u_xlat12 = (u_xlatb3) ? (-u_xlat12) : u_xlat12;
					        u_xlat10.x = u_xlat20 * abs(u_xlat10.x);
					        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					        u_xlat20 = u_xlatb0 ? _MainTex_TexelSize.x : float(0.0);
					        u_xlat32 = (u_xlatb0) ? 0.0 : _MainTex_TexelSize.y;
					        u_xlat13.xy = vec2(u_xlat12) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat13.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat13.x;
					        u_xlat23.x = (u_xlatb0) ? u_xlat13.y : vs_TEXCOORD0.y;
					        u_xlat4.x = (-u_xlat20) + u_xlat13.x;
					        u_xlat4.y = (-u_xlat32) + u_xlat23.x;
					        u_xlat5.x = u_xlat20 + u_xlat13.x;
					        u_xlat5.y = u_xlat32 + u_xlat23.x;
					        u_xlat13.x = u_xlat10.x * -2.0 + 3.0;
					        u_xlat23.xy = u_xlat4.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat6 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat23.xy = u_xlat5.xy;
					        u_xlat23.xy = clamp(u_xlat23.xy, 0.0, 1.0);
					        u_xlat23.xy = u_xlat23.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat7 = textureLod(_MainTex, u_xlat23.xy, 0.0);
					        u_xlat30 = (u_xlatb3) ? u_xlat30 : u_xlat2.x;
					        u_xlat2.x = u_xlat22.x * 0.25;
					        u_xlat22.x = (-u_xlat30) * 0.5 + u_xlat1.y;
					        u_xlat10.x = u_xlat10.x * u_xlat13.x;
					        u_xlati22 = int((u_xlat22.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.y = (-u_xlat30) * 0.5 + u_xlat6.y;
					        u_xlat3.x = (-u_xlat30) * 0.5 + u_xlat7.y;
					        u_xlati24.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					        u_xlat25.x = (-u_xlat20) * 1.5 + u_xlat4.x;
					        u_xlat25.x = (u_xlati24.x != 0) ? u_xlat4.x : u_xlat25.x;
					        u_xlat4.x = (-u_xlat32) * 1.5 + u_xlat4.y;
					        u_xlat25.y = (u_xlati24.x != 0) ? u_xlat4.y : u_xlat4.x;
					        u_xlati4.xy = ~(u_xlati24.xy);
					        u_xlati4.x = int(uint(u_xlati4.y) | uint(u_xlati4.x));
					        u_xlat14 = u_xlat20 * 1.5 + u_xlat5.x;
					        u_xlat6.x = (u_xlati24.y != 0) ? u_xlat5.x : u_xlat14;
					        u_xlat14 = u_xlat32 * 1.5 + u_xlat5.y;
					        u_xlat6.y = (u_xlati24.y != 0) ? u_xlat5.y : u_xlat14;
					        if(u_xlati4.x != 0) {
					            if(u_xlati24.x == 0) {
					                u_xlat4.xy = u_xlat25.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat7 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            } else {
					                u_xlat7.x = u_xlat3.y;
					            }
					            if(u_xlati24.y == 0) {
					                u_xlat4.xy = u_xlat6.xy;
					                u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					                u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
					                u_xlat3 = textureLod(_MainTex, u_xlat4.xy, 0.0).yxzw;
					            }
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					            u_xlat3.y = (u_xlati24.x != 0) ? u_xlat7.x : u_xlat4.x;
					            u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati24.y != 0) ? u_xlat3.x : u_xlat4.x;
					            u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					            u_xlat24.x = (-u_xlat20) * 2.0 + u_xlat25.x;
					            u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					            u_xlat24.x = (-u_xlat32) * 2.0 + u_xlat25.y;
					            u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					            u_xlati24.xy = ~(u_xlati4.xy);
					            u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					            u_xlat34 = u_xlat20 * 2.0 + u_xlat6.x;
					            u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					            u_xlat34 = u_xlat32 * 2.0 + u_xlat6.y;
					            u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					            if(u_xlati24.x != 0) {
					                if(u_xlati4.x == 0) {
					                    u_xlat24.xy = u_xlat25.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                } else {
					                    u_xlat7.x = u_xlat3.y;
					                }
					                if(u_xlati4.y == 0) {
					                    u_xlat24.xy = u_xlat6.xy;
					                    u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                    u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                    u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                }
					                u_xlat24.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat24.x;
					                u_xlat4.x = (-u_xlat30) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat4.x;
					                u_xlati4.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.yxyy), u_xlat2.xxxx).xy) * 0xFFFFFFFFu);
					                u_xlat24.x = (-u_xlat20) * 4.0 + u_xlat25.x;
					                u_xlat25.x = (u_xlati4.x != 0) ? u_xlat25.x : u_xlat24.x;
					                u_xlat24.x = (-u_xlat32) * 4.0 + u_xlat25.y;
					                u_xlat25.y = (u_xlati4.x != 0) ? u_xlat25.y : u_xlat24.x;
					                u_xlati24.xy = ~(u_xlati4.xy);
					                u_xlati24.x = int(uint(u_xlati24.y) | uint(u_xlati24.x));
					                u_xlat34 = u_xlat20 * 4.0 + u_xlat6.x;
					                u_xlat6.x = (u_xlati4.y != 0) ? u_xlat6.x : u_xlat34;
					                u_xlat34 = u_xlat32 * 4.0 + u_xlat6.y;
					                u_xlat6.y = (u_xlati4.y != 0) ? u_xlat6.y : u_xlat34;
					                if(u_xlati24.x != 0) {
					                    if(u_xlati4.x == 0) {
					                        u_xlat24.xy = u_xlat25.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat7 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    } else {
					                        u_xlat7.x = u_xlat3.y;
					                    }
					                    if(u_xlati4.y == 0) {
					                        u_xlat24.xy = u_xlat6.xy;
					                        u_xlat24.xy = clamp(u_xlat24.xy, 0.0, 1.0);
					                        u_xlat24.xy = u_xlat24.xy * vec2(_RenderViewportScaleFactor);
					                        u_xlat3 = textureLod(_MainTex, u_xlat24.xy, 0.0).yxzw;
					                    }
					                    u_xlat23.x = (-u_xlat30) * 0.5 + u_xlat7.x;
					                    u_xlat3.y = (u_xlati4.x != 0) ? u_xlat7.x : u_xlat23.x;
					                    u_xlat30 = (-u_xlat30) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati4.y != 0) ? u_xlat3.x : u_xlat30;
					                    u_xlatb23.xy = greaterThanEqual(abs(u_xlat3.yxyx), u_xlat2.xxxx).xy;
					                    u_xlat30 = (-u_xlat20) * 12.0 + u_xlat25.x;
					                    u_xlat25.x = (u_xlatb23.x) ? u_xlat25.x : u_xlat30;
					                    u_xlat30 = (-u_xlat32) * 12.0 + u_xlat25.y;
					                    u_xlat25.y = (u_xlatb23.x) ? u_xlat25.y : u_xlat30;
					                    u_xlat20 = u_xlat20 * 12.0 + u_xlat6.x;
					                    u_xlat6.x = (u_xlatb23.y) ? u_xlat6.x : u_xlat20;
					                    u_xlat20 = u_xlat32 * 12.0 + u_xlat6.y;
					                    u_xlat6.y = (u_xlatb23.y) ? u_xlat6.y : u_xlat20;
					                }
					            }
					        }
					        u_xlat20 = (-u_xlat25.x) + vs_TEXCOORD0.x;
					        u_xlat30 = u_xlat6.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat25.y) + vs_TEXCOORD0.y;
					        u_xlat20 = (u_xlatb0) ? u_xlat20 : u_xlat2.x;
					        u_xlat2.x = u_xlat6.y + (-vs_TEXCOORD0.y);
					        u_xlat30 = (u_xlatb0) ? u_xlat30 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.yyyx, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat20 + u_xlat30;
					        u_xlatb2.xz = notEqual(ivec4(u_xlati22), u_xlati2.xxwx).xz;
					        u_xlat32 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat20<u_xlat30;
					        u_xlat20 = min(u_xlat30, u_xlat20);
					        u_xlatb30 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.z;
					        u_xlat10.x = u_xlat10.x * u_xlat10.x;
					        u_xlat20 = u_xlat20 * (-u_xlat32) + 0.5;
					        u_xlat20 = u_xlatb30 ? u_xlat20 : float(0.0);
					        u_xlat10.x = max(u_xlat10.x, u_xlat20);
					        u_xlat10.xy = u_xlat10.xx * vec2(u_xlat12) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb0) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					        u_xlat2.y = (u_xlatb0) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
					        u_xlat0.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
					        u_xlat0 = textureLod(_MainTex, u_xlat0.xy, 0.0);
					        u_xlat1.w = u_xlat1.y;
					    } else {
					        u_xlat0.xyz = u_xlat1.xyz;
					    }
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Dithering_Coords.xy + _Dithering_Coords.zw;
					    u_xlat2 = texture(_DitheringTex, u_xlat2.xy);
					    u_xlat30 = u_xlat2.w * 2.0 + -1.0;
					    u_xlat2.x = u_xlat30 * 3.40282347e+38 + 0.5;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat1.xyz = vec3(u_xlat30) * vec3(0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}"
				}
			}
		}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 156930
		}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 209563
		}
	}
}