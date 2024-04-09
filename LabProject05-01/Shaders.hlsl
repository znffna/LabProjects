float4 VSMain(uint nVertexID : SV_VertexID) : SV_POSITION
{
    float4 output = (float4)0;
    
//프리미티브(삼각형)를 구성하는 정점의 인덱스(SV_VertexID)에 따라 정점을 반환한다. 
//정점의 위치 좌표는 변환이 된 좌표(SV_POSITION)이다. 즉, 투영좌표계의 좌표이다. 
    if (nVertexID == 0) output = float4(-1.0f, +1.0f, 0.0f, 1.0f);
    else if (nVertexID == 1) output = float4(+1.0f, +1.0f, 0.0f, 1.0f);
    else if (nVertexID == 2) output = float4(+1.0f, -1.0f, 0.0f, 1.0f);
    
    else if (nVertexID == 3) output = float4(-1.0f, +1.0f, 0.0f, 1.0f);
    else if (nVertexID == 4) output = float4(+1.0f, -1.0f, 0.0f, 1.0f);
    else if (nVertexID == 5) output = float4(-1.0f, -1.0f, 0.0f, 1.0f);
    
    return (output);

}

#define FRAME_BUFFER_WIDTH      800.0f
#define FRAME_BUFFER_HEIGHT      600.0f

#define HALF_WIDTH (FRAME_BUFFER_WIDTH * 0.5f)
#define HALF_HEIGHT (FRAME_BUFFER_HEIGHT * 0.5f)
#define EPSILON 1.0e-5f
inline bool IsZero(float fValue)
{
    return ((abs(fValue) <= EPSILON));
}
inline bool IsZero(float fValue, float fEpsilon)
{
    return ((abs(fValue) <= fEpsilon));
}
inline bool IsEqual(float fA, float fB, float fEpsilon)
{
    return ((abs(fA - fB) <=
fEpsilon));
}

float Rectangle(float2 f2NDC, float fLeft, float fRight, float fTop, float fBottom)
{
    float2 f2Shape = float2(step(fLeft, f2NDC.x), step(f2NDC.x, fRight));
    f2Shape *= float2(step(fTop, f2NDC.y), step(f2NDC.y, fBottom));
    return (f2Shape.x * f2Shape.y);
}

//픽셀 셰이더를 정의한다.
float4 PSMain(float4 input : SV_POSITION) : SV_TARGET
{
    float4 cColor = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) -0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);
    float2 f2Horizontal = float2(0.1f, +0.3f); //(Left, Right)
    float2 f2Vertical = float2(-0.3f, +0.3f); //(Top, Bottom)
    cColor.b = Rectangle(f2NDC, +0.1f, +0.3f, -0.2f, +0.4f);
    cColor.b += Rectangle(f2NDC, -0.3f, -0.1f, -0.4f, -0.1f);
    
    return (cColor);
}