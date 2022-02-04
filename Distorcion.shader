Shader "Custom/Distorcion"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Factor ("factor",float)=0.5

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
		half4 _MainTex_TexelSize;

		float2 uv_MainTex;

		fixed4 _Color;

		float4 frag(v2f_img i) :COLOR
		{
			float x0 = i.uv.x;
			float y0 = i.uv.y;
			float t = _Time.y;

			float x1 = 1 * cos(x0);
			float y1 = 1 * sin(y0);

			float x2 = lerp(x0, x1, _SinTime / 10);
			float y2 = lerp(y0, y1, _SinTime / 10);

			float4 uvs = float4(x2, y2, 0, 0);
			float4 output = float4 (tex2Dlod(_MainTex,uvs).rgb,1);
			return output;

		}
		ENDCG
		}


	}
		FallBack "Diffuse"
}
