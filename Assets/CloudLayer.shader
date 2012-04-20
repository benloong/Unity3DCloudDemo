Shader "Custom/CloudLayer" {
	Properties {
		_Color ("Cloud Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_PerlinTex ("Perturb ", 2D) = "white" {}
		_Offset ("TexCoord offset", float) = 1
		_PerturbScale ("Perturb scale", float) = 1
		_Brightness ("Cloud Brightness", float) = 1
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		Cull Front Lighting Off ZWrite Off
		
//		Blend SrcAlpha Zero
		Blend One One
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _PerlinTex;
			float 	_Offset;
			float   _PerturbScale;
			float   _Brightness;
			float4  _Color;
			struct v2f {
			    float4  pos : SV_POSITION;
			    float2  uv : TEXCOORD0;
			};
			
			float4 _MainTex_ST;
			
			v2f vert (appdata_base v)
			{
			    v2f o;
			    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
			    o.pos.z = o.pos.w;
			    o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
//			    o.uv.x += _Offset;
			    return o;
			}
			
			float4 frag (v2f i) : COLOR
			{
				float4 cloudColor;
	
				i.uv.x += _Offset;
				float4 perturbValue = tex2D( _PerlinTex, i.uv) * _PerturbScale;
				perturbValue.xy = perturbValue.xy + i.uv + _Offset;
			    float4 texcol = tex2D (_MainTex, perturbValue.xy);
			    return texcol * _Color * _Brightness;
			}
			ENDCG
			
		}
	}
	FallBack "Diffuse"
}
