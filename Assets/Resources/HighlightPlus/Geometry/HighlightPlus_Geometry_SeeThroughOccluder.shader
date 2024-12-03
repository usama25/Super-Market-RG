// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "HighlightPlus/Geometry/SeeThroughOccluder"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
    _Color ("Color", Vector) = (1,1,1,1)
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
      
      uniform float4 _MainTex_ST;
      
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
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      uniform samplerCUBE unity_SpecCube0;
      
      uniform samplerCUBE unity_SpecCube1;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 texcoord6 : TEXCOORD6;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
      
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
          
          out_v.texcoord2.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord1.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord5 = float4(0.0, 0.0, 0.0, 0.0);
          
          out_v.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float3 u_xlat2;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat4;
      
      float4 u_xlat16_4;
      
      float3 u_xlat5;
      
      float4 u_xlat16_5;
      
      float3 u_xlat6_d;
      
      float3 u_xlat7;
      
      bool3 u_xlatb7;
      
      float3 u_xlat8;
      
      float3 u_xlat16_8;
      
      bool3 u_xlatb9;
      
      float u_xlat16_10;
      
      float3 u_xlat11;
      
      float3 u_xlat16_21;
      
      float u_xlat22;
      
      float u_xlat33;
      
      float u_xlat34;
      
      int u_xlatb34;
      
      float u_xlat16_36;
      
      float u_xlat16_41;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xyz = (-in_f.texcoord2.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat33 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat33 = inversesqrt(u_xlat33);
          
          u_xlat1_d.xyz = float3(u_xlat33) * u_xlat0_d.xyz;
          
          u_xlat16_2.xyz = texture(_MainTex, in_f.texcoord.xy).xyz;
          
          u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz;
          
          u_xlat16_3.x = dot((-u_xlat1_d.xyz), in_f.texcoord1.xyz);
          
          u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
          
          u_xlat16_3.xyz = in_f.texcoord1.xyz * (-u_xlat16_3.xxx) + (-u_xlat1_d.xyz);
          
          u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
          
          if(u_xlatb34)
      {
              
              u_xlat34 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
              
              u_xlat34 = inversesqrt(u_xlat34);
              
              u_xlat4.xyz = float3(u_xlat34) * u_xlat16_3.xyz;
              
              u_xlat5.xyz = (-in_f.texcoord2.xyz) + unity_SpecCube0_BoxMax.xyz;
              
              u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
              
              u_xlat6_d.xyz = (-in_f.texcoord2.xyz) + unity_SpecCube0_BoxMin.xyz;
              
              u_xlat6_d.xyz = u_xlat6_d.xyz / u_xlat4.xyz;
              
              u_xlatb7.xyz = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
              
              
                  {
                  
                  float3 hlslcc_movcTemp = u_xlat5;
                  
                  hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6_d.x;
                  
                  hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6_d.y;
                  
                  hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6_d.z;
                  
                  u_xlat5 = hlslcc_movcTemp;
      
      }
              
              u_xlat34 = min(u_xlat5.y, u_xlat5.x);
              
              u_xlat34 = min(u_xlat5.z, u_xlat34);
              
              u_xlat5.xyz = in_f.texcoord2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
              
              u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat34) + u_xlat5.xyz;
      
      }
          else
          
              {
              
              u_xlat4.xyz = u_xlat16_3.xyz;
      
      }
          
          u_xlat16_4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
          
          u_xlat16_36 = u_xlat16_4.w + -1.0;
          
          u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
          
          u_xlat16_36 = log2(u_xlat16_36);
          
          u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.y;
          
          u_xlat16_36 = exp2(u_xlat16_36);
          
          u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
          
          u_xlat16_8.xyz = u_xlat16_4.xyz * float3(u_xlat16_36);
          
          u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
          
          if(u_xlatb34)
      {
              
              u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
              
              if(u_xlatb34)
      {
                  
                  u_xlat34 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
                  
                  u_xlat34 = inversesqrt(u_xlat34);
                  
                  u_xlat5.xyz = float3(u_xlat34) * u_xlat16_3.xyz;
                  
                  u_xlat6_d.xyz = (-in_f.texcoord2.xyz) + unity_SpecCube1_BoxMax.xyz;
                  
                  u_xlat6_d.xyz = u_xlat6_d.xyz / u_xlat5.xyz;
                  
                  u_xlat7.xyz = (-in_f.texcoord2.xyz) + unity_SpecCube1_BoxMin.xyz;
                  
                  u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
                  
                  u_xlatb9.xyz = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
                  
                  
                      {
                      
                      float3 hlslcc_movcTemp = u_xlat6_d;
                      
                      hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat6_d.x : u_xlat7.x;
                      
                      hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat6_d.y : u_xlat7.y;
                      
                      hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat6_d.z : u_xlat7.z;
                      
                      u_xlat6_d = hlslcc_movcTemp;
      
      }
                  
                  u_xlat34 = min(u_xlat6_d.y, u_xlat6_d.x);
                  
                  u_xlat34 = min(u_xlat6_d.z, u_xlat34);
                  
                  u_xlat6_d.xyz = in_f.texcoord2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                  
                  u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat34) + u_xlat6_d.xyz;
      
      }
              else
              
                  {
                  
                  u_xlat5.xyz = u_xlat16_3.xyz;
      
      }
              
              u_xlat16_5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
              
              u_xlat16_3.x = u_xlat16_5.w + -1.0;
              
              u_xlat16_3.x = unity_SpecCube1_HDR.w * u_xlat16_3.x + 1.0;
              
              u_xlat16_3.x = log2(u_xlat16_3.x);
              
              u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube1_HDR.y;
              
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              
              u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube1_HDR.x;
              
              u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xxx;
              
              u_xlat4.xyz = float3(u_xlat16_36) * u_xlat16_4.xyz + (-u_xlat16_3.xyz);
              
              u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat16_3.xyz;
              
              u_xlat16_8.xyz = u_xlat8.xyz;
      
      }
          
          u_xlat34 = dot(in_f.texcoord1.xyz, in_f.texcoord1.xyz);
          
          u_xlat34 = inversesqrt(u_xlat34);
          
          u_xlat4.xyz = float3(u_xlat34) * in_f.texcoord1.xyz;
          
          u_xlat16_3.xyz = u_xlat2.xyz * float3(0.959999979, 0.959999979, 0.959999979);
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(u_xlat33) + _WorldSpaceLightPos0.xyz;
          
          u_xlat33 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat33 = max(u_xlat33, 0.00100000005);
          
          u_xlat33 = inversesqrt(u_xlat33);
          
          u_xlat0_d.xyz = float3(u_xlat33) * u_xlat0_d.xyz;
          
          u_xlat33 = dot(u_xlat4.xyz, u_xlat1_d.xyz);
          
          u_xlat1_d.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
          
          u_xlat1_d.x = clamp(u_xlat1_d.x, 0.0, 1.0);
          
          u_xlat0_d.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0_d.xyz);
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat16_36 = u_xlat0_d.x + u_xlat0_d.x;
          
          u_xlat16_36 = u_xlat16_36 * u_xlat0_d.x + -0.5;
          
          u_xlat16_41 = (-u_xlat1_d.x) + 1.0;
          
          u_xlat16_10 = u_xlat16_41 * u_xlat16_41;
          
          u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
          
          u_xlat16_41 = u_xlat16_41 * u_xlat16_10;
          
          u_xlat16_41 = u_xlat16_36 * u_xlat16_41 + 1.0;
          
          u_xlat16_10 = -abs(u_xlat33) + 1.0;
          
          u_xlat16_21.x = u_xlat16_10 * u_xlat16_10;
          
          u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
          
          u_xlat16_10 = u_xlat16_10 * u_xlat16_21.x;
          
          u_xlat16_36 = u_xlat16_36 * u_xlat16_10 + 1.0;
          
          u_xlat16_36 = u_xlat16_36 * u_xlat16_41;
          
          u_xlat11.x = u_xlat1_d.x * u_xlat16_36;
          
          u_xlat22 = abs(u_xlat33) + u_xlat1_d.x;
          
          u_xlat22 = u_xlat22 + 9.99999975e-06;
          
          u_xlat22 = 0.5 / u_xlat22;
          
          u_xlat22 = u_xlat1_d.x * u_xlat22;
          
          u_xlat22 = u_xlat22 * 0.999999881;
          
          u_xlat16_21.xyz = u_xlat11.xxx * _LightColor0.xyz;
          
          u_xlat11.xyz = float3(u_xlat22) * _LightColor0.xyz;
          
          u_xlat16_36 = (-u_xlat0_d.x) + 1.0;
          
          u_xlat16_41 = u_xlat16_36 * u_xlat16_36;
          
          u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
          
          u_xlat16_36 = u_xlat16_36 * u_xlat16_41;
          
          u_xlat16_36 = u_xlat16_36 * 0.959999979 + 0.0399999991;
          
          u_xlat0_d.xyz = u_xlat11.xyz * float3(u_xlat16_36);
          
          u_xlat0_d.xyz = u_xlat16_3.xyz * u_xlat16_21.xyz + u_xlat0_d.xyz;
          
          u_xlat16_3.xyz = u_xlat16_8.xyz * float3(0.5, 0.5, 0.5);
          
          u_xlat16_36 = u_xlat16_10 * 2.23517418e-08 + 0.0399999991;
          
          u_xlat0_d.xyz = u_xlat16_3.xyz * float3(u_xlat16_36) + u_xlat0_d.xyz;
          
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
      
      uniform float4 _MainTex_ST;
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightColor0;
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _LightTexture0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat10 = inversesqrt(u_xlat10);
          
          out_v.texcoord1.xyz = float3(u_xlat10) * u_xlat1.xyz;
          
          out_v.texcoord2.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = unity_ObjectToWorld[3] * in_v.vertex.wwww + u_xlat0;
          
          u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
          
          u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          out_v.texcoord3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
          
          out_v.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float3 u_xlat16_1;
      
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
          
          u_xlat0_d.xyz = (-in_f.texcoord2.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat15 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat0_d.xyz = float3(u_xlat15) * u_xlat0_d.xyz;
          
          u_xlat1_d.xyz = (-in_f.texcoord2.xyz) + _WorldSpaceLightPos0.xyz;
          
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
          
          u_xlat15 = dot(in_f.texcoord1.xyz, in_f.texcoord1.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat2_d.xyz = float3(u_xlat15) * in_f.texcoord1.xyz;
          
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
          
          u_xlat1_d.xyz = in_f.texcoord2.yyy * unity_WorldToLight[1].xyz;
          
          u_xlat1_d.xyz = unity_WorldToLight[0].xyz * in_f.texcoord2.xxx + u_xlat1_d.xyz;
          
          u_xlat1_d.xyz = unity_WorldToLight[2].xyz * in_f.texcoord2.zzz + u_xlat1_d.xyz;
          
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
          
          u_xlat16_1.xyz = texture(_MainTex, in_f.texcoord.xy).xyz;
          
          u_xlat1_d.xyz = u_xlat16_1.xyz * _Color.xyz;
          
          u_xlat16_3.xyz = u_xlat1_d.xyz * float3(0.959999979, 0.959999979, 0.959999979);
          
          u_xlat0_d.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat0_d.xyz;
          
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
      
      uniform float4 _MainTex_ST;
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
      
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
          
          out_v.texcoord2.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord1.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_MainTex, in_f.texcoord.xy).xyz;
          
          u_xlat0_d.xyz = u_xlat16_0.xyz * _Color.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz * float3(0.959999979, 0.959999979, 0.959999979);
          
          out_f.color.w = 1.0;
          
          out_f.color1 = float4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
          
          u_xlat0_d.xyz = in_f.texcoord1.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
          
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
