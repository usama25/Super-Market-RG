// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable

Shader "Universal Render Pipeline/Lit"
{
  Properties
  {
    _WorkflowMode ("WorkflowMode", float) = 1
    _BaseMap ("Albedo", 2D) = "white" {}
    _BaseColor ("Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    _SmoothnessTextureChannel ("Smoothness texture channel", float) = 0
    _Metallic ("Metallic", Range(0, 1)) = 0
    _MetallicGlossMap ("Metallic", 2D) = "white" {}
    _SpecColor ("Specular", Color) = (0.2,0.2,0.2,1)
    _SpecGlossMap ("Specular", 2D) = "white" {}
    [ToggleOff] _SpecularHighlights ("Specular Highlights", float) = 1
    [ToggleOff] _EnvironmentReflections ("Environment Reflections", float) = 1
    _BumpScale ("Scale", float) = 1
    _BumpMap ("Normal Map", 2D) = "bump" {}
    _Parallax ("Scale", Range(0.005, 0.08)) = 0.005
    _ParallaxMap ("Height Map", 2D) = "black" {}
    _OcclusionStrength ("Strength", Range(0, 1)) = 1
    _OcclusionMap ("Occlusion", 2D) = "white" {}
    [HDR] _EmissionColor ("Color", Color) = (0,0,0,1)
    _EmissionMap ("Emission", 2D) = "white" {}
    _DetailMask ("Detail Mask", 2D) = "white" {}
    _DetailAlbedoMapScale ("Scale", Range(0, 2)) = 1
    _DetailAlbedoMap ("Detail Albedo x2", 2D) = "linearGrey" {}
    _DetailNormalMapScale ("Scale", Range(0, 2)) = 1
    [Normal] _DetailNormalMap ("Normal Map", 2D) = "bump" {}
    [HideInInspector] _ClearCoatMask ("_ClearCoatMask", float) = 0
    [HideInInspector] _ClearCoatSmoothness ("_ClearCoatSmoothness", float) = 0
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
    [HideInInspector] _GlossMapScale ("Smoothness", float) = 0
    [HideInInspector] _Glossiness ("Smoothness", float) = 0
    [HideInInspector] _GlossyReflections ("EnvironmentReflections", float) = 0
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
      "UniversalMaterialType" = "Lit"
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
        "UniversalMaterialType" = "Lit"
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
      
      
      uniform float4 unity_MatrixVP[4];
      
      uniform int unity_BaseInstanceID;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _MainLightPosition;
      
      uniform float4 _MainLightColor;
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 _MainLightWorldToLight[4];
      
      uniform float _MainLightCookieTextureFormat;
      
      uniform float _DitheringTextureInvSize;
      
      uniform samplerCUBE unity_SpecCube0;
      
      // uniform sampler2D unity_Lightmap;
      
      uniform sampler2D _BaseMap;
      
      uniform sampler2D _EmissionMap;
      
      uniform sampler2D _MainLightCookieTexture;
      
      uniform sampler2D _DitheringTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord5 : TEXCOORD5;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float2 texcoord8 : TEXCOORD8;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float2 texcoord8 : TEXCOORD8;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      struct unity_Builtins0Array_Type 
          {
          
          float4 unity_ObjectToWorldArray[4];
          
          float4 unity_WorldToObjectArray[4];
          
          float2 unity_LODFadeArray;
          
          float unity_RenderingLayerArray;
      
      };
      
      uniform UnityInstancing_PerDraw0 
          {
          
          #endif
          uniform unity_Builtins0Array_Type unity_Builtins0Array[2];
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      struct unity_Builtins2Array_Type 
          {
          
          float4 unity_LightmapSTArray;
          
          float4 unity_LightmapIndexArray;
      
      };
      
      uniform UnityInstancing_PerDraw2 
          {
          
          #endif
          uniform unity_Builtins2Array_Type unity_Builtins2Array[2];
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 Xhlslcc_UnusedX_DetailAlbedoMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 _EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float _Smoothness;
          
          uniform float _Metallic;
          
          uniform float Xhlslcc_UnusedX_BumpScale;
          
          uniform float Xhlslcc_UnusedX_Parallax;
          
          uniform float Xhlslcc_UnusedX_OcclusionStrength;
          
          uniform float Xhlslcc_UnusedX_ClearCoatMask;
          
          uniform float Xhlslcc_UnusedX_ClearCoatSmoothness;
          
          uniform float Xhlslcc_UnusedX_DetailAlbedoMapScale;
          
          uniform float Xhlslcc_UnusedX_DetailNormalMapScale;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      flat out uint vs_SV_InstanceID0;
      
      float4 u_xlat0;
      
      int u_xlati0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      int u_xlati2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.texcoord.xy = in_v.texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
          
          u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
          
          u_xlati2 = u_xlati0 * 9;
          
          u_xlati0 = int(u_xlati0 << (1 & int(0x1F)));
          
          out_v.texcoord8.xy = in_v.texcoord1.xy * unity_Builtins2Array[u_xlati0 / 2].unity_LightmapSTArray.xy + unity_Builtins2Array[u_xlati0 / 2].unity_LightmapSTArray.zw;
          
          u_xlat0.xzw = in_v.vertex.yyy * unity_Builtins0Array[u_xlati2 / 9].unity_ObjectToWorldArray[1].xyz;
          
          u_xlat0.xzw = unity_Builtins0Array[u_xlati2 / 9].unity_ObjectToWorldArray[0].xyz * in_v.vertex.xxx + u_xlat0.xzw;
          
          u_xlat0.xzw = unity_Builtins0Array[u_xlati2 / 9].unity_ObjectToWorldArray[2].xyz * in_v.vertex.zzz + u_xlat0.xzw;
          
          u_xlat0.xzw = u_xlat0.xzw + unity_Builtins0Array[u_xlati2 / 9].unity_ObjectToWorldArray[3].xyz;
          
          out_v.texcoord1.xyz = u_xlat0.xzw;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_Builtins0Array[u_xlati2 / 9].unity_WorldToObjectArray[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_Builtins0Array[u_xlati2 / 9].unity_WorldToObjectArray[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_Builtins0Array[u_xlati2 / 9].unity_WorldToObjectArray[2].xyz);
          
          u_xlat2 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat2 = max(u_xlat2, 1.17549435e-38);
          
          u_xlat2 = inversesqrt(u_xlat2);
          
          out_v.texcoord2.xyz = float3(u_xlat2) * u_xlat1.xyz;
          
          out_v.texcoord5 = 0.0;
          
          u_xlat1 = u_xlat0.zzzz * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat0 + unity_MatrixVP[3];
          
          vs_SV_InstanceID0 = uint(gl_InstanceID);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 Xhlslcc_UnusedXunity_ObjectToWorld[4];
          
          uniform float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 unity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 unity_SpecCube0_HDR;
          
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
      
      struct unity_Builtins0Array_Type 
          {
          
          float4 unity_ObjectToWorldArray[4];
          
          float4 unity_WorldToObjectArray[4];
          
          float2 unity_LODFadeArray;
          
          float unity_RenderingLayerArray;
      
      };
      
      uniform UnityInstancing_PerDraw0 
          {
          
          #endif
          uniform unity_Builtins0Array_Type unity_Builtins0Array[2];
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 Xhlslcc_UnusedX_DetailAlbedoMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 _EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float _Smoothness;
          
          uniform float _Metallic;
          
          uniform float Xhlslcc_UnusedX_BumpScale;
          
          uniform float Xhlslcc_UnusedX_Parallax;
          
          uniform float Xhlslcc_UnusedX_OcclusionStrength;
          
          uniform float Xhlslcc_UnusedX_ClearCoatMask;
          
          uniform float Xhlslcc_UnusedX_ClearCoatSmoothness;
          
          uniform float Xhlslcc_UnusedX_DetailAlbedoMapScale;
          
          uniform float Xhlslcc_UnusedX_DetailNormalMapScale;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      flat in uint vs_SV_InstanceID0;
      
      float u_xlat0_d;
      
      int u_xlati0_d;
      
      int u_xlatb0;
      
      float3 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat3;
      
      float u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float u_xlat16_7;
      
      bool2 u_xlatb8;
      
      float3 u_xlat16_9;
      
      float3 u_xlat16_10;
      
      float2 u_xlat16_11;
      
      float3 u_xlat16_12;
      
      int u_xlatb15;
      
      float u_xlat16_19;
      
      float3 u_xlat16_23;
      
      float u_xlat16_31;
      
      float u_xlat16_38;
      
      float u_xlat39;
      
      float u_xlat16_40;
      
      float u_xlat16_42;
      
      float u_xlat16_43;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
          
          u_xlati0_d = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
          
          u_xlat16_1 = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_2.xyz = u_xlat16_1.xyz * _BaseColor.xyz;
          
          u_xlat16_12.xyz = texture(_EmissionMap, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat3.xy = hlslcc_FragCoord.xy * float2(float2(_DitheringTextureInvSize, _DitheringTextureInvSize));
          
          u_xlat16_3 = texture(_DitheringTexture, u_xlat3.xy, _GlobalMipBias.x).w;
          
          u_xlati0_d = u_xlati0_d * 9;
          
          u_xlatb15 = unity_Builtins0Array[u_xlati0_d / 9].unity_LODFadeArray.x>=0.0;
          
          u_xlat3.x = (u_xlatb15) ? abs(u_xlat16_3) : -abs(u_xlat16_3);
          
          u_xlat0_d = (-u_xlat3.x) + unity_Builtins0Array[u_xlati0_d / 9].unity_LODFadeArray.x;
          
          u_xlatb0 = u_xlat0_d<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlatb0 = unity_OrthoParams.w==0.0;
          
          u_xlat3.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
          
          u_xlat39 = inversesqrt(u_xlat39);
          
          u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
          
          u_xlat16_4.x = (u_xlatb0) ? u_xlat3.x : unity_MatrixV[0].z;
          
          u_xlat16_4.y = (u_xlatb0) ? u_xlat3.y : unity_MatrixV[1].z;
          
          u_xlat16_4.z = (u_xlatb0) ? u_xlat3.z : unity_MatrixV[2].z;
          
          u_xlat0_d = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat0_d = inversesqrt(u_xlat0_d);
          
          u_xlat3.xyz = float3(u_xlat0_d) * in_f.texcoord2.xyz;
          
          u_xlat16_5.xyz = texture(unity_Lightmap, in_f.texcoord8.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_38 = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat16_40 = u_xlat16_1.w * _Smoothness + (-u_xlat16_38);
          
          u_xlat16_2.xyz = float3(u_xlat16_38) * u_xlat16_2.xyz;
          
          u_xlat16_6.xyz = u_xlat16_1.xyz * _BaseColor.xyz + float3(-0.0399999991, -0.0399999991, -0.0399999991);
          
          u_xlat16_6.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
          
          u_xlat16_38 = (-u_xlat16_1.w) * _Smoothness + 1.0;
          
          u_xlat16_42 = u_xlat16_38 * u_xlat16_38;
          
          u_xlat16_42 = max(u_xlat16_42, 0.0078125);
          
          u_xlat16_7 = u_xlat16_42 * u_xlat16_42;
          
          u_xlat16_40 = u_xlat16_40 + 1.0;
          
          u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
          
          u_xlat16_19 = u_xlat16_42 * 4.0 + 2.0;
          
          u_xlatb0 = _MainLightCookieTextureFormat!=-1.0;
          
          if(u_xlatb0)
      {
              
              u_xlat1_d.xy = in_f.texcoord1.yy * _MainLightWorldToLight[1].xy;
              
              u_xlat1_d.xy = _MainLightWorldToLight[0].xy * in_f.texcoord1.xx + u_xlat1_d.xy;
              
              u_xlat1_d.xy = _MainLightWorldToLight[2].xy * in_f.texcoord1.zz + u_xlat1_d.xy;
              
              u_xlat1_d.xy = u_xlat1_d.xy + _MainLightWorldToLight[3].xy;
              
              u_xlat1_d.xy = u_xlat1_d.xy * float2(0.5, 0.5) + float2(0.5, 0.5);
              
              u_xlat16_1 = texture(_MainLightCookieTexture, u_xlat1_d.xy, _GlobalMipBias.x);
              
              u_xlatb8.xy = equal(float4(float4(_MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat)), float4(0.0, 1.0, 0.0, 0.0)).xy;
              
              u_xlat16_31 = (u_xlatb8.y) ? u_xlat16_1.w : u_xlat16_1.x;
              
              u_xlat16_9.xyz = (u_xlatb8.x) ? u_xlat16_1.xyz : float3(u_xlat16_31);
      
      }
          else
          
              {
              
              u_xlat16_9.x = float(1.0);
              
              u_xlat16_9.y = float(1.0);
              
              u_xlat16_9.z = float(1.0);
      
      }
          
          u_xlat16_9.xyz = u_xlat16_9.xyz * _MainLightColor.xyz;
          
          u_xlat16_31 = dot((-u_xlat16_4.xyz), u_xlat3.xyz);
          
          u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
          
          u_xlat16_10.xyz = u_xlat3.xyz * (-float3(u_xlat16_31)) + (-u_xlat16_4.xyz);
          
          u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_4.xyz);
          
          u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
          
          u_xlat16_31 = (-u_xlat16_31) + 1.0;
          
          u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
          
          u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
          
          u_xlat16_43 = (-u_xlat16_38) * 0.699999988 + 1.70000005;
          
          u_xlat16_38 = u_xlat16_38 * u_xlat16_43;
          
          u_xlat16_38 = u_xlat16_38 * 6.0;
          
          u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat16_10.xyz, u_xlat16_38);
          
          u_xlat16_38 = u_xlat16_1.w + -1.0;
          
          u_xlat16_38 = unity_SpecCube0_HDR.w * u_xlat16_38 + 1.0;
          
          u_xlat16_38 = max(u_xlat16_38, 0.0);
          
          u_xlat16_38 = log2(u_xlat16_38);
          
          u_xlat16_38 = u_xlat16_38 * unity_SpecCube0_HDR.y;
          
          u_xlat16_38 = exp2(u_xlat16_38);
          
          u_xlat16_38 = u_xlat16_38 * unity_SpecCube0_HDR.x;
          
          u_xlat16_10.xyz = u_xlat16_1.xyz * float3(u_xlat16_38);
          
          u_xlat16_11.xy = float2(u_xlat16_42) * float2(u_xlat16_42) + float2(-1.0, 1.0);
          
          u_xlat16_38 = float(1.0) / u_xlat16_11.y;
          
          u_xlat16_23.xyz = (-u_xlat16_6.xyz) + float3(u_xlat16_40);
          
          u_xlat16_23.xyz = float3(u_xlat16_31) * u_xlat16_23.xyz + u_xlat16_6.xyz;
          
          u_xlat1_d.xyz = float3(u_xlat16_38) * u_xlat16_23.xyz;
          
          u_xlat16_10.xyz = u_xlat1_d.xyz * u_xlat16_10.xyz;
          
          u_xlat16_10.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_10.xyz;
          
          u_xlat16_38 = dot(u_xlat3.xyz, _MainLightPosition.xyz);
          
          u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
          
          u_xlat16_38 = u_xlat16_38 * unity_LightData.z;
          
          u_xlat16_9.xyz = float3(u_xlat16_38) * u_xlat16_9.xyz;
          
          u_xlat1_d.xyz = u_xlat16_4.xyz + _MainLightPosition.xyz;
          
          u_xlat0_d = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          
          u_xlat0_d = max(u_xlat0_d, 1.17549435e-38);
          
          u_xlat0_d = inversesqrt(u_xlat0_d);
          
          u_xlat1_d.xyz = float3(u_xlat0_d) * u_xlat1_d.xyz;
          
          u_xlat0_d = dot(u_xlat3.xyz, u_xlat1_d.xyz);
          
          u_xlat0_d = clamp(u_xlat0_d, 0.0, 1.0);
          
          u_xlat1_d.x = dot(_MainLightPosition.xyz, u_xlat1_d.xyz);
          
          u_xlat1_d.x = clamp(u_xlat1_d.x, 0.0, 1.0);
          
          u_xlat0_d = u_xlat0_d * u_xlat0_d;
          
          u_xlat0_d = u_xlat0_d * u_xlat16_11.x + 1.00001001;
          
          u_xlat16_38 = u_xlat1_d.x * u_xlat1_d.x;
          
          u_xlat0_d = u_xlat0_d * u_xlat0_d;
          
          u_xlat1_d.x = max(u_xlat16_38, 0.100000001);
          
          u_xlat0_d = u_xlat0_d * u_xlat1_d.x;
          
          u_xlat0_d = u_xlat16_19 * u_xlat0_d;
          
          u_xlat0_d = u_xlat16_7 / u_xlat0_d;
          
          u_xlat16_38 = u_xlat0_d + -6.10351562e-05;
          
          u_xlat16_38 = max(u_xlat16_38, 0.0);
          
          u_xlat16_38 = min(u_xlat16_38, 1000.0);
          
          u_xlat16_2.xyz = u_xlat16_6.xyz * float3(u_xlat16_38) + u_xlat16_2.xyz;
          
          u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz + u_xlat16_10.xyz;
          
          u_xlat16_2.xyz = u_xlat16_12.xyz * _EmissionColor.xyz + u_xlat16_2.xyz;
          
          out_f.color.xyz = min(u_xlat16_2.xyz, float3(65504.0, 65504.0, 65504.0));
          
          u_xlat16_2.x = min(_BaseColor.w, 65504.0);
          
          u_xlatb0 = _Surface==1.0;
          
          out_f.color.w = (u_xlatb0) ? u_xlat16_2.x : 1.0;
          
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
        "UniversalMaterialType" = "Lit"
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
        "UniversalMaterialType" = "Lit"
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
          
          float3 texcoord5 : TEXCOORD5;
          
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
          
          out_v.texcoord2.xyz = u_xlat0.xyz;
          
          out_v.texcoord5.xyz = float3(0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat0_d.x = inversesqrt(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord2.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
