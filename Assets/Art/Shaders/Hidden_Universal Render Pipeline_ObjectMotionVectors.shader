Shader "Hidden/Universal Render Pipeline/ObjectMotionVectors"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: Object Motion Vectors
    {
      Name "Object Motion Vectors"
      Tags
      { 
        "LIGHTMODE" = "MOTIONVECTORS"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _PrevViewProjMatrix[4];
      
      uniform float4 _NonJitteredViewProjMatrix[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 texcoord4 : TEXCOORD4;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 Xhlslcc_UnusedXunity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 unity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 unity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_MatrixVP[3];
          
          out_v.vertex.z = unity_MotionVectorsParams.z * u_xlat0.w + u_xlat0.z;
          
          out_v.vertex.xyw = u_xlat0.xyw;
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[3] * in_v.vertex.wwww + u_xlat0;
          
          u_xlat1 = u_xlat0.yyyy * _NonJitteredViewProjMatrix[1];
          
          u_xlat1 = _NonJitteredViewProjMatrix[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = _NonJitteredViewProjMatrix[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.texcoord = _NonJitteredViewProjMatrix[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlatb0 = unity_MotionVectorsParams.x==1.0;
          
          u_xlat1.xyz = in_v.texcoord4.xyz;
          
          u_xlat1.w = 1.0;
          
          u_xlat0 = (int(u_xlatb0)) ? u_xlat1 : in_v.vertex;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixPreviousM[1];
          
          u_xlat1 = unity_MatrixPreviousM[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixPreviousM[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = unity_MatrixPreviousM[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat1 = u_xlat0.yyyy * _PrevViewProjMatrix[1];
          
          u_xlat1 = _PrevViewProjMatrix[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = _PrevViewProjMatrix[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.texcoord1 = _PrevViewProjMatrix[3] * u_xlat0.wwww + u_xlat1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 Xhlslcc_UnusedXunity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 unity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 unity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float u_xlat0_d;
      
      int u_xlatb0_d;
      
      float2 u_xlat16_1;
      
      float2 u_xlat2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0_d = unity_MotionVectorsParams.y==0.0;
          
          if(u_xlatb0_d)
      {
              
              out_f.color = float4(0.0, 0.0, 0.0, 0.0);
              
              return;
      
      }
          
          u_xlat0_d = float(1.0) / float(in_f.texcoord.w);
          
          u_xlat2.x = float(1.0) / float(in_f.texcoord1.w);
          
          u_xlat2.xy = u_xlat2.xx * in_f.texcoord1.xy;
          
          u_xlat16_1.xy = in_f.texcoord.xy * float2(u_xlat0_d) + (-u_xlat2.xy);
          
          out_f.color.xy = u_xlat16_1.xy * float2(0.5, 0.5);
          
          out_f.color.zw = float2(0.0, 0.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
