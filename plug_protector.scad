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

linear_extrude(SINGLE_Z - 1)
difference() {
    minkowski() {
        hull()
        cutout_base(expand=-2)
            ;
        circle(r=8, $fn=50)
            ;
    }
        ;
    cutout_base(expand=0.1)
        ;
}
