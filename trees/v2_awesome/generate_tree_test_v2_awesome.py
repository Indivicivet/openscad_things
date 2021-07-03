import math
import random
from dataclasses import dataclass, field

from solid import *

@dataclass
class Node:
    x: float = 0
    y: float = 0
    h: float = 5
    r_top: float = 5
    children: List = field(default_factory=lambda: [])

    def __init__(self, *args):
        self.x, self.y, self.h, self.r_top, *self.children = args


MAX_FN = 20
MIN_FN = 8

BASE_WIDTH = 50

def get_fn(r):
    if r < BASE_WIDTH * 0.2:
        return MIN_FN
    return (r / BASE_WIDTH - 0.2) * (MAX_FN - MIN_FN) + MIN_FN


def thin_disc(r):
    return cylinder(r=r, h=0.01, segments=get_fn(r))


def solidify_tree(node, start_r=BASE_WIDTH):
    return (
        hull() (
            thin_disc(start_r),
            translate([node.x, node.y, node.h]) (thin_disc(node.r_top)),
        )
        + translate([node.x, node.y, node.h]) (
            sum(
                solidify_tree(child, start_r=node.r_top)
                for child in node.children
            )
        )
    )


random.seed(50)


MAX_OVERHANG_ANGLE = math.pi / 4 * 1.2;


def random_pos():
    h = random.uniform(10, 60)
    dir = random.uniform(0, 2 * math.pi)
    rel_angle = random.uniform(-1, 1)
    offs_magnitude = math.tan(MAX_OVERHANG_ANGLE * rel_angle) * h
    return [
        math.cos(dir) * offs_magnitude,
        math.sin(dir) * offs_magnitude,
        h,
    ]


def random_children(start_r):
    n_children = int(start_r / 3 * random.random())
    children = [
        Node(
            *random_pos(),
            random.uniform(1 + start_r / 3, start_r),
        )
        for _ in range(n_children)
    ]
    for child in children:
        if child.r_top < 5:
            continue
        child.children += random_children(child.r_top)
    return children


#TREE = Node(
#    0, 0, 5, BASE_WIDTH,
#    Node(
#        0, 0, 5, 30,
#        Node(
#            0, 0, 10, 20,
#            *random_children(30),
#            Node(
#                0, 0, 30, 15,
#                Node(7, 0, 20, 5),
#                Node(
#                    -10, 5, 15, 4,
#                    *random_children(4),
#                    Node(
#                        -5, 0, 20, 3,
#                        Node(0, 3, 10, 2),
#                    ),
#                ),
#            ),
#        ),
#    ),
#)

TREE = Node(
    0, 0, 5, BASE_WIDTH,
    Node(
        0, 0, 5, 30,
        Node(
            0, 0, 30, 27,
            *random_children(27),
        ),
    ),
)


print(TREE)
solid_tree = solidify_tree(TREE)

scad_render_to_file(solid_tree, "generate_tree_test_out.scad")
