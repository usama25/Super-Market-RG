Shader "Hidden/Universal Render Pipeline/UberPost"
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
    Pass // ind: 1, name: UberPost
    {
      Name "UberPost"
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
      
      uniform float4 _Lut_Params;
      
      uniform float4 _UserLut_Params;
      
      uniform float4 _Vignette_Params1;
      
      uniform float4 _Vignette_Params2;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _InternalLut;
      
      uniform sampler2D _UserLut;
      
      
      
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
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat16_0;
      
      bool3 u_xlatb0;
      
      float3 u_xlat1;
      
      float3 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float4 u_xlat4;
      
      float3 u_xlat16_4;
      
      float2 u_xlat5;
      
      float3 u_xlat16_5;
      
      float2 u_xlat6;
      
      float3 u_xlat16_7;
      
      float3 u_xlat16_8;
      
      float u_xlat24;
      
      int u_xlatb24;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.xyz = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlatb24 = 0.0<_Vignette_Params2.z;
          
          if(u_xlatb24)
      {
              
              u_xlat1.xy = in_f.texcoord.xy + (-_Vignette_Params2.xy);
              
              u_xlat1.yz = abs(u_xlat1.xy) * _Vignette_Params2.zz;
              
              u_xlat1.x = u_xlat1.y * _Vignette_Params1.w;
              
              u_xlat24 = dot(u_xlat1.xz, u_xlat1.xz);
              
              u_xlat24 = (-u_xlat24) + 1.0;
              
              u_xlat24 = max(u_xlat24, 0.0);
              
              u_xlat24 = log2(u_xlat24);
              
              u_xlat24 = u_xlat24 * _Vignette_Params2.w;
              
              u_xlat24 = exp2(u_xlat24);
              
              u_xlat1.xyz = (-_Vignette_Params1.xyz) + float3(1.0, 1.0, 1.0);
              
              u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz + _Vignette_Params1.xyz;
              
              u_xlat1.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              
              u_xlat16_1.xyz = u_xlat1.xyz;
      
      }
          else
          
              {
              
              u_xlat16_1.xyz = u_xlat16_0.xyz;
      
      }
          
          u_xlat16_2.xyz = u_xlat16_1.xyz * _Lut_Params.www;
          
          u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
          
          u_xlatb0.x = 0.0<_UserLut_Params.w;
          
          if(u_xlatb0.x)
      {
              
              u_xlatb0.xyz = greaterThanEqual(float4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat16_2.xyzx).xyz;
              
              u_xlat16_3.xyz = u_xlat16_2.xyz * float3(12.9232101, 12.9232101, 12.9232101);
              
              u_xlat4.xyz = log2(u_xlat16_2.xyz);
              
              u_xlat4.xyz = u_xlat4.xyz * float3(0.416666657, 0.416666657, 0.416666657);
              
              u_xlat4.xyz = exp2(u_xlat4.xyz);
              
              u_xlat4.xyz = u_xlat4.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
              
              u_xlat0_d.x = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat4.x;
              
              u_xlat0_d.y = (u_xlatb0.y) ? u_xlat16_3.y : u_xlat4.y;
              
              u_xlat0_d.z = (u_xlatb0.z) ? u_xlat16_3.z : u_xlat4.z;
              
              u_xlat4.xyz = u_xlat0_d.zxy * _UserLut_Params.zzz;
              
              u_xlat24 = floor(u_xlat4.x);
              
              u_xlat4.xw = _UserLut_Params.xy * float2(0.5, 0.5);
              
              u_xlat4.yz = u_xlat4.yz * _UserLut_Params.xy + u_xlat4.xw;
              
              u_xlat4.x = u_xlat24 * _UserLut_Params.y + u_xlat4.y;
              
              u_xlat16_5.xyz = textureLod(_UserLut, u_xlat4.xz, 0.0).xyz;
              
              u_xlat6.x = _UserLut_Params.y;
              
              u_xlat6.y = 0.0;
              
              u_xlat4.xy = u_xlat4.xz + u_xlat6.xy;
              
              u_xlat16_4.xyz = textureLod(_UserLut, u_xlat4.xy, 0.0).xyz;
              
              u_xlat24 = u_xlat0_d.z * _UserLut_Params.z + (-u_xlat24);
              
              u_xlat4.xyz = (-u_xlat16_5.xyz) + u_xlat16_4.xyz;
              
              u_xlat4.xyz = float3(u_xlat24) * u_xlat4.xyz + u_xlat16_5.xyz;
              
              u_xlat4.xyz = (-u_xlat0_d.xyz) + u_xlat4.xyz;
              
              u_xlat0_d.xyz = _UserLut_Params.www * u_xlat4.xyz + u_xlat0_d.xyz;
              
              u_xlat16_3.xyz = u_xlat0_d.xyz * float3(0.0773993805, 0.0773993805, 0.0773993805);
              
              u_xlat16_7.xyz = u_xlat0_d.xyz + float3(0.0549999997, 0.0549999997, 0.0549999997);
              
              u_xlat16_7.xyz = u_xlat16_7.xyz * float3(0.947867334, 0.947867334, 0.947867334);
              
              u_xlat4.xyz = log2(abs(u_xlat16_7.xyz));
              
              u_xlat4.xyz = u_xlat4.xyz * float3(2.4000001, 2.4000001, 2.4000001);
              
              u_xlat4.xyz = exp2(u_xlat4.xyz);
              
              u_xlatb0.xyz = greaterThanEqual(float4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0_d.xyzx).xyz;
              
              u_xlat16_2.x = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat4.x;
              
              u_xlat16_2.y = (u_xlatb0.y) ? u_xlat16_3.y : u_xlat4.y;
              
              u_xlat16_2.z = (u_xlatb0.z) ? u_xlat16_3.z : u_xlat4.z;
      
      }
          
          u_xlat0_d.xyz = u_xlat16_2.zxy * _Lut_Params.zzz;
          
          u_xlat0_d.x = floor(u_xlat0_d.x);
          
          u_xlat4.xy = _Lut_Params.xy * float2(0.5, 0.5);
          
          u_xlat4.yz = u_xlat0_d.yz * _Lut_Params.xy + u_xlat4.xy;
          
          u_xlat4.x = u_xlat0_d.x * _Lut_Params.y + u_xlat4.y;
          
          u_xlat16_8.xyz = textureLod(_InternalLut, u_xlat4.xz, 0.0).xyz;
          
          u_xlat5.x = _Lut_Params.y;
          
          u_xlat5.y = 0.0;
          
          u_xlat4.xy = u_xlat4.xz + u_xlat5.xy;
          
          u_xlat16_4.xyz = textureLod(_InternalLut, u_xlat4.xy, 0.0).xyz;
          
          u_xlat0_d.x = u_xlat16_2.z * _Lut_Params.z + (-u_xlat0_d.x);
          
          u_xlat4.xyz = (-u_xlat16_8.xyz) + u_xlat16_4.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * u_xlat4.xyz + u_xlat16_8.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
