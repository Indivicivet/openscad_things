BOARD_R = 50;
CIRC_EXTEND_RATIO = 0.0;
BASE_EXTEND_RATIO = 0.001;

GAP_W = 1.65;
EDGE_W = 1.3;
MINK_R = 0.8;

// 3D params
BASE_H = 3;
MID_RAISE = 1.5;
EDGE_RAISE = 3.5;


module myline(gap_w)
square([gap_w + MINK_R * 2, BOARD_R * 2.2], center=true)
    ;

module top_plate(gap_w=GAP_W, cull_outside_board=false)
minkowski() {
    difference() {
        circle(r=BOARD_R * (1 + CIRC_EXTEND_RATIO) - MINK_R, $fn=100)
            ;
        for (i=[0:7]) {
            rotate(i * 45)
            myline(gap_w=gap_w)
                ;
            rotate(i * 45)
            translate([BOARD_R / sqrt(2), 0])
            myline(gap_w=gap_w)
                ;
            rotate(i * 45 + 22.5)
            translate([BOARD_R * cos(22.5), 0])
            myline(gap_w=gap_w)
                ;
            rotate(i * 45 + 22.5)
            translate([BOARD_R * sin(22.5), 0])
            myline(gap_w=gap_w)
                    ;
            // fill in the outer pieces as they are border pieces
            // not scoreable
            if(cull_outside_board)
            rotate(i * 45 + 22.5)
            translate([BOARD_R * cos(22.5), -BOARD_R * 1.5])
            square([999, BOARD_R * 3])
                ;
        }
            ;
    }
        ;
    circle(r=MINK_R, $fn=20)
        ;
}
    ;


linear_extrude(BASE_H)
circle(r=BOARD_R * (1 + CIRC_EXTEND_RATIO + BASE_EXTEND_RATIO), $fn=100)
    ;
// edges:
translate([0, 0, BASE_H - 0.001])
linear_extrude(EDGE_RAISE)
difference() {
    top_plate()
        ;
    top_plate(gap_w=GAP_W + EDGE_W, cull_outside_board=true)
        ;
}
translate([0, 0, BASE_H - 0.001])
linear_extrude(MID_RAISE)
top_plate()
    ;

