VOFFS = 22.2;
HOFFS = 22.2 / 2;

PAIR_W = 6.35;
PAIR_H = 4;
PAIR_Z = 17.7;

SINGLE_W = 4;
SINGLE_H = 7.93;
SINGLE_Z = 22.73;


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


rotate([180, 0, 0])
difference() {
    union() {
        plug_segment(6, 6, 0, SINGLE_Z - 16)
            ;
        plug_segment(6, 4.5, SINGLE_Z - 16, SINGLE_Z - 12)
            ;
        plug_segment(4.5, 4.5, SINGLE_Z - 12, SINGLE_Z - 8)
            ;
        plug_segment(4.5, 6, SINGLE_Z - 8, SINGLE_Z - 7)
            ;
        plug_segment(6, 6, SINGLE_Z - 7, SINGLE_Z - 5)
            ;
        plug_segment(6, 1, SINGLE_Z - 5, SINGLE_Z - 0.5)
            ;
    }
        ;
    linear_extrude(999, center=true)
    cutout_base(expand=0.1)
        ;
}
