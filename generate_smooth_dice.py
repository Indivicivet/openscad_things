import numpy as np
from solid import scad_render_to_file, import_scad
from solid.objects import *

fn = 50

PTS = 25

points = [
    np.array([i, j, k])
    for i in range(PTS + 1)
    for j in range(PTS + 1)
    for k in range(PTS + 1)
    if (
        (i in [0, PTS])
        + (j in [0, PTS])
        + (k in [0, PTS])
    ) > 1
]


OUTER_RADIUS = 4
INNER_RADIUS = 1.5


def magic_sphere(pt, outer_radius=OUTER_RADIUS, inner_radius=INNER_RADIUS):
    dist = max(min(v, PTS - v) for v in pt)
    edge_vector = np.array([
        -1 if v == 0 else 1 if v == PTS else 0
        for v in pt
    ])
    radius = inner_radius + (outer_radius - inner_radius) / (1 + 0.7 * dist)
    trans = pt + edge_vector * (outer_radius - radius)
    return translate(trans)(sphere(r=radius))


soft_cube = hull()(*[magic_sphere(pt) for pt in points])
dice_faces = import_scad("dice_faces.scad").diceFaces(PTS, OUTER_RADIUS, 512, 6)
s = difference()(soft_cube, dice_faces)
scad_render_to_file(s, "my_hull.scad", file_header=f"${fn=};")
