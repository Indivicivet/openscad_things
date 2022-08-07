$fn = 100;

FOOT_DIAM = 40;
FOOT_THICK_OUTER = 1.5;
FOOT_THICK_MID = 2;
FOOT_THICK_INNER = 2.25;
INNER_THIN_THICK = 1.5;
INNER_THIN_DIAM = 15.5;

RANDOM_HOLE_OFFS = 4;
RANDOM_HOLE_DIAM = 3.5;

SOCKET_INNER_BOTTOM = 18.75;
SOCKET_INNER_TOP = 20.5;
SOCKET_INNER_ADJUST = 0.0;
SOCKET_OUTER_TOP = 23;
SOCKET_OUTER_BOTTOM = 25;

TOTAL_HEIGHT = 9.75;

difference() {
    union() {
        hull() {
            linear_extrude(FOOT_THICK_OUTER)
            circle(d=FOOT_DIAM)
                ;
            linear_extrude(FOOT_THICK_MID)
            circle(d=SOCKET_OUTER_BOTTOM)
                ;
        }
            ;
        hull() {
            linear_extrude(FOOT_THICK_MID)
            circle(d=SOCKET_OUTER_BOTTOM)
                ;
            linear_extrude(TOTAL_HEIGHT)
            circle(d=SOCKET_OUTER_TOP)
                ;
        }
            ;
        linear_extrude(FOOT_THICK_INNER)
        circle(d=SOCKET_INNER_TOP)
            ;
    }
        ;
    linear_extrude(999, center=true)
    translate([RANDOM_HOLE_OFFS, 0])
    circle(d=RANDOM_HOLE_DIAM)
        ;
    translate([0, 0, INNER_THIN_THICK])
    linear_extrude(999)
    circle(d=INNER_THIN_DIAM)
        ;
    hull() {
        translate([0, 0, FOOT_THICK_INNER - 0.01])
        linear_extrude(0.01)
        circle(d=SOCKET_INNER_BOTTOM + SOCKET_INNER_ADJUST)
            ;
        translate([0, 0, TOTAL_HEIGHT])
        linear_extrude(0.01)
        circle(d=SOCKET_INNER_TOP + SOCKET_INNER_ADJUST)
            ;
    }
        ;
}
