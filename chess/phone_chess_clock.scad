$fn = 20;

module buttons() {
    // core
    linear_extrude(40, center=true)
    difference() {
        union() {
            circle(8)
                ;
            translate([0, 2.5])
            for (i = [-1, 1])
            translate([25 * i, 0])
            rotate(8 * i)
            union() {
                square([50, 6], center=true)
                    ;
                translate([25 * i, 0])
                hull() {
                    circle(3)
                        ;
                    translate([4 * i, -1])
                    circle(1)
                        ;
                }
            }
                ;
        }
            ;
        circle(4)
            ;
    }
        ;
    // button pads
    translate([0, 1.96, 0])
    for (i = [-1, 1])
    rotate([0, 0, 8 * i])
    translate([36 * i, 0, 0])
    hull() {
        cube([25, 0.1, 35], center=true)
            ;
        translate([0, 3, 0])
        cube([13, 0.1, 25], center=true)
            ;
    }
        ;
    // camera target bar
    translate([0, 0, -20])
    linear_extrude(3)
    for (i = [-1, 1])
    //rotate(8 * i)
    translate([-35 * i, -30 + 5])
    translate([-4, 0, 0])
    square([8, 30])
        ;
}

buttons()
    ;

/*translate([0, 0, 5])
cube([80, 30, 10], center=true)
    ;
*/