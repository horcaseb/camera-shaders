Shader "Custom/Holograma"
{
	Properties
	{	
		_Texture1("textura ", 2D) = "whitte" {}
		_Color1("Color a cambiar",Color) = (1,1,1,1)
		_Factor("bordes",Range(0,1)) = 1
		_Maskfactor("transparencia",Range(0,1)) = 1

	}
		
		SubShader
		{
				pass 
				{
					ZWrite On
					ColorMask 0
					
				}
			Tags 
			{ 
				"Queue" = "Transparent"
				"IgnoreProjector" = "true"
				"RenderType" = "TransparentCutout"
			}
			LOD 200

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard Example alpha:fade

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _Texture1;
			float4 _Color1;
			float _Factor;
			float _Maskfactor;



			//Siempre: uv_ + nombre de la textura
			struct Input
			{
				float2 uv_Texture1;
				float3 worldNormal;
				float3 viewDir;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				float bordes = 1 - (dot(IN.viewDir, IN.worldNormal));
				float4 Original = tex2D(_Texture1, IN.uv_Texture1);
				float mascara = 0;
				if (bordes >= _Factor) 
				{
					mascara = 1;
				}
				else 
				{
					mascara = _Maskfactor;
				}
				float3 paso1 = _Color1*(mascara);
				float3 paso2 = Original*(mascara);
				o.Albedo = paso1 + paso2 + (Original*_Maskfactor);
				o.Alpha = mascara;
				//o.Emission = paso1*1-_Factor;
			} 
			
		
			ENDCG
		}
			FallBack "Diffuse"
}
