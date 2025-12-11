BOARD_R = 50;
CIRC_EXTEND_RATIO = 0.1;

GAP_W = 3;
MINK_R = 1.5;


module myline()
square([GAP_W + MINK_R * 2, BOARD_R * 2.2], center=true)
    ;


minkowski() {
    difference() {
        circle(r=BOARD_R * (1 + CIRC_EXTEND_RATIO), $fn=100)
            ;
        for (i=[0:7])
        rotate(i * 45)
        myline()
            ;
        for (i=[0:7])
        rotate(i * 45 + 22.5)
        translate([BOARD_R, 0])
        myline()
            ;
    }
        ;
    circle(r=MINK_R, fn=30)
        ;
}
