Shader "Hidden/Universal Render Pipeline/Scaling Setup"
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
    Pass // ind: 1, name: ScalingSetup
    {
      Name "ScalingSetup"
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
      
      uniform float4 _SourceSize;
      
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
      
      int4 u_xlati0;
      
      uint4 u_xlatu0_d;
      
      float4 u_xlat1;
      
      float3 u_xlat16_1;
      
      int4 u_xlati1;
      
      uint4 u_xlatu1;
      
      int u_xlatb1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      uint4 u_xlatu2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      int u_xlatb8;
      
      float3 u_xlat16_10;
      
      float3 u_xlat16_11;
      
      float u_xlat16_17;
      
      float u_xlat16_24;
      
      float u_xlat16_26;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = in_f.texcoord.xyxy * _SourceSize.xyxy;
          
          u_xlati0 = int4(u_xlat0_d);
          
          u_xlati1 = u_xlati0.zwzw + int4(int(0xFFFFFFFFu), int(0xFFFFFFFFu), 1, int(0xFFFFFFFFu));
          
          u_xlati0 = u_xlati0 + int4(int(0xFFFFFFFFu), 1, 1, 1);
          
          u_xlat0_d = float4(u_xlati0);
          
          u_xlat0_d = max(u_xlat0_d, float4(0.0, 0.0, 0.0, 0.0));
          
          u_xlat1 = float4(u_xlati1);
          
          u_xlat1 = max(u_xlat1, float4(0.0, 0.0, 0.0, 0.0));
          
          u_xlat2 = _SourceSize.xyxy + float4(-1.0, -1.0, -1.0, -1.0);
          
          u_xlat1 = min(u_xlat1, u_xlat2);
          
          u_xlat0_d = min(u_xlat0_d, u_xlat2);
          
          u_xlatu0_d = uint4(int4(u_xlat0_d.zwxy));
          
          u_xlatu1 = uint4(int4(u_xlat1.zwxy));
          
          u_xlatu2.xy = u_xlatu1.zw;
          
          u_xlatu2.z = uint(uint(0u));
          
          u_xlatu2.w = uint(uint(0u));
          
          u_xlat2.xyz = texelFetch(_BlitTexture, int2(u_xlatu2.xy), int(u_xlatu2.w)).xyz;
          
          u_xlat16_3.xyz = u_xlat2.xyz;
          
          u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
          
          u_xlat16_3.x = dot(u_xlat16_3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlatu2.xy = u_xlatu0_d.zw;
          
          u_xlatu2.z = uint(uint(0u));
          
          u_xlatu2.w = uint(uint(0u));
          
          u_xlat2.xyz = texelFetch(_BlitTexture, int2(u_xlatu2.xy), int(u_xlatu2.w)).xyz;
          
          u_xlat16_10.xyz = u_xlat2.xyz;
          
          u_xlat16_10.xyz = clamp(u_xlat16_10.xyz, 0.0, 1.0);
          
          u_xlat16_10.x = dot(u_xlat16_10.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat16_17 = u_xlat16_10.x + u_xlat16_3.x;
          
          u_xlatu1.z = uint(uint(0u));
          
          u_xlatu1.w = uint(uint(0u));
          
          u_xlat1.xyz = texelFetch(_BlitTexture, int2(u_xlatu1.xy), int(u_xlatu1.w)).xyz;
          
          u_xlat16_4.xyz = u_xlat1.xyz;
          
          u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
          
          u_xlat16_24 = dot(u_xlat16_4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlatu0_d.z = uint(uint(0u));
          
          u_xlatu0_d.w = uint(uint(0u));
          
          u_xlat0_d.xyz = texelFetch(_BlitTexture, int2(u_xlatu0_d.xy), int(u_xlatu0_d.w)).xyz;
          
          u_xlat16_4.xyz = u_xlat0_d.xyz;
          
          u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
          
          u_xlat16_4.x = dot(u_xlat16_4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat16_11.x = u_xlat16_24 + u_xlat16_4.x;
          
          u_xlat16_0.yw = float2(u_xlat16_17) + (-u_xlat16_11.xx);
          
          u_xlat16_17 = u_xlat16_24 + u_xlat16_3.x;
          
          u_xlat16_11.x = u_xlat16_10.x + u_xlat16_4.x;
          
          u_xlat16_11.x = u_xlat16_17 + (-u_xlat16_11.x);
          
          u_xlat16_17 = u_xlat16_10.x + u_xlat16_17;
          
          u_xlat16_17 = u_xlat16_4.x + u_xlat16_17;
          
          u_xlat16_17 = u_xlat16_17 * 0.03125;
          
          u_xlat16_17 = max(u_xlat16_17, 0.0078125);
          
          u_xlat1.x = min(abs(u_xlat16_0.w), abs(u_xlat16_11.x));
          
          u_xlat16_0.xz = (-u_xlat16_11.xx);
          
          u_xlat1.x = u_xlat16_17 + u_xlat1.x;
          
          u_xlat1.x = float(1.0) / float(u_xlat1.x);
          
          u_xlat0_d = u_xlat16_0 * u_xlat1.xxxx;
          
          u_xlat0_d = max(u_xlat0_d, float4(-8.0, -8.0, -8.0, -8.0));
          
          u_xlat0_d = min(u_xlat0_d, float4(8.0, 8.0, 8.0, 8.0));
          
          u_xlat0_d = u_xlat0_d * _SourceSize.zwzw;
          
          u_xlat1 = u_xlat0_d.zwzw * float4(-0.5, -0.5, -0.166666672, -0.166666672) + in_f.texcoord.xyxy;
          
          u_xlat0_d = u_xlat0_d * float4(0.166666672, 0.166666672, 0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_11.xyz = u_xlat16_1.xyz;
          
          u_xlat16_11.xyz = clamp(u_xlat16_11.xyz, 0.0, 1.0);
          
          u_xlat16_5.xyz = u_xlat16_2.xyz;
          
          u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_6.xyz = u_xlat16_2.xyz;
          
          u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
          
          u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_6.xyz;
          
          u_xlat16_6.xyz = u_xlat16_1.xyz;
          
          u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
          
          u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
          
          u_xlat16_5.xyz = u_xlat16_5.xyz * float3(0.25, 0.25, 0.25);
          
          u_xlat16_5.xyz = u_xlat16_11.xyz * float3(0.25, 0.25, 0.25) + u_xlat16_5.xyz;
          
          u_xlat16_11.xyz = u_xlat16_11.xyz * float3(0.5, 0.5, 0.5);
          
          u_xlat16_17 = dot(u_xlat16_5.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat16_26 = min(u_xlat16_10.x, u_xlat16_24);
          
          u_xlat16_10.x = max(u_xlat16_10.x, u_xlat16_24);
          
          u_xlat16_10.x = max(u_xlat16_4.x, u_xlat16_10.x);
          
          u_xlat16_24 = min(u_xlat16_4.x, u_xlat16_26);
          
          u_xlat16_1.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_6.xyz = u_xlat16_1.xyz;
          
          u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
          
          u_xlat16_4.x = dot(u_xlat16_6.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat16_26 = min(u_xlat16_3.x, u_xlat16_4.x);
          
          u_xlat16_3.x = max(u_xlat16_3.x, u_xlat16_4.x);
          
          u_xlat16_3.x = max(u_xlat16_10.x, u_xlat16_3.x);
          
          u_xlatb1 = u_xlat16_3.x<u_xlat16_17;
          
          u_xlat16_3.x = min(u_xlat16_24, u_xlat16_26);
          
          u_xlatb8 = u_xlat16_17<u_xlat16_3.x;
          
          u_xlatb1 = u_xlatb1 || u_xlatb8;
          
          out_f.color.xyz = (int(u_xlatb1)) ? u_xlat16_11.xyz : u_xlat16_5.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
