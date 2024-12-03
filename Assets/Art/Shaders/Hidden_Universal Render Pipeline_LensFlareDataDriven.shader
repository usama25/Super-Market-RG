Shader "Hidden/Universal Render Pipeline/LensFlareDataDriven"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
      "RenderPipeline" = "UniversalPipeline"
    }
    Pass // ind: 1, name: LensFlareAdditive
    {
      Name "LensFlareAdditive"
      Tags
      { 
        "QUEUE" = "Transparent"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ScaledScreenParams;
      
      uniform float4 _FlareData0;
      
      uniform float4 _FlareData2;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _FlareColorValue;
      
      uniform sampler2D _FlareTex;
      
      
      
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
      
      int u_xlati0;
      
      uint2 u_xlatu0;
      
      float2 u_xlat1;
      
      float u_xlat4;
      
      int u_xlati4;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlati0 = int(uint(uint(vertexID) & 1u));
          
          u_xlatu0.y = uint(uint(vertexID) >> (1u & uint(0x1F)));
          
          u_xlati4 = (-u_xlati0) + (-int(u_xlatu0.y));
          
          u_xlati0 = u_xlati0 + int(u_xlatu0.y);
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          out_v.texcoord.y = float(u_xlatu0.x);
          
          u_xlati0 = u_xlati4 + 1;
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          u_xlat1.xy = float2(u_xlatu0.yx);
          
          u_xlat0.xy = u_xlat1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.xy = u_xlat0.xy * _FlareData2.zw;
          
          u_xlat4 = u_xlat0.y * _FlareData0.y;
          
          u_xlat4 = u_xlat0.x * _FlareData0.x + (-u_xlat4);
          
          u_xlat0.y = dot(u_xlat0.yx, _FlareData0.xy);
          
          u_xlat6 = _ScaledScreenParams.y / _ScaledScreenParams.x;
          
          u_xlat0.x = u_xlat6 * u_xlat4;
          
          u_xlat0.xy = u_xlat0.xy + _FlareData2.xy;
          
          out_v.vertex.xy = u_xlat0.xy + _FlareData0.zw;
          
          out_v.vertex.zw = float2(1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_FlareTex, in_f.texcoord.xy, _GlobalMipBias.x);
          
          out_f.color = u_xlat16_0 * _FlareColorValue;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: LensFlareScreen
    {
      Name "LensFlareScreen"
      Tags
      { 
        "QUEUE" = "Transparent"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Off
      Blend One OneMinusSrcColor
      BlendOp Max, Max
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ScaledScreenParams;
      
      uniform float4 _FlareData0;
      
      uniform float4 _FlareData2;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _FlareColorValue;
      
      uniform sampler2D _FlareTex;
      
      
      
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
      
      int u_xlati0;
      
      uint2 u_xlatu0;
      
      float2 u_xlat1;
      
      float u_xlat4;
      
      int u_xlati4;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlati0 = int(uint(uint(vertexID) & 1u));
          
          u_xlatu0.y = uint(uint(vertexID) >> (1u & uint(0x1F)));
          
          u_xlati4 = (-u_xlati0) + (-int(u_xlatu0.y));
          
          u_xlati0 = u_xlati0 + int(u_xlatu0.y);
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          out_v.texcoord.y = float(u_xlatu0.x);
          
          u_xlati0 = u_xlati4 + 1;
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          u_xlat1.xy = float2(u_xlatu0.yx);
          
          u_xlat0.xy = u_xlat1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.xy = u_xlat0.xy * _FlareData2.zw;
          
          u_xlat4 = u_xlat0.y * _FlareData0.y;
          
          u_xlat4 = u_xlat0.x * _FlareData0.x + (-u_xlat4);
          
          u_xlat0.y = dot(u_xlat0.yx, _FlareData0.xy);
          
          u_xlat6 = _ScaledScreenParams.y / _ScaledScreenParams.x;
          
          u_xlat0.x = u_xlat6 * u_xlat4;
          
          u_xlat0.xy = u_xlat0.xy + _FlareData2.xy;
          
          out_v.vertex.xy = u_xlat0.xy + _FlareData0.zw;
          
          out_v.vertex.zw = float2(1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_FlareTex, in_f.texcoord.xy, _GlobalMipBias.x);
          
          out_f.color = u_xlat16_0 * _FlareColorValue;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: LensFlarePremultiply
    {
      Name "LensFlarePremultiply"
      Tags
      { 
        "QUEUE" = "Transparent"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Off
      Blend One OneMinusSrcAlpha
      ColorMask RGB
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ScaledScreenParams;
      
      uniform float4 _FlareData0;
      
      uniform float4 _FlareData2;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _FlareColorValue;
      
      uniform sampler2D _FlareTex;
      
      
      
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
      
      int u_xlati0;
      
      uint2 u_xlatu0;
      
      float2 u_xlat1;
      
      float u_xlat4;
      
      int u_xlati4;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlati0 = int(uint(uint(vertexID) & 1u));
          
          u_xlatu0.y = uint(uint(vertexID) >> (1u & uint(0x1F)));
          
          u_xlati4 = (-u_xlati0) + (-int(u_xlatu0.y));
          
          u_xlati0 = u_xlati0 + int(u_xlatu0.y);
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          out_v.texcoord.y = float(u_xlatu0.x);
          
          u_xlati0 = u_xlati4 + 1;
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          u_xlat1.xy = float2(u_xlatu0.yx);
          
          u_xlat0.xy = u_xlat1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.xy = u_xlat0.xy * _FlareData2.zw;
          
          u_xlat4 = u_xlat0.y * _FlareData0.y;
          
          u_xlat4 = u_xlat0.x * _FlareData0.x + (-u_xlat4);
          
          u_xlat0.y = dot(u_xlat0.yx, _FlareData0.xy);
          
          u_xlat6 = _ScaledScreenParams.y / _ScaledScreenParams.x;
          
          u_xlat0.x = u_xlat6 * u_xlat4;
          
          u_xlat0.xy = u_xlat0.xy + _FlareData2.xy;
          
          out_v.vertex.xy = u_xlat0.xy + _FlareData0.zw;
          
          out_v.vertex.zw = float2(1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_FlareTex, in_f.texcoord.xy, _GlobalMipBias.x);
          
          out_f.color = u_xlat16_0 * _FlareColorValue;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: LensFlareLerp
    {
      Name "LensFlareLerp"
      Tags
      { 
        "QUEUE" = "Transparent"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask RGB
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _ScaledScreenParams;
      
      uniform float4 _FlareData0;
      
      uniform float4 _FlareData2;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _FlareColorValue;
      
      uniform sampler2D _FlareTex;
      
      
      
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
      
      int u_xlati0;
      
      uint2 u_xlatu0;
      
      float2 u_xlat1;
      
      float u_xlat4;
      
      int u_xlati4;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlati0 = int(uint(uint(vertexID) & 1u));
          
          u_xlatu0.y = uint(uint(vertexID) >> (1u & uint(0x1F)));
          
          u_xlati4 = (-u_xlati0) + (-int(u_xlatu0.y));
          
          u_xlati0 = u_xlati0 + int(u_xlatu0.y);
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          out_v.texcoord.y = float(u_xlatu0.x);
          
          u_xlati0 = u_xlati4 + 1;
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          u_xlat1.xy = float2(u_xlatu0.yx);
          
          u_xlat0.xy = u_xlat1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.xy = u_xlat0.xy * _FlareData2.zw;
          
          u_xlat4 = u_xlat0.y * _FlareData0.y;
          
          u_xlat4 = u_xlat0.x * _FlareData0.x + (-u_xlat4);
          
          u_xlat0.y = dot(u_xlat0.yx, _FlareData0.xy);
          
          u_xlat6 = _ScaledScreenParams.y / _ScaledScreenParams.x;
          
          u_xlat0.x = u_xlat6 * u_xlat4;
          
          u_xlat0.xy = u_xlat0.xy + _FlareData2.xy;
          
          out_v.vertex.xy = u_xlat0.xy + _FlareData0.zw;
          
          out_v.vertex.zw = float2(1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_FlareTex, in_f.texcoord.xy, _GlobalMipBias.x);
          
          out_f.color = u_xlat16_0 * _FlareColorValue;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: LensFlareOcclusion
    {
      Name "LensFlareOcclusion"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
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
      
      
      uniform float4 _ScaledScreenParams;
      
      uniform float4 _ZBufferParams;
      
      uniform float4 _FlareData1;
      
      uniform float4 _FlareData2;
      
      uniform float4 _FlareData3;
      
      uniform sampler2D _CameraDepthTexture;
      
      uniform sampler2D _FlareOcclusionRemapTex;
      
      
      
      struct appdata_t
      {
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float u_xlat0;
      
      int u_xlati0;
      
      uint3 u_xlatu0;
      
      int u_xlatb0;
      
      float2 u_xlat1;
      
      uint4 u_xlatu1;
      
      bool2 u_xlatb1;
      
      float2 u_xlat2;
      
      uint u_xlatu3;
      
      bool2 u_xlatb3;
      
      float2 u_xlat16_4;
      
      float u_xlat16_5;
      
      float2 u_xlat16_6;
      
      int u_xlati7;
      
      uint u_xlatu7;
      
      int u_xlatb7;
      
      float u_xlat8;
      
      bool2 u_xlatb10;
      
      float u_xlat16_11;
      
      int u_xlati14;
      
      bool2 u_xlatb14;
      
      float2 u_xlat16;
      
      int u_xlati16;
      
      uint u_xlatu16;
      
      int u_xlatb16;
      
      uint u_xlatu21;
      
      int u_xlatb21;
      
      float u_xlat23;
      
      int u_xlati23;
      
      uint u_xlatu23;
      
      int int_bitfieldInsert(int base, int insert, int offset, int bits) 
          {
          
          uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
          
          return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
      
      }
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(uint(vertexID) >> (1u & uint(0x1F)));
          
          u_xlati7 = int(uint(uint(vertexID) & 1u));
          
          u_xlati14 = (-u_xlati7) + (-int(u_xlatu0.x));
          
          u_xlati14 = u_xlati14 + 1;
          
          u_xlatu0.z = uint(uint(u_xlati14) & 1u);
          
          u_xlat1.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          u_xlati0 = u_xlati7 + int(u_xlatu0.x);
          
          u_xlatu0.x = uint(uint(u_xlati0) & 1u);
          
          out_v.texcoord.y = float(u_xlatu0.x);
          
          out_v.texcoord.x = (-u_xlat1.x) + 1.0;
          
          u_xlatb0 = _FlareData1.y!=0.0;
          
          if(u_xlatb0)
      {
              
              u_xlat0 = float(1.0) / _FlareData1.y;
              
              u_xlatu7 = uint(_FlareData1.y);
              
              u_xlatb14.x = 0.0<_FlareData3.x;
              
              u_xlatu1.z = uint(uint(0u));
              
              u_xlatu1.w = uint(uint(0u));
              
              u_xlat2.x = 0.0;
              
              for(uint u_xlatu_loop_1 = uint(0u) ; u_xlatu_loop_1<u_xlatu7 ; u_xlatu_loop_1++)
      
              
                  {
                  
                  u_xlati16 = int(int(u_xlatu_loop_1) << (1 & int(0x1F)));
                  
                  u_xlati16 = int(uint(uint(u_xlati16) ^ 2747636419u));
                  
                  u_xlatu16 = uint(u_xlati16) * 2654435769u;
                  
                  u_xlatu23 = uint(u_xlatu16 >> (16u & uint(0x1F)));
                  
                  u_xlati16 = int(uint(u_xlatu23 ^ u_xlatu16));
                  
                  u_xlatu16 = uint(u_xlati16) * 2654435769u;
                  
                  u_xlatu23 = uint(u_xlatu16 >> (16u & uint(0x1F)));
                  
                  u_xlati16 = int(uint(u_xlatu23 ^ u_xlatu16));
                  
                  u_xlatu16 = uint(u_xlati16) * 2654435769u;
                  
                  u_xlat16.x = float(u_xlatu16);
                  
                  u_xlat16.x = u_xlat16.x * 2.32830644e-10;
                  
                  u_xlati23 = int(int_bitfieldInsert(1, int(u_xlatu_loop_1), 1 & int(0x1F), 31));
                  
                  u_xlati23 = int(uint(uint(u_xlati23) ^ 2747636419u));
                  
                  u_xlatu23 = uint(u_xlati23) * 2654435769u;
                  
                  u_xlatu3 = uint(u_xlatu23 >> (16u & uint(0x1F)));
                  
                  u_xlati23 = int(uint(u_xlatu23 ^ u_xlatu3));
                  
                  u_xlatu23 = uint(u_xlati23) * 2654435769u;
                  
                  u_xlatu3 = uint(u_xlatu23 >> (16u & uint(0x1F)));
                  
                  u_xlati23 = int(uint(u_xlatu23 ^ u_xlatu3));
                  
                  u_xlatu23 = uint(u_xlati23) * 2654435769u;
                  
                  u_xlat23 = float(u_xlatu23);
                  
                  u_xlat16_4.x = sqrt(u_xlat16.x);
                  
                  u_xlat16_11 = u_xlat23 * 1.46291812e-09;
                  
                  u_xlat16_5 = sin(u_xlat16_11);
                  
                  u_xlat16_6.x = cos(u_xlat16_11);
                  
                  u_xlat16_6.y = u_xlat16_5;
                  
                  u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_6.xy;
                  
                  u_xlat16.xy = _FlareData1.xx * u_xlat16_4.xy + _FlareData2.xy;
                  
                  u_xlat16.xy = u_xlat16.xy * float2(0.5, 0.5) + float2(0.5, 0.5);
                  
                  u_xlatb3.xy = greaterThanEqual(u_xlat16.xyxx, float4(0.0, 0.0, 0.0, 0.0)).xy;
                  
                  u_xlatb3.x = u_xlatb3.y && u_xlatb3.x;
                  
                  u_xlatb10.xy = greaterThanEqual(float4(1.0, 1.0, 0.0, 0.0), u_xlat16.xyxx).xy;
                  
                  u_xlatb10.x = u_xlatb10.y && u_xlatb10.x;
                  
                  u_xlatb3.x = u_xlatb10.x && u_xlatb3.x;
                  
                  if(u_xlatb3.x)
      {
                      
                      u_xlat16.xy = u_xlat16.xy * _ScaledScreenParams.xy;
                      
                      u_xlatu1.xy = uint2(u_xlat16.xy);
                      
                      u_xlat1.x = texelFetch(_CameraDepthTexture, int2(u_xlatu1.xy), int(u_xlatu1.w)).x;
                      
                      u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
                      
                      u_xlat1.x = float(1.0) / u_xlat1.x;
                      
                      u_xlatb1.x = _FlareData1.z<u_xlat1.x;
                      
                      u_xlat8 = u_xlat0 + u_xlat2.x;
                      
                      u_xlat2.x = (u_xlatb1.x) ? u_xlat8 : u_xlat2.x;
      
      }
                  else
                  
                      {
                      
                      u_xlat1.x = u_xlat0 + u_xlat2.x;
                      
                      u_xlat2.x = (u_xlatb14.x) ? u_xlat1.x : u_xlat2.x;
      
      }
      
      }
              
              u_xlat2.x = u_xlat2.x;
              
              u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
              
              u_xlat2.y = 0.0;
              
              u_xlat0 = textureLod(_FlareOcclusionRemapTex, u_xlat2.xy, 0.0).x;
              
              u_xlat0 = u_xlat0;
              
              u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
      
      }
          else
          
              {
              
              u_xlat0 = 1.0;
      
      }
          
          u_xlatb7 = _FlareData3.x<0.0;
          
          u_xlatb14.xy = lessThan(_FlareData2.xyxy, float4(-1.0, -1.0, -1.0, -1.0)).xy;
          
          u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
          
          u_xlatb1.xy = greaterThanEqual(_FlareData2.xyxx, float4(1.0, 1.0, 0.0, 0.0)).xy;
          
          u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
          
          u_xlatb14.x = u_xlatb21 || u_xlatb14.x;
          
          u_xlatb7 = u_xlatb14.x && u_xlatb7;
          
          out_v.texcoord1 = (u_xlatb7) ? 0.0 : u_xlat0;
          
          out_v.vertex.zw = float2(1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color.xyz = float3(in_f.texcoord1);
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
