Shader "Custom/RGB_to_HSV"
{

	Properties
	{

		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Factor("factor",float) = 0.5
		_A("saturacion",float) = 0

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
						float _Factor;
						float _A;


						inline float3 rgb2hsv(float3 c)   //metodo sacado de internet RGB to HSV
						{
							float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
							float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
							float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
							float d = q.x - min(q.w, q.y);
							float e = 1.0e-10;
							return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
						}

						inline float3 hsv2rgb(float3 c)   //metodo sacado de internet HSV to RGB
						{
							float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
							float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
							return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
						}

						float4 frag(v2f_img i) :COLOR{

							float4 main = tex2D(_MainTex,i.uv);   //declaracion del main
							float3 hsv = rgb2hsv(main.rgb);   //convertir el main original en hsv
							//hsv.g *= _A;    //slider _A para cambiar la saturacion
							//hsv.r *= _A;    //slider _A para cambiar el tono
							float4 c2;    //nuevo rgb
							c2.rgb = hsv2rgb(hsv);   //convertir el hsv en rgb
							c2.a = 1;	//alpha
							float4 c3 = main * (1 - _Factor) + c2 * _Factor; //lerp entre el original y el hsv
							//return c3;
							//return float4 (hsv.ggg, 1);  //depende de la saturacion de los objetos de la escena
							//return float4 (hsv.rrr, 1);  //depende del tono de los objetos de la escena
							return float4 (hsv.rrr, 1);

						}
						ENDCG
				}

		}
			FallBack "Diffuse"
}
