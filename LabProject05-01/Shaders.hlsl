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

//픽셀 셰이더를 정의한다.
float4 PSMain(float4 input : SV_POSITION) : SV_TARGET
{
    float4 cColor = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    // 입력받은 위치를 NDC(래스터라이즈과정의 원근 나눗셈이 적용된 정규 좌표)로 표현.
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) -0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);  // cColor.b = step(length(f2NDC), 0.25f); //step(x, y) = (x <= y) ? 1 : 0
    cColor.b = (length(f2NDC) <= 0.25f) ? 1.0f : 0.0f;  //step(x, y) = (x <= y) ? 1 : 0
    
    return (cColor);
}