Shader "Custom/Normals"
{
	Properties
	{ _Texture1("ColorAl ", 2D) = "whitte" {}
		_Color1("Color a cambiar",Color) = (1,1,1,1)
		_Factor("Factor",Range(0,1)) = 1
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _Texture1;
			float4 _Color1;
			float _Factor;


			//Siempre: uv_ + nombre de la textura
			struct Input
			{
				float2 uv_Texture1;
				float3 worldNormal;
				float3 viewDir;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				o.Albedo = abs(IN.worldNormal);
			}
			ENDCG
		}
			FallBack "Diffuse"
}

