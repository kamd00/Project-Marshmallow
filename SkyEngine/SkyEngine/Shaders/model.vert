#version 450
#extension GL_ARB_separate_shader_objects : enable

out gl_PerVertex {
    vec4 gl_Position;
};

layout(binding = 0) uniform UniformCameraObject {
    mat4 view;
    mat4 proj;
    vec3 cameraPosition;
} camera;

layout(binding = 1) uniform UniformModelObject {
    mat4 model;
    mat4 invTranspose;
} model;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inUV;
layout(location = 3) in vec3 inNormal;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragUV;
layout(location = 2) out vec3 fragPosition;
layout(location = 3) out vec3 fragNormal;

void main() {
    
	//gl_Position = vec4(inPosition, 0.0, 1.0);
    gl_Position = camera.proj * camera.view * model.model * vec4(inPosition, 1.0);
    fragUV = inUV;
	fragColor = inColor;
    fragPosition = (camera.view * vec4(inPosition, 1.0)).xyz;
    
    fragNormal = normalize((camera.view * vec4(normalize((model.invTranspose * vec4(inNormal, 0.0)).xyz), 0.0)).xyz);
}