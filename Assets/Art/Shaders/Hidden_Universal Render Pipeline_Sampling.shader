Shader "Hidden/Universal Render Pipeline/Sampling"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
      "RenderPipeline" = "UniversalPipeline"
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: BoxDownsample
    {
      Name "BoxDownsample"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _BlitScaleBias;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _BlitTexture_TexelSize;
      
      uniform float _SampleOffset;
      
      uniform sampler2D _BlitTexture;
      
      
      
      struct appdata_t
      {
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float2 u_xlat0;
      
      uint3 u_xlatu0;
      
      int int_bitfieldInsert(int base, int insert, int offset, int bits) 
          {
          
          uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
          
          return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
      
      }
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(int_bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(uint(vertexID) & 2u);
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = float4(_SampleOffset) * float4(-1.0, -1.0, 1.0, 1.0);
          
          u_xlat1 = _BlitTexture_TexelSize.xyxy * u_xlat0_d.xyzy + in_f.texcoord.xyxy;
          
          u_xlat0_d = _BlitTexture_TexelSize.xyxy * u_xlat0_d.xwzw + in_f.texcoord.xyxy;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x);
          
          u_xlat16_1 = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat16_1 + u_xlat16_2;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x);
          
          u_xlat16_0 = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat1 + u_xlat16_2;
          
          u_xlat0_d = u_xlat16_0 + u_xlat1;
          
          u_xlat0_d = u_xlat0_d * float4(0.25, 0.25, 0.25, 0.25);
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
