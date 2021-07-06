use <chess_pieces_v1.scad>

square_size = 40;
corner_factor = 0.2;

board_thick = 8;
top_thick = 4;
board_margin = 10;
board_inner_margin = 3;

expand = 0.8;

module board_top(square_size, expand=0) {
    new_square_size = square_size + expand * 2;
    anti_square_size = square_size - expand * 2;
    linear_extrude(top_thick)
    union() {
        translate([-1, -1] * expand)
        for (i = [1:8]) {
            for (j = [1:8]) {
                translate([i - 1, j - 1, 0] * square_size)
                if ((i + j) % 2 == 1) {
                    square(square_size + expand * 2)
                        ;
                }
                else {
                    translate([1, 1] * expand * 2)
                    for (corner_i = [0, 1]) {
                        for (corner_j = [0, 1]) {
                            /*if (
                                i + corner_i > 1
                                && i + corner_i < 9
                                && j + corner_j > 1
                                && j + corner_j < 9
                            )*/
                            translate(
                                [corner_i, corner_j]
                                * (1 - corner_factor * 2) * anti_square_size
                            )
                            difference() {
                                translate(
                                    [corner_i, corner_j]
                                    * anti_square_size * corner_factor
                                    - [0.01, 0.01]
                                )
                                square(anti_square_size * corner_factor + 0.02)
                                    ;
                                translate([1, 1] * anti_square_size * corner_factor)
                                circle(anti_square_size * corner_factor)
                                    ;
                            }
                                ;
                        }
                            ;
                    }
                }
                    ;
                // corners
                //translate([i - 1, j - 1, 0] * square_size)
                //cylinder(r=3, h=top_thick)
                    //;
            }
        }
            ;
        difference() {
            minkowski() {
                square(square_size * 8)
                    ;
                circle(board_inner_margin + expand)
                    ;
            }
                ;
            translate([1, 1] * expand)
            square(square_size * 8 - 0.001 - expand * 2)
                ;
        }
    }
}

module board_base(square_size) {
    difference() {
        linear_extrude(board_thick)
        minkowski() {
            square(square_size * 8)
                ;
            circle(board_margin)
                ;
        }
            ;
        translate([0, 0, board_thick - top_thick])
        scale([1, 1, 1.01])
        board_top(square_size, expand=expand)
            ;
    }
        ;
}


module board_combined(square_size) {
    color([0.2, 0.2, 0.2])
    board_base(square_size)
        ;
    color([1, 1, 1])
    translate([0, 0, board_thick - top_thick])  // todo
    board_top(square_size)
        ;
}

BOARD_BASE = 1;
BOARD_TOP = 2;
BOARD_COMBINED = 3;
ALL = 4;

RENDER = BOARD_COMBINED;


if (RENDER == BOARD_BASE) {
    board_base(square_size)
        ;
}
if (RENDER == BOARD_TOP) {
    board_top(square_size)
        ;
}
if (RENDER == BOARD_COMBINED) {
    board_combined(square_size)
        ;
}

if (RENDER == ALL) {
    translate([square_size / 2, square_size / 2, 0])
    board_layout(square_size)
        ;
    translate([0, 0, -board_thick])
    board_combined(square_size)
        ;
}


