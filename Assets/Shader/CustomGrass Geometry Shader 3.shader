
Shader "Custom/Grass Geometry Shader 3" {
	Properties{
		_BottomColor("Bottom Color", Color) = (0,1,0,1)
		_TopColor("Top Color", Color) = (1,1,0,1)
		_GrassHeight("Grass Height", Float) = 1
		_GrassWidth("Grass Width", Float) = 0.06
		_RandomHeight("Grass Height Randomness", Float) = 0.25
		_WindSpeed("Wind Speed", Float) = 100
		_WindStrength("Wind Strength", Float) = 0.05
		_Radius("Interactor Radius", Float) = 0.3
		_Strength("Interactor Strength", Float) = 5
		_Rad("Blade Radius", Range(0,1)) = 0.6
		_BladeForward("Blade Forward Amount", Float) = 0.38
		_BladeCurve("Blade Curvature Amount", Range(1, 4)) = 2
		_AmbientStrength("Ambient Strength",  Range(0,1)) = 0.5
		_MinDist("Min Distance", Float) = 40
		_MaxDist("Max Distance", Float) = 60
	}


		CGINCLUDE
#include "UnityCG.cginc" 
#include "Lighting.cginc"
#include "AutoLight.cginc"
#pragma multi_compile _SHADOWS_SCREEN
#pragma multi_compile_fwdbase_fullforwardshadows
#pragma multi_compile_fog
#define GrassSegments 5 // segments per blade
#define GrassBlades 4 // blades per vertex

		struct v2g
	{
		float4 pos : SV_POSITION;
		float3 norm : NORMAL;
		float2 uv : TEXCOORD0;
		float3 color : COLOR;


	};

	struct g2f
	{
		float4 pos : SV_POSITION;
		float3 norm : NORMAL;
		float2 uv : TEXCOORD0;
		float3 diffuseColor : COLOR;
		float3 worldPos : TEXCOORD3;
		LIGHTING_COORDS(5, 6)
			UNITY_FOG_COORDS(4)
	};

	half _GrassHeight;
	half _GrassWidth;
	half _WindSpeed;
	float _WindStrength;
	half _Radius, _Strength;
	float _Rad;

	float _RandomHeight;
	float _BladeForward;
	float _BladeCurve;

	float _MinDist, _MaxDist;

	uniform float3 _PositionMoving;

	v2g vert(appdata_full v)
	{
		float3 v0 = v.vertex.xyz;

		v2g OUT;
		OUT.pos = v.vertex;
		OUT.norm = v.normal;
		OUT.uv = v.texcoord;
		OUT.color = v.color;
		return OUT;
	}

	float rand(float3 co)
	{
		return frac(sin(dot(co.xyz, float3(12.9898, 78.233, 53.539))) * 43758.5453);
	}

	// Construct a rotation matrix that rotates around the provided axis, sourced from:
// https://gist.github.com/keijiro/ee439d5e7388f3aafc5296005c8c3f33
	float3x3 AngleAxis3x3(float angle, float3 axis)
	{
		float c, s;
		sincos(angle, s, c);

		float t = 1 - c;
		float x = axis.x;
		float y = axis.y;
		float z = axis.z;

		return float3x3(
			t * x * x + c, t * x * y - s * z, t * x * z + s * y,
			t * x * y + s * z, t * y * y + c, t * y * z - s * x,
			t * x * z - s * y, t * y * z + s * x, t * z * z + c
			);
	}

	// hack because TRANSFER_VERTEX_TO_FRAGMENT has harcoded requirement for 'v.vertex'
	struct unityTransferVertexToFragmentHack
	{
		float3 vertex : POSITION;
	};

	// per new grass vertex
	g2f GrassVertex(float3 vertexPos, float width, float height, float offset, float curve, float2 uv, float3x3 rotation, float3 faceNormal, float3 color, float3 worldPos) {
		g2f OUT;
		OUT.pos = UnityObjectToClipPos(vertexPos + mul(rotation, float3(width, height, curve) + float3(0, 0, offset)));
		OUT.norm = faceNormal;
		OUT.diffuseColor = color;
		OUT.uv = uv;
		OUT.worldPos = worldPos;

		// send extra vertex to forwardadd pass
		unityTransferVertexToFragmentHack v;
		v.vertex = vertexPos + mul(rotation, float3(width, height, curve) + float3(0, 0, offset));
		TRANSFER_VERTEX_TO_FRAGMENT(OUT);
		UNITY_TRANSFER_FOG(OUT, OUT.pos);
		return OUT;
	}

	// wind and basic grassblade setup from https://roystan.net/articles/grass-shader.html
	// limit for vertices
	[maxvertexcount(51)]
	void geom(point v2g IN[1], inout TriangleStream<g2f> triStream)
	{



		float forward = rand(IN[0].pos.yyz) * _BladeForward;
		float3 lightPosition = _WorldSpaceLightPos0;

		float3 perpendicularAngle = float3(0, 0, 1);
		float3 faceNormal = cross(perpendicularAngle, IN[0].norm) * lightPosition;

		float4 worldPos = mul(unity_ObjectToWorld, IN[0].pos);

		// camera distance for culling 
		float distanceFromCamera = distance(worldPos, _WorldSpaceCameraPos);
		float distanceFade = 1 - saturate((distanceFromCamera - _MinDist) / _MaxDist);

		float3 v0 = IN[0].pos.xyz;

		float3 wind1 = float3(sin(_Time.x * _WindSpeed + v0.x) + sin(_Time.x * _WindSpeed + v0.z * 2) + sin(_Time.x * _WindSpeed * 0.1 + v0.x), 0,
			cos(_Time.x * _WindSpeed + v0.x * 2) + cos(_Time.x * _WindSpeed + v0.z));

		wind1 *= _WindStrength;


		// Interactivity
		float3 dis = distance(_PositionMoving, worldPos); // distance for radius
		float3 radius = 1 - saturate(dis / _Radius); // in world radius based on objects interaction radius
		float3 sphereDisp = worldPos - _PositionMoving; // position comparison
		sphereDisp *= radius; // position multiplied by radius for falloff
		// increase strength
		sphereDisp = clamp(sphereDisp.xyz * _Strength, -0.8, 0.8);

		// set vertex color
		float3 color = (IN[0].color);
		// set grass height
		_GrassHeight *= IN[0].uv.y;
		_GrassWidth *= IN[0].uv.x;
		_GrassHeight *= clamp(rand(IN[0].pos.xyz), 1 - _RandomHeight, 1 + _RandomHeight);

		// grassblades geometry
		for (int j = 0; j < (GrassBlades * distanceFade); j++)
		{
			// set rotation and radius of the blades
			float3x3 facingRotationMatrix = AngleAxis3x3(rand(IN[0].pos.xyz) * UNITY_TWO_PI + j, float3(0, 1, -0.1));
			float3x3 transformationMatrix = facingRotationMatrix;
			float radius = j / (float)GrassBlades;
			float offset = (1 - radius) * _Rad;
			for (int i = 0; i < GrassSegments; i++)
			{
				// taper width, increase height;
				float t = i / (float)GrassSegments;
				float segmentHeight = _GrassHeight * t;
				float segmentWidth = _GrassWidth * (1 - t);

				// the first (0) grass segment is thinner
				segmentWidth = i == 0 ? _GrassWidth * 0.3 : segmentWidth;

				float segmentForward = pow(t, _BladeCurve) * forward;

				// Add below the line declaring float segmentWidth.
				float3x3 transformMatrix = i == 0 ? facingRotationMatrix : transformationMatrix;

				// first grass (0) segment does not get displaced by interactivity
				float3 newPos = i == 0 ? v0 : v0 + ((float3(sphereDisp.x, sphereDisp.y, sphereDisp.z) + wind1) * t);

				// every segment adds 2 new triangles
				triStream.Append(GrassVertex(newPos, segmentWidth, segmentHeight, offset, segmentForward, float2(0, t), transformMatrix, faceNormal, color, worldPos));
				triStream.Append(GrassVertex(newPos, -segmentWidth, segmentHeight, offset, segmentForward, float2(1, t), transformMatrix, faceNormal, color, worldPos));



			}
			// Add just below the loop to insert the vertex at the tip of the blade.
			triStream.Append(GrassVertex(v0 + float3(sphereDisp.x * 1.5, sphereDisp.y, sphereDisp.z * 1.5) + wind1, 0, _GrassHeight, offset, forward, float2(0.5, 1), transformationMatrix, faceNormal, color, worldPos));
			// restart the strip to start another grass blade
			triStream.RestartStrip();
		}
	}


	ENDCG
		SubShader
	{
		Cull Off

			Pass // basic color with directional lights
			{
				Tags
				{
					"RenderType" = "Geometry"
					"LightMode" = "ForwardBase"
				}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 
			#pragma geometry geom
			#pragma target 4.6
			#pragma multi_compile_fwdbase_fullforwardshadows

			float4 _TopColor;
			float4 _BottomColor;
			float _AmbientStrength;

			float4 frag(g2f i) : SV_Target
			{
				// take shadow data
			float shadow = 1;
#if defined(SHADOWS_SCREEN)
			shadow = (SAMPLE_DEPTH_TEXTURE_PROJ(_ShadowMapTexture, UNITY_PROJ_COORD(i._ShadowCoord)).r);
#endif			
			// base color by lerping 2 colors over the UVs
			float4 baseColor = lerp(_BottomColor , _TopColor , saturate(i.uv.y)) * float4(i.diffuseColor, 1);
			// multiply with lighting color
			float4 litColor = (baseColor * _LightColor0);
			// multiply with vertex color, and shadows
			float4 final = litColor * shadow;
			// add in basecolor when lights turned off
			final += saturate((1 - shadow) * baseColor * 0.2);
			// add in ambient color
			final += (unity_AmbientSky * baseColor * _AmbientStrength);
			// add fog
			UNITY_APPLY_FOG(i.fogCoord, final);
			return final;
			}
			ENDCG
		}

			Pass
				// point lights
			{
				Tags
				{
					"LightMode" = "ForwardAdd"
				}
				Blend OneMinusDstColor One
				ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag									
			#pragma multi_compile_fwdadd_fullforwardshadows

			float4 frag(g2f i) : SV_Target
			{
					UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);

					float3 pointlights = atten * _LightColor0.rgb;

					return float4(pointlights, 1);
				}
			ENDCG
			}

		Pass // shadow pass
			{
				Tags
				{
					"LightMode" = "ShadowCaster"
				}

					CGPROGRAM
					#pragma vertex vert
					#pragma geometry geom
					#pragma fragment frag
					#pragma multi_compile_shadowcaster

					float4 frag(g2f i) : SV_Target
					{

						SHADOW_CASTER_FRAGMENT(i)
					}
					ENDCG
			}


	}    Fallback "VertexLit"
}
