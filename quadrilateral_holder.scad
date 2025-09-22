// quadrilateral holder -- pair can be joined by rubber band etc

$fn = 32;

THETA_1 = 114;
THETA_2 = 130.5;
BASE_THICK = 4;
BASE_R = 15;
BAND_THICK = BASE_THICK * 0.6;
BAND_GROOVE = 1;

module pacman(theta, outer_only=false)
difference() {
    linear_extrude(BASE_THICK)
    difference() {
        circle(r=BASE_R)
            ;
        polygon([
            [0, 0],
            [cos(theta/2), -sin(theta/2)] * BASE_R * 10,
            [BASE_R * 100, 0],
            [cos(theta/2), sin(theta/2)] * BASE_R * 10
        ])
            ;
        translate([-BASE_R * 0.5, 0])
        circle(d=6.2)
            ;
        if (outer_only)
        circle(r=BASE_R * 0.75)
            ;
    }
        ;
    translate([0, 0, (BASE_THICK - BAND_THICK) / 2])
    rotate_extrude()
    translate([BASE_R - BAND_GROOVE, 0])
    hull () {
        translate([0, BAND_GROOVE])
        square([BAND_GROOVE + 1, BAND_THICK - BAND_GROOVE * 2])
            ;
        translate([BAND_GROOVE, 0])
        square([BAND_GROOVE, BAND_THICK])
            ;
    }
}


module pacman_with_top(theta) {
    pacman(theta)
        ;
    translate([0, 0, BASE_THICK])
    pacman(270, outer_only=true)
        ;
}


PREVIEW = false;  // otherwise print

pacman_with_top(THETA_1)
    ;

if(PREVIEW)
color("red")
translate([BASE_R * 0.3, 0, 2 * BASE_THICK])
rotate([180, 0, 180])
pacman_with_top(THETA_2)
    ;

if(!PREVIEW)
translate([BASE_R * 2, -00, 0])
pacman_with_top(THETA_2)
    ;
