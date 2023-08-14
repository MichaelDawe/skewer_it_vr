// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
// By Michael Dawe, partially based on:
// The Universe Within - by Martijn Steinrucken aka BigWings 2018
// Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
// License under Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

shader_type spatial;
render_mode unshaded;

uniform vec3 background;
uniform float t;

uniform float catch;
uniform float damaged;
uniform float sparks;
uniform float highscore;

varying vec3 vertsPos;

float random(vec2 par){
   return fract(sin(dot(par.xy,vec2(12.9898,78.233))) * 43758.5453);
}

vec2 random2(vec2 par){
	float rand = random(par);
	return vec2(rand, random(par+rand));
}

void vertex() {
	vertsPos = VERTEX;
}

void fragment() {
    float layers = 6.0;
    float scale = 25.0;
	
	float stars = 0.0;
    float depth = 0.0;
    vec2 index = vec2(0.0);
	vec2 uv = vec2(0.0);
    vec2 seed = vec2(0.0);
    vec2 local_uv = vec2(0.0);
    vec2 pos = vec2(0.0);
    float phase = 0.0;
	
	for(float i = 0.0; i < layers; i++)
	{
        depth = fract(i/layers + t);
        
        //Get uv from the fragment coordinates and depth
    	//uv.x = 0.5 - UV.x;
    	//uv.y = 0.5 - UV.y;
		uv = vertsPos.xy;
    	uv *= mix(scale, 0.0, depth);
        
        //The local cell
        index = floor(uv);
        
        //Local cell seed;
        seed = 20.0 * i + index;
        
        //The local cell coordinates
        local_uv = fract(i + uv) - 0.5;
        
        //Get a random position for the local cell
        pos = 0.8 * (random2(seed) - 0.5);
        
        //Get a random phase
        phase = 128.0 * random(seed);
        
		//Get distance to the generated point, add fading to distant points
		//Add the distance to the sum
		stars += pow(abs(1.0 - length(local_uv - pos)), 80.0 + 20.0 * sin(phase + 8.0 * TIME)) * min(1.0, depth * 2.0);
	}
	
	float noise = 0.0;
	
	noise += (random(UV * TIME) * 0.15) - 0.075;
	
	vec3 col = (vec3(mix(0.0, stars, min(max(vertsPos.z, 0.0) * 2.0, 1.0))) * (1.0 - background)) + background * (vertsPos.z + 0.5 + noise);
	
	uv = SCREEN_UV * (1.0 - SCREEN_UV.yx); //vec2(1.0)- uv.yx; -> 1.-u.yx; Thanks FabriceNeyret !
	float vig = 1.0 - (uv.x*uv.y * 16.0); //multiply with sth for intensity
	vig = pow(vig, 0.5);
	
	col *= 1.0 + (catch * vig);
	col *= 1.0 + (vec3(1.0, 0.8, 0.4) * highscore * vig);
	col = mix(col, (col * vec3(1.0, 0.0, 0.0)) + vec3(0.4, 0.0, 0.0), vig * damaged);
	
	col += (1.0 - SCREEN_UV.y) * sparks * vec3(1.0, 0.4, 0.05);
	
	ALBEDO = col;
}
