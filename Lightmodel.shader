Shader "Custom/Lightmodel"
{
	Properties
	{
		_Texture("textura (RGB)", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque"}
			LOD 200

			CGPROGRAM

			#pragma surface surf Example



			#pragma target 3.0

			sampler2D _Texture;
			float4 _Color;

			struct Input
			{
				float2 uv_Texture;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_Texture, IN.uv_Texture) * _Color;


			}
			float4 LightingExample(SurfaceOutput s, float3 lightDir, float atten)
			{
				half NdotL = dot(s.Normal, lightDir);
				float4 light;
				light.rgb = s.Albedo*_LightColor0*(NdotL*atten*2);
				light.a = s.Alpha;
				return light;
			}

			ENDCG
		}
			FallBack "Diffuse"
}
