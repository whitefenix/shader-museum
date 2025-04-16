Shader "Custom/Commented Shader"
{
    Properties
    {
        _Value("My Value", Float) = 1.0
        _Color("My color", Color) = (1,1,1,1) //Custom property visible in the inspector
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert //defines vertex shader as existing in the function vert
            #pragma fragment frag //defines fragment shader as existing in function frag

            #include "UnityCG.cginc"

            float _Value;
            float4 _Color; //Field linked to the property accessible in both frag and vert

            struct MeshData // per vertex mesh data
            {
                float4 vertex : POSITION; //vertex position
                float2 uv : TEXCOORD0; // uv coordinates
                float3 normals : NORMAL;
                // float4 color : COLOR;
                // float4 tangent : TANGENT;
                // float2 uv1 : TEXCOORD1; //Semantics refer to specific UV channels
            };

            struct Interpolators //Fragment shader input
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
                // float4 uv : TEXCOORD0; //Semantics are arbitrary
            };

            Interpolators vert(MeshData v)
            {
                Interpolators o; //o for output
                o.vertex = UnityObjectToClipPos(v.vertex); //converts local space to clip space
                o.normal = UnityObjectToWorldNormal(v.normals); //convert to world space from local space
                //o.normal = v.normals; //uses local space to determine up
                // o.normal = _Color.rgb //Data can be anything

                o.uv = v.uv; //Passthrough
                
                return o;
            }

            //can be float4, fixed4, half3, etc.
            //PC might only use float4
            //dont optimize prematurely, too low precision can cause hard to debug errors
            float4 frag(Interpolators i) : SV_Target //Single target, can be multi target with deferred rendering
            {

                return float4(i.uv.xxx, 1); //Outputs horizontal greyscale gradient, .yyy gives vertical gradient
                // return float4(i.uv, 0, 1);
                
                // return float4(i.normal, 1);
                // return _Color;
                
            }
            ENDCG
        }
    }
}
