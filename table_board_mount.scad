
TABLE_SEP = 12;
TABLE_ASYM = 2.5;
INSERT_AMOUNT = 15;
BOARD_THICK = 5;
GAP_SIZE = BOARD_THICK + 1;
BASE_WIDTH = 80;
SUPPORT_HEIGHT = 55;
TRIANGLE_CUT = 30;
BASE_HEIGHT = 10;
THICKNESS = 20;


module mirror_copy(axis) {
    children()
        ;
    mirror(axis)
    children()
        ;
}


for (xoffs=[0, BASE_WIDTH + 10])
translate([xoffs, 0, 0])
linear_extrude(THICKNESS) {
    translate([-TABLE_SEP / 2, -INSERT_AMOUNT])
    square([TABLE_SEP, INSERT_AMOUNT])
        ;
    translate([-TABLE_SEP / 2, 0])
    square([BASE_WIDTH / 2 + TABLE_SEP / 2, TABLE_ASYM + 0.01])
        ;
    translate([-BASE_WIDTH / 2, TABLE_ASYM])
    square([BASE_WIDTH, BASE_HEIGHT])
        ;
    translate([0, BASE_HEIGHT + TABLE_ASYM])
    difference() {
        mirror_copy()
        polygon([
            [-BASE_WIDTH / 2, 0],
            [0, SUPPORT_HEIGHT + TRIANGLE_CUT],
            [0, 0]
        ])
            ;
        translate([-GAP_SIZE / 2, 0])
        square([GAP_SIZE, SUPPORT_HEIGHT + TRIANGLE_CUT])
            ;
        translate([-BASE_WIDTH / 2, SUPPORT_HEIGHT])
        square([BASE_WIDTH, 50])
            ;
    }
        ;
        
}
    ;
