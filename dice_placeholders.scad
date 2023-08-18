CUBE_W = 16;
TET_R = 17;
OCT_R = 13;

for (i=[0:2])
for (yoffs=[i * TET_R * 2])
translate([0, yoffs, 0])
union() {
    cube(CUBE_W)
        ;
    translate([CUBE_W + TET_R, TET_R, 0])
    hull() {
        linear_extrude(0.001)
        circle(r=TET_R, $fn=3)
            ;
        translate([0, 0, TET_R * sqrt(3/2)])
        linear_extrude(0.001)
        circle(r=0.001, $fn=3)
            ;
    }
        ;
    translate([CUBE_W + TET_R * 2 + OCT_R, OCT_R, 0])
    hull() {
        linear_extrude(0.001)
        circle(r=OCT_R, $fn=3)
            ;
        translate([0, 0, OCT_R * 4/3])
        linear_extrude(0.001)
        rotate(60)
        circle(r=OCT_R, $fn=3)
            ;
    }
        ;
}
