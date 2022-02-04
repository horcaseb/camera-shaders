Shader "Custom/Bordes camara"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Factor("Factor",Range(0,1)) = 1


    }
    SubShader
    {
		pass 
		{
			CGPROGRAM

		#pragma vertex vert_img
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"
		#pragma target 3.0

		sampler2D _MainTex;
		float4 _MainTex_TexelSize;

		sampler2D _CameraDepthTexture;
		float4 _CameraDepthTexture_TexelSize;

		float2 uv_MainTex;
		float2 uv_CameraDepthTexture;

		float4 _Color;

		float _Factor;

		
		static const half edge8[9] = {
			-1.0,-1.0,-1.0,
			-1.0,8.0,-1.0,
			-1.0,-1.0,-1.0
		};



		float4 frag(v2f_img i) :COLOR
		{

			float4 output = half4(0,0,0,1);
			float4 texelm = _MainTex_TexelSize;
			float4 texel = _CameraDepthTexture_TexelSize;

			float4 colororiginal = tex2D(_MainTex, i.uv);
			float profundidad = tex2D(_CameraDepthTexture, i.uv);
			profundidad = 1-Linear01Depth(profundidad);

			int linea = 2;
			float3 main = tex2D(_MainTex, float2(i.uv.x, i.uv.y)).rgb;
			float3 main1 = tex2D(_MainTex, float2(i.uv.x - linea * texelm.x, i.uv.y)).rgb;//izq
			float3 main2 = tex2D(_MainTex, float2(i.uv.x + linea * texelm.x, i.uv.y)).rgb;//der
			float3 main3 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - linea * texelm.y)).rgb;//abajo
			float3 main4 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + linea * texelm.y)).rgb;//arriba
			float3 main5 = tex2D(_MainTex, float2(i.uv.x + linea * texelm.x, i.uv.y + linea * texelm.y)).rgb;
			float3 main6 = tex2D(_MainTex, float2(i.uv.x - linea * texelm.x, i.uv.y - linea * texelm.y)).rgb;
			float3 main7 = tex2D(_MainTex, float2(i.uv.x + linea * texelm.x, i.uv.y - linea * texelm.y)).rgb;
			float3 main8 = tex2D(_MainTex, float2(i.uv.x - linea * texelm.x, i.uv.y + linea * texelm.y)).rgb;
			
			float pixel0 = tex2D(_CameraDepthTexture, float2(i.uv.x, i.uv.y));//centro
			float pixel1 = tex2D(_CameraDepthTexture, float2(i.uv.x - linea * texel.x, i.uv.y)).rgb;//izq
			float pixel2 = tex2D(_CameraDepthTexture, float2(i.uv.x + linea * texel.x, i.uv.y)).rgb;//der
			float pixel3 = tex2D(_CameraDepthTexture, float2(i.uv.x, i.uv.y - linea * texel.y)).rgb;//abajo
			float pixel4 = tex2D(_CameraDepthTexture, float2(i.uv.x, i.uv.y + linea * texel.y)).rgb;//arriba
			float pixel5 = tex2D(_CameraDepthTexture, float2(i.uv.x + linea * texel.x, i.uv.y + linea * texel.y)).rgb;
			float pixel6 = tex2D(_CameraDepthTexture, float2(i.uv.x - linea * texel.x, i.uv.y - linea * texel.y)).rgb;
			float pixel7 = tex2D(_CameraDepthTexture, float2(i.uv.x + linea * texel.x, i.uv.y - linea * texel.y)).rgb;
			float pixel8 = tex2D(_CameraDepthTexture, float2(i.uv.x - linea * texel.x, i.uv.y + linea * texel.y)).rgb;


			float camaraprof = 10*pixel0-(pixel1 + pixel2 + pixel3 + pixel4 + pixel5 + pixel6 + pixel7 + pixel8);
			float edge = 8 * main - (main1 + main2 + main3 + main4 + main5 + main6 + main7 + main8);
			edge = edge * edge;
			output.rgb= colororiginal - edge.xxx;
			//output.rgb = edge;

			return  output;
		}
		ENDCG
		}

		
    }
    FallBack "Diffuse"
}
