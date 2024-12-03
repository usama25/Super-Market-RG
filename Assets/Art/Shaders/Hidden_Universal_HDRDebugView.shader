Shader "Hidden/Universal/HDRDebugView"
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
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      ZClip Off
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
      
      uniform int _HDRColorspace;
      
      uniform float4 _HDRDebugParams;
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      writeonly layout(binding=1, r32f) uniform image2D _xyBufferRW;
      
      float4 u_xlat0_d;
      
      uint4 u_xlatu0_d;
      
      bool2 u_xlatb0;
      
      float4 u_xlat16_1;
      
      float3 u_xlat2;
      
      float3 u_xlat3;
      
      float3 u_xlat4;
      
      float u_xlat8;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0.xy = equal(int4(_HDRColorspace), int4(1, 2, 0, 0)).xy;
          
          u_xlat16_1 = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat2.x = dot(float3(0.486571014, 0.265668005, 0.198217005), u_xlat16_1.xyz);
          
          u_xlat2.y = dot(float3(0.228974998, 0.691739023, 0.079287), u_xlat16_1.xyz);
          
          u_xlat2.z = dot(float2(0.045113001, 1.043944), u_xlat16_1.yz);
          
          u_xlat3.x = dot(float3(0.412391007, 0.357584, 0.180481002), u_xlat16_1.xyz);
          
          u_xlat3.y = dot(float3(0.212639004, 0.715169013, 0.0721922964), u_xlat16_1.xyz);
          
          u_xlat3.z = dot(float3(0.0193307996, 0.119194999, 0.950532019), u_xlat16_1.xyz);
          
          u_xlat4.xyz = (u_xlatb0.y) ? u_xlat2.xyz : u_xlat3.xyz;
          
          u_xlat2.x = dot(float3(0.638574004, 0.144617006, 0.167264998), u_xlat16_1.xyz);
          
          u_xlat2.y = dot(float3(0.263366997, 0.677998006, 0.0586352982), u_xlat16_1.xyz);
          
          u_xlat2.z = dot(float2(0.0280726999, 1.06098998), u_xlat16_1.yz);
          
          out_f.color = u_xlat16_1;
          
          u_xlat0_d.xyz = (u_xlatb0.x) ? u_xlat2.xyz : u_xlat4.xyz;
          
          u_xlat8 = dot(u_xlat0_d.xyz, float3(1.0, 1.0, 1.0));
          
          u_xlat0_d = u_xlat0_d.xyyy / float4(u_xlat8);
          
          u_xlat0_d = u_xlat0_d * _HDRDebugParams.xyyy;
          
          u_xlatu0_d = uint4(u_xlat0_d);
          
          imageStore(_xyBufferRW, int2(u_xlatu0_d.xy), float4(1.0, 1.0, 1.0, 1.0));
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      ZClip Off
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
      
      uniform float4 _ScreenSize;
      
      uniform int _HDRColorspace;
      
      uniform int _DebugHDRMode;
      
      uniform float4 _HDROutputLuminanceParams;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _xyBuffer;
      
      
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat16_0;
      
      float3 u_xlat1;
      
      float3 u_xlat16_1;
      
      int u_xlati1;
      
      int u_xlatb1;
      
      float4 u_xlat2;
      
      bool2 u_xlatb2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_3;
      
      int u_xlatb3;
      
      float4 u_xlat4;
      
      int u_xlatb4;
      
      float3 u_xlat5;
      
      bool4 u_xlatb5;
      
      float4 u_xlat6;
      
      bool3 u_xlatb6;
      
      float3 u_xlat7;
      
      float3 u_xlat8;
      
      float3 u_xlat9;
      
      float u_xlat16_10;
      
      float u_xlat16_11;
      
      float2 u_xlat13;
      
      float3 u_xlat15;
      
      int u_xlatb15;
      
      float3 u_xlat16;
      
      bool2 u_xlatb16;
      
      float u_xlat17;
      
      float u_xlat18;
      
      float2 u_xlat25;
      
      float2 u_xlat26;
      
      bool2 u_xlatb26;
      
      float u_xlat27;
      
      float u_xlat28;
      
      bool2 u_xlatb28;
      
      float u_xlat29;
      
      int u_xlatb36;
      
      float u_xlat37;
      
      float u_xlat38;
      
      int u_xlatb38;
      
      int u_xlatb39;
      
      float u_xlat40;
      
      int u_xlatb40;
      
      float u_xlat41;
      
      int u_xlatb41;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb36 = _DebugHDRMode!=3;
          
          if(u_xlatb36)
      {
              
              u_xlatb36 = _DebugHDRMode==2;
              
              u_xlati1 = u_xlatb36 ? 1 : int(0);
              
              u_xlat13.x = _ScreenSize.x * 0.333333343;
              
              u_xlat25.xy = in_f.texcoord.xy * _ScreenSize.xy;
              
              u_xlatb2.xy = equal(int4(_HDRColorspace), int4(1, 2, 0, 0)).xy;
              
              if(u_xlati1 != 0)
      {
                  
                  u_xlat3.x = dot(float3(0.638574004, 0.144617006, 0.167264998), u_xlat16_0.xyz);
                  
                  u_xlat3.y = dot(float3(0.263366997, 0.677998006, 0.0586352982), u_xlat16_0.xyz);
                  
                  u_xlat3.z = dot(float2(0.0280726999, 1.06098998), u_xlat16_0.yz);
                  
                  u_xlat4.x = dot(float3(0.486571014, 0.265668005, 0.198217005), u_xlat16_0.xyz);
                  
                  u_xlat4.y = dot(float3(0.228974998, 0.691739023, 0.079287), u_xlat16_0.xyz);
                  
                  u_xlat4.z = dot(float2(0.045113001, 1.043944), u_xlat16_0.yz);
                  
                  u_xlat5.x = dot(float3(0.412391007, 0.357584, 0.180481002), u_xlat16_0.xyz);
                  
                  u_xlat5.y = dot(float3(0.212639004, 0.715169013, 0.0721922964), u_xlat16_0.xyz);
                  
                  u_xlat5.z = dot(float3(0.0193307996, 0.119194999, 0.950532019), u_xlat16_0.xyz);
                  
                  u_xlat4.xyz = (u_xlatb2.y) ? u_xlat4.xyz : u_xlat5.xyz;
                  
                  u_xlat3.xyz = (u_xlatb2.x) ? u_xlat3.xyz : u_xlat4.xyz;
                  
                  u_xlat26.x = dot(u_xlat3.xyz, float3(1.0, 1.0, 1.0));
                  
                  u_xlat26.xy = u_xlat3.xy / u_xlat26.xx;
                  
                  u_xlat3.xy = u_xlat26.xy + float2(-0.639999986, -0.330000013);
                  
                  u_xlat3.z = dot(u_xlat3.xy, float2(-0.339999974, 0.270000011));
                  
                  u_xlat3.x = dot(u_xlat3.xy, float2(-0.48999998, -0.270000011));
                  
                  u_xlat15.xz = u_xlat3.zx * float2(0.0936999768, 0.0936999768);
                  
                  u_xlat27 = u_xlat3.z * 0.312999994 + (-u_xlat15.z);
                  
                  u_xlat3.x = u_xlat3.x * 0.188499987 + (-u_xlat15.x);
                  
                  u_xlat15.x = (-u_xlat27) * 19.9120636 + 1.0;
                  
                  u_xlat3.x = (-u_xlat3.x) * 19.9120636 + u_xlat15.x;
                  
                  u_xlatb15 = u_xlat3.x>=0.0;
                  
                  u_xlatb39 = 1.0>=u_xlat3.x;
                  
                  u_xlatb15 = u_xlatb39 && u_xlatb15;
                  
                  u_xlatb39 = u_xlat27>=0.0;
                  
                  u_xlatb15 = u_xlatb39 && u_xlatb15;
                  
                  u_xlatb39 = 0.0502208099>=u_xlat27;
                  
                  u_xlatb15 = u_xlatb39 && u_xlatb15;
                  
                  u_xlat3.x = u_xlat27 * 19.9120636 + u_xlat3.x;
                  
                  u_xlatb3 = 1.0>=u_xlat3.x;
                  
                  u_xlatb3 = u_xlatb3 && u_xlatb15;
                  
                  if(u_xlatb3)
      {
                      
                      u_xlat3.x = float(0.0);
                      
                      u_xlat3.z = float(0.0);
                      
                      u_xlat3.y = _HDROutputLuminanceParams.z;
                      
                      u_xlat3.xyz = u_xlat3.xyz * float3(0.200000003, 0.200000003, 0.200000003);
                      
                      u_xlat3.xyz = u_xlat16_0.xyz * float3(0.800000012, 0.800000012, 0.800000012) + u_xlat3.xyz;
                      
                      u_xlat16_3.xyz = u_xlat3.xyz;
      
      }
                  else
                  
                      {
                      
                      u_xlat4.xy = u_xlat26.xy + float2(-0.680000007, -0.319999993);
                      
                      u_xlat4.z = dot(u_xlat4.xy, float2(-0.415000021, 0.370000005));
                      
                      u_xlat4.x = dot(u_xlat4.xy, float2(-0.529999971, -0.25999999));
                      
                      u_xlat16.xz = u_xlat4.zx * float2(0.123750001, 0.123750001);
                      
                      u_xlat28 = u_xlat4.z * 0.348499954 + (-u_xlat16.z);
                      
                      u_xlat4.x = u_xlat4.x * 0.309125036 + (-u_xlat16.x);
                      
                      u_xlat16.x = (-u_xlat28) * 10.8206377 + 1.0;
                      
                      u_xlat4.x = (-u_xlat4.x) * 10.8206377 + u_xlat16.x;
                      
                      u_xlatb16.x = u_xlat4.x>=0.0;
                      
                      u_xlatb40 = 1.0>=u_xlat4.x;
                      
                      u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                      
                      u_xlatb40 = u_xlat28>=0.0;
                      
                      u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                      
                      u_xlatb40 = 0.0924159959>=u_xlat28;
                      
                      u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                      
                      u_xlat4.x = u_xlat28 * 10.8206377 + u_xlat4.x;
                      
                      u_xlatb4 = 1.0>=u_xlat4.x;
                      
                      u_xlatb4 = u_xlatb4 && u_xlatb16.x;
                      
                      if(u_xlatb4)
      {
                          
                          u_xlat4.x = float(0.0);
                          
                          u_xlat4.y = float(0.0);
                          
                          u_xlat4.z = _HDROutputLuminanceParams.z;
                          
                          u_xlat4.xyz = u_xlat4.xyz * float3(0.200000003, 0.200000003, 0.200000003);
                          
                          u_xlat3.xyz = u_xlat16_0.xyz * float3(0.800000012, 0.800000012, 0.800000012) + u_xlat4.xyz;
                          
                          u_xlat16_3.xyz = u_xlat3.xyz;
      
      }
                      else
                      
                          {
                          
                          u_xlat26.xy = u_xlat26.xy + float2(-0.708000004, -0.291999996);
                          
                          u_xlat4.x = dot(u_xlat26.xy, float2(-0.537999988, 0.504999995));
                          
                          u_xlat26.x = dot(u_xlat26.xy, float2(-0.577000022, -0.245999992));
                          
                          u_xlat38 = u_xlat4.x * 0.186196014;
                          
                          u_xlat16.x = u_xlat26.x * 0.186196014;
                          
                          u_xlat4.x = u_xlat4.x * 0.393445015 + (-u_xlat16.x);
                          
                          u_xlat26.x = u_xlat26.x * 0.544468999 + (-u_xlat38);
                          
                          u_xlat38 = (-u_xlat4.x) * 5.56948948 + 1.0;
                          
                          u_xlat26.x = (-u_xlat26.x) * 5.56948948 + u_xlat38;
                          
                          u_xlatb38 = u_xlat26.x>=0.0;
                          
                          u_xlatb16.x = 1.0>=u_xlat26.x;
                          
                          u_xlatb38 = u_xlatb38 && u_xlatb16.x;
                          
                          u_xlatb16.x = u_xlat4.x>=0.0;
                          
                          u_xlatb38 = u_xlatb38 && u_xlatb16.x;
                          
                          u_xlatb16.x = 0.179549664>=u_xlat4.x;
                          
                          u_xlatb38 = u_xlatb38 && u_xlatb16.x;
                          
                          u_xlat26.x = u_xlat4.x * 5.56948948 + u_xlat26.x;
                          
                          u_xlatb26.x = 1.0>=u_xlat26.x;
                          
                          u_xlatb26.x = u_xlatb26.x && u_xlatb38;
                          
                          u_xlat4.x = _HDROutputLuminanceParams.z;
                          
                          u_xlat4.y = float(0.200000003);
                          
                          u_xlat4.z = float(0.200000003);
                          
                          u_xlat4.xyz = u_xlat4.xyz * float3(0.200000003, 0.0, 0.0);
                          
                          u_xlat4.xyz = u_xlat16_0.xyz * float3(0.800000012, 0.800000012, 0.800000012) + u_xlat4.xyz;
                          
                          u_xlat16_3.xyz = (u_xlatb26.x) ? u_xlat4.xyz : u_xlat16_0.xyz;
      
      }
      
      }
      
      }
              else
              
                  {
                  
                  u_xlat16_3.xyz = u_xlat16_0.xyz;
      
      }
              
              u_xlat13.x = trunc(u_xlat13.x);
              
              u_xlatb26.xy = lessThan(u_xlat25.xyxy, u_xlat13.xxxx).xy;
              
              u_xlatb26.x = u_xlatb26.y && u_xlatb26.x;
              
              if(u_xlatb26.x)
      {
                  
                  u_xlat13.xy = u_xlat25.xy / u_xlat13.xx;
                  
                  u_xlat4 = (-u_xlat13.xyxy) + float4(0.300000012, 0.600000024, 0.150000006, 0.0599999987);
                  
                  u_xlat37 = dot(u_xlat4.xy, u_xlat4.xy);
                  
                  u_xlat37 = sqrt(u_xlat37);
                  
                  u_xlat4.x = dot(u_xlat4.zw, u_xlat4.zw);
                  
                  u_xlat4.x = sqrt(u_xlat4.x);
                  
                  u_xlatb16.xy = greaterThanEqual(float4(u_xlat37), float4(0.560446262, 0.434165865, 0.0, 0.0)).xy;
                  
                  u_xlatb5 = greaterThanEqual(u_xlat4.xxxx, float4(0.560446262, 0.559464037, 0.640410006, 0.590338826));
                  
                  u_xlatb16.x = u_xlatb16.x || u_xlatb5.x;
                  
                  u_xlat40 = u_xlat37 + u_xlat4.x;
                  
                  u_xlat40 = u_xlat40 + 0.560446262;
                  
                  u_xlat5.x = u_xlat40 * 0.5;
                  
                  u_xlat6.x = u_xlat40 * 0.5 + (-u_xlat37);
                  
                  u_xlat5.x = u_xlat5.x * u_xlat6.x;
                  
                  u_xlat6.x = u_xlat40 * 0.5 + (-u_xlat4.x);
                  
                  u_xlat5.x = u_xlat5.x * u_xlat6.x;
                  
                  u_xlat40 = u_xlat40 * 0.5 + -0.560446262;
                  
                  u_xlat40 = u_xlat40 * u_xlat5.x;
                  
                  u_xlat40 = sqrt(u_xlat40);
                  
                  u_xlat40 = u_xlat40 * 3.56858468 + -0.00100000005;
                  
                  u_xlat40 = u_xlat40 * 500.000031;
                  
                  u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
                  
                  u_xlat5.x = u_xlat40 * -2.0 + 3.0;
                  
                  u_xlat40 = u_xlat40 * u_xlat40;
                  
                  u_xlat40 = (-u_xlat5.x) * u_xlat40 + 1.0;
                  
                  u_xlat16.x = (u_xlatb16.x) ? 0.0 : u_xlat40;
                  
                  u_xlat6 = (-u_xlat13.xyxy) + float4(0.639999986, 0.330000013, 0.170000002, 0.796999991);
                  
                  u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                  
                  u_xlat40 = sqrt(u_xlat40);
                  
                  u_xlatb6.xy = greaterThanEqual(float4(u_xlat40), float4(0.559464037, 0.434165865, 0.0, 0.0)).xy;
                  
                  u_xlatb5.x = u_xlatb5.y || u_xlatb6.x;
                  
                  u_xlat17 = u_xlat40 + u_xlat4.x;
                  
                  u_xlat17 = u_xlat17 + 0.559464037;
                  
                  u_xlat6.x = u_xlat17 * 0.5;
                  
                  u_xlat7.x = u_xlat17 * 0.5 + (-u_xlat4.x);
                  
                  u_xlat6.x = u_xlat6.x * u_xlat7.x;
                  
                  u_xlat7.x = u_xlat17 * 0.5 + (-u_xlat40);
                  
                  u_xlat6.x = u_xlat6.x * u_xlat7.x;
                  
                  u_xlat17 = u_xlat17 * 0.5 + -0.559464037;
                  
                  u_xlat17 = u_xlat17 * u_xlat6.x;
                  
                  u_xlat17 = sqrt(u_xlat17);
                  
                  u_xlat17 = u_xlat17 * 3.57485008 + -0.00100000005;
                  
                  u_xlat17 = u_xlat17 * 500.000031;
                  
                  u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
                  
                  u_xlat6.x = u_xlat17 * -2.0 + 3.0;
                  
                  u_xlat17 = u_xlat17 * u_xlat17;
                  
                  u_xlat17 = (-u_xlat6.x) * u_xlat17 + 1.0;
                  
                  u_xlat5.x = (u_xlatb5.x) ? 0.0 : u_xlat17;
                  
                  u_xlat16.x = u_xlat16.x + u_xlat5.x;
                  
                  u_xlatb28.x = u_xlatb16.y || u_xlatb6.y;
                  
                  u_xlat5.x = u_xlat37 + u_xlat40;
                  
                  u_xlat5.x = u_xlat5.x + 0.434165865;
                  
                  u_xlat17 = u_xlat5.x * 0.5;
                  
                  u_xlat40 = u_xlat5.x * 0.5 + (-u_xlat40);
                  
                  u_xlat40 = u_xlat40 * u_xlat17;
                  
                  u_xlat37 = u_xlat5.x * 0.5 + (-u_xlat37);
                  
                  u_xlat37 = u_xlat37 * u_xlat40;
                  
                  u_xlat40 = u_xlat5.x * 0.5 + -0.434165865;
                  
                  u_xlat37 = u_xlat37 * u_xlat40;
                  
                  u_xlat37 = sqrt(u_xlat37);
                  
                  u_xlat37 = u_xlat37 * 4.60653448 + -0.00100000005;
                  
                  u_xlat37 = u_xlat37 * 500.000031;
                  
                  u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
                  
                  u_xlat40 = u_xlat37 * -2.0 + 3.0;
                  
                  u_xlat37 = u_xlat37 * u_xlat37;
                  
                  u_xlat37 = (-u_xlat40) * u_xlat37 + 1.0;
                  
                  u_xlat37 = (u_xlatb28.x) ? 0.0 : u_xlat37;
                  
                  u_xlat37 = u_xlat37 + u_xlat16.x;
                  
                  u_xlat16.x = dot(u_xlat6.zw, u_xlat6.zw);
                  
                  u_xlat6 = (-u_xlat13.xyxy) + float4(0.130999997, 0.0460000001, 0.708000004, 0.291999996);
                  
                  u_xlat16.y = dot(u_xlat6.xy, u_xlat6.xy);
                  
                  u_xlat16.xy = sqrt(u_xlat16.xy);
                  
                  u_xlatb5.xy = greaterThanEqual(u_xlat16.xxxx, float4(0.752011955, 0.737881422, 0.0, 0.0)).xy;
                  
                  u_xlatb6.xy = greaterThanEqual(u_xlat16.yyyy, float4(0.752011955, 0.627251983, 0.0, 0.0)).xy;
                  
                  u_xlatb40 = u_xlatb5.x || u_xlatb6.x;
                  
                  u_xlat5.x = u_xlat16.y + u_xlat16.x;
                  
                  u_xlat5.x = u_xlat5.x + 0.752011955;
                  
                  u_xlat6.x = u_xlat5.x * 0.5;
                  
                  u_xlat7.x = u_xlat5.x * 0.5 + (-u_xlat16.x);
                  
                  u_xlat6.x = u_xlat6.x * u_xlat7.x;
                  
                  u_xlat7.x = u_xlat5.x * 0.5 + (-u_xlat16.y);
                  
                  u_xlat6.x = u_xlat6.x * u_xlat7.x;
                  
                  u_xlat5.x = u_xlat5.x * 0.5 + -0.752011955;
                  
                  u_xlat5.x = u_xlat5.x * u_xlat6.x;
                  
                  u_xlat5.x = sqrt(u_xlat5.x);
                  
                  u_xlat5.x = u_xlat5.x * 2.65953207 + -0.00100000005;
                  
                  u_xlat5.x = u_xlat5.x * 500.000031;
                  
                  u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
                  
                  u_xlat6.x = u_xlat5.x * -2.0 + 3.0;
                  
                  u_xlat5.x = u_xlat5.x * u_xlat5.x;
                  
                  u_xlat5.x = (-u_xlat6.x) * u_xlat5.x + 1.0;
                  
                  u_xlat40 = (u_xlatb40) ? 0.0 : u_xlat5.x;
                  
                  u_xlat37 = u_xlat37 + u_xlat40;
                  
                  u_xlat40 = dot(u_xlat6.zw, u_xlat6.zw);
                  
                  u_xlat40 = sqrt(u_xlat40);
                  
                  u_xlatb6.xz = greaterThanEqual(float4(u_xlat40), float4(0.627251983, 0.0, 0.737881422, 0.0)).xz;
                  
                  u_xlatb5.x = u_xlatb6.x || u_xlatb6.y;
                  
                  u_xlat6.x = u_xlat40 + u_xlat16.y;
                  
                  u_xlat6.x = u_xlat6.x + 0.627251983;
                  
                  u_xlat18 = u_xlat6.x * 0.5;
                  
                  u_xlat28 = u_xlat6.x * 0.5 + (-u_xlat16.y);
                  
                  u_xlat28 = u_xlat28 * u_xlat18;
                  
                  u_xlat18 = u_xlat6.x * 0.5 + (-u_xlat40);
                  
                  u_xlat28 = u_xlat28 * u_xlat18;
                  
                  u_xlat6.x = u_xlat6.x * 0.5 + -0.627251983;
                  
                  u_xlat28 = u_xlat28 * u_xlat6.x;
                  
                  u_xlat28 = sqrt(u_xlat28);
                  
                  u_xlat28 = u_xlat28 * 3.18851113 + -0.00100000005;
                  
                  u_xlat28 = u_xlat28 * 500.000031;
                  
                  u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
                  
                  u_xlat6.x = u_xlat28 * -2.0 + 3.0;
                  
                  u_xlat28 = u_xlat28 * u_xlat28;
                  
                  u_xlat28 = (-u_xlat6.x) * u_xlat28 + 1.0;
                  
                  u_xlat28 = (u_xlatb5.x) ? 0.0 : u_xlat28;
                  
                  u_xlat37 = u_xlat37 + u_xlat28;
                  
                  u_xlatb28.x = u_xlatb5.y || u_xlatb6.z;
                  
                  u_xlat5.x = u_xlat16.x + u_xlat40;
                  
                  u_xlat5.x = u_xlat5.x + 0.737881422;
                  
                  u_xlat17 = u_xlat5.x * 0.5;
                  
                  u_xlat40 = u_xlat5.x * 0.5 + (-u_xlat40);
                  
                  u_xlat40 = u_xlat40 * u_xlat17;
                  
                  u_xlat16.x = u_xlat5.x * 0.5 + (-u_xlat16.x);
                  
                  u_xlat16.x = u_xlat16.x * u_xlat40;
                  
                  u_xlat40 = u_xlat5.x * 0.5 + -0.737881422;
                  
                  u_xlat16.x = u_xlat40 * u_xlat16.x;
                  
                  u_xlat16.x = sqrt(u_xlat16.x);
                  
                  u_xlat16.x = u_xlat16.x * 2.71046257 + -0.00100000005;
                  
                  u_xlat16.x = u_xlat16.x * 500.000031;
                  
                  u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
                  
                  u_xlat40 = u_xlat16.x * -2.0 + 3.0;
                  
                  u_xlat16.x = u_xlat16.x * u_xlat16.x;
                  
                  u_xlat16.x = (-u_xlat40) * u_xlat16.x + 1.0;
                  
                  u_xlat16.x = (u_xlatb28.x) ? 0.0 : u_xlat16.x;
                  
                  u_xlat37 = u_xlat37 + u_xlat16.x;
                  
                  u_xlat6 = (-u_xlat13.xyxy) + float4(0.264999986, 0.689999998, 0.680000007, 0.319999993);
                  
                  u_xlat16.x = dot(u_xlat6.xy, u_xlat6.xy);
                  
                  u_xlat16.x = sqrt(u_xlat16.x);
                  
                  u_xlatb28.xy = greaterThanEqual(u_xlat16.xxxx, float4(0.640410006, 0.55599016, 0.640410006, 0.55599016)).xy;
                  
                  u_xlatb28.x = u_xlatb5.z || u_xlatb28.x;
                  
                  u_xlat5.x = u_xlat4.x + u_xlat16.x;
                  
                  u_xlat5.x = u_xlat5.x + 0.640410006;
                  
                  u_xlat17 = u_xlat5.x * 0.5;
                  
                  u_xlat29 = u_xlat5.x * 0.5 + (-u_xlat16.x);
                  
                  u_xlat17 = u_xlat29 * u_xlat17;
                  
                  u_xlat29 = u_xlat5.x * 0.5 + (-u_xlat4.x);
                  
                  u_xlat17 = u_xlat29 * u_xlat17;
                  
                  u_xlat5.x = u_xlat5.x * 0.5 + -0.640410006;
                  
                  u_xlat5.x = u_xlat5.x * u_xlat17;
                  
                  u_xlat5.x = sqrt(u_xlat5.x);
                  
                  u_xlat5.x = u_xlat5.x * 3.12299919 + -0.00100000005;
                  
                  u_xlat5.x = u_xlat5.x * 500.000031;
                  
                  u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
                  
                  u_xlat17 = u_xlat5.x * -2.0 + 3.0;
                  
                  u_xlat5.x = u_xlat5.x * u_xlat5.x;
                  
                  u_xlat5.x = (-u_xlat17) * u_xlat5.x + 1.0;
                  
                  u_xlat28 = (u_xlatb28.x) ? 0.0 : u_xlat5.x;
                  
                  u_xlat37 = u_xlat37 + u_xlat28;
                  
                  u_xlat28 = dot(u_xlat6.zw, u_xlat6.zw);
                  
                  u_xlat28 = sqrt(u_xlat28);
                  
                  u_xlatb5.xy = greaterThanEqual(float4(u_xlat28), float4(0.590338826, 0.55599016, 0.0, 0.0)).xy;
                  
                  u_xlatb5.x = u_xlatb5.x || u_xlatb5.w;
                  
                  u_xlat29 = u_xlat28 + u_xlat4.x;
                  
                  u_xlat29 = u_xlat29 + 0.590338826;
                  
                  u_xlat41 = u_xlat29 * 0.5;
                  
                  u_xlat4.x = u_xlat29 * 0.5 + (-u_xlat4.x);
                  
                  u_xlat4.x = u_xlat4.x * u_xlat41;
                  
                  u_xlat41 = u_xlat29 * 0.5 + (-u_xlat28);
                  
                  u_xlat4.x = u_xlat4.x * u_xlat41;
                  
                  u_xlat29 = u_xlat29 * 0.5 + -0.590338826;
                  
                  u_xlat4.x = u_xlat4.x * u_xlat29;
                  
                  u_xlat4.x = sqrt(u_xlat4.x);
                  
                  u_xlat4.x = u_xlat4.x * 3.38788486 + -0.00100000005;
                  
                  u_xlat4.x = u_xlat4.x * 500.000031;
                  
                  u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
                  
                  u_xlat29 = u_xlat4.x * -2.0 + 3.0;
                  
                  u_xlat4.x = u_xlat4.x * u_xlat4.x;
                  
                  u_xlat4.x = (-u_xlat29) * u_xlat4.x + 1.0;
                  
                  u_xlat4.x = (u_xlatb5.x) ? 0.0 : u_xlat4.x;
                  
                  u_xlat37 = u_xlat37 + u_xlat4.x;
                  
                  u_xlatb4 = u_xlatb28.y || u_xlatb5.y;
                  
                  u_xlat40 = u_xlat16.x + u_xlat28;
                  
                  u_xlat40 = u_xlat40 + 0.55599016;
                  
                  u_xlat5.x = u_xlat40 * 0.5;
                  
                  u_xlat28 = u_xlat40 * 0.5 + (-u_xlat28);
                  
                  u_xlat28 = u_xlat28 * u_xlat5.x;
                  
                  u_xlat16.x = u_xlat40 * 0.5 + (-u_xlat16.x);
                  
                  u_xlat16.x = u_xlat16.x * u_xlat28;
                  
                  u_xlat28 = u_xlat40 * 0.5 + -0.55599016;
                  
                  u_xlat16.x = u_xlat28 * u_xlat16.x;
                  
                  u_xlat16.x = sqrt(u_xlat16.x);
                  
                  u_xlat16.x = u_xlat16.x * 3.59718585 + -0.00100000005;
                  
                  u_xlat16.x = u_xlat16.x * 500.000031;
                  
                  u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
                  
                  u_xlat28 = u_xlat16.x * -2.0 + 3.0;
                  
                  u_xlat16.x = u_xlat16.x * u_xlat16.x;
                  
                  u_xlat16.x = (-u_xlat28) * u_xlat16.x + 1.0;
                  
                  u_xlat4.x = (u_xlatb4) ? 0.0 : u_xlat16.x;
                  
                  u_xlat37 = u_xlat37 + u_xlat4.x;
                  
                  u_xlat4.xy = u_xlat13.xy + float2(-0.708000004, -0.291999996);
                  
                  u_xlat4.z = dot(u_xlat4.xy, float2(-0.537999988, 0.504999995));
                  
                  u_xlat4.x = dot(u_xlat4.xy, float2(-0.577000022, -0.245999992));
                  
                  u_xlat16.xz = u_xlat4.zx * float2(0.186196014, 0.186196014);
                  
                  u_xlat28 = u_xlat4.z * 0.393445015 + (-u_xlat16.z);
                  
                  u_xlat4.x = u_xlat4.x * 0.544468999 + (-u_xlat16.x);
                  
                  u_xlat16.x = (-u_xlat28) * 5.56948948 + 1.0;
                  
                  u_xlat4.x = (-u_xlat4.x) * 5.56948948 + u_xlat16.x;
                  
                  u_xlatb16.x = u_xlat4.x>=0.0;
                  
                  u_xlatb40 = 1.0>=u_xlat4.x;
                  
                  u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                  
                  u_xlatb40 = u_xlat28>=0.0;
                  
                  u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                  
                  u_xlatb40 = 0.179549664>=u_xlat28;
                  
                  u_xlatb16.x = u_xlatb40 && u_xlatb16.x;
                  
                  u_xlat4.x = u_xlat28 * 5.56948948 + u_xlat4.x;
                  
                  u_xlatb4 = 1.0>=u_xlat4.x;
                  
                  u_xlatb4 = u_xlatb4 && u_xlatb16.x;
                  
                  if(u_xlatb4)
      {
                      
                      if(u_xlati1 != 0)
      {
                          
                          u_xlat4.xy = u_xlat13.xy + float2(-0.639999986, -0.330000013);
                          
                          u_xlat1.x = dot(u_xlat4.xy, float2(-0.339999974, 0.270000011));
                          
                          u_xlat4.x = dot(u_xlat4.xy, float2(-0.48999998, -0.270000011));
                          
                          u_xlat16.x = u_xlat1.x * 0.0936999768;
                          
                          u_xlat28 = u_xlat4.x * 0.0936999768;
                          
                          u_xlat1.x = u_xlat1.x * 0.312999994 + (-u_xlat28);
                          
                          u_xlat4.x = u_xlat4.x * 0.188499987 + (-u_xlat16.x);
                          
                          u_xlat16.x = (-u_xlat1.x) * 19.9120636 + 1.0;
                          
                          u_xlat4.x = (-u_xlat4.x) * 19.9120636 + u_xlat16.x;
                          
                          u_xlatb16.x = u_xlat4.x>=0.0;
                          
                          u_xlatb28.x = 1.0>=u_xlat4.x;
                          
                          u_xlatb16.x = u_xlatb28.x && u_xlatb16.x;
                          
                          u_xlatb28.x = u_xlat1.x>=0.0;
                          
                          u_xlatb16.x = u_xlatb28.x && u_xlatb16.x;
                          
                          u_xlatb28.x = 0.0502208099>=u_xlat1.x;
                          
                          u_xlatb16.x = u_xlatb28.x && u_xlatb16.x;
                          
                          u_xlat1.x = u_xlat1.x * 19.9120636 + u_xlat4.x;
                          
                          u_xlatb1 = 1.0>=u_xlat1.x;
                          
                          u_xlatb1 = u_xlatb1 && u_xlatb16.x;
                          
                          if(u_xlatb1)
      {
                              
                              u_xlat4.x = float(0.400000006);
                              
                              u_xlat4.y = float(0.600000024);
                              
                              u_xlat4.z = float(0.400000006);
                              
                              u_xlat5.x = float(0.0);
                              
                              u_xlat5.z = float(0.0);
                              
                              u_xlat5.y = _HDROutputLuminanceParams.z;
      
      }
                          else
                          
                              {
                              
                              u_xlat6.xy = u_xlat13.xy + float2(-0.680000007, -0.319999993);
                              
                              u_xlat1.x = dot(u_xlat6.xy, float2(-0.415000021, 0.370000005));
                              
                              u_xlat40 = dot(u_xlat6.xy, float2(-0.529999971, -0.25999999));
                              
                              u_xlat41 = u_xlat1.x * 0.123750001;
                              
                              u_xlat6.x = u_xlat40 * 0.123750001;
                              
                              u_xlat1.x = u_xlat1.x * 0.348499954 + (-u_xlat6.x);
                              
                              u_xlat40 = u_xlat40 * 0.309125036 + (-u_xlat41);
                              
                              u_xlat41 = (-u_xlat1.x) * 10.8206377 + 1.0;
                              
                              u_xlat40 = (-u_xlat40) * 10.8206377 + u_xlat41;
                              
                              u_xlatb41 = u_xlat40>=0.0;
                              
                              u_xlatb6.x = 1.0>=u_xlat40;
                              
                              u_xlatb41 = u_xlatb41 && u_xlatb6.x;
                              
                              u_xlatb6.x = u_xlat1.x>=0.0;
                              
                              u_xlatb41 = u_xlatb41 && u_xlatb6.x;
                              
                              u_xlatb6.x = 0.0924159959>=u_xlat1.x;
                              
                              u_xlatb41 = u_xlatb41 && u_xlatb6.x;
                              
                              u_xlat1.x = u_xlat1.x * 10.8206377 + u_xlat40;
                              
                              u_xlatb1 = 1.0>=u_xlat1.x;
                              
                              u_xlatb1 = u_xlatb1 && u_xlatb41;
                              
                              u_xlat4.xyz = (int(u_xlatb1)) ? float3(0.400000006, 0.400000006, 0.600000024) : float3(3.0, 0.5, 0.5);
                              
                              u_xlat6.x = 0.0;
                              
                              u_xlat6.z = _HDROutputLuminanceParams.z;
                              
                              u_xlat5.xyz = (int(u_xlatb1)) ? u_xlat6.xxz : u_xlat6.zxx;
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlat1.x = float(1.0) / u_xlat13.y;
                          
                          u_xlat6.x = u_xlat13.x * u_xlat1.x;
                          
                          u_xlat40 = (-u_xlat13.x) + 1.0;
                          
                          u_xlat40 = (-u_xlat13.y) + u_xlat40;
                          
                          u_xlat6.z = u_xlat1.x * u_xlat40;
                          
                          u_xlat6.y = 1.0;
                          
                          u_xlat7.x = dot(float3(1.71235168, -0.354878962, -0.250341356), u_xlat6.xyz);
                          
                          u_xlat7.y = dot(float3(-0.667286217, 1.61794055, 0.0149537995), u_xlat6.xyz);
                          
                          u_xlat7.z = dot(float3(0.0176398493, -0.0427706018, 0.942103207), u_xlat6.xyz);
                          
                          u_xlat8.x = dot(float3(2.49349689, -0.93138361, -0.402710795), u_xlat6.xyz);
                          
                          u_xlat8.y = dot(float3(-0.829488993, 1.76266408, 0.0236246865), u_xlat6.xyz);
                          
                          u_xlat8.z = dot(float3(0.035845831, -0.0761723891, 0.956884503), u_xlat6.xyz);
                          
                          u_xlat9.x = dot(float3(3.2409699, -1.5373832, -0.498610765), u_xlat6.xyz);
                          
                          u_xlat9.y = dot(float3(-0.969243646, 1.8759675, 0.0415550582), u_xlat6.xyz);
                          
                          u_xlat9.z = dot(float3(0.0556300804, -0.203976959, 1.05697155), u_xlat6.xyz);
                          
                          u_xlat6.xyz = (u_xlatb2.y) ? u_xlat8.xyz : u_xlat9.xyz;
                          
                          u_xlat6.xyz = (u_xlatb2.x) ? u_xlat7.xyz : u_xlat6.xyz;
                          
                          u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
                          
                          u_xlat1.x = sqrt(u_xlat1.x);
                          
                          u_xlat1.x = float(1.0) / u_xlat1.x;
                          
                          u_xlat40 = dot(u_xlat6.xyz, float3(0.333000004, 0.333000004, 0.333000004));
                          
                          u_xlat7.xyz = (-float3(u_xlat40)) + u_xlat6.xyz;
                          
                          u_xlat40 = dot(u_xlat7.xyz, u_xlat7.xyz);
                          
                          u_xlat40 = sqrt(u_xlat40);
                          
                          u_xlat40 = u_xlat40 * -2.88539004;
                          
                          u_xlat40 = exp2(u_xlat40);
                          
                          u_xlat40 = u_xlat40 * 0.5 + 1.0;
                          
                          u_xlat1.x = u_xlat1.x * u_xlat40;
                          
                          u_xlat4.xyz = u_xlat1.xxx * u_xlat6.xyz;
                          
                          u_xlat5.x = float(0.0);
                          
                          u_xlat5.z = float(0.0);
                          
                          u_xlat5.y = _HDROutputLuminanceParams.z;
      
      }
                      
                      u_xlat2.w = max(u_xlat37, 0.150000006);
                      
                      u_xlat2.xyz = u_xlat4.xyz * _HDROutputLuminanceParams.zzz;
                      
                      u_xlat1.x = textureLod(_xyBuffer, u_xlat13.xy, 0.0).x;
                      
                      u_xlatb1 = u_xlat1.x!=0.0;
                      
                      u_xlat4.xyz = (int(u_xlatb36)) ? u_xlat5.xyz : u_xlat2.xyz;
                      
                      u_xlat4.w = 1.0;
                      
                      u_xlat2 = (int(u_xlatb1)) ? u_xlat4 : u_xlat2;
      
      }
                  else
                  
                      {
                      
                      u_xlat2.x = float(0.0);
                      
                      u_xlat2.y = float(0.0);
                      
                      u_xlat2.z = float(0.0);
                      
                      u_xlat2.w = float(0.0);
      
      }
                  
                  u_xlat1.x = (-u_xlat37) + 1.0;
                  
                  u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
      
      }
              else
              
                  {
                  
                  u_xlat1.x = float(0.0);
                  
                  u_xlat1.y = float(0.0);
                  
                  u_xlat1.z = float(0.0);
                  
                  u_xlat2.w = 0.0;
      
      }
              
              u_xlat37 = (-u_xlat2.w) + 1.0;
              
              u_xlat4.xyz = float3(u_xlat37) * u_xlat16_3.xyz;
              
              u_xlat1.xyz = u_xlat1.xyz * u_xlat2.www + u_xlat4.xyz;
              
              u_xlat16_1.xyz = u_xlat1.xyz;
      
      }
          else
          
              {
              
              u_xlat16_10 = max(u_xlat16_0.z, u_xlat16_0.y);
              
              u_xlat16_10 = max(u_xlat16_0.x, u_xlat16_10);
              
              u_xlat4.x = _HDROutputLuminanceParams.z;
              
              u_xlat4.z = 0.0;
              
              u_xlat16.x = (-u_xlat4.x) + u_xlat16_10;
              
              u_xlat40 = (-u_xlat4.x) + _HDROutputLuminanceParams.y;
              
              u_xlat16.x = u_xlat16.x / u_xlat40;
              
              u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
              
              u_xlatb40 = _HDROutputLuminanceParams.z<u_xlat16_10;
              
              u_xlat5.xyz = (-u_xlat4.xxz) + u_xlat4.xzz;
              
              u_xlat4.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat4.xxz;
              
              u_xlat16_11 = dot(u_xlat16_0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
              
              u_xlat1.xyz = (int(u_xlatb40)) ? u_xlat4.xyz : float3(u_xlat16_11);
              
              u_xlat16_1.xyz = u_xlat1.xyz;
      
      }
          
          out_f.color.xyz = u_xlat16_1.xyz;
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
