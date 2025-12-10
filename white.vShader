struct VertexIn {
    float3 position [[attribute(0)]];
};
struct VertexOut {
    float4 position [[position]];
};
vertex VertexOut vertexMain(
    VertexIn in [[stage_in]],
    constant float4x4 &modelMatrix [[buffer(1)]],
    constant float4x4 &viewMatrix [[buffer(2)]],
    constant float4x4 &projectionMatrix [[buffer(3)]]
) {
    VertexOut out;
    float4 worldPosition = modelMatrix * float4(in.position, 1.0);
    out.position = projectionMatrix * viewMatrix * worldPosition;
    return out;
}