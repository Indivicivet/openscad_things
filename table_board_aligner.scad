
INSERT_AMOUNT = 15;
BOARD_THICK = 5;
GAP_SIZE = BOARD_THICK + 1;
SIDE_THICK = 3;
TOP_THICK = 3;
LENGTH = 80;
MIDPOINT_BEVEL_THICK = 5;

difference() {
    rotate([-90, 0, 0])
    mirror([0, 1, 0])
    linear_extrude(SIDE_THICK * 2 + GAP_SIZE)
    union() {
        difference() {
            square([LENGTH, INSERT_AMOUNT + TOP_THICK])
                ;
            for (xoffs = [0, LENGTH - INSERT_AMOUNT])
            translate([xoffs, TOP_THICK])
            square([INSERT_AMOUNT, INSERT_AMOUNT])
                ;
        }
            ;
        for (xoffs = [INSERT_AMOUNT, LENGTH - INSERT_AMOUNT])
        translate([xoffs, TOP_THICK])
        intersection() {
            circle(INSERT_AMOUNT)
                ;
            translate([-99, 0])
            square(999)
                ;
        }
    }
    translate([-1, SIDE_THICK, TOP_THICK])
    cube([999, GAP_SIZE, 999])
        ;
}

translate([LENGTH / 2, SIDE_THICK + GAP_SIZE / 2, TOP_THICK])
intersection() {
    rotate([0, 45, 0])
    cube(
        [MIDPOINT_BEVEL_THICK, SIDE_THICK * 2 + GAP_SIZE, MIDPOINT_BEVEL_THICK],
        center=true
    )
        ;
    translate([-99, -99, 0])
    cube(999)
        ;
}
