// replacement feet for Logitech K120

INSERT_H = 3.5;

T_WIDTH = 16.8;
BAR_HEIGHT = 24.5;

FAR_EDGE_DISTANCE = 100;
DESIRED_H = 15;  // at the top of the T
ROT = atan2(DESIRED_H, FAR_EDGE_DISTANCE);

module insert_2d(h_expand=10, v_expand=6) {
    translate([-T_WIDTH / 2 - h_expand, 0])
    square([T_WIDTH + h_expand * 2, BAR_HEIGHT])
        ;
    translate([-T_WIDTH / 2, 0])
    square([T_WIDTH, BAR_HEIGHT + v_expand])
        ;
}

module surrounder_plate(h_expand=13, v_expand=12)
linear_extrude(0.01)
translate([-T_WIDTH / 2 - h_expand, -(v_expand-6)/2])
square([T_WIDTH + h_expand * 2, BAR_HEIGHT + v_expand])
    ;

module cap_solid() {
    rotate([ROT, 0, 0])
    linear_extrude(INSERT_H)
    insert_2d()
        ;
    hull() {
        rotate([ROT, 0, 0])
        surrounder_plate()
            ;
        translate([0, 0, -DESIRED_H])
        surrounder_plate()
            ;
    }
        ;
}

difference() {
    cap_solid()
        ;
    // for easier sticking (and un-sticking!)
    translate([0, BAR_HEIGHT / 2, 0])
    cylinder(r=BAR_HEIGHT * 0.3, h=999, center=true)
        ;
}
