float4 VSMain(uint nVertexID : SV_VertexID) : SV_POSITION
{
    float4 output = (float4)0;
    
//������Ƽ��(�ﰢ��)�� �����ϴ� ������ �ε���(SV_VertexID)�� ���� ������ ��ȯ�Ѵ�. 
//������ ��ġ ��ǥ�� ��ȯ�� �� ��ǥ(SV_POSITION)�̴�. ��, ������ǥ���� ��ǥ�̴�. 
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

//�ȼ� ���̴��� �����Ѵ�.
float4 PSMain(float4 input : SV_POSITION) : SV_TARGET
{
    float4 cColor = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    // �Է¹��� ��ġ�� NDC(�����Ͷ���������� ���� �������� ����� ���� ��ǥ)�� ǥ��.
    float2 f2NDC = float2(input.x / FRAME_BUFFER_WIDTH, input.y / FRAME_BUFFER_HEIGHT) -0.5f; // (0, 1) : (-0.5, 0.5)
    f2NDC.x *= (FRAME_BUFFER_WIDTH / FRAME_BUFFER_HEIGHT);  // cColor.b = step(length(f2NDC), 0.25f); //step(x, y) = (x <= y) ? 1 : 0
    cColor.b = (length(f2NDC) <= 0.25f) ? 1.0f : 0.0f;  //step(x, y) = (x <= y) ? 1 : 0
    
    return (cColor);
}