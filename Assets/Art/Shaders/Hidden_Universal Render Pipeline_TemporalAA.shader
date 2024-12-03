Shader "Hidden/Universal Render Pipeline/TemporalAA"
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
    Pass // ind: 1, name: TemporalAA - Accumulate - Quality Very Low
    {
      Name "TemporalAA - Accumulate - Quality Very Low"
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
      
      uniform sampler2D _TaaMotionVectorTex;
      
      uniform sampler2D _TaaAccumulationTex;
      
      
      
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
      
      
      
      uniform TemporalAAData 
          {
          
          #endif
          uniform float4 _BlitTexture_TexelSize;
          
          uniform float4 Xhlslcc_UnusedX_TaaMotionVectorTex_TexelSize;
          
          uniform float4 Xhlslcc_UnusedX_TaaAccumulationTex_TexelSize;
          
          uniform float Xhlslcc_UnusedX_TaaFilterWeights[9];
          
          uniform float _TaaFrameInfluence;
          
          uniform float Xhlslcc_UnusedX_TaaVarianceClampScale;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float3 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float u_xlat18;
      
      float u_xlat16_22;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xy = texture(_TaaMotionVectorTex, in_f.texcoord.xy, _GlobalMipBias.x).xy;
          
          u_xlat0_d.xy = (-u_xlat16_0.xy) + in_f.texcoord.xy;
          
          u_xlat16_0.xyz = texture(_TaaAccumulationTex, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat1 = _BlitTexture_TexelSize.xyxy * float4(0.0, -1.0, -1.0, 0.0) + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_3.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_4.xyz = min(u_xlat16_1.xyz, u_xlat16_3.xyz);
          
          u_xlat16_5.xyz = max(u_xlat16_1.xyz, u_xlat16_3.xyz);
          
          u_xlat16_5.xyz = max(u_xlat16_2.xyz, u_xlat16_5.xyz);
          
          u_xlat16_4.xyz = min(u_xlat16_2.xyz, u_xlat16_4.xyz);
          
          u_xlat1 = _BlitTexture_TexelSize.xyxy * float4(1.0, 0.0, 0.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_4.xyz = min(u_xlat16_4.xyz, u_xlat16_2.xyz);
          
          u_xlat16_5.xyz = max(u_xlat16_5.xyz, u_xlat16_2.xyz);
          
          u_xlat16_5.xyz = max(u_xlat16_1.xyz, u_xlat16_5.xyz);
          
          u_xlat16_4.xyz = min(u_xlat16_1.xyz, u_xlat16_4.xyz);
          
          u_xlat16_4.xyz = max(u_xlat16_0.xyz, u_xlat16_4.xyz);
          
          u_xlat16_4.xyz = min(u_xlat16_5.xyz, u_xlat16_4.xyz);
          
          u_xlat16_22 = dot(u_xlat16_4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat0_d.x = u_xlat16_22 + 1.0;
          
          u_xlat0_d.x = float(1.0) / float(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat16_4.xyz;
          
          u_xlat16_4.x = dot(u_xlat16_3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat18 = u_xlat16_4.x + 1.0;
          
          u_xlat18 = float(1.0) / float(u_xlat18);
          
          u_xlat1.xyz = u_xlat16_3.xyz * float3(u_xlat18) + (-u_xlat0_d.xyz);
          
          u_xlat0_d.xyz = float3(_TaaFrameInfluence) * u_xlat1.xyz + u_xlat0_d.xyz;
          
          u_xlat16_4.x = dot(u_xlat0_d.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat18 = (-u_xlat16_4.x) + 1.0;
          
          u_xlat18 = float(1.0) / float(u_xlat18);
          
          u_xlat0_d.xyz = float3(u_xlat18) * u_xlat0_d.xyz;
          
          out_f.color.xyz = max(u_xlat0_d.xyz, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: TemporalAA - Accumulate - Quality Low
    {
      Name "TemporalAA - Accumulate - Quality Low"
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
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _TaaMotionVectorTex;
      
      uniform sampler2D _TaaAccumulationTex;
      
      
      
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
      
      
      
      uniform TemporalAAData 
          {
          
          #endif
          uniform float4 _BlitTexture_TexelSize;
          
          uniform float4 _TaaMotionVectorTex_TexelSize;
          
          uniform float4 Xhlslcc_UnusedX_TaaAccumulationTex_TexelSize;
          
          uniform float Xhlslcc_UnusedX_TaaFilterWeights[9];
          
          uniform float _TaaFrameInfluence;
          
          uniform float Xhlslcc_UnusedX_TaaVarianceClampScale;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      float2 u_xlat3;
      
      float2 u_xlat16_3;
      
      bool2 u_xlatb3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float3 u_xlat16_7;
      
      float2 u_xlat16_9;
      
      int u_xlatb10;
      
      int u_xlatb11;
      
      float2 u_xlat19;
      
      float u_xlat24;
      
      int u_xlatb24;
      
      float u_xlat16_25;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_1.x = min(u_xlat0_d.x, 1.0);
          
          u_xlat0_d = _BlitTexture_TexelSize.xyxy * float4(1.0, 0.0, 0.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat2.x = texture(_CameraDepthTexture, u_xlat0_d.xy, _GlobalMipBias.x).x;
          
          u_xlatb10 = u_xlat2.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat2.x);
          
          u_xlat16_9.x = (u_xlatb10) ? 1.0 : 0.0;
          
          u_xlat2 = _BlitTexture_TexelSize.xyxy * float4(0.0, -1.0, -1.0, 0.0) + in_f.texcoord.xyxy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.xy, _GlobalMipBias.x).x;
          
          u_xlatb11 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_9.x = (u_xlatb11) ? 0.0 : u_xlat16_9.x;
          
          u_xlat16_9.y = (u_xlatb11) ? -1.0 : 0.0;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.zw, _GlobalMipBias.x).x;
          
          u_xlatb11 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_9.xy = (int(u_xlatb11)) ? float2(-1.0, 0.0) : u_xlat16_9.xy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat0_d.zw, _GlobalMipBias.x).x;
          
          u_xlatb3.x = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = (u_xlatb3.x) ? 0.0 : u_xlat16_9.x;
          
          u_xlat16_1.y = (u_xlatb3.x) ? 1.0 : u_xlat16_9.y;
          
          u_xlat3.xy = _TaaMotionVectorTex_TexelSize.xy * u_xlat16_1.xy + in_f.texcoord.xy;
          
          u_xlat16_3.xy = texture(_TaaMotionVectorTex, u_xlat3.xy, _GlobalMipBias.x).xy;
          
          u_xlat19.xy = (-u_xlat16_3.xy) + in_f.texcoord.xy;
          
          u_xlat16_4.xyz = texture(_TaaAccumulationTex, u_xlat19.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_5.xyz = texture(_BlitTexture, u_xlat2.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_6.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = min(u_xlat16_2.xyz, u_xlat16_6.xyz);
          
          u_xlat16_7.xyz = max(u_xlat16_2.xyz, u_xlat16_6.xyz);
          
          u_xlat16_7.xyz = max(u_xlat16_5.xyz, u_xlat16_7.xyz);
          
          u_xlat16_1.xyz = min(u_xlat16_1.xyz, u_xlat16_5.xyz);
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = min(u_xlat16_1.xyz, u_xlat16_2.xyz);
          
          u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_2.xyz);
          
          u_xlat16_7.xyz = max(u_xlat16_0.xyz, u_xlat16_7.xyz);
          
          u_xlat16_1.xyz = min(u_xlat16_0.xyz, u_xlat16_1.xyz);
          
          u_xlat16_1.xyz = max(u_xlat16_1.xyz, u_xlat16_4.xyz);
          
          u_xlat16_1.xyz = min(u_xlat16_7.xyz, u_xlat16_1.xyz);
          
          u_xlat16_25 = dot(u_xlat16_1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat0_d.x = u_xlat16_25 + 1.0;
          
          u_xlat0_d.x = float(1.0) / float(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat16_1.xyz;
          
          u_xlat16_1.x = dot(u_xlat16_6.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat24 = u_xlat16_1.x + 1.0;
          
          u_xlat24 = float(1.0) / float(u_xlat24);
          
          u_xlat2.xyz = u_xlat16_6.xyz * float3(u_xlat24) + (-u_xlat0_d.xyz);
          
          u_xlat19.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
          
          u_xlat3.xy = (-u_xlat16_3.xy) + u_xlat19.xy;
          
          u_xlatb3.xy = lessThan(float4(0.5, 0.5, 0.0, 0.0), abs(u_xlat3.xyxx)).xy;
          
          u_xlatb24 = u_xlatb3.y || u_xlatb3.x;
          
          u_xlat16_1.x = (u_xlatb24) ? 1.0 : _TaaFrameInfluence;
          
          u_xlat0_d.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0_d.xyz;
          
          u_xlat16_1.x = dot(u_xlat0_d.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
          
          u_xlat24 = (-u_xlat16_1.x) + 1.0;
          
          u_xlat24 = float(1.0) / float(u_xlat24);
          
          u_xlat0_d.xyz = float3(u_xlat24) * u_xlat0_d.xyz;
          
          out_f.color.xyz = max(u_xlat0_d.xyz, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: TemporalAA - Accumulate - Quality Medium
    {
      Name "TemporalAA - Accumulate - Quality Medium"
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
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _TaaMotionVectorTex;
      
      uniform sampler2D _TaaAccumulationTex;
      
      
      
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
      
      
      
      uniform TemporalAAData 
          {
          
          #endif
          uniform float4 _BlitTexture_TexelSize;
          
          uniform float4 _TaaMotionVectorTex_TexelSize;
          
          uniform float4 Xhlslcc_UnusedX_TaaAccumulationTex_TexelSize;
          
          uniform float Xhlslcc_UnusedX_TaaFilterWeights[9];
          
          uniform float _TaaFrameInfluence;
          
          uniform float _TaaVarianceClampScale;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      float2 u_xlat3;
      
      float4 u_xlat16_3;
      
      bool2 u_xlatb3;
      
      int u_xlatb4;
      
      float4 u_xlat5;
      
      float2 u_xlat6;
      
      float2 u_xlat16_6;
      
      float3 u_xlat16_7;
      
      float3 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float3 u_xlat16_10;
      
      float3 u_xlat16_11;
      
      float3 u_xlat16_12;
      
      float3 u_xlat16_13;
      
      float3 u_xlat16_14;
      
      float3 u_xlat16_15;
      
      float3 u_xlat16_16;
      
      float3 u_xlat16_17;
      
      float3 u_xlat16_18;
      
      float3 u_xlat16_19;
      
      float2 u_xlat16_21;
      
      int u_xlatb22;
      
      int u_xlatb23;
      
      float2 u_xlat24;
      
      float3 u_xlat16_24;
      
      int u_xlatb24;
      
      float u_xlat16_41;
      
      float u_xlat43;
      
      int u_xlatb43;
      
      float2 u_xlat46;
      
      float u_xlat60;
      
      int u_xlatb60;
      
      float u_xlat16_61;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_1.x = min(u_xlat0_d.x, 1.0);
          
          u_xlat0_d = _BlitTexture_TexelSize.xyxy * float4(1.0, 0.0, 0.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat2.x = texture(_CameraDepthTexture, u_xlat0_d.xy, _GlobalMipBias.x).x;
          
          u_xlatb22 = u_xlat2.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat2.x);
          
          u_xlat16_21.x = (u_xlatb22) ? 1.0 : 0.0;
          
          u_xlat2 = _BlitTexture_TexelSize.xyxy * float4(0.0, -1.0, -1.0, 0.0) + in_f.texcoord.xyxy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.xy, _GlobalMipBias.x).x;
          
          u_xlatb23 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_21.x = (u_xlatb23) ? 0.0 : u_xlat16_21.x;
          
          u_xlat16_21.y = (u_xlatb23) ? -1.0 : 0.0;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.zw, _GlobalMipBias.x).x;
          
          u_xlatb23 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_21.xy = (int(u_xlatb23)) ? float2(-1.0, 0.0) : u_xlat16_21.xy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat0_d.zw, _GlobalMipBias.x).x;
          
          u_xlatb23 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_21.xy = (int(u_xlatb23)) ? float2(0.0, 1.0) : u_xlat16_21.xy;
          
          u_xlat3.xy = in_f.texcoord.xy + (-_BlitTexture_TexelSize.xy);
          
          u_xlat43 = texture(_CameraDepthTexture, u_xlat3.xy, _GlobalMipBias.x).x;
          
          u_xlat16_3.xyw = texture(_BlitTexture, u_xlat3.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb4 = u_xlat43<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat43);
          
          u_xlat16_21.x = (u_xlatb4) ? -1.0 : u_xlat16_21.x;
          
          u_xlat5 = _BlitTexture_TexelSize.xyxy * float4(1.0, -1.0, -1.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat43 = texture(_CameraDepthTexture, u_xlat5.xy, _GlobalMipBias.x).x;
          
          u_xlatb24 = u_xlat43<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat43);
          
          u_xlat16_21.x = (u_xlatb24) ? 1.0 : u_xlat16_21.x;
          
          u_xlatb43 = u_xlatb24 || u_xlatb4;
          
          u_xlat16_41 = (u_xlatb43) ? -1.0 : u_xlat16_21.y;
          
          u_xlat43 = texture(_CameraDepthTexture, u_xlat5.zw, _GlobalMipBias.x).x;
          
          u_xlatb4 = u_xlat43<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat43);
          
          u_xlat16_21.x = (u_xlatb4) ? -1.0 : u_xlat16_21.x;
          
          u_xlat24.xy = in_f.texcoord.xy + _BlitTexture_TexelSize.xy;
          
          u_xlat43 = texture(_CameraDepthTexture, u_xlat24.xy, _GlobalMipBias.x).x;
          
          u_xlat16_24.xyz = texture(_BlitTexture, u_xlat24.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb43 = u_xlat43<u_xlat16_1.x;
          
          u_xlat16_1.x = (u_xlatb43) ? 1.0 : u_xlat16_21.x;
          
          u_xlatb43 = u_xlatb43 || u_xlatb4;
          
          u_xlat16_1.y = (u_xlatb43) ? 1.0 : u_xlat16_41;
          
          u_xlat6.xy = _TaaMotionVectorTex_TexelSize.xy * u_xlat16_1.xy + in_f.texcoord.xy;
          
          u_xlat16_6.xy = texture(_TaaMotionVectorTex, u_xlat6.xy, _GlobalMipBias.x).xy;
          
          u_xlat46.xy = (-u_xlat16_6.xy) + in_f.texcoord.xy;
          
          u_xlat16_7.xyz = texture(_TaaAccumulationTex, u_xlat46.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.x = dot(u_xlat16_7.xz, float2(0.5, -0.5));
          
          u_xlat16_1.y = u_xlat16_1.x + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_7.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_1.x = dot(u_xlat16_7.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_1.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_24.xz, float2(0.5, -0.5));
          
          u_xlat16_8.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_24.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_8.x = dot(u_xlat16_24.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_8.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_3.xw, float2(0.5, -0.5));
          
          u_xlat16_9.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_3.xwy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_9.x = dot(u_xlat16_3.xwy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_9.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_3.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_61 = dot(u_xlat16_3.xz, float2(0.5, -0.5));
          
          u_xlat16_10.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_3.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_10.x = dot(u_xlat16_3.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_10.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_11.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_11.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_11.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat2.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_61 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_12.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_12.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_12.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_13.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_13.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_13.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_14.xyz = u_xlat16_13.xyz * u_xlat16_13.xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_61 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_15.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_15.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_15.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_14.xyz = u_xlat16_15.xyz * u_xlat16_15.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_12.xyz * u_xlat16_12.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_11.xyz * u_xlat16_11.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_9.xyz * u_xlat16_9.xyz + u_xlat16_14.xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat5.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat5.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_61 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_16.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_16.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_16.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_14.xyz = u_xlat16_16.xyz * u_xlat16_16.xyz + u_xlat16_14.xyz;
          
          u_xlat16_61 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_17.y = u_xlat16_61 + 0.501960814;
          
          u_xlat16_61 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_17.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_17.z = u_xlat16_61 + 0.501960814;
          
          u_xlat16_14.xyz = u_xlat16_17.xyz * u_xlat16_17.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_8.xyz * u_xlat16_8.xyz + u_xlat16_14.xyz;
          
          u_xlat16_18.xyz = u_xlat16_13.xyz + u_xlat16_15.xyz;
          
          u_xlat16_18.xyz = u_xlat16_12.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_11.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_10.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_9.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_16.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_17.xyz + u_xlat16_18.xyz;
          
          u_xlat16_18.xyz = u_xlat16_8.xyz + u_xlat16_18.xyz;
          
          u_xlat16_19.xyz = u_xlat16_18.xyz * float3(0.111111112, 0.111111112, 0.111111112);
          
          u_xlat16_19.xyz = u_xlat16_19.xyz * u_xlat16_19.xyz;
          
          u_xlat16_14.xyz = u_xlat16_14.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_19.xyz);
          
          u_xlat16_14.xyz = sqrt(abs(u_xlat16_14.xyz));
          
          u_xlat16_14.xyz = u_xlat16_14.xyz * float3(float3(_TaaVarianceClampScale, _TaaVarianceClampScale, _TaaVarianceClampScale));
          
          u_xlat16_19.xyz = u_xlat16_18.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_14.xyz);
          
          u_xlat16_14.xyz = u_xlat16_18.xyz * float3(0.111111112, 0.111111112, 0.111111112) + u_xlat16_14.xyz;
          
          u_xlat16_18.xyz = min(u_xlat16_13.xyz, u_xlat16_15.xyz);
          
          u_xlat16_13.xyz = max(u_xlat16_13.xyz, u_xlat16_15.xyz);
          
          u_xlat16_13.xyz = max(u_xlat16_12.xyz, u_xlat16_13.xyz);
          
          u_xlat16_12.xyz = min(u_xlat16_12.xyz, u_xlat16_18.xyz);
          
          u_xlat16_12.xyz = min(u_xlat16_11.xyz, u_xlat16_12.xyz);
          
          u_xlat16_11.xyz = max(u_xlat16_11.xyz, u_xlat16_13.xyz);
          
          u_xlat16_11.xyz = max(u_xlat16_10.xyz, u_xlat16_11.xyz);
          
          u_xlat16_10.xyz = min(u_xlat16_10.xyz, u_xlat16_12.xyz);
          
          u_xlat16_10.xyz = min(u_xlat16_9.xyz, u_xlat16_10.xyz);
          
          u_xlat16_9.xyz = max(u_xlat16_9.xyz, u_xlat16_11.xyz);
          
          u_xlat16_9.xyz = max(u_xlat16_9.xyz, u_xlat16_16.xyz);
          
          u_xlat16_10.xyz = min(u_xlat16_10.xyz, u_xlat16_16.xyz);
          
          u_xlat16_10.xyz = min(u_xlat16_10.xyz, u_xlat16_17.xyz);
          
          u_xlat16_9.xyz = max(u_xlat16_9.xyz, u_xlat16_17.xyz);
          
          u_xlat16_9.xyz = max(u_xlat16_8.xyz, u_xlat16_9.xyz);
          
          u_xlat16_8.xyz = min(u_xlat16_8.xyz, u_xlat16_10.xyz);
          
          u_xlat16_8.xyz = max(u_xlat16_19.xyz, u_xlat16_8.xyz);
          
          u_xlat16_1.xyz = max(u_xlat16_1.xyz, u_xlat16_8.xyz);
          
          u_xlat16_8.xyz = min(u_xlat16_14.xyz, u_xlat16_9.xyz);
          
          u_xlat16_1.xyz = min(u_xlat16_1.xyz, u_xlat16_8.xyz);
          
          u_xlat0_d.x = u_xlat16_1.x + 1.0;
          
          u_xlat0_d.x = float(1.0) / float(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat16_1.xyz;
          
          u_xlat60 = u_xlat16_15.x + 1.0;
          
          u_xlat60 = float(1.0) / float(u_xlat60);
          
          u_xlat2.xyz = u_xlat16_15.xyz * float3(u_xlat60) + (-u_xlat0_d.xyz);
          
          u_xlat3.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
          
          u_xlat3.xy = (-u_xlat16_6.xy) + u_xlat3.xy;
          
          u_xlatb3.xy = lessThan(float4(0.5, 0.5, 0.0, 0.0), abs(u_xlat3.xyxx)).xy;
          
          u_xlatb60 = u_xlatb3.y || u_xlatb3.x;
          
          u_xlat16_1.x = (u_xlatb60) ? 1.0 : _TaaFrameInfluence;
          
          u_xlat0_d.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0_d.xyz;
          
          u_xlat60 = (-u_xlat0_d.x) + 1.0;
          
          u_xlat60 = float(1.0) / float(u_xlat60);
          
          u_xlat16_1.xy = u_xlat0_d.zy * float2(u_xlat60) + float2(-0.501960814, -0.501960814);
          
          u_xlat16_41 = u_xlat0_d.x * u_xlat60 + (-u_xlat16_1.y);
          
          u_xlat16_0.yz = u_xlat0_d.xx * float2(u_xlat60) + u_xlat16_1.yx;
          
          u_xlat16_0.w = (-u_xlat16_1.x) + u_xlat16_41;
          
          u_xlat16_0.x = (-u_xlat16_1.x) + u_xlat16_0.y;
          
          out_f.color.xyz = max(u_xlat16_0.xzw, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: TemporalAA - Accumulate - Quality High
    {
      Name "TemporalAA - Accumulate - Quality High"
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
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _TaaMotionVectorTex;
      
      uniform sampler2D _TaaAccumulationTex;
      
      
      
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
      
      
      
      uniform TemporalAAData 
          {
          
          #endif
          uniform float4 _BlitTexture_TexelSize;
          
          uniform float4 _TaaMotionVectorTex_TexelSize;
          
          uniform float4 _TaaAccumulationTex_TexelSize;
          
          uniform float Xhlslcc_UnusedX_TaaFilterWeights[9];
          
          uniform float _TaaFrameInfluence;
          
          uniform float _TaaVarianceClampScale;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float2 u_xlat16_1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      float2 u_xlat3;
      
      float4 u_xlat16_3;
      
      bool2 u_xlatb3;
      
      int u_xlatb4;
      
      float4 u_xlat5;
      
      float2 u_xlat6;
      
      float2 u_xlat16_6;
      
      float4 u_xlat7;
      
      float3 u_xlat16_7;
      
      float3 u_xlat16_8;
      
      float4 u_xlat16_9;
      
      float4 u_xlat16_10;
      
      float3 u_xlat16_11;
      
      float3 u_xlat16_12;
      
      float3 u_xlat16_13;
      
      float3 u_xlat16_14;
      
      float3 u_xlat16_15;
      
      float3 u_xlat16_16;
      
      float3 u_xlat16_17;
      
      float3 u_xlat16_18;
      
      float3 u_xlat16_19;
      
      float3 u_xlat16_20;
      
      float3 u_xlat16_21;
      
      float3 u_xlat16_22;
      
      float2 u_xlat16_24;
      
      int u_xlatb25;
      
      int u_xlatb26;
      
      float2 u_xlat27;
      
      float3 u_xlat16_27;
      
      int u_xlatb27;
      
      float3 u_xlat16_31;
      
      float u_xlat16_47;
      
      float u_xlat49;
      
      int u_xlatb49;
      
      float2 u_xlat52;
      
      float2 u_xlat16_54;
      
      float u_xlat69;
      
      int u_xlatb69;
      
      float u_xlat16_77;
      
      float u_xlat16_78;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_1.x = min(u_xlat0_d.x, 1.0);
          
          u_xlat0_d = _BlitTexture_TexelSize.xyxy * float4(1.0, 0.0, 0.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat2.x = texture(_CameraDepthTexture, u_xlat0_d.xy, _GlobalMipBias.x).x;
          
          u_xlatb25 = u_xlat2.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat2.x);
          
          u_xlat16_24.x = (u_xlatb25) ? 1.0 : 0.0;
          
          u_xlat2 = _BlitTexture_TexelSize.xyxy * float4(0.0, -1.0, -1.0, 0.0) + in_f.texcoord.xyxy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.xy, _GlobalMipBias.x).x;
          
          u_xlatb26 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_24.x = (u_xlatb26) ? 0.0 : u_xlat16_24.x;
          
          u_xlat16_24.y = (u_xlatb26) ? -1.0 : 0.0;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat2.zw, _GlobalMipBias.x).x;
          
          u_xlatb26 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_24.xy = (int(u_xlatb26)) ? float2(-1.0, 0.0) : u_xlat16_24.xy;
          
          u_xlat3.x = texture(_CameraDepthTexture, u_xlat0_d.zw, _GlobalMipBias.x).x;
          
          u_xlatb26 = u_xlat3.x<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat3.x);
          
          u_xlat16_24.xy = (int(u_xlatb26)) ? float2(0.0, 1.0) : u_xlat16_24.xy;
          
          u_xlat3.xy = in_f.texcoord.xy + (-_BlitTexture_TexelSize.xy);
          
          u_xlat49 = texture(_CameraDepthTexture, u_xlat3.xy, _GlobalMipBias.x).x;
          
          u_xlat16_3.xyw = texture(_BlitTexture, u_xlat3.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb4 = u_xlat49<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat49);
          
          u_xlat16_24.x = (u_xlatb4) ? -1.0 : u_xlat16_24.x;
          
          u_xlat5 = _BlitTexture_TexelSize.xyxy * float4(1.0, -1.0, -1.0, 1.0) + in_f.texcoord.xyxy;
          
          u_xlat49 = texture(_CameraDepthTexture, u_xlat5.xy, _GlobalMipBias.x).x;
          
          u_xlatb27 = u_xlat49<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat49);
          
          u_xlat16_24.x = (u_xlatb27) ? 1.0 : u_xlat16_24.x;
          
          u_xlatb49 = u_xlatb27 || u_xlatb4;
          
          u_xlat16_47 = (u_xlatb49) ? -1.0 : u_xlat16_24.y;
          
          u_xlat49 = texture(_CameraDepthTexture, u_xlat5.zw, _GlobalMipBias.x).x;
          
          u_xlatb4 = u_xlat49<u_xlat16_1.x;
          
          u_xlat16_1.x = min(u_xlat16_1.x, u_xlat49);
          
          u_xlat16_24.x = (u_xlatb4) ? -1.0 : u_xlat16_24.x;
          
          u_xlat27.xy = in_f.texcoord.xy + _BlitTexture_TexelSize.xy;
          
          u_xlat49 = texture(_CameraDepthTexture, u_xlat27.xy, _GlobalMipBias.x).x;
          
          u_xlat16_27.xyz = texture(_BlitTexture, u_xlat27.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb49 = u_xlat49<u_xlat16_1.x;
          
          u_xlat16_1.x = (u_xlatb49) ? 1.0 : u_xlat16_24.x;
          
          u_xlatb49 = u_xlatb49 || u_xlatb4;
          
          u_xlat16_1.y = (u_xlatb49) ? 1.0 : u_xlat16_47;
          
          u_xlat6.xy = _TaaMotionVectorTex_TexelSize.xy * u_xlat16_1.xy + in_f.texcoord.xy;
          
          u_xlat16_6.xy = texture(_TaaMotionVectorTex, u_xlat6.xy, _GlobalMipBias.x).xy;
          
          u_xlat52.xy = (-u_xlat16_6.xy) + in_f.texcoord.xy;
          
          u_xlat7.xy = u_xlat52.xy * _TaaAccumulationTex_TexelSize.zw + float2(-0.5, -0.5);
          
          u_xlat7.xy = floor(u_xlat7.xy);
          
          u_xlat1 = u_xlat7.xyxy + float4(0.5, 0.5, -0.5, -0.5);
          
          u_xlat7.xy = u_xlat7.xy + float2(2.5, 2.5);
          
          u_xlat7.xy = u_xlat7.xy * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat52.xy = u_xlat52.xy * _TaaAccumulationTex_TexelSize.zw + (-u_xlat1.xy);
          
          u_xlat16_8.xy = u_xlat52.xy * u_xlat52.xy;
          
          u_xlat16_9 = u_xlat52.xyxy * u_xlat16_8.xyxy;
          
          u_xlat16_54.xy = u_xlat16_9.wz * float2(-0.5, -0.5) + u_xlat16_8.yx;
          
          u_xlat16_54.xy = (-u_xlat52.yx) * float2(0.5, 0.5) + u_xlat16_54.xy;
          
          u_xlat16_9.xy = u_xlat16_9.xy * float2(-1.5, -1.5);
          
          u_xlat16_9.xy = u_xlat16_8.xy * float2(2.0, 2.0) + u_xlat16_9.xy;
          
          u_xlat16_10 = u_xlat16_8.xyxy * float4(2.5, 2.5, 0.5, 0.5);
          
          u_xlat16_8.xy = u_xlat52.xy * float2(0.5, 0.5) + u_xlat16_9.xy;
          
          u_xlat16_9.xy = u_xlat16_9.wz * float2(1.5, 1.5) + (-u_xlat16_10.yx);
          
          u_xlat16_9.zw = u_xlat16_9.zw * float2(0.5, 0.5) + (-u_xlat16_10.zw);
          
          u_xlat16_9.xy = u_xlat16_9.xy + float2(1.0, 1.0);
          
          u_xlat16_9.xy = u_xlat16_8.yx + u_xlat16_9.xy;
          
          u_xlat16_8.xy = u_xlat16_8.xy / u_xlat16_9.yx;
          
          u_xlat52.xy = u_xlat1.xy + u_xlat16_8.xy;
          
          u_xlat1.zw = u_xlat1.zw * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat1.xy = u_xlat52.xy * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat16_8.xy = u_xlat16_54.xy * u_xlat16_9.yx;
          
          u_xlat16_11.xyz = texture(_TaaAccumulationTex, u_xlat1.zy, _GlobalMipBias.x).xyz;
          
          u_xlat16_12.xyz = texture(_TaaAccumulationTex, u_xlat1.xw, _GlobalMipBias.x).xyz;
          
          u_xlat16_54.x = dot(u_xlat16_11.xz, float2(0.5, -0.5));
          
          u_xlat16_10.y = u_xlat16_54.x + 0.501960814;
          
          u_xlat16_54.x = dot(u_xlat16_11.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_10.x = dot(u_xlat16_11.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_10.z = u_xlat16_54.x + 0.501960814;
          
          u_xlat16_10.xyz = u_xlat16_8.yyy * u_xlat16_10.xyz;
          
          u_xlat16_54.x = dot(u_xlat16_12.xz, float2(0.5, -0.5));
          
          u_xlat16_13.y = u_xlat16_54.x + 0.501960814;
          
          u_xlat16_54.x = dot(u_xlat16_12.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_13.x = dot(u_xlat16_12.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_13.z = u_xlat16_54.x + 0.501960814;
          
          u_xlat16_10.xyz = u_xlat16_13.xyz * u_xlat16_8.xxx + u_xlat16_10.xyz;
          
          u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
          
          u_xlat16_8.x = u_xlat16_9.y * u_xlat16_9.x + u_xlat16_8.x;
          
          u_xlat16_8.x = u_xlat16_9.z * u_xlat16_9.x + u_xlat16_8.x;
          
          u_xlat16_8.x = u_xlat16_9.w * u_xlat16_9.y + u_xlat16_8.x;
          
          u_xlat16_31.xyz = u_xlat16_9.xyx * u_xlat16_9.zwy;
          
          u_xlat16_8.x = float(1.0) / float(u_xlat16_8.x);
          
          u_xlat16_11.xyz = texture(_TaaAccumulationTex, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat7.zw = u_xlat1.yx;
          
          u_xlat16_9.x = dot(u_xlat16_11.xz, float2(0.5, -0.5));
          
          u_xlat16_9.y = u_xlat16_9.x + 0.501960814;
          
          u_xlat16_78 = dot(u_xlat16_11.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_9.x = dot(u_xlat16_11.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_9.z = u_xlat16_78 + 0.501960814;
          
          u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_31.zzz + u_xlat16_10.xyz;
          
          u_xlat16_11.xyz = texture(_TaaAccumulationTex, u_xlat7.xz, _GlobalMipBias.x).xyz;
          
          u_xlat16_7.xyz = texture(_TaaAccumulationTex, u_xlat7.wy, _GlobalMipBias.x).xyz;
          
          u_xlat16_77 = dot(u_xlat16_11.xz, float2(0.5, -0.5));
          
          u_xlat16_10.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_11.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_10.x = dot(u_xlat16_11.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_10.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_9.xyz = u_xlat16_10.xyz * u_xlat16_31.xxx + u_xlat16_9.xyz;
          
          u_xlat16_31.x = dot(u_xlat16_7.xz, float2(0.5, -0.5));
          
          u_xlat16_10.y = u_xlat16_31.x + 0.501960814;
          
          u_xlat16_31.x = dot(u_xlat16_7.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_10.x = dot(u_xlat16_7.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_10.z = u_xlat16_31.x + 0.501960814;
          
          u_xlat16_31.xyz = u_xlat16_10.xyz * u_xlat16_31.yyy + u_xlat16_9.xyz;
          
          u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_31.xyz;
          
          u_xlat16_77 = dot(u_xlat16_27.xz, float2(0.5, -0.5));
          
          u_xlat16_9.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_27.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_9.x = dot(u_xlat16_27.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_9.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_3.xw, float2(0.5, -0.5));
          
          u_xlat16_10.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_3.xwy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_10.x = dot(u_xlat16_3.xwy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_10.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_3.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_77 = dot(u_xlat16_3.xz, float2(0.5, -0.5));
          
          u_xlat16_13.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_3.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_13.x = dot(u_xlat16_3.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_13.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_14.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_14.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_14.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat2.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_77 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_15.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_15.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_15.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_16.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_16.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_16.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_17.xyz = u_xlat16_16.xyz * u_xlat16_16.xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_77 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_18.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_18.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_18.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_17.xyz = u_xlat16_18.xyz * u_xlat16_18.xyz + u_xlat16_17.xyz;
          
          u_xlat16_17.xyz = u_xlat16_15.xyz * u_xlat16_15.xyz + u_xlat16_17.xyz;
          
          u_xlat16_17.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz + u_xlat16_17.xyz;
          
          u_xlat16_17.xyz = u_xlat16_13.xyz * u_xlat16_13.xyz + u_xlat16_17.xyz;
          
          u_xlat16_17.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz + u_xlat16_17.xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat5.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat5.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_77 = dot(u_xlat16_0.xz, float2(0.5, -0.5));
          
          u_xlat16_19.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_0.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_19.x = dot(u_xlat16_0.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_19.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_17.xyz = u_xlat16_19.xyz * u_xlat16_19.xyz + u_xlat16_17.xyz;
          
          u_xlat16_77 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_20.y = u_xlat16_77 + 0.501960814;
          
          u_xlat16_77 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_20.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_20.z = u_xlat16_77 + 0.501960814;
          
          u_xlat16_17.xyz = u_xlat16_20.xyz * u_xlat16_20.xyz + u_xlat16_17.xyz;
          
          u_xlat16_17.xyz = u_xlat16_9.xyz * u_xlat16_9.xyz + u_xlat16_17.xyz;
          
          u_xlat16_21.xyz = u_xlat16_16.xyz + u_xlat16_18.xyz;
          
          u_xlat16_21.xyz = u_xlat16_15.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_14.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_13.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_10.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_19.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_20.xyz + u_xlat16_21.xyz;
          
          u_xlat16_21.xyz = u_xlat16_9.xyz + u_xlat16_21.xyz;
          
          u_xlat16_22.xyz = u_xlat16_21.xyz * float3(0.111111112, 0.111111112, 0.111111112);
          
          u_xlat16_22.xyz = u_xlat16_22.xyz * u_xlat16_22.xyz;
          
          u_xlat16_17.xyz = u_xlat16_17.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_22.xyz);
          
          u_xlat16_17.xyz = sqrt(abs(u_xlat16_17.xyz));
          
          u_xlat16_17.xyz = u_xlat16_17.xyz * float3(float3(_TaaVarianceClampScale, _TaaVarianceClampScale, _TaaVarianceClampScale));
          
          u_xlat16_22.xyz = u_xlat16_21.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_17.xyz);
          
          u_xlat16_17.xyz = u_xlat16_21.xyz * float3(0.111111112, 0.111111112, 0.111111112) + u_xlat16_17.xyz;
          
          u_xlat16_21.xyz = min(u_xlat16_16.xyz, u_xlat16_18.xyz);
          
          u_xlat16_16.xyz = max(u_xlat16_16.xyz, u_xlat16_18.xyz);
          
          u_xlat16_16.xyz = max(u_xlat16_15.xyz, u_xlat16_16.xyz);
          
          u_xlat16_15.xyz = min(u_xlat16_15.xyz, u_xlat16_21.xyz);
          
          u_xlat16_15.xyz = min(u_xlat16_14.xyz, u_xlat16_15.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_16.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_13.xyz, u_xlat16_14.xyz);
          
          u_xlat16_13.xyz = min(u_xlat16_13.xyz, u_xlat16_15.xyz);
          
          u_xlat16_13.xyz = min(u_xlat16_10.xyz, u_xlat16_13.xyz);
          
          u_xlat16_10.xyz = max(u_xlat16_10.xyz, u_xlat16_14.xyz);
          
          u_xlat16_10.xyz = max(u_xlat16_10.xyz, u_xlat16_19.xyz);
          
          u_xlat16_13.xyz = min(u_xlat16_13.xyz, u_xlat16_19.xyz);
          
          u_xlat16_13.xyz = min(u_xlat16_13.xyz, u_xlat16_20.xyz);
          
          u_xlat16_10.xyz = max(u_xlat16_10.xyz, u_xlat16_20.xyz);
          
          u_xlat16_10.xyz = max(u_xlat16_9.xyz, u_xlat16_10.xyz);
          
          u_xlat16_9.xyz = min(u_xlat16_9.xyz, u_xlat16_13.xyz);
          
          u_xlat16_9.xyz = max(u_xlat16_22.xyz, u_xlat16_9.xyz);
          
          u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_9.xyz);
          
          u_xlat16_9.xyz = min(u_xlat16_17.xyz, u_xlat16_10.xyz);
          
          u_xlat16_8.xyz = min(u_xlat16_8.xyz, u_xlat16_9.xyz);
          
          u_xlat0_d.x = u_xlat16_8.x + 1.0;
          
          u_xlat0_d.x = float(1.0) / float(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat16_8.xyz;
          
          u_xlat69 = u_xlat16_18.x + 1.0;
          
          u_xlat69 = float(1.0) / float(u_xlat69);
          
          u_xlat2.xyz = u_xlat16_18.xyz * float3(u_xlat69) + (-u_xlat0_d.xyz);
          
          u_xlat3.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
          
          u_xlat3.xy = (-u_xlat16_6.xy) + u_xlat3.xy;
          
          u_xlatb3.xy = lessThan(float4(0.5, 0.5, 0.0, 0.0), abs(u_xlat3.xyxx)).xy;
          
          u_xlatb69 = u_xlatb3.y || u_xlatb3.x;
          
          u_xlat16_8.x = (u_xlatb69) ? 1.0 : _TaaFrameInfluence;
          
          u_xlat0_d.xyz = u_xlat16_8.xxx * u_xlat2.xyz + u_xlat0_d.xyz;
          
          u_xlat69 = (-u_xlat0_d.x) + 1.0;
          
          u_xlat69 = float(1.0) / float(u_xlat69);
          
          u_xlat16_8.xy = u_xlat0_d.zy * float2(u_xlat69) + float2(-0.501960814, -0.501960814);
          
          u_xlat16_54.x = u_xlat0_d.x * u_xlat69 + (-u_xlat16_8.y);
          
          u_xlat16_0.yz = u_xlat0_d.xx * float2(u_xlat69) + u_xlat16_8.yx;
          
          u_xlat16_0.w = (-u_xlat16_8.x) + u_xlat16_54.x;
          
          u_xlat16_0.x = (-u_xlat16_8.x) + u_xlat16_0.y;
          
          out_f.color.xyz = max(u_xlat16_0.xzw, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: TemporalAA - Accumulate - Quality Very High
    {
      Name "TemporalAA - Accumulate - Quality Very High"
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
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _TaaMotionVectorTex;
      
      uniform sampler2D _TaaAccumulationTex;
      
      
      
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
      
      
      
      uniform TemporalAAData 
          {
          
          #endif
          uniform float4 _BlitTexture_TexelSize;
          
          uniform float4 _TaaMotionVectorTex_TexelSize;
          
          uniform float4 _TaaAccumulationTex_TexelSize;
          
          uniform float _TaaFilterWeights[9];
          
          uniform float _TaaFrameInfluence;
          
          uniform float _TaaVarianceClampScale;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      bool2 u_xlatb0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_1;
      
      int u_xlatb1;
      
      float4 u_xlat2;
      
      float3 u_xlat16_2;
      
      float3 u_xlat3;
      
      float4 u_xlat16_3;
      
      float4 u_xlat4;
      
      float4 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float4 u_xlat7;
      
      float3 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float2 u_xlat10;
      
      float3 u_xlat16_11;
      
      float3 u_xlat16_12;
      
      float3 u_xlat16_13;
      
      float3 u_xlat16_14;
      
      float3 u_xlat16_15;
      
      float3 u_xlat16_16;
      
      float4 u_xlat16_17;
      
      float3 u_xlat16_18;
      
      float3 u_xlat16_19;
      
      float3 u_xlat16_20;
      
      float3 u_xlat16_21;
      
      float3 u_xlat16_22;
      
      float3 u_xlat16_23;
      
      float3 u_xlat16_24;
      
      float u_xlat25;
      
      int u_xlatb25;
      
      float2 u_xlat50;
      
      int u_xlatb50;
      
      float u_xlat16_63;
      
      float2 u_xlat16_67;
      
      float2 u_xlat16_68;
      
      float u_xlat75;
      
      float u_xlat77;
      
      float u_xlat16_88;
      
      float u_xlat16_89;
      
      float u_xlat16_90;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat1 = _BlitTexture_TexelSize.xyxy * float4(0.0, 1.0, 1.0, 0.0) + in_f.texcoord.xyxy;
          
          u_xlat16_2.xyz = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x).xyz;
          
          u_xlat3.xyz = u_xlat16_2.xyz * float3(_TaaFilterWeights[1]);
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[0]) * u_xlat16_0.xyz + u_xlat3.xyz;
          
          u_xlat16_3.xyz = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[2]) * u_xlat16_3.xyz + u_xlat0_d.xyz;
          
          u_xlat4 = _BlitTexture_TexelSize.xyxy * float4(-1.0, 0.0, 0.0, -1.0) + in_f.texcoord.xyxy;
          
          u_xlat16_5.xyz = texture(_BlitTexture, u_xlat4.xy, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[3]) * u_xlat16_5.xyz + u_xlat0_d.xyz;
          
          u_xlat16_6.xyz = texture(_BlitTexture, u_xlat4.zw, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[4]) * u_xlat16_6.xyz + u_xlat0_d.xyz;
          
          u_xlat7 = _BlitTexture_TexelSize.xyxy * float4(-1.0, 1.0, 1.0, -1.0) + in_f.texcoord.xyxy;
          
          u_xlat16_8.xyz = texture(_BlitTexture, u_xlat7.xy, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[5]) * u_xlat16_8.xyz + u_xlat0_d.xyz;
          
          u_xlat16_9.xyz = texture(_BlitTexture, u_xlat7.zw, _GlobalMipBias.x).xyz;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[6]) * u_xlat16_9.xyz + u_xlat0_d.xyz;
          
          u_xlat10.xy = in_f.texcoord.xy + _BlitTexture_TexelSize.xy;
          
          u_xlat16_11.xyz = texture(_BlitTexture, u_xlat10.xy, _GlobalMipBias.x).xyz;
          
          u_xlat75 = texture(_CameraDepthTexture, u_xlat10.xy, _GlobalMipBias.x).x;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[7]) * u_xlat16_11.xyz + u_xlat0_d.xyz;
          
          u_xlat10.xy = in_f.texcoord.xy + (-_BlitTexture_TexelSize.xy);
          
          u_xlat16_12.xyz = texture(_BlitTexture, u_xlat10.xy, _GlobalMipBias.x).xyz;
          
          u_xlat77 = texture(_CameraDepthTexture, u_xlat10.xy, _GlobalMipBias.x).x;
          
          u_xlat0_d.xyz = float3(_TaaFilterWeights[8]) * u_xlat16_12.xyz + u_xlat0_d.xyz;
          
          u_xlat16_13.x = dot(u_xlat0_d.xz, float2(0.5, -0.5));
          
          u_xlat16_13.y = u_xlat16_13.x + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat0_d.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_13.x = dot(u_xlat0_d.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_13.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_6.xz, float2(0.5, -0.5));
          
          u_xlat16_14.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_6.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_14.x = dot(u_xlat16_6.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_14.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz;
          
          u_xlat16_15.xyz = u_xlat16_13.xyz * u_xlat16_13.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_5.xz, float2(0.5, -0.5));
          
          u_xlat16_16.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_5.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_16.x = dot(u_xlat16_5.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_16.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_16.xyz * u_xlat16_16.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_3.xz, float2(0.5, -0.5));
          
          u_xlat16_17.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_3.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_17.x = dot(u_xlat16_3.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_17.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_17.xyz * u_xlat16_17.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_18.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_18.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_18.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_18.xyz * u_xlat16_18.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_12.xz, float2(0.5, -0.5));
          
          u_xlat16_19.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_12.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_19.x = dot(u_xlat16_12.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_19.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_19.xyz * u_xlat16_19.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_9.xz, float2(0.5, -0.5));
          
          u_xlat16_20.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_9.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_20.x = dot(u_xlat16_9.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_20.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_20.xyz * u_xlat16_20.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_8.xz, float2(0.5, -0.5));
          
          u_xlat16_21.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_8.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_21.x = dot(u_xlat16_8.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_21.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_21.xyz * u_xlat16_21.xyz + u_xlat16_15.xyz;
          
          u_xlat16_88 = dot(u_xlat16_11.xz, float2(0.5, -0.5));
          
          u_xlat16_22.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_11.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_22.x = dot(u_xlat16_11.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_22.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_15.xyz = u_xlat16_22.xyz * u_xlat16_22.xyz + u_xlat16_15.xyz;
          
          u_xlat16_23.xyz = u_xlat16_13.xyz + u_xlat16_14.xyz;
          
          u_xlat16_23.xyz = u_xlat16_16.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_17.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_18.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_19.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_20.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_21.xyz + u_xlat16_23.xyz;
          
          u_xlat16_23.xyz = u_xlat16_22.xyz + u_xlat16_23.xyz;
          
          u_xlat16_24.xyz = u_xlat16_23.xyz * float3(0.111111112, 0.111111112, 0.111111112);
          
          u_xlat16_24.xyz = u_xlat16_24.xyz * u_xlat16_24.xyz;
          
          u_xlat16_15.xyz = u_xlat16_15.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_24.xyz);
          
          u_xlat16_15.xyz = sqrt(abs(u_xlat16_15.xyz));
          
          u_xlat16_15.xyz = u_xlat16_15.xyz * float3(float3(_TaaVarianceClampScale, _TaaVarianceClampScale, _TaaVarianceClampScale));
          
          u_xlat16_24.xyz = u_xlat16_23.xyz * float3(0.111111112, 0.111111112, 0.111111112) + (-u_xlat16_15.xyz);
          
          u_xlat16_15.xyz = u_xlat16_23.xyz * float3(0.111111112, 0.111111112, 0.111111112) + u_xlat16_15.xyz;
          
          u_xlat16_23.xyz = min(u_xlat16_13.xyz, u_xlat16_14.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_13.xyz, u_xlat16_14.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_16.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_23.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_17.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_17.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_18.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_18.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_19.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_19.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_20.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_20.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_21.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_21.xyz);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, u_xlat16_22.xyz);
          
          u_xlat16_16.xyz = min(u_xlat16_16.xyz, u_xlat16_22.xyz);
          
          u_xlat16_16.xyz = max(u_xlat16_24.xyz, u_xlat16_16.xyz);
          
          u_xlat16_14.xyz = min(u_xlat16_15.xyz, u_xlat16_14.xyz);
          
          u_xlat16_15.xyz = u_xlat16_16.xyz + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = (-u_xlat16_16.xyz) + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = u_xlat16_14.xyz * float3(0.5, 0.5, 0.5);
          
          u_xlat16_14.xyz = max(u_xlat16_14.xyz, float3(6.10351562e-05, 6.10351562e-05, 6.10351562e-05));
          
          u_xlat16_16.xyz = u_xlat16_15.xyz * float3(0.5, 0.5, 0.5);
          
          u_xlat0_d.x = texture(_CameraDepthTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_88 = min(u_xlat0_d.x, 1.0);
          
          u_xlat0_d.x = texture(_CameraDepthTexture, u_xlat1.zw, _GlobalMipBias.x).x;
          
          u_xlat25 = texture(_CameraDepthTexture, u_xlat1.xy, _GlobalMipBias.x).x;
          
          u_xlatb50 = u_xlat0_d.x<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat0_d.x, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb50) ? 1.0 : 0.0;
          
          u_xlat0_d.x = texture(_CameraDepthTexture, u_xlat4.zw, _GlobalMipBias.x).x;
          
          u_xlat50.x = texture(_CameraDepthTexture, u_xlat4.xy, _GlobalMipBias.x).x;
          
          u_xlatb1 = u_xlat0_d.x<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat0_d.x, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb1) ? 0.0 : u_xlat16_89;
          
          u_xlat16_90 = (u_xlatb1) ? -1.0 : 0.0;
          
          u_xlatb0.x = u_xlat50.x<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat50.x, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb0.x) ? -1.0 : u_xlat16_89;
          
          u_xlat16_90 = (u_xlatb0.x) ? 0.0 : u_xlat16_90;
          
          u_xlatb0.x = u_xlat25<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat25, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb0.x) ? 0.0 : u_xlat16_89;
          
          u_xlat16_90 = (u_xlatb0.x) ? 1.0 : u_xlat16_90;
          
          u_xlatb0.x = u_xlat77<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat77, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb0.x) ? -1.0 : u_xlat16_89;
          
          u_xlat25 = texture(_CameraDepthTexture, u_xlat7.zw, _GlobalMipBias.x).x;
          
          u_xlat50.x = texture(_CameraDepthTexture, u_xlat7.xy, _GlobalMipBias.x).x;
          
          u_xlatb1 = u_xlat25<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat25, u_xlat16_88);
          
          u_xlat16_89 = (u_xlatb1) ? 1.0 : u_xlat16_89;
          
          u_xlatb0.x = u_xlatb0.x || u_xlatb1;
          
          u_xlat16_90 = (u_xlatb0.x) ? -1.0 : u_xlat16_90;
          
          u_xlatb0.x = u_xlat50.x<u_xlat16_88;
          
          u_xlat16_88 = min(u_xlat50.x, u_xlat16_88);
          
          u_xlatb25 = u_xlat75<u_xlat16_88;
          
          u_xlat16_88 = (u_xlatb0.x) ? -1.0 : u_xlat16_89;
          
          u_xlatb0.x = u_xlatb25 || u_xlatb0.x;
          
          u_xlat16_17.x = (u_xlatb25) ? 1.0 : u_xlat16_88;
          
          u_xlat16_17.y = (u_xlatb0.x) ? 1.0 : u_xlat16_90;
          
          u_xlat0_d.xy = _TaaMotionVectorTex_TexelSize.xy * u_xlat16_17.xy + in_f.texcoord.xy;
          
          u_xlat16_0.xy = texture(_TaaMotionVectorTex, u_xlat0_d.xy, _GlobalMipBias.x).xy;
          
          u_xlat50.xy = (-u_xlat16_0.xy) + in_f.texcoord.xy;
          
          u_xlat1.xy = u_xlat50.xy * _TaaAccumulationTex_TexelSize.zw + float2(-0.5, -0.5);
          
          u_xlat1.xy = floor(u_xlat1.xy);
          
          u_xlat2 = u_xlat1.xyxy + float4(0.5, 0.5, -0.5, -0.5);
          
          u_xlat1.xy = u_xlat1.xy + float2(2.5, 2.5);
          
          u_xlat1.xy = u_xlat1.xy * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat50.xy = u_xlat50.xy * _TaaAccumulationTex_TexelSize.zw + (-u_xlat2.xy);
          
          u_xlat16_17.xy = u_xlat50.xy * u_xlat50.xy;
          
          u_xlat16_3 = u_xlat50.xyxy * u_xlat16_17.xyxy;
          
          u_xlat16_67.xy = u_xlat16_3.wz * float2(-0.5, -0.5) + u_xlat16_17.yx;
          
          u_xlat16_67.xy = (-u_xlat50.yx) * float2(0.5, 0.5) + u_xlat16_67.xy;
          
          u_xlat16_18.xy = u_xlat16_3.xy * float2(-1.5, -1.5);
          
          u_xlat16_18.xy = u_xlat16_17.xy * float2(2.0, 2.0) + u_xlat16_18.xy;
          
          u_xlat16_4 = u_xlat16_17.xyxy * float4(2.5, 2.5, 0.5, 0.5);
          
          u_xlat16_17.xy = u_xlat50.xy * float2(0.5, 0.5) + u_xlat16_18.xy;
          
          u_xlat16_18.xy = u_xlat16_3.wz * float2(1.5, 1.5) + (-u_xlat16_4.yx);
          
          u_xlat16_68.xy = u_xlat16_3.zw * float2(0.5, 0.5) + (-u_xlat16_4.zw);
          
          u_xlat16_18.xy = u_xlat16_18.xy + float2(1.0, 1.0);
          
          u_xlat16_18.xy = u_xlat16_17.yx + u_xlat16_18.xy;
          
          u_xlat16_17.xy = u_xlat16_17.xy / u_xlat16_18.yx;
          
          u_xlat50.xy = u_xlat2.xy + u_xlat16_17.xy;
          
          u_xlat2.zw = u_xlat2.zw * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat2.xy = u_xlat50.xy * _TaaAccumulationTex_TexelSize.xy;
          
          u_xlat16_17.xy = u_xlat16_67.xy * u_xlat16_18.yx;
          
          u_xlat16_5.xyz = texture(_TaaAccumulationTex, u_xlat2.zy, _GlobalMipBias.x).xyz;
          
          u_xlat16_6.xyz = texture(_TaaAccumulationTex, u_xlat2.xw, _GlobalMipBias.x).xyz;
          
          u_xlat16_88 = dot(u_xlat16_5.xz, float2(0.5, -0.5));
          
          u_xlat16_19.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_5.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_19.x = dot(u_xlat16_5.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_19.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_19.xyz = u_xlat16_17.yyy * u_xlat16_19.xyz;
          
          u_xlat16_88 = dot(u_xlat16_6.xz, float2(0.5, -0.5));
          
          u_xlat16_20.y = u_xlat16_88 + 0.501960814;
          
          u_xlat16_88 = dot(u_xlat16_6.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_20.x = dot(u_xlat16_6.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_20.z = u_xlat16_88 + 0.501960814;
          
          u_xlat16_19.xyz = u_xlat16_20.xyz * u_xlat16_17.xxx + u_xlat16_19.xyz;
          
          u_xlat16_88 = u_xlat16_17.y + u_xlat16_17.x;
          
          u_xlat16_88 = u_xlat16_18.y * u_xlat16_18.x + u_xlat16_88;
          
          u_xlat16_88 = u_xlat16_68.x * u_xlat16_18.x + u_xlat16_88;
          
          u_xlat16_88 = u_xlat16_68.y * u_xlat16_18.y + u_xlat16_88;
          
          u_xlat16_17.xy = u_xlat16_18.xy * u_xlat16_68.xy;
          
          u_xlat16_89 = u_xlat16_18.x * u_xlat16_18.y;
          
          u_xlat16_88 = float(1.0) / float(u_xlat16_88);
          
          u_xlat16_5.xyz = texture(_TaaAccumulationTex, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat1.zw = u_xlat2.yx;
          
          u_xlat16_90 = dot(u_xlat16_5.xz, float2(0.5, -0.5));
          
          u_xlat16_18.y = u_xlat16_90 + 0.501960814;
          
          u_xlat16_90 = dot(u_xlat16_5.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_18.x = dot(u_xlat16_5.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_18.z = u_xlat16_90 + 0.501960814;
          
          u_xlat16_18.xyz = u_xlat16_18.xyz * float3(u_xlat16_89) + u_xlat16_19.xyz;
          
          u_xlat16_2.xyz = texture(_TaaAccumulationTex, u_xlat1.xz, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_TaaAccumulationTex, u_xlat1.wy, _GlobalMipBias.x).xyz;
          
          u_xlat16_89 = dot(u_xlat16_2.xz, float2(0.5, -0.5));
          
          u_xlat16_19.y = u_xlat16_89 + 0.501960814;
          
          u_xlat16_89 = dot(u_xlat16_2.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_19.x = dot(u_xlat16_2.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_19.z = u_xlat16_89 + 0.501960814;
          
          u_xlat16_17.xzw = u_xlat16_19.xyz * u_xlat16_17.xxx + u_xlat16_18.xyz;
          
          u_xlat16_89 = dot(u_xlat16_1.xz, float2(0.5, -0.5));
          
          u_xlat16_18.y = u_xlat16_89 + 0.501960814;
          
          u_xlat16_89 = dot(u_xlat16_1.xzy, float3(-0.25, -0.25, 0.5));
          
          u_xlat16_18.x = dot(u_xlat16_1.xzy, float3(0.25, 0.25, 0.5));
          
          u_xlat16_18.z = u_xlat16_89 + 0.501960814;
          
          u_xlat16_17.xyz = u_xlat16_18.xyz * u_xlat16_17.yyy + u_xlat16_17.xzw;
          
          u_xlat16_16.xyz = u_xlat16_17.xyz * float3(u_xlat16_88) + (-u_xlat16_16.xyz);
          
          u_xlat16_17.xyz = float3(u_xlat16_88) * u_xlat16_17.xyz;
          
          u_xlat16_14.xyz = u_xlat16_16.xyz / u_xlat16_14.xyz;
          
          u_xlat16_88 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
          
          u_xlat16_88 = max(abs(u_xlat16_14.z), u_xlat16_88);
          
          u_xlat16_14.xyz = u_xlat16_16.xyz / float3(u_xlat16_88);
          
          u_xlatb50 = 1.0<u_xlat16_88;
          
          u_xlat16_14.xyz = u_xlat16_15.xyz * float3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
          
          u_xlat16_14.xyz = (int(u_xlatb50)) ? u_xlat16_14.xyz : u_xlat16_17.xyz;
          
          u_xlat50.x = u_xlat16_14.x + 1.0;
          
          u_xlat50.x = float(1.0) / float(u_xlat50.x);
          
          u_xlat1.xyz = u_xlat50.xxx * u_xlat16_14.xyz;
          
          u_xlat50.x = u_xlat16_13.x + 1.0;
          
          u_xlat50.x = float(1.0) / float(u_xlat50.x);
          
          u_xlat2.xyz = u_xlat16_13.xyz * u_xlat50.xxx + (-u_xlat1.xyz);
          
          u_xlat50.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
          
          u_xlat0_d.xy = (-u_xlat16_0.xy) + u_xlat50.xy;
          
          u_xlatb0.xy = lessThan(float4(0.5, 0.5, 0.0, 0.0), abs(u_xlat0_d.xyxx)).xy;
          
          u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
          
          u_xlat16_13.x = (u_xlatb0.x) ? 1.0 : _TaaFrameInfluence;
          
          u_xlat0_d.xyz = u_xlat16_13.xxx * u_xlat2.xyz + u_xlat1.xyz;
          
          u_xlat75 = (-u_xlat0_d.x) + 1.0;
          
          u_xlat75 = float(1.0) / float(u_xlat75);
          
          u_xlat16_13.xy = u_xlat0_d.zy * float2(u_xlat75) + float2(-0.501960814, -0.501960814);
          
          u_xlat16_63 = u_xlat0_d.x * u_xlat75 + (-u_xlat16_13.y);
          
          u_xlat16_0.yz = u_xlat0_d.xx * float2(u_xlat75) + u_xlat16_13.yx;
          
          u_xlat16_0.w = (-u_xlat16_13.x) + u_xlat16_63;
          
          u_xlat16_0.x = (-u_xlat16_13.x) + u_xlat16_0.y;
          
          out_f.color.xyz = max(u_xlat16_0.xzw, float3(0.0, 0.0, 0.0));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 6, name: TemporalAA - Copy History
    {
      Name "TemporalAA - Copy History"
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
      
      
      
      float3 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          out_f.color.xyz = u_xlat16_0.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
