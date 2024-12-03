// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable
// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable

Shader "Universal Render Pipeline/Simple Lit"
{
  Properties
  {
    _BaseMap ("Base Map (RGB) Smoothness / Alpha (A)", 2D) = "white" {}
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Clipping", Range(0, 1)) = 0.5
    _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,0.5)
    _SpecGlossMap ("Specular Map", 2D) = "white" {}
    _SmoothnessSource ("Smoothness Source", float) = 0
    _SpecularHighlights ("Specular Highlights", float) = 1
    [HideInInspector] _BumpScale ("Scale", float) = 1
    [NoScaleOffset] _BumpMap ("Normal Map", 2D) = "bump" {}
    [HDR] _EmissionColor ("Emission Color", Color) = (0,0,0,1)
    [NoScaleOffset] _EmissionMap ("Emission Map", 2D) = "white" {}
    _Surface ("__surface", float) = 0
    _Blend ("__blend", float) = 0
    _Cull ("__cull", float) = 2
    [ToggleUI] _AlphaClip ("__clip", float) = 0
    [HideInInspector] _SrcBlend ("__src", float) = 1
    [HideInInspector] _DstBlend ("__dst", float) = 0
    [HideInInspector] _SrcBlendAlpha ("__srcA", float) = 1
    [HideInInspector] _DstBlendAlpha ("__dstA", float) = 0
    [HideInInspector] _ZWrite ("__zw", float) = 1
    [HideInInspector] _BlendModePreserveSpecular ("_BlendModePreserveSpecular", float) = 1
    [HideInInspector] _AlphaToMask ("__alphaToMask", float) = 0
    [ToggleUI] _ReceiveShadows ("Receive Shadows", float) = 1
    _QueueOffset ("Queue offset", float) = 0
    [HideInInspector] _MainTex ("BaseMap", 2D) = "white" {}
    [HideInInspector] _Color ("Base Color", Color) = (1,1,1,1)
    [HideInInspector] _Shininess ("Smoothness", float) = 0
    [HideInInspector] _GlossinessSource ("GlossinessSource", float) = 0
    [HideInInspector] _SpecSource ("SpecularHighlights", float) = 0
    unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
    unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
    unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "RenderPipeline" = "UniversalPipeline"
      "RenderType" = "Opaque"
      "UniversalMaterialType" = "SimpleLit"
    }
    LOD 300
    Pass // ind: 1, name: ForwardLit
    {
      Name "ForwardLit"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "UniversalForward"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
      LOD 300
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float2 _GlobalMipBias;
      
      uniform float _AlphaToMaskAvailable;
      
      uniform float4 _MainLightPosition;
      
      uniform float4 _MainLightColor;
      
      uniform float4 _MainLightWorldToLight[4];
      
      uniform float _MainLightCookieTextureFormat;
      
      uniform float _DitheringTextureInvSize;
      
      // uniform sampler2D unity_Lightmap;
      
      uniform sampler2D _BaseMap;
      
      uniform sampler2D _BumpMap;
      
      uniform sampler2D _EmissionMap;
      
      uniform sampler2D _MainLightCookieTexture;
      
      uniform sampler2D _DitheringTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 tangent : TANGENT0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord5 : TEXCOORD5;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float2 texcoord7 : TEXCOORD7;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float2 texcoord7 : TEXCOORD7;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 unity_LODFade;
          
          uniform float4 unity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 unity_LightData;
          
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
          
          // uniform float4 unity_LightmapST;
          
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
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 _SpecColor;
          
          uniform float4 _EmissionColor;
          
          uniform float _Cutoff;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat2;
      
      float4 u_xlat3;
      
      float u_xlat16_4;
      
      float u_xlat15;
      
      int u_xlatb15;
      
      float u_xlat16;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.texcoord.xy = in_v.texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          out_v.texcoord1.xyz = u_xlat0.xyz;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat15 = max(u_xlat15, 1.17549435e-38);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat1.xyz = float3(u_xlat15) * u_xlat1.xyz;
          
          u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlatb15 = unity_OrthoParams.w==0.0;
          
          u_xlat1.w = (u_xlatb15) ? u_xlat2.x : unity_MatrixV[0].z;
          
          out_v.texcoord2 = u_xlat1;
          
          u_xlat3.xyz = in_v.tangent.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat3.xyz = unity_ObjectToWorld[0].xyz * in_v.tangent.xxx + u_xlat3.xyz;
          
          u_xlat3.xyz = unity_ObjectToWorld[2].xyz * in_v.tangent.zzz + u_xlat3.xyz;
          
          u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
          
          u_xlat16 = max(u_xlat16, 1.17549435e-38);
          
          u_xlat16 = inversesqrt(u_xlat16);
          
          u_xlat3.xyz = float3(u_xlat16) * u_xlat3.xyz;
          
          u_xlat3.w = (u_xlatb15) ? u_xlat2.y : unity_MatrixV[1].z;
          
          u_xlat15 = (u_xlatb15) ? u_xlat2.z : unity_MatrixV[2].z;
          
          out_v.texcoord4.w = u_xlat15;
          
          out_v.texcoord3 = u_xlat3;
          
          u_xlat2.xyz = u_xlat1.zxy * u_xlat3.yzx;
          
          u_xlat1.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
          
          u_xlatb15 = unity_WorldTransformParams.w>=0.0;
          
          u_xlat15 = (u_xlatb15) ? 1.0 : -1.0;
          
          u_xlat16_4 = u_xlat15 * in_v.tangent.w;
          
          out_v.texcoord4.xyz = u_xlat1.xyz * float3(u_xlat16_4);
          
          out_v.texcoord5 = 0.0;
          
          out_v.texcoord7.xy = in_v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat0 + unity_MatrixVP[3];
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 unity_LODFade;
          
          uniform float4 unity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 unity_LightData;
          
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
          
          // uniform float4 unity_LightmapST;
          
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
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 _SpecColor;
          
          uniform float4 _EmissionColor;
          
          uniform float _Cutoff;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float u_xlat0_d;
      
      float4 u_xlat16_0;
      
      int u_xlatb0;
      
      float4 u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float u_xlat16_2;
      
      int u_xlatb2;
      
      float3 u_xlat16_3;
      
      float4 u_xlat16_4_d;
      
      float3 u_xlat16_5;
      
      float3 u_xlat6;
      
      bool2 u_xlatb6;
      
      float3 u_xlat16_7;
      
      float3 u_xlat8;
      
      float u_xlat9;
      
      int u_xlatb9;
      
      float3 u_xlat16_10;
      
      int u_xlatb11;
      
      float u_xlat18;
      
      int u_xlatb18;
      
      float u_xlat27;
      
      float u_xlat29;
      
      float u_xlat16_30;
      
      int u_xlatb32;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
          
          u_xlat16_0 = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_1 = u_xlat16_0.wxyz * _BaseColor.wxyz;
          
          u_xlatb0 = u_xlat16_1.x>=_Cutoff;
          
          u_xlat0_d = (u_xlatb0) ? u_xlat16_1.x : 0.0;
          
          u_xlatb9 = 0.0>=_Cutoff;
          
          u_xlat18 = u_xlat16_0.w * _BaseColor.w + (-_Cutoff);
          
          u_xlat27 = dFdx(u_xlat16_1.x);
          
          u_xlat2_d.x = dFdy(u_xlat16_1.x);
          
          u_xlat27 = abs(u_xlat27) + abs(u_xlat2_d.x);
          
          u_xlat27 = max(u_xlat27, 9.99999975e-05);
          
          u_xlat18 = u_xlat18 / u_xlat27;
          
          u_xlat18 = u_xlat18 + 0.5;
          
          u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
          
          u_xlat9 = (u_xlatb9) ? 1.0 : u_xlat18;
          
          u_xlatb18 = _AlphaToMaskAvailable!=0.0;
          
          u_xlat16_1.x = (u_xlatb18) ? u_xlat9 : u_xlat0_d;
          
          u_xlat16_3.x = u_xlat16_1.x + -9.99999975e-05;
          
          u_xlatb0 = u_xlat16_3.x<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat16_0.xy = texture(_BumpMap, in_f.texcoord.xy, _GlobalMipBias.x).yw;
          
          u_xlat16_3.xy = u_xlat16_0.yx * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          u_xlat16_30 = dot(u_xlat16_3.xy, u_xlat16_3.xy);
          
          u_xlat16_30 = min(u_xlat16_30, 1.0);
          
          u_xlat16_30 = (-u_xlat16_30) + 1.0;
          
          u_xlat16_30 = sqrt(u_xlat16_30);
          
          u_xlat16_3.z = max(u_xlat16_30, 1.00000002e-16);
          
          u_xlat16_0.xyw = texture(_EmissionMap, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat2_d.xy = hlslcc_FragCoord.xy * float2(float2(_DitheringTextureInvSize, _DitheringTextureInvSize));
          
          u_xlat16_2 = texture(_DitheringTexture, u_xlat2_d.xy, _GlobalMipBias.x).w;
          
          u_xlatb11 = unity_LODFade.x>=0.0;
          
          u_xlat2_d.x = (u_xlatb11) ? abs(u_xlat16_2) : -abs(u_xlat16_2);
          
          u_xlat2_d.x = (-u_xlat2_d.x) + unity_LODFade.x;
          
          u_xlatb2 = u_xlat2_d.x<0.0;
          
          if(u_xlatb2)
      {
              discard;
      }
          
          u_xlat16_4_d.x = in_f.texcoord3.x;
          
          u_xlat16_4_d.y = in_f.texcoord4.x;
          
          u_xlat16_4_d.z = in_f.texcoord2.x;
          
          u_xlat2_d.x = dot(u_xlat16_3.xyz, u_xlat16_4_d.xyz);
          
          u_xlat16_4_d.x = in_f.texcoord3.y;
          
          u_xlat16_4_d.y = in_f.texcoord4.y;
          
          u_xlat16_4_d.z = in_f.texcoord2.y;
          
          u_xlat2_d.y = dot(u_xlat16_3.xyz, u_xlat16_4_d.xyz);
          
          u_xlat16_4_d.x = in_f.texcoord3.z;
          
          u_xlat16_4_d.y = in_f.texcoord4.z;
          
          u_xlat16_4_d.z = in_f.texcoord2.z;
          
          u_xlat2_d.z = dot(u_xlat16_3.xyz, u_xlat16_4_d.xyz);
          
          u_xlat29 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          
          u_xlat29 = inversesqrt(u_xlat29);
          
          u_xlat2_d.xyz = float3(u_xlat29) * u_xlat2_d.xyz;
          
          u_xlat16_3.x = in_f.texcoord2.w;
          
          u_xlat16_3.y = in_f.texcoord3.w;
          
          u_xlat16_3.z = in_f.texcoord4.w;
          
          u_xlat29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
          
          u_xlat29 = max(u_xlat29, 1.17549435e-38);
          
          u_xlat29 = inversesqrt(u_xlat29);
          
          u_xlat16_5.xyz = texture(unity_Lightmap, in_f.texcoord7.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb32 = _MainLightCookieTextureFormat!=-1.0;
          
          if(u_xlatb32)
      {
              
              u_xlat6.xy = in_f.texcoord1.yy * _MainLightWorldToLight[1].xy;
              
              u_xlat6.xy = _MainLightWorldToLight[0].xy * in_f.texcoord1.xx + u_xlat6.xy;
              
              u_xlat6.xy = _MainLightWorldToLight[2].xy * in_f.texcoord1.zz + u_xlat6.xy;
              
              u_xlat6.xy = u_xlat6.xy + _MainLightWorldToLight[3].xy;
              
              u_xlat6.xy = u_xlat6.xy * float2(0.5, 0.5) + float2(0.5, 0.5);
              
              u_xlat16_4_d = texture(_MainLightCookieTexture, u_xlat6.xy, _GlobalMipBias.x);
              
              u_xlatb6.xy = equal(float4(float4(_MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat)), float4(0.0, 1.0, 0.0, 0.0)).xy;
              
              u_xlat16_30 = (u_xlatb6.y) ? u_xlat16_4_d.w : u_xlat16_4_d.x;
              
              u_xlat16_7.xyz = (u_xlatb6.x) ? u_xlat16_4_d.xyz : float3(u_xlat16_30);
      
      }
          else
          
              {
              
              u_xlat16_7.x = float(1.0);
              
              u_xlat16_7.y = float(1.0);
              
              u_xlat16_7.z = float(1.0);
      
      }
          
          u_xlat16_7.xyz = u_xlat16_7.xyz * _MainLightColor.xyz;
          
          u_xlat6.xyz = u_xlat16_7.xyz * unity_LightData.zzz;
          
          u_xlat16_30 = dot(u_xlat2_d.xyz, _MainLightPosition.xyz);
          
          u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
          
          u_xlat16_7.xyz = float3(u_xlat16_30) * u_xlat6.xyz;
          
          u_xlat16_30 = _SpecColor.w * 10.0 + 1.0;
          
          u_xlat16_30 = exp2(u_xlat16_30);
          
          u_xlat8.xyz = u_xlat16_3.xyz * float3(u_xlat29) + _MainLightPosition.xyz;
          
          u_xlat29 = dot(u_xlat8.xyz, u_xlat8.xyz);
          
          u_xlat29 = max(u_xlat29, 1.17549435e-38);
          
          u_xlat29 = inversesqrt(u_xlat29);
          
          u_xlat8.xyz = float3(u_xlat29) * u_xlat8.xyz;
          
          u_xlat2_d.x = dot(u_xlat2_d.xyz, u_xlat8.xyz);
          
          u_xlat2_d.x = clamp(u_xlat2_d.x, 0.0, 1.0);
          
          u_xlat16_3.x = log2(u_xlat2_d.x);
          
          u_xlat16_3.x = u_xlat16_3.x * u_xlat16_30;
          
          u_xlat16_3.x = exp2(u_xlat16_3.x);
          
          u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat6.xyz;
          
          u_xlat16_3.xyz = u_xlat16_7.xyz * u_xlat16_1.yzw + u_xlat16_3.xyz;
          
          u_xlat16_10.xyz = u_xlat16_5.xyz * u_xlat16_1.yzw + u_xlat16_3.xyz;
          
          out_f.color.xyz = u_xlat16_0.xyw * _EmissionColor.xyz + u_xlat16_10.xyz;
          
          u_xlatb0 = _Surface==1.0;
          
          u_xlatb0 = u_xlatb0 || u_xlatb18;
          
          out_f.color.w = (u_xlatb0) ? u_xlat16_1.x : 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: DepthOnly
    {
      Name "DepthOnly"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "DepthOnly"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
      LOD 300
      Cull Off
      ColorMask B
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float SV_TARGET0 : SV_TARGET0;
      
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
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
          
          out_f.SV_TARGET0 = hlslcc_FragCoord.z;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: DepthNormals
    {
      Name "DepthNormals"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "DepthNormals"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
      LOD 300
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord2 : TEXCOORD2;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
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
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = max(u_xlat6, 1.17549435e-38);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord2.xyz = u_xlat0.xyz;
          
          out_v.texcoord3.xyz = float3(0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat16_0 = inversesqrt(u_xlat16_0);
          
          out_f.color.xyz = float3(u_xlat16_0) * in_f.texcoord2.xyz;
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
