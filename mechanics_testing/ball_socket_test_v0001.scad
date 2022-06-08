DELTA = 0.5;
INNER_R = 8;
OUTER_THICK = 3;

ROD_R = 3.5;

$fn = 50;


intersection() {
    translate([0, 0, -ROD_R])
    linear_extrude(999)
    square(999, center=true)
        ;
    union() {
        // here is the hinge part:
        difference() {
            sphere(r=INNER_R + DELTA + OUTER_THICK)
                ;
            sphere(r=INNER_R + DELTA)
                ;
            rotate([-90, 0, 0])
            cylinder(r=ROD_R + DELTA, h=999)
                ;
            translate([0, INNER_R, -ROD_R - DELTA])
            cube([(ROD_R + DELTA) * 2, OUTER_THICK * 3, (ROD_R + DELTA) * 2], center=true)
                ;
        }
            ;
        translate([0, 0, INNER_R + DELTA])
        cylinder(r=ROD_R, h=40)
            ;
        sphere(r=INNER_R)
            ;
        rotate([-90, 0, 0])
        cylinder(r=ROD_R, h=50)
            ;
    }
}
