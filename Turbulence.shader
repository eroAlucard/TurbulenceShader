// Shader created with Shader Forge v1.35 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.35;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:6430,x:32975,y:32743,varname:node_6430,prsc:2|emission-4301-OUT,voffset-3605-OUT;n:type:ShaderForge.SFN_TexCoord,id:4888,x:31399,y:32544,varname:node_4888,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:5186,x:31775,y:32857,varname:node_5186,prsc:2,spu:1,spv:1|UVIN-8277-OUT,DIST-3973-OUT;n:type:ShaderForge.SFN_VertexColor,id:9738,x:31164,y:32683,varname:node_9738,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:3973,x:31436,y:32980,varname:node_3973,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-9738-A;n:type:ShaderForge.SFN_Tex2d,id:5566,x:31959,y:32857,ptovrint:False,ptlb:Twist,ptin:_Twist,varname:_Twist,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-5186-UVOUT;n:type:ShaderForge.SFN_Multiply,id:8198,x:32169,y:32857,varname:node_8198,prsc:2|A-5566-RGB,B-5566-A;n:type:ShaderForge.SFN_Multiply,id:7327,x:32556,y:32621,varname:node_7327,prsc:2|A-9738-RGB,B-8198-OUT;n:type:ShaderForge.SFN_Tex2d,id:7045,x:32544,y:33025,ptovrint:False,ptlb:Albedo,ptin:_Albedo,varname:_Albedo,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3605,x:32643,y:33290,varname:node_3605,prsc:2|A-8198-OUT,B-2162-OUT,C-7915-OUT;n:type:ShaderForge.SFN_NormalVector,id:7915,x:32391,y:33434,prsc:2,pt:False;n:type:ShaderForge.SFN_ValueProperty,id:2162,x:32391,y:33324,ptovrint:False,ptlb:Offset,ptin:_Offset,varname:_Offset,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_ValueProperty,id:4240,x:32544,y:32896,ptovrint:False,ptlb:Albedo Power,ptin:_AlbedoPower,varname:_AlbedoPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Time,id:3814,x:31378,y:32759,varname:node_3814,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8277,x:31622,y:32746,varname:node_8277,prsc:2|A-4888-UVOUT,B-3814-TSL;n:type:ShaderForge.SFN_Multiply,id:4301,x:32752,y:32862,varname:node_4301,prsc:2|A-7327-OUT,B-4240-OUT,C-7045-RGB;proporder:5566-7045-4240-2162;pass:END;sub:END;*/

Shader "Unlit/Turbulence" {
    Properties {
        _Twist ("Twist", 2D) = "white" {}
        _Albedo ("Albedo", 2D) = "white" {}
        _AlbedoPower ("Albedo Power", Float ) = 1
        _Offset ("Offset", Float ) = 0.2
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _Twist; uniform float4 _Twist_ST;
            uniform sampler2D _Albedo; uniform float4 _Albedo_ST;
            uniform float _Offset;
            uniform float _AlbedoPower;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_3814 = _Time + _TimeEditor;
                float2 node_5186 = ((o.uv0*node_3814.r)+(o.vertexColor.a*2.0+-1.0)*float2(1,1));
                float4 _Twist_var = tex2Dlod(_Twist,float4(TRANSFORM_TEX(node_5186, _Twist),0.0,0));
                float3 node_8198 = (_Twist_var.rgb*_Twist_var.a);
                v.vertex.xyz += (node_8198*_Offset*v.normal);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 node_3814 = _Time + _TimeEditor;
                float2 node_5186 = ((i.uv0*node_3814.r)+(i.vertexColor.a*2.0+-1.0)*float2(1,1));
                float4 _Twist_var = tex2D(_Twist,TRANSFORM_TEX(node_5186, _Twist));
                float3 node_8198 = (_Twist_var.rgb*_Twist_var.a);
                float4 _Albedo_var = tex2D(_Albedo,TRANSFORM_TEX(i.uv0, _Albedo));
                float3 emissive = ((i.vertexColor.rgb*node_8198)*_AlbedoPower*_Albedo_var.rgb);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _Twist; uniform float4 _Twist_ST;
            uniform float _Offset;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_3814 = _Time + _TimeEditor;
                float2 node_5186 = ((o.uv0*node_3814.r)+(o.vertexColor.a*2.0+-1.0)*float2(1,1));
                float4 _Twist_var = tex2Dlod(_Twist,float4(TRANSFORM_TEX(node_5186, _Twist),0.0,0));
                float3 node_8198 = (_Twist_var.rgb*_Twist_var.a);
                v.vertex.xyz += (node_8198*_Offset*v.normal);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
