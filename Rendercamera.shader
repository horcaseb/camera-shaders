Shader "Custom/Rendercamera"
{
    Properties
    {
        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Factor("factor",float) =0.5
    }
    SubShader
    {
			pass {
					CGPROGRAM
					#pragma vertex vert_img
					#pragma fragment frag
					#pragma fragmentoption ARB_precision_hint_fastest
					#include "UnityCG.cginc"

					#pragma target 3.0

					uniform sampler2D _MainTex;
					sampler2D _CameraDepthTexture;
					float _Factor;

					float4 frag(v2f_img i) :COLOR{
						float4 c1 = tex2D(_MainTex, i.uv);
						float4 c3 = tex2D(_CameraDepthTexture, i.uv);

						/*if (c1.r > 2 * c1.g&&c1.r > 2 * c1.b) {
							return float4 (1, 1, 1, 1);
						}
						else {
							return float4(0, 0, 0, 1);
						}*/
						float4 c2 = c1.r*0.2126f+c1.g*0.7152f+c1.b*0.0722f; //escala de grises perfecta
						float a=1;
						float b=0;
						//return (c1 + b)*a;
						return 1 - c1;
					}
					ENDCG
			}
        
    }
    FallBack "Diffuse"
}
