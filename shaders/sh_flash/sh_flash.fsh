//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_flash;      // intensidade (0 a 1)
uniform vec3 u_flashColor;  // cor da piscada

void main()
{
    vec4 baseColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    baseColor.rgb = mix(baseColor.rgb, u_flashColor, u_flash);

    gl_FragColor = baseColor;
}
