CONTRACTED = true;
// 16.8=4+8+4.8, so offs = 4.8+2+4 = 10.8ish
VOFFS = CONTRACTED ? 10.8: 22.2;
HOFFS = 22.2 / 2;

PAIR_W = 6.35;
PAIR_H = 4;
PAIR_Z = 17.7;

SINGLE_W = 4;
SINGLE_H = 7.93;
SINGLE_Z = 22.73;

PINS_EXPAND = 0.15;


module cutout_base(expand=0) {
    for (xoffs = [-HOFFS, HOFFS])
    translate([xoffs, 0])
    square([
        PAIR_W + expand,
        PAIR_H + expand
    ], center=true)
        ;
    translate([0, VOFFS])
    square([
        SINGLE_W + expand,
        SINGLE_H + expand
    ], center=true)
        ;
}


module smoothed_plug(mink=2) {
    linear_extrude(0.01)
    minkowski() {
        hull()
        cutout_base(expand=-2)
            ;
        circle(r=2 + mink, $fn=50)
            ;
    }
        ;
}


module plug_segment(r0, r1, z0, z1) {
    hull() {
        translate([0, 0, z0])
        smoothed_plug(r0)
            ;
        translate([0, 0, z1])
        smoothed_plug(r1)
            ;
    }
        ;
}


difference() {
    union() {
        plug_segment(6, 6, SINGLE_Z, 20)
            ;
        plug_segment(6, 4, 20, 16)
            ;
        plug_segment(4, 4, 16, 8)
            ;
        plug_segment(4, 5.75, 8, 7.5)
            ;
        plug_segment(5.75, 6, 7.5, 7)
            ;
        plug_segment(6, 6, 7, 5)
            ;
        plug_segment(6, 1, 5, 0.5)
            ;
    }
        ;
    linear_extrude(999, center=true)
    cutout_base(expand=PINS_EXPAND)
        ;
    translate([0, 0, SINGLE_Z])
    hull() {
        translate([0, 0, 0.01])
        linear_extrude(0.01)
        cutout_base(expand=5)
            ;
        translate([0, 0, -3])
        linear_extrude(0.01)
        cutout_base(expand=PINS_EXPAND)
            ;
    }
}
