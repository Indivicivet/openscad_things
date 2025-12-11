BOARD_R = 50;
CIRC_EXTEND_RATIO = 0.0;

GAP_W = 2;
MINK_R = 0.7;


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
        translate([BOARD_R * cos(22.5), 0])
        myline()
            ;
        for (i=[0:7])
        rotate(i * 45)
        translate([BOARD_R / sqrt(2), 0])
        myline()
            ;
        for (i=[0:7])
        rotate(i * 45 + 22.5)
        translate([BOARD_R * sin(22.5), 0])
        myline()
            ;
    }
        ;
    circle(r=MINK_R, fn=30)
        ;
}
