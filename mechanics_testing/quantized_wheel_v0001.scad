module pip(delta=0) {
    hull() {
        cube([3 + delta, 3 + delta, 0.01], center=true)
            ;
        translate([0, 0, 1])
        cube([1 + delta, 1 + delta, 0.01], center=true)
            ;
    }
        ;
}

module wheel(n, r, pips_r, rod_d, h) {
    difference() {
        linear_extrude(h)
        rotate(360 / n * 0.5)
        difference() {
            circle(r=r, $fn=n)
                ;
            circle(d=rod_d)
                ;
            for (i = [0 : n])
            rotate(i / n * 360)
            translate([r, 0])
            scale([1, 2])
            circle(r=2)
                ;
        }
            ;
        for (i = [0 : n])
        rotate(i / n * 360)
        translate([pips_r, 0, h])
        rotate([180, 0, 0])
        pip(delta=-0.1)
            ;
    }
}

module base(rod_d, pips_r, base_h) {
    cylinder(h=base_h + 15, d=rod_d)
        ;
    linear_extrude(base_h)
    square([20, 80], center=true)
        ;
    cylinder(h=base_h, r=pips_r + 3)
        ;
    translate([pips_r, 0, base_h])
    pip(delta=0.1)
        ;
}

WHEEL = 0;
BASE = 1;
ASSEMBLY = 2;
PRINTABLE = 3;

$fn = 50;
SHOW = PRINTABLE;
SHOW_N = 10;
SHOW_R = 30;
SHOW_PIPS_R = 20;
SHOW_ROD_D = 10;
SHOW_ROD_EPS = 1;
SHOW_BASE_H = 4;
SHOW_WHEEL_H = 4;

module show_wheel() {
    wheel(SHOW_N, SHOW_R, SHOW_PIPS_R, SHOW_ROD_D + SHOW_ROD_EPS, SHOW_WHEEL_H);
}

module show_base() {
    base(SHOW_ROD_D, SHOW_PIPS_R, SHOW_BASE_H);
}

if (SHOW == WHEEL) {
    show_wheel();
}
if (SHOW == BASE) {
    show_base();
}
if (SHOW == ASSEMBLY) {
    translate([0, 0, SHOW_BASE_H + SHOW_WHEEL_H + 1])
    color([0, 0, 1, 0.3])
    rotate([180, 0, 0])
    show_wheel()
        ;
    show_base();
}
if (SHOW == PRINTABLE) {
    translate([60, 0, 0])
    show_wheel()
        ;
    show_base();
}
