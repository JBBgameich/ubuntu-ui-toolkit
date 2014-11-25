// Copyright © 2014 Canonical Ltd.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation; version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// Author: Loïc Molinari <loic.molinari@canonical.com>

// Static flow control (branching on a uniform value) is fast on most GPUs (including ultra-low
// power ones) because it allows to use the same shader execution path for an entire draw call. We
// rely on that technique here (also known as "uber-shader" solution) to avoid the complexity of
// dealing with a multiple shaders solution.

// FIXME(loicm)
//  - Check GPU behavior with regards to static flow control.
//  - Ensure binary flag testing doesn't prevent static flow control.
//  - Binary operator '&' is supported starting from GLSL 1.3 (OpenGL 3).

uniform sampler2D shapeTexture;
uniform sampler2D sourceTexture;
uniform lowp float sourceOpacity;
uniform lowp float opacity;
uniform lowp int flags;

varying mediump vec2 shapeCoord;
varying mediump vec4 sourceCoord;
varying lowp vec4 backgroundColor;

const lowp int TEXTURED_FLAG = 0x1;

void main(void)
{
    // Early texture fetch to cover latency as best as possible.
    lowp vec4 shapeData = texture2D(shapeTexture, shapeCoord);

    lowp vec4 color = backgroundColor;

    // Blend the source over the current color (static flow control prevents the texture fetch).
    if (flags & TEXTURED_FLAG) {
        lowp vec2 axisMask = -sign((sourceCoord.zw * sourceCoord.zw) - vec2(1.0));
        lowp float mask = clamp(axisMask.x + axisMask.y, 0.0, 1.0);
        lowp vec4 source = texture2D(sourceTexture, sourceCoord) * sourceOpacity * mask;
        color = vec4(1.0 - source.a) * color + source;
    }

    // Shape the current color with the mask.
    color *= vec4(shapeData.b);

    // Blend the border color over the current color.
    color = vec4(1.0 - shapeData.r) * color + shapeData.gggr;

    gl_FragColor = color * vec4(opacity);
}
