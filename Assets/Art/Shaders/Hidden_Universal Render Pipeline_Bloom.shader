Shader "Hidden/Universal Render Pipeline/Bloom"
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
    Pass // ind: 1, name: Bloom Prefilter
    {
      Name "Bloom Prefilter"
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
      
      uniform float4 _Params;
      
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
      
      
      
      float u_xlat0_d;
      
      float3 u_xlat16_1;
      
      float u_xlat2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_3;
      
      float u_xlat16_4;
      
      float u_xlat5;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = _Params.w + _Params.w;
          
          u_xlat16_3.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat3.xyz = min(u_xlat16_3.xyz, _Params.yyy);
          
          u_xlat16_1.x = max(u_xlat3.y, u_xlat3.x);
          
          u_xlat16_1.x = max(u_xlat3.z, u_xlat16_1.x);
          
          u_xlat2 = u_xlat16_1.x + (-_Params.z);
          
          u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
          
          u_xlat5 = u_xlat2 + _Params.w;
          
          u_xlat5 = max(u_xlat5, 0.0);
          
          u_xlat0_d = min(u_xlat0_d, u_xlat5);
          
          u_xlat16_4 = u_xlat0_d * u_xlat0_d;
          
          u_xlat0_d = _Params.w * 4.0 + 9.99999975e-05;
          
          u_xlat0_d = u_xlat16_4 / u_xlat0_d;
          
          u_xlat0_d = max(u_xlat0_d, u_xlat2);
          
          u_xlat0_d = u_xlat0_d / u_xlat16_1.x;
          
          u_xlat16_1.xyz = float3(u_xlat0_d) * u_xlat3.xyz;
          
          out_f.color.xyz = max(u_xlat16_1.xyz, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: Bloom Blur Horizontal
    {
      Name "Bloom Blur Horizontal"
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
      
      float3 u_xlat16_0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xz = _BlitTexture_TexelSize.xx * float2(8.0, 6.0);
          
          u_xlat0_d.y = float(0.0);
          
          u_xlat0_d.w = float(0.0);
          
          u_xlat1 = (-u_xlat0_d) + in_f.texcoord.xyxy;
          
          u_xlat0_d = u_xlat0_d.zwxw + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz * float3(0.0540540516, 0.0540540516, 0.0540540516);
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.0162162203, 0.0162162203, 0.0162162203) + u_xlat16_3.xyz;
          
          u_xlat1.xz = _BlitTexture_TexelSize.xx * float2(4.0, 2.0);
          
          u_xlat1.y = float(0.0);
          
          u_xlat1.w = float(0.0);
          
          u_xlat2 = (-u_xlat1) + in_f.texcoord.xyxy;
          
          u_xlat1 = u_xlat1.zwxy + in_f.texcoord.xyxy;
          
          u_xlat16_4.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_4.xyz * float3(0.121621624, 0.121621624, 0.121621624) + u_xlat16_3.xyz;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz * float3(0.194594592, 0.194594592, 0.194594592) + u_xlat16_3.xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz * float3(0.227027029, 0.227027029, 0.227027029) + u_xlat16_3.xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz * float3(0.194594592, 0.194594592, 0.194594592) + u_xlat16_3.xyz;
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.121621624, 0.121621624, 0.121621624) + u_xlat16_3.xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.0540540516, 0.0540540516, 0.0540540516) + u_xlat16_3.xyz;
          
          out_f.color.xyz = u_xlat16_0.xyz * float3(0.0162162203, 0.0162162203, 0.0162162203) + u_xlat16_3.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: Bloom Blur Vertical
    {
      Name "Bloom Blur Vertical"
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
      
      float3 u_xlat16_0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = 0.0;
          
          u_xlat0_d.yw = _BlitTexture_TexelSize.yy * float2(3.23076916, 1.38461542);
          
          u_xlat1 = (-u_xlat0_d.xyxw) + in_f.texcoord.xyxy;
          
          u_xlat0_d = u_xlat0_d.xwxy + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz * float3(0.31621623, 0.31621623, 0.31621623);
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.0702702701, 0.0702702701, 0.0702702701) + u_xlat16_3.xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.227027029, 0.227027029, 0.227027029) + u_xlat16_3.xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = u_xlat16_1.xyz * float3(0.31621623, 0.31621623, 0.31621623) + u_xlat16_3.xyz;
          
          out_f.color.xyz = u_xlat16_0.xyz * float3(0.0702702701, 0.0702702701, 0.0702702701) + u_xlat16_3.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: Bloom Upsample
    {
      Name "Bloom Upsample"
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
      
      uniform float4 _Params;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _SourceTexLowMip;
      
      
      
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
      
      float3 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_SourceTexLowMip, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
          
          u_xlat0_d.xyz = _Params.xxx * u_xlat0_d.xyz + u_xlat16_1.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
