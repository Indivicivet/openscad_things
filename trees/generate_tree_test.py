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

    cum_x: float = 0
    cum_y: float = 0
    cum_height: float = 0

    def __init__(self, *args, parent=None):
        self.x, self.y, self.h, self.r_top, *self.children = args
        self.parent = parent
        if self.parent is not None:
            self.update_parent_info()

    def update_parent_info(self):
        self.cum_x = self.parent.cum_x + self.x
        self.cum_y = self.parent.cum_y + self.y
        self.cum_height = self.parent.cum_height + self.h

    def with_children(self, *children):
        for child in children:
            child.parent = self
            child.update_parent_info()
        self.children += children
        return self

    def with_random_children(self):
        return self.with_children(*random_children(self))
        # URGHHH need parents for generation order ><


def random_children(parent):
    parent.update_parent_info()
    n_children = 1 + int(
        parent.r_top / 5 * (0.3 + 0.7 * random.random())
    )
    children = []
    for _ in range(n_children):
        pos = random_pos(parent)
        cum_r = ((pos[0] + parent.cum_x) ** 2 + (pos[1] + parent.cum_y) ** 2) ** 0.5
        child = Node(
            *pos,
            (
                random.uniform(
                    parent.r_top * (1 / (1 + parent.cum_height * 0.02)),
                    parent.r_top
                )
                / (1 + 0.01 * cum_r ** 0.5)
            ),
            parent=parent,
        )
        if child.r_top < 5:  # 4?
            continue
        child.children += random_children(child)
        #if child.r_top < 5:
        #    for child2 in child.children:
        #        child2.r_top = 2.5
        children.append(child)
    return children


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


RANDOM_SEED = 500
random.seed(RANDOM_SEED)


MAX_ADJ_ANGLE = math.pi / 4 * 1.2;
MAX_OVERHANG_ANGLE = math.pi / 4 * 1.2;


def random_pos(parent):
    h = random.uniform(10, 60)
    dir = random.uniform(0, 2 * math.pi)
    rel_angle = random.uniform(-1, 1)
    #rel_angle *= abs(rel_angle)  # r^2 prob distribution
    offs_magnitude = math.tan(MAX_ADJ_ANGLE * rel_angle) * h
    delta_x = (
        math.cos(dir) * offs_magnitude
        + 0.4 * parent.x
        + h * 0.5 * (parent.cum_x / parent.cum_height) ** 2
        #+ 0.01 * parent.cum_y
    )
    delta_y = (
        math.sin(dir) * offs_magnitude
        + 0.4 * parent.y
        + h * 0.5 * (parent.cum_y / parent.cum_height) ** 2
        #- 0.01 * parent.cum_x
    )
    scale_adjust = min(1, math.tan(MAX_OVERHANG_ANGLE) * h / (delta_x ** 2 + delta_y ** 2) ** 0.5)
    delta_x *= scale_adjust
    delta_y *= scale_adjust
    return [
        delta_x,
        delta_y,
        h,
    ]


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
    (n2 := Node(
        0, 0, 5, 30,
        (n3 := Node(0, 0, 40, 27)),
    )),
)

# now I pay for my sins:
n2.parent = TREE
n3.parent = n2

n2.update_parent_info()
n3.update_parent_info()

# would like to do this in-place but want to update lower tree first
n3.children = random_children(n3)

print(TREE)
solid_tree = solidify_tree(TREE)

scad_render_to_file(solid_tree, f"generate_tree_test_out_seed{RANDOM_SEED}.scad")
