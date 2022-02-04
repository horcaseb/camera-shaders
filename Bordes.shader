Shader "Custom/Bordes"
{
	Properties
	{	_Texture1("ColorAl ", 2D) = "whitte" {}
		_Color1("Color a cambiar",Color) = (1,1,1,1)
		_mask("Mask ", 2D) = "whitte" {}
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
		sampler2D _mask;
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
			float bordes = 1-(dot(IN.viewDir, IN.worldNormal));
			float4 Original = tex2D(_Texture1, IN.uv_Texture1);
			float3 mask = tex2D(_mask, IN.uv_Texture1).rgb;
			float mascara = 0;
			if (bordes > _Factor) {
				mascara = 1;
			}
			else {
				mascara = 0;
			}
			float3 paso1 = Original+Original * (mascara+mask);
			float3 paso2 = _Color1 * (mascara+mask);
			o.Albedo = paso1+paso2;
			o.Emission = paso2;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
