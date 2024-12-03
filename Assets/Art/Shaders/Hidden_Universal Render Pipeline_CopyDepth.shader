Shader "Hidden/Universal Render Pipeline/CopyDepth"
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
    Pass // ind: 1, name: CopyDepth
    {
      Name "CopyDepth"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      ZTest Always
      Cull Off
      ColorMask B
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _BlitScaleBias;
      
      uniform float2 _GlobalMipBias;
      
      uniform sampler2D _CameraDepthAttachment;
      
      
      
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
          
          float color : SV_Target0;
      
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
      
      
      
      float u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = texture(_CameraDepthAttachment, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
