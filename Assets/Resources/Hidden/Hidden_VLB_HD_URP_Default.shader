// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "Hidden/VLB_HD_URP_Default"
{
  Properties
  {
    _ConeRadius ("Cone Radius", Vector) = (0,0,0,0)
    _ConeGeomProps ("Cone Geom Props", Vector) = (0,0,0,0)
    _ColorFlat ("Color", Vector) = (1,1,1,1)
    _HDRPExposureWeight ("HDRP Exposure Weight", Range(0, 1)) = 0
    _DistanceFallOff ("Distance Fall Off", Vector) = (0,1,1,0)
    _NoiseVelocityAndScale ("Noise Velocity And Scale", Vector) = (0,0,0,0)
    _NoiseParam ("Noise Param", Vector) = (0,0,0,0)
    _BlendSrcFactor ("BlendSrcFactor", float) = 1
    _BlendDstFactor ("BlendDstFactor", float) = 1
    _ZTest ("ZTest", float) = 4
    _ConeSlopeCosSin ("Cone Slope Cos Sin", Vector) = (0,0,0,0)
    _AlphaInside ("Alpha Inside", Range(0, 1)) = 1
    _AlphaOutside ("Alpha Outside", Range(0, 1)) = 1
    _DistanceCamClipping ("Camera Clipping Distance", float) = 0.5
    _FadeOutFactor ("FadeOutFactor", float) = 1
    _AttenuationLerpLinearQuad ("Lerp between attenuation linear and quad", float) = 0.5
    _DepthBlendDistance ("Depth Blend Distance", float) = 2
    _FresnelPow ("Fresnel Pow", Range(0, 15)) = 1
    _GlareFrontal ("Glare Frontal", Range(0, 1)) = 0.5
    _GlareBehind ("Glare from Behind", Range(0, 1)) = 0.5
    _DrawCap ("Draw Cap", float) = 1
    _CameraParams ("Camera Params", Vector) = (0,0,0,0)
    _DynamicOcclusionClippingPlaneWS ("Dynamic Occlusion Clipping Plane WS", Vector) = (0,0,0,0)
    _DynamicOcclusionClippingPlaneProps ("Dynamic Occlusion Clipping Plane Props", float) = 0.25
    _DynamicOcclusionDepthTexture ("DynamicOcclusionDepthTexture", 2D) = "white" {}
    _DynamicOcclusionDepthProps ("DynamicOcclusionDepthProps", Vector) = (1,1,0.25,1)
    _LocalForwardDirection ("LocalForwardDirection", Vector) = (0,0,1,1)
    _TiltVector ("TiltVector", Vector) = (0,0,0,0)
    _AdditionalClippingPlaneWS ("AdditionalClippingPlaneWS", Vector) = (0,0,0,0)
    _Intensity ("Intensity", Range(0, 8)) = 1
    _SideSoftness ("SideSoftness", Range(0, 15)) = 1
    _Jittering ("Jittering", Vector) = (0,0,0,0)
    _CameraForwardOS ("Camera Forward OS", Vector) = (0,0,0,1)
    _CameraForwardWS ("Camera Forward WS", Vector) = (0,0,0,1)
    _TransformScale ("Transform Scale", Vector) = (0,0,0,1)
    _CookieTexture ("CookieTexture", 2D) = "white" {}
    _CookieProperties ("CookieProperties", Vector) = (0,0,0,0)
    _CookiePosAndScale ("CookiePosAndScale", Vector) = (0,0,1,1)
    _ShadowDepthTexture ("ShadowDepthTexture", 2D) = "white" {}
    _ShadowProps ("ShadowProps", Vector) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 200
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 unity_SpecCube0_BoxMax;
      
      uniform float4 unity_SpecCube0_BoxMin;
      
      uniform float4 unity_SpecCube0_ProbePosition;
      
      uniform float4 unity_SpecCube0_HDR;
      
      uniform float4 unity_SpecCube1_BoxMax;
      
      uniform float4 unity_SpecCube1_BoxMin;
      
      uniform float4 unity_SpecCube1_ProbePosition;
      
      uniform float4 unity_SpecCube1_HDR;
      
      uniform float4 _LightColor0;
      
      uniform samplerCUBE unity_SpecCube0;
      
      uniform samplerCUBE unity_SpecCube1;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          out_v.texcoord1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
          
          out_v.texcoord5 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float4 u_xlat16_2;
      
      float3 u_xlat3;
      
      float4 u_xlat16_3;
      
      float3 u_xlat4;
      
      float4 u_xlat16_4;
      
      float3 u_xlat5;
      
      float3 u_xlat6_d;
      
      bool3 u_xlatb6;
      
      float3 u_xlat7;
      
      float3 u_xlat16_7;
      
      bool3 u_xlatb8;
      
      float u_xlat16_9;
      
      float3 u_xlat10;
      
      float u_xlat16_12;
      
      float u_xlat20;
      
      float u_xlat16_22;
      
      float u_xlat30;
      
      float u_xlat31;
      
      int u_xlatb31;
      
      float u_xlat16_32;
      
      float u_xlat16_37;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat30 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat30 = inversesqrt(u_xlat30);
          
          u_xlat1_d.xyz = float3(u_xlat30) * u_xlat0_d.xyz;
          
          u_xlat16_2.x = dot((-u_xlat1_d.xyz), in_f.texcoord.xyz);
          
          u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
          
          u_xlat16_2.xyz = in_f.texcoord.xyz * (-u_xlat16_2.xxx) + (-u_xlat1_d.xyz);
          
          u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
          
          if(u_xlatb31)
      {
              
              u_xlat31 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
              
              u_xlat31 = inversesqrt(u_xlat31);
              
              u_xlat3.xyz = float3(u_xlat31) * u_xlat16_2.xyz;
              
              u_xlat4.xyz = (-in_f.texcoord1.xyz) + unity_SpecCube0_BoxMax.xyz;
              
              u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
              
              u_xlat5.xyz = (-in_f.texcoord1.xyz) + unity_SpecCube0_BoxMin.xyz;
              
              u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
              
              u_xlatb6.xyz = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
              
              
                  {
                  
                  float3 hlslcc_movcTemp = u_xlat4;
                  
                  hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
                  
                  hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
                  
                  hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
                  
                  u_xlat4 = hlslcc_movcTemp;
      
      }
              
              u_xlat31 = min(u_xlat4.y, u_xlat4.x);
              
              u_xlat31 = min(u_xlat4.z, u_xlat31);
              
              u_xlat4.xyz = in_f.texcoord1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
              
              u_xlat3.xyz = u_xlat3.xyz * float3(u_xlat31) + u_xlat4.xyz;
      
      }
          else
          
              {
              
              u_xlat3.xyz = u_xlat16_2.xyz;
      
      }
          
          u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
          
          u_xlat16_32 = u_xlat16_3.w + -1.0;
          
          u_xlat16_32 = unity_SpecCube0_HDR.w * u_xlat16_32 + 1.0;
          
          u_xlat16_32 = log2(u_xlat16_32);
          
          u_xlat16_32 = u_xlat16_32 * unity_SpecCube0_HDR.y;
          
          u_xlat16_32 = exp2(u_xlat16_32);
          
          u_xlat16_32 = u_xlat16_32 * unity_SpecCube0_HDR.x;
          
          u_xlat16_7.xyz = u_xlat16_3.xyz * float3(u_xlat16_32);
          
          u_xlatb31 = unity_SpecCube0_BoxMin.w<0.999989986;
          
          if(u_xlatb31)
      {
              
              u_xlatb31 = 0.0<unity_SpecCube1_ProbePosition.w;
              
              if(u_xlatb31)
      {
                  
                  u_xlat31 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
                  
                  u_xlat31 = inversesqrt(u_xlat31);
                  
                  u_xlat4.xyz = float3(u_xlat31) * u_xlat16_2.xyz;
                  
                  u_xlat5.xyz = (-in_f.texcoord1.xyz) + unity_SpecCube1_BoxMax.xyz;
                  
                  u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
                  
                  u_xlat6_d.xyz = (-in_f.texcoord1.xyz) + unity_SpecCube1_BoxMin.xyz;
                  
                  u_xlat6_d.xyz = u_xlat6_d.xyz / u_xlat4.xyz;
                  
                  u_xlatb8.xyz = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
                  
                  
                      {
                      
                      float3 hlslcc_movcTemp = u_xlat5;
                      
                      hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat5.x : u_xlat6_d.x;
                      
                      hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat5.y : u_xlat6_d.y;
                      
                      hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat5.z : u_xlat6_d.z;
                      
                      u_xlat5 = hlslcc_movcTemp;
      
      }
                  
                  u_xlat31 = min(u_xlat5.y, u_xlat5.x);
                  
                  u_xlat31 = min(u_xlat5.z, u_xlat31);
                  
                  u_xlat5.xyz = in_f.texcoord1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                  
                  u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat31) + u_xlat5.xyz;
      
      }
              else
              
                  {
                  
                  u_xlat4.xyz = u_xlat16_2.xyz;
      
      }
              
              u_xlat16_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
              
              u_xlat16_2.x = u_xlat16_4.w + -1.0;
              
              u_xlat16_2.x = unity_SpecCube1_HDR.w * u_xlat16_2.x + 1.0;
              
              u_xlat16_2.x = log2(u_xlat16_2.x);
              
              u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube1_HDR.y;
              
              u_xlat16_2.x = exp2(u_xlat16_2.x);
              
              u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube1_HDR.x;
              
              u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx;
              
              u_xlat3.xyz = float3(u_xlat16_32) * u_xlat16_3.xyz + (-u_xlat16_2.xyz);
              
              u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat16_2.xyz;
              
              u_xlat16_7.xyz = u_xlat7.xyz;
      
      }
          
          u_xlat31 = dot(in_f.texcoord.xyz, in_f.texcoord.xyz);
          
          u_xlat31 = inversesqrt(u_xlat31);
          
          u_xlat3.xyz = float3(u_xlat31) * in_f.texcoord.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(u_xlat30) + _WorldSpaceLightPos0.xyz;
          
          u_xlat30 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat30 = max(u_xlat30, 0.00100000005);
          
          u_xlat30 = inversesqrt(u_xlat30);
          
          u_xlat0_d.xyz = float3(u_xlat30) * u_xlat0_d.xyz;
          
          u_xlat30 = dot(u_xlat3.xyz, u_xlat1_d.xyz);
          
          u_xlat1_d.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
          
          u_xlat1_d.x = clamp(u_xlat1_d.x, 0.0, 1.0);
          
          u_xlat0_d.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0_d.xyz);
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat16_2.x = u_xlat0_d.x + u_xlat0_d.x;
          
          u_xlat16_2.x = u_xlat16_2.x * u_xlat0_d.x + -0.5;
          
          u_xlat16_12 = (-u_xlat1_d.x) + 1.0;
          
          u_xlat16_22 = u_xlat16_12 * u_xlat16_12;
          
          u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
          
          u_xlat16_12 = u_xlat16_12 * u_xlat16_22;
          
          u_xlat16_12 = u_xlat16_2.x * u_xlat16_12 + 1.0;
          
          u_xlat16_22 = -abs(u_xlat30) + 1.0;
          
          u_xlat16_32 = u_xlat16_22 * u_xlat16_22;
          
          u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
          
          u_xlat16_22 = u_xlat16_22 * u_xlat16_32;
          
          u_xlat16_2.x = u_xlat16_2.x * u_xlat16_22 + 1.0;
          
          u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
          
          u_xlat10.x = u_xlat1_d.x * u_xlat16_2.x;
          
          u_xlat20 = abs(u_xlat30) + u_xlat1_d.x;
          
          u_xlat20 = u_xlat20 + 9.99999975e-06;
          
          u_xlat20 = 0.5 / u_xlat20;
          
          u_xlat20 = u_xlat1_d.x * u_xlat20;
          
          u_xlat20 = u_xlat20 * 0.999999881;
          
          u_xlat16_2.xyw = u_xlat10.xxx * _LightColor0.xyz;
          
          u_xlat10.xyz = float3(u_xlat20) * _LightColor0.xyz;
          
          u_xlat16_37 = (-u_xlat0_d.x) + 1.0;
          
          u_xlat16_9 = u_xlat16_37 * u_xlat16_37;
          
          u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
          
          u_xlat16_37 = u_xlat16_37 * u_xlat16_9;
          
          u_xlat16_37 = u_xlat16_37 * 0.959999979 + 0.0399999991;
          
          u_xlat0_d.xyz = u_xlat10.xyz * float3(u_xlat16_37);
          
          u_xlat0_d.xyz = u_xlat16_2.xyw * float3(0.959999979, 0.959999979, 0.959999979) + u_xlat0_d.xyz;
          
          u_xlat16_2.xyw = u_xlat16_7.xyz * float3(0.5, 0.5, 0.5);
          
          u_xlat16_22 = u_xlat16_22 * 2.23517418e-08 + 0.0399999991;
          
          u_xlat0_d.xyz = u_xlat16_2.xyw * float3(u_xlat16_22) + u_xlat0_d.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "RenderType" = "Opaque"
      }
      LOD 200
      ZWrite Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 unity_WorldToLight[4];
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightColor0;
      
      uniform sampler2D _LightTexture0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float u_xlat10;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat10 = inversesqrt(u_xlat10);
          
          out_v.texcoord.xyz = float3(u_xlat10) * u_xlat1.xyz;
          
          out_v.texcoord1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = unity_ObjectToWorld[3] * in_v.vertex.wwww + u_xlat0;
          
          u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
          
          u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          out_v.texcoord2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
          
          out_v.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float3 u_xlat2_d;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float u_xlat5;
      
      float u_xlat16_8;
      
      float u_xlat10_d;
      
      float u_xlat16_13;
      
      float u_xlat15;
      
      float u_xlat16_18;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat15 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat0_d.xyz = float3(u_xlat15) * u_xlat0_d.xyz;
          
          u_xlat1_d.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceLightPos0.xyz;
          
          u_xlat15 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat2_d.xyz = u_xlat1_d.xyz * float3(u_xlat15) + u_xlat0_d.xyz;
          
          u_xlat1_d.xyz = float3(u_xlat15) * u_xlat1_d.xyz;
          
          u_xlat15 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          
          u_xlat15 = max(u_xlat15, 0.00100000005);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat2_d.xyz = float3(u_xlat15) * u_xlat2_d.xyz;
          
          u_xlat15 = dot(u_xlat1_d.xyz, u_xlat2_d.xyz);
          
          u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          
          u_xlat16_3.x = u_xlat15 + u_xlat15;
          
          u_xlat16_3.x = u_xlat16_3.x * u_xlat15 + -0.5;
          
          u_xlat16_8 = (-u_xlat15) + 1.0;
          
          u_xlat15 = dot(in_f.texcoord.xyz, in_f.texcoord.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat2_d.xyz = float3(u_xlat15) * in_f.texcoord.xyz;
          
          u_xlat0_d.x = dot(u_xlat2_d.xyz, u_xlat0_d.xyz);
          
          u_xlat5 = dot(u_xlat2_d.xyz, u_xlat1_d.xyz);
          
          u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
          
          u_xlat16_13 = -abs(u_xlat0_d.x) + 1.0;
          
          u_xlat0_d.x = abs(u_xlat0_d.x) + u_xlat5;
          
          u_xlat0_d.x = u_xlat0_d.x + 9.99999975e-06;
          
          u_xlat0_d.x = 0.5 / u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat5 * u_xlat0_d.x;
          
          u_xlat0_d.x = u_xlat0_d.x * 0.999999881;
          
          u_xlat16_18 = u_xlat16_13 * u_xlat16_13;
          
          u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
          
          u_xlat16_13 = u_xlat16_13 * u_xlat16_18;
          
          u_xlat16_13 = u_xlat16_3.x * u_xlat16_13 + 1.0;
          
          u_xlat16_18 = (-u_xlat5) + 1.0;
          
          u_xlat16_4.x = u_xlat16_18 * u_xlat16_18;
          
          u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
          
          u_xlat16_18 = u_xlat16_18 * u_xlat16_4.x;
          
          u_xlat16_3.x = u_xlat16_3.x * u_xlat16_18 + 1.0;
          
          u_xlat16_3.x = u_xlat16_13 * u_xlat16_3.x;
          
          u_xlat5 = u_xlat5 * u_xlat16_3.x;
          
          u_xlat1_d.xyz = in_f.texcoord1.yyy * unity_WorldToLight[1].xyz;
          
          u_xlat1_d.xyz = unity_WorldToLight[0].xyz * in_f.texcoord1.xxx + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = unity_WorldToLight[2].xyz * in_f.texcoord1.zzz + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = u_xlat1_d.xyz + unity_WorldToLight[3].xyz;
          
          u_xlat10_d = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          
          u_xlat10_d = texture(_LightTexture0, float2(u_xlat10_d)).x;
          
          u_xlat16_3.xzw = float3(u_xlat10_d) * _LightColor0.xyz;
          
          u_xlat16_4.xyz = float3(u_xlat5) * u_xlat16_3.xzw;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat16_3.xzw;
          
          u_xlat16_3.x = u_xlat16_8 * u_xlat16_8;
          
          u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
          
          u_xlat16_3.x = u_xlat16_8 * u_xlat16_3.x;
          
          u_xlat16_3.x = u_xlat16_3.x * 0.959999979 + 0.0399999991;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * u_xlat16_3.xxx;
          
          u_xlat0_d.xyz = u_xlat16_4.xyz * float3(0.959999979, 0.959999979, 0.959999979) + u_xlat0_d.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: DEFERRED
    {
      Name "DEFERRED"
      Tags
      { 
        "LIGHTMODE" = "DEFERRED"
        "RenderType" = "Opaque"
      }
      LOD 200
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
          
          float4 color1 : SV_Target1;
          
          float4 color2 : SV_Target2;
          
          float4 color3 : SV_Target3;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          out_v.texcoord1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color = float4(0.959999979, 0.959999979, 0.959999979, 1.0);
          
          out_f.color1 = float4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
          
          u_xlat0_d.xyz = in_f.texcoord.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
          
          u_xlat0_d.w = 1.0;
          
          out_f.color2 = u_xlat0_d;
          
          out_f.color3 = float4(1.0, 1.0, 1.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
