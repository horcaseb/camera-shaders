Shader "Custom/Slider"
{

	Properties
	{
		_Texture1("ColorAl ", 2D) = "whitte" {}
		_Texture2("Mask (RGB)", 2D) = "whitte" {}
		_Color1("Color a cambiar",Color) = (1,1,1,1)
		_Factor("Factor",Range(0,1))=1

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
			sampler2D _Texture2;
			float4 _Color1;
			float _Factor;

			//Siempre: uv_ + nombre de la textura
			struct Input
			{
				float2 uv_Texture1;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				float3 Character = tex2D(_Texture1, IN.uv_Texture1).rgb;
				float3 mask = tex2D(_Texture2, IN.uv_Texture1).rgb;
				float3 c2 = Character * (1 - mask);
				float4 color = _Color1;
				float3 colorfinal = _Color1 *(1-_Factor)+ mask * _Factor;
				o.Albedo = (c2 + colorfinal).rgb;

			}
			ENDCG
		}
			FallBack "Diffuse"
}
