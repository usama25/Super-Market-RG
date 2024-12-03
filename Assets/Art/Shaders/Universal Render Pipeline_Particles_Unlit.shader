// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "Universal Render Pipeline/Particles/Unlit"
{
  Properties
  {
    _BaseMap ("Base Map", 2D) = "white" {}
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _BumpMap ("Normal Map", 2D) = "bump" {}
    [HDR] _EmissionColor ("Color", Color) = (0,0,0,1)
    _EmissionMap ("Emission", 2D) = "white" {}
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
    }
    Pass // ind: 1, name: ForwardLit
    {
      Name "ForwardLit"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PerformanceChecks" = "False"
        "PreviewType" = "Plane"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
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
      
      uniform sampler2D _BaseMap;
      
      
      
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
          
          float3 texcoord8 : TEXCOORD8;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
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
      
      float3 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      int u_xlatb6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat1 + unity_MatrixVP[3];
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.color = in_v.color;
          
          out_v.texcoord1.xyz = u_xlat0.xyz;
          
          u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
          
          out_v.texcoord1.w = 0.0;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat6 = max(u_xlat6, 1.17549435e-38);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat1.xyz = float3(u_xlat6) * u_xlat1.xyz;
          
          out_v.texcoord2.xyz = u_xlat1.xyz;
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          u_xlatb6 = unity_OrthoParams.w==0.0;
          
          out_v.texcoord3.x = (u_xlatb6) ? u_xlat0.x : unity_MatrixV[0].z;
          
          out_v.texcoord3.y = (u_xlatb6) ? u_xlat0.y : unity_MatrixV[1].z;
          
          out_v.texcoord3.z = (u_xlatb6) ? u_xlat0.z : unity_MatrixV[2].z;
          
          out_v.texcoord8.xyz = float3(0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 Xhlslcc_UnusedX_SoftParticleFadeParams;
          
          uniform float4 Xhlslcc_UnusedX_CameraFadeParams;
          
          uniform float4 Xhlslcc_UnusedX_BaseMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_EmissionColor;
          
          uniform float4 Xhlslcc_UnusedX_BaseColorAddSubDiff;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float Xhlslcc_UnusedX_DistortionStrengthScaled;
          
          uniform float Xhlslcc_UnusedX_DistortionBlend;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat16_0;
      
      int u_xlatb1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_0 = u_xlat16_0 * _BaseColor;
          
          u_xlat16_0 = u_xlat16_0 * in_f.color;
          
          u_xlatb1 = _Surface==1.0;
          
          out_f.color.w = (u_xlatb1) ? u_xlat16_0.w : 1.0;
          
          out_f.color.xyz = u_xlat16_0.xyz;
          
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
    Pass // ind: 3, name: DepthNormalsOnly
    {
      Name "DepthNormalsOnly"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "DepthNormalsOnly"
        "PerformanceChecks" = "False"
        "PreviewType" = "Plane"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      Cull Off
      // m_ProgramMask = 6
      Program "vp"
      {
        SubProgram "vulkan"
        {
          
          "!!vulkan
          60000002060200000D060000B0000000560100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000001F48F8CC75E581D346AED944D97747B92926350B3338D0C42A2B6C1FABF7E745000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004C4F4D53000001010A000800330000000000000018040000910201D11002474C534C2E7374642E34353000000000A0040001EF0E0404EDC2A5F306000B1DA0020407550B00000076735F544558434F4F5244320000000010161E0000240010001E00930202A1040202A6020620B7020206033E020607390802063E020107390A0201B502082000BB040F02000000003E020606B7021406043E02031B391C0203BB04060800000000BB040F02030000003E0203063E06071BB502042001B7020228043E020729940204B702022C043E02072DB702040F043E020730C60602590003180239264407392A0807392E08073931060701074B0201070204C4120602040213110809102200081311020910010602025C060201201413110209102200020107021C3D07020202000107021C4A070204022222000107082A011B0204441B020204040506032206001323081D222200068D1E88064C4F4D53000001010A000800D400000000000000DC160000910201D11002474C534C2E7374642E34353000000000A00400019F0F0004EDC2A5F306000C5D658601C101558600000076735F544558434F4F5244320000000055C100000076735F544558434F4F5244330000000010181E00100A06101002061010040610100206101002061047022A002300012340012340010000231001231001000023100100002310012320010000231001000023100123100123100123100123100123100123100123100123100100002310010000231001000023100100002310010000231001000023100100002310012310012310012310012340012340000002100422011000210110480610100206104702040023000123100123100123400000021004220110002100473403000B0100010B0101010B010300000210141E0110421E0000300010461E01000200930202A1040202A6020620B7020206033E02060739080206B7020206043E02010A390B0201B502062000BB040F0204000000BC02020A10BC02020A10BB040F0202000000BC02020A13BC02020A10BC02020A10FE83400211120A0A0A0A140A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A15160A3E02021739180202B502022001BB041A0200000000BB041A02010000003E02020ABB041A1A02000000BB041A14030000003E0A060A39390206BC02060A10BC02020A10DE0202070A3D3E3E02023F394002023E280207BB040F0801000000BC02020659CE02020A065A3E02035B395C02033E0A030A3E04010739640201BB040F0C000000003E020606396C1C06BB04060E000080003E080307398501020394021E3E020695013996010206BB040F02030000003E020206BB04060600000000390804063E04070639850142033E0403063E0C070AB702041A043E0207CB01B702049501043E0207CE01B702040F043E0207D101C606029B030003180239A001B8020739A001160739A001160739C901260739CC01060739CF01060739D2010607010A8B03023D0702020254231D20191B1C010A02023D07020202184A07022602223000231D02191B1B010A02023D0702020218010A02323D07020202004A070206020107023E4B07020402224000231D04191B2A010A02023D0702020218010A02443D07020202A84A07020602010702504B0702040222520001070254231D04191B34010A02023D07020202184B07020A02225E00010706644D0A02020255231D0C41341C010A02024A0A021002221400231D0241341B010A02020107027C4D0A020202004A0A020602010A02204B0A020402222200231D0241342A010A02020107028A014D0A020202AA4A0A020602010A022E4B0A02040222300001070294013F070202135504411B010702024B07020802229E0100010A0C48231D02413434010A02024B0A0206021362045D1B22000401070602231D02191C1B010A02023D0702020218C41206020802136C063A6B22000601070212231D02191C1C010A02023D0702020218C41206020802136C023A592200020107021E231D02191C2A010A02023D0702020218C41206020802136C023A13220002010A0482013D0702020218010A0286013D0702020218C41206020602220A000106020C6C0604012880018101221000010602125C0602012083012214000106061AD00A0702020202010A029E013D07020202184A07020602220A0001070286020107028802C412060204022228000106022A5C060201208F01222C000106022ED00A070202020201070294024A07020402229602002399010C411C980101060202C4169501040402220C000195010410A71E0700BA1E00050D1806136C04096B01060202220800991E04180233990102412A1B1301060202220E00991E0A180901060C10136C029E016B2200020195010228A71E0500BA1E00030B1804136C04095901060202220800991E04180233990102412A1C1301060202220E00991E0A180901060C10136C029E0159220002019501023EA71E0500BA1E00030B1804136C04091301060202220800991E04180233990102412A2A1301060202220E00991E0A180901060C10136C029E01132200020107044822020023C301045D1B59010602023F06020223C301025D1B592200028D1E8806
          
          "
        }
      }
      Program "fp"
      {
      }
      Program "gp"
      {
      }
      Program "hp"
      {
      }
      Program "dp"
      {
      }
      Program "surface"
      {
      }
      Program "rtp"
      {
      }
      
    } // end phase
  }
  FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
