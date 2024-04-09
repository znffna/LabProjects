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

//픽셀 셰이더를 정의한다.
float4 PSMain(float4 input : SV_POSITION) : SV_TARGET
{
    float4 cColor = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    if ((int) input.x == (int) HALF_WIDTH)
        cColor.g = 1.0f;
    if ((int) input.y == (int) HALF_HEIGHT)
        cColor.r = 1.0f;
    float fDistance = distance((int2) input.xy, float2(HALF_WIDTH, HALF_HEIGHT));
    if (IsEqual(fDistance, 100.0f, 0.5f))
        cColor.b = 1.0f;
    
    return (cColor);
}