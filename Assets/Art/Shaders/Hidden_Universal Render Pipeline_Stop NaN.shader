Shader "Hidden/Universal Render Pipeline/Stop NaN"
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
    Pass // ind: 1, name: Stop NaN
    {
      Name "Stop NaN"
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
      
      
      
      float3 u_xlat0_d;
      
      uint3 u_xlatu1;
      
      bool3 u_xlatb1;
      
      bool3 u_xlatb2;
      
      int u_xlatb9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlatu1.xyz = uint3(uint(floatBitsToUint(u_xlat0_d.x)) & uint(2147483647u), uint(floatBitsToUint(u_xlat0_d.y)) & uint(2147483647u), uint(floatBitsToUint(u_xlat0_d.z)) & uint(2147483647u));
          
          u_xlatb2.xyz = lessThan(uint4(2139095040u, 2139095040u, 2139095040u, uint(0u)), u_xlatu1.xyzx).xyz;
          
          u_xlatb1.xyz = equal(int4(u_xlatu1.xyzx), int4(int(0x7F800000u), int(0x7F800000u), int(0x7F800000u), 0)).xyz;
          
          u_xlatb9 = u_xlatb2.y || u_xlatb2.x;
          
          u_xlatb9 = u_xlatb2.z || u_xlatb9;
          
          u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
          
          u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
          
          u_xlatb9 = u_xlatb9 || u_xlatb1.x;
          
          out_f.color.xyz = (int(u_xlatb9)) ? float3(0.0, 0.0, 0.0) : u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
