// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "Universal Render Pipeline/Particles/Simple Lit"
{
  Properties
  {
    _BaseMap ("Base Map", 2D) = "white" {}
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _SpecGlossMap ("Specular", 2D) = "white" {}
    _SpecColor ("Specular", Color) = (1,1,1,1)
    _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    _BumpScale ("Scale", float) = 1
    _BumpMap ("Normal Map", 2D) = "bump" {}
    [HDR] _EmissionColor ("Color", Color) = (0,0,0,1)
    _EmissionMap ("Emission", 2D) = "white" {}
    _SmoothnessSource ("Smoothness Source", float) = 0
    _SpecularHighlights ("Specular Highlights", float) = 1
    [ToggleUI] _ReceiveShadows ("Receive Shadows", float) = 1
    _SoftParticlesNearFadeDistance ("Soft Particles Near Fade", float) = 0
    _SoftParticlesFarFadeDistance ("Soft Particles Far Fade", float) = 1
    _CameraNearFadeDistance ("Camera Near Fade", float) = 1
    _CameraFarFadeDistance ("Camera Far Fade", float) = 2
    _DistortionBlend ("Distortion Blend", Range(0, 1)) = 0.5
    _DistortionStrength ("Distortion Strength", float) = 1
    _Surface ("__surface", float) = 0
    _Blend ("__mode", float) = 0
    _Cull ("__cull", float) = 2
    [ToggleUI] _AlphaClip ("__clip", float) = 0
    [HideInInspector] _BlendOp ("__blendop", float) = 0
    [HideInInspector] _SrcBlend ("__src", float) = 1
    [HideInInspector] _DstBlend ("__dst", float) = 0
    [HideInInspector] _SrcBlendAlpha ("__srcA", float) = 1
    [HideInInspector] _DstBlendAlpha ("__dstA", float) = 0
    [HideInInspector] _ZWrite ("__zw", float) = 1
    [HideInInspector] _AlphaToMask ("__alphaToMask", float) = 0
    _ColorMode ("_ColorMode", float) = 0
    [HideInInspector] _BaseColorAddSubDiff ("_ColorMode", Vector) = (0,0,0,0)
    [ToggleOff] _FlipbookBlending ("__flipbookblending", float) = 0
    [ToggleUI] _SoftParticlesEnabled ("__softparticlesenabled", float) = 0
    [ToggleUI] _CameraFadingEnabled ("__camerafadingenabled", float) = 0
    [ToggleUI] _DistortionEnabled ("__distortionenabled", float) = 0
    [HideInInspector] _SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
    [HideInInspector] _CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
    [HideInInspector] _DistortionStrengthScaled ("Distortion Strength Scaled", float) = 0.1
    _QueueOffset ("Queue offset", float) = 0
    [HideInInspector] _FlipbookMode ("flipbook", float) = 0
    [HideInInspector] _Glossiness ("gloss", float) = 0
    [HideInInspector] _Mode ("mode", float) = 0
    [HideInInspector] _Color ("color", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PerformanceChecks" = "False"
      "PreviewType" = "Plane"
      "RenderPipeline" = "UniversalPipeline"
      "RenderType" = "Opaque"
      "UniversalMaterialType" = "SimpleLit"
    }
    Pass // ind: 1, name: ForwardLit
    {
      Name "ForwardLit"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "UniversalForward"
        "PerformanceChecks" = "False"
        "PreviewType" = "Plane"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11, OpenGL ES 2.0 because it uses unsized arrays
#pragma exclude_renderers d3d11 gles
      #pragma multi_compile _Surface
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _ProjectionParams;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform int unity_BaseInstanceID;
      
      uniform float4 unity_ParticleUVShiftData;
      
      uniform float unity_ParticleUseMeshColors;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _MainLightPosition;
      
      uniform float4 _MainLightColor;
      
      uniform float4 _ZBufferParams;
      
      uniform float4 _MainLightWorldToLight[4];
      
      uniform float _MainLightCookieTextureFormat;
      
      uniform sampler2D _MainLightCookieTexture;
      
      uniform sampler2D _BaseMap;
      
      uniform sampler2D _CameraDepthTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 texcoord6 : TEXCOORD6;
          
          float3 texcoord8 : TEXCOORD8;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord6 : TEXCOORD6;
          
          float3 texcoord8 : TEXCOORD8;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          float4 Xhlslcc_UnusedXunity_ObjectToWorld[4];
          
          float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          float4 Xhlslcc_UnusedXunity_LODFade;
          
          float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          float4 unity_LightData;
          
          float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          float4 Xhlslcc_UnusedXunity_LightmapST;
          
          float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          float4 unity_SHAr;
          
          float4 unity_SHAg;
          
          float4 unity_SHAb;
          
          float4 unity_SHBr;
          
          float4 unity_SHBg;
          
          float4 unity_SHBb;
          
          float4 unity_SHC;
          
          float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
      
      };
      
      struct unity_ParticleInstanceData_type 
          {
          
          uint[14] value;
      
      };
      
      
      layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData 
          {
          
          unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
      
      };
      
      flat out uint vs_SV_InstanceID0;
      
      float4 u_xlat0;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      int u_xlati1;
      
      uint u_xlatu1;
      
      float4 u_xlat2;
      
      float4 u_xlat16_2;
      
      uint3 u_xlatu2;
      
      float4 u_xlat3;
      
      float4 u_xlat4;
      
      float4 u_xlat5;
      
      float3 u_xlat6;
      
      float4 u_xlat7;
      
      float3 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float3 u_xlat11;
      
      int u_xlatb21;
      
      float u_xlat31;
      
      int u_xlatb31;
      
      uint uint_bitfieldExtract(uint value, int offset, int bits) 
          {
          return (value >> uint(offset)) & uint(~(int(~0) << uint(bits)));
      }
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.xyz;
          
          u_xlat0.w = 1.0;
          
          u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
          
          u_xlat2 = float4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
          
          u_xlat3.w = u_xlat2.y;
          
          u_xlat11.xyz = float3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
          
          u_xlat3.y = u_xlat11.y;
          
          u_xlat4.xyz = float3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
          
          u_xlat3.z = u_xlat4.x;
          
          u_xlat5.xyz = float3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
          
          u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
          
          u_xlat1.x = floor(u_xlat1.x);
          
          u_xlat3.x = u_xlat5.z;
          
          u_xlat6.y = dot(u_xlat3, u_xlat0);
          
          u_xlat7 = u_xlat6.yyyy * unity_MatrixVP[1];
          
          u_xlat4.w = u_xlat2.x;
          
          u_xlat5.z = u_xlat4.y;
          
          u_xlat4.x = u_xlat5.y;
          
          u_xlat4.y = u_xlat11.x;
          
          u_xlat5.y = u_xlat11.z;
          
          u_xlat6.x = dot(u_xlat4, u_xlat0);
          
          u_xlat7 = unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat7;
          
          u_xlat5.w = u_xlat2.z;
          
          u_xlat6.z = dot(u_xlat5, u_xlat0);
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat7;
          
          u_xlat0 = u_xlat0 + unity_MatrixVP[3];
          
          out_v.vertex = u_xlat0;
          
          u_xlat11.x = u_xlat1.x / unity_ParticleUVShiftData.y;
          
          u_xlat11.x = floor(u_xlat11.x);
          
          u_xlat1.x = (-u_xlat11.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
          
          u_xlat1.x = floor(u_xlat1.x);
          
          u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
          
          u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
          
          u_xlat2.y = (-u_xlat11.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
          
          u_xlat1.xy = in_v.texcoord.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
          
          u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
          
          out_v.texcoord.xy = (int(u_xlatb21)) ? u_xlat1.xy : in_v.texcoord.xy;
          
          u_xlatu1 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
          
          u_xlat1.x = float(u_xlatu1);
          
          u_xlatu2.xy = uint2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
          
          u_xlatu2.z = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
          
          u_xlat1.yzw = float3(u_xlatu2.xyz);
          
          u_xlat1 = u_xlat1 * float4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
          
          u_xlat16_2 = in_v.color + float4(-1.0, -1.0, -1.0, -1.0);
          
          u_xlat16_2 = float4(unity_ParticleUseMeshColors) * u_xlat16_2 + float4(1.0, 1.0, 1.0, 1.0);
          
          out_v.color = u_xlat1 * u_xlat16_2;
          
          out_v.texcoord1.w = 0.0;
          
          out_v.texcoord1.xyz = u_xlat6.xyz;
          
          u_xlat1.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat6.xyz = u_xlat4.yzx * u_xlat5.zxy;
          
          u_xlat6.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat6.xyz);
          
          u_xlat7.xyz = u_xlat3.zxy * u_xlat5.yzx;
          
          u_xlat5.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat7.xyz);
          
          u_xlat31 = dot(u_xlat4.xyz, u_xlat5.xyz);
          
          u_xlat31 = float(1.0) / float(u_xlat31);
          
          u_xlat6.xyz = float3(u_xlat31) * u_xlat6.xyz;
          
          u_xlat6.y = dot(in_v.normal.xyz, u_xlat6.xyz);
          
          u_xlat7.xyz = u_xlat3.yzx * u_xlat4.zxy;
          
          u_xlat3.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat7.xyz);
          
          u_xlat3.xyz = float3(u_xlat31) * u_xlat3.xyz;
          
          u_xlat4.xyz = float3(u_xlat31) * u_xlat5.xyz;
          
          u_xlat6.x = dot(in_v.normal.xyz, u_xlat4.xyz);
          
          u_xlat6.z = dot(in_v.normal.xyz, u_xlat3.xyz);
          
          u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
          
          u_xlat31 = max(u_xlat31, 1.17549435e-38);
          
          u_xlat31 = inversesqrt(u_xlat31);
          
          u_xlat2.xyz = float3(u_xlat31) * u_xlat6.xyz;
          
          out_v.texcoord2.xyz = u_xlat2.xyz;
          
          u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat31 = inversesqrt(u_xlat31);
          
          u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
          
          u_xlatb31 = unity_OrthoParams.w==0.0;
          
          out_v.texcoord3.x = (u_xlatb31) ? u_xlat1.x : unity_MatrixV[0].z;
          
          out_v.texcoord3.y = (u_xlatb31) ? u_xlat1.y : unity_MatrixV[1].z;
          
          out_v.texcoord3.z = (u_xlatb31) ? u_xlat1.z : unity_MatrixV[2].z;
          
          u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
          
          u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
          
          out_v.texcoord6.zw = u_xlat0.zw;
          
          out_v.texcoord6.xy = u_xlat1.zz + u_xlat1.xw;
          
          u_xlat16_8.x = u_xlat2.y * u_xlat2.y;
          
          u_xlat16_8.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_8.x);
          
          u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
          
          u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
          
          u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
          
          u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
          
          u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
          
          u_xlat2.w = 1.0;
          
          u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
          
          u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
          
          u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
          
          u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
          
          out_v.texcoord8.xyz = max(u_xlat16_8.xyz, float3(0.0, 0.0, 0.0));
          
          vs_SV_InstanceID0 = uint(gl_InstanceID);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerDraw 
          {
          
          float4 Xhlslcc_UnusedXunity_ObjectToWorld[4];
          
          float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          float4 Xhlslcc_UnusedXunity_LODFade;
          
          float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          float4 unity_LightData;
          
          float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          float4 Xhlslcc_UnusedXunity_LightmapST;
          
          float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          float4 unity_SHAr;
          
          float4 unity_SHAg;
          
          float4 unity_SHAb;
          
          float4 unity_SHBr;
          
          float4 unity_SHBg;
          
          float4 unity_SHBb;
          
          float4 unity_SHC;
          
          float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
      
      };
      
      uniform UnityPerMaterial 
          {
          
          float4 _SoftParticleFadeParams;
          
          float4 _CameraFadeParams;
          
          float4 Xhlslcc_UnusedX_BaseMap_ST;
          
          float4 _BaseColor;
          
          float4 Xhlslcc_UnusedX_EmissionColor;
          
          float4 Xhlslcc_UnusedX_BaseColorAddSubDiff;
          
          float4 Xhlslcc_UnusedX_SpecColor;
          
          float Xhlslcc_UnusedX_Cutoff;
          
          float Xhlslcc_UnusedX_Smoothness;
          
          float Xhlslcc_UnusedX_DistortionStrengthScaled;
          
          float Xhlslcc_UnusedX_DistortionBlend;
          
          float _Surface;
      
      };
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0_d;
      
      float3 u_xlat1_d;
      
      bool2 u_xlatb1;
      
      float3 u_xlat2_d;
      
      float4 u_xlat16_2_d;
      
      bool2 u_xlatb3;
      
      float3 u_xlat16_4;
      
      float u_xlat6_d;
      
      int u_xlatb6;
      
      float u_xlat11_d;
      
      float u_xlat16;
      
      int u_xlatb16;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0_d = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_0_d = u_xlat16_0_d * _BaseColor;
          
          u_xlat16_0_d = u_xlat16_0_d * in_f.color;
          
          u_xlatb1.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), _SoftParticleFadeParams.xyxx).xy;
          
          u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
          
          if(u_xlatb1.x)
      {
              
              u_xlat1_d.xy = in_f.texcoord6.xy / in_f.texcoord6.ww;
              
              u_xlat1_d.x = texture(_CameraDepthTexture, u_xlat1_d.xy, _GlobalMipBias.x).x;
              
              u_xlatb6 = unity_OrthoParams.w==0.0;
              
              u_xlat11_d = _ZBufferParams.z * u_xlat1_d.x + _ZBufferParams.w;
              
              u_xlat11_d = float(1.0) / u_xlat11_d;
              
              u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
              
              u_xlat1_d.x = u_xlat16 * u_xlat1_d.x + _ProjectionParams.y;
              
              u_xlat1_d.x = (u_xlatb6) ? u_xlat11_d : u_xlat1_d.x;
              
              u_xlat6_d = in_f.texcoord1.y * unity_MatrixV[1].z;
              
              u_xlat6_d = unity_MatrixV[0].z * in_f.texcoord1.x + u_xlat6_d;
              
              u_xlat6_d = unity_MatrixV[2].z * in_f.texcoord1.z + u_xlat6_d;
              
              u_xlat6_d = u_xlat6_d + unity_MatrixV[3].z;
              
              u_xlat1_d.x = u_xlat1_d.x + (-_SoftParticleFadeParams.x);
              
              u_xlat1_d.x = -abs(u_xlat6_d) + u_xlat1_d.x;
              
              u_xlat1_d.x = u_xlat1_d.x * _SoftParticleFadeParams.y;
              
              u_xlat1_d.x = clamp(u_xlat1_d.x, 0.0, 1.0);
      
      }
          else
          
              {
              
              u_xlat1_d.x = 1.0;
      
      }
          
          u_xlat0_d = u_xlat16_0_d * u_xlat1_d.xxxx;
          
          u_xlat1_d.x = in_f.texcoord6.z / in_f.texcoord6.w;
          
          u_xlat1_d.x = _ZBufferParams.z * u_xlat1_d.x + _ZBufferParams.w;
          
          u_xlat1_d.x = float(1.0) / u_xlat1_d.x;
          
          u_xlat1_d.x = u_xlat1_d.x + (-_CameraFadeParams.x);
          
          u_xlat1_d.x = u_xlat1_d.x * _CameraFadeParams.y;
          
          u_xlat1_d.x = clamp(u_xlat1_d.x, 0.0, 1.0);
          
          u_xlat16_0_d = u_xlat0_d * u_xlat1_d.xxxx;
          
          u_xlat1_d.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat1_d.x = inversesqrt(u_xlat1_d.x);
          
          u_xlat1_d.xyz = u_xlat1_d.xxx * in_f.texcoord2.xyz;
          
          u_xlatb16 = _MainLightCookieTextureFormat!=-1.0;
          
          if(u_xlatb16)
      {
              
              u_xlat2_d.xy = in_f.texcoord1.yy * _MainLightWorldToLight[1].xy;
              
              u_xlat2_d.xy = _MainLightWorldToLight[0].xy * in_f.texcoord1.xx + u_xlat2_d.xy;
              
              u_xlat2_d.xy = _MainLightWorldToLight[2].xy * in_f.texcoord1.zz + u_xlat2_d.xy;
              
              u_xlat2_d.xy = u_xlat2_d.xy + _MainLightWorldToLight[3].xy;
              
              u_xlat2_d.xy = u_xlat2_d.xy * float2(0.5, 0.5) + float2(0.5, 0.5);
              
              u_xlat16_2_d = texture(_MainLightCookieTexture, u_xlat2_d.xy, _GlobalMipBias.x);
              
              u_xlatb3.xy = equal(float4(float4(_MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat, _MainLightCookieTextureFormat)), float4(0.0, 1.0, 0.0, 0.0)).xy;
              
              u_xlat16_4.x = (u_xlatb3.y) ? u_xlat16_2_d.w : u_xlat16_2_d.x;
              
              u_xlat16_4.xyz = (u_xlatb3.x) ? u_xlat16_2_d.xyz : u_xlat16_4.xxx;
      
      }
          else
          
              {
              
              u_xlat16_4.x = float(1.0);
              
              u_xlat16_4.y = float(1.0);
              
              u_xlat16_4.z = float(1.0);
      
      }
          
          u_xlat16_4.xyz = u_xlat16_4.xyz * _MainLightColor.xyz;
          
          u_xlat2_d.xyz = u_xlat16_4.xyz * unity_LightData.zzz;
          
          u_xlat16_4.x = dot(u_xlat1_d.xyz, _MainLightPosition.xyz);
          
          u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
          
          u_xlat16_4.xyz = u_xlat2_d.xyz * u_xlat16_4.xxx;
          
          u_xlat16_4.xyz = u_xlat16_0_d.xyz * u_xlat16_4.xyz;
          
          u_xlat16_4.xyz = u_xlat16_0_d.www * u_xlat16_4.xyz;
          
          out_f.color.xyz = in_f.texcoord8.xyz * u_xlat16_0_d.xyz + u_xlat16_4.xyz;
          
          u_xlatb1.x = _Surface==1.0;
          
          out_f.color.w = (u_xlatb1.x) ? u_xlat16_0_d.w : 1.0;
          
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
        "PerformanceChecks" = "False"
        "PreviewType" = "Plane"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
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
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat0 + unity_MatrixVP[3];
          
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
        "PerformanceChecks" = "False"
        "PreviewType" = "Plane"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "SimpleLit"
      }
      Cull Off
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
          
          float4 SV_TARGET0 : SV_TARGET0;
      
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
      
      float3 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_2;
      
      float u_xlat9;
      
      int u_xlatb9;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
          
          out_v.vertex = u_xlat1 + unity_MatrixVP[3];
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat9 = max(u_xlat9, 1.17549435e-38);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          out_v.texcoord2.xyz = float3(u_xlat9) * u_xlat1.xyz;
          
          u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
          
          u_xlatb9 = unity_OrthoParams.w==0.0;
          
          u_xlat16_2.x = (u_xlatb9) ? u_xlat0.x : unity_MatrixV[0].z;
          
          u_xlat16_2.y = (u_xlatb9) ? u_xlat0.y : unity_MatrixV[1].z;
          
          u_xlat16_2.z = (u_xlatb9) ? u_xlat0.z : unity_MatrixV[2].z;
          
          out_v.texcoord3.xyz = u_xlat16_2.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat0_d.x = inversesqrt(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord2.xyz;
          
          out_f.SV_TARGET0.xyz = u_xlat0_d.xyz;
          
          out_f.SV_TARGET0.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Universal Render Pipeline/Particles/Unlit"
}
