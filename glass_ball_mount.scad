radius = 30;

$fn = 50;

module the_ball() {
    translate([0, 0, radius + 2])
    sphere(r=radius, $fn=200)
        ;
}

color([0.25, 0.25, 0.25])
difference() {
    intersection() {
        translate([-50, -50, 0])
        cube([100, 100, 100])
            ;
        union() {
            minkowski(){
                cylinder(r=radius * 0.8, h=4)
                    ;
                translate([0, 0, 1])
                sphere(r=1)
                    ;
            }
                ;
            for (i=[1:10]) {
                rotate(360/10 * i)
                translate([
                    radius * (0.62 + 0.8 * ((i + 1) % 3.3) / 30),
                    0,
                    7 + (i % 2.5)
                ])
                sphere(r=4)
                    ;
            }
                ;
            for (i=[0:25]) {
                rotate(360/6.7 * i + 18)
                translate([
                    radius * (0.66 + ((i+2) % 2.3) / 30),
                    0, 2])
                cylinder(
                    r=2.5 + 0.75*(i%4),
                    h=3 + 2 * (floor(i/8)%2)
                )
                    ;
            }
                ;
        }
            ;
    }
        ;
    the_ball()
        ;
    cylinder(r=radius * 0.3, h=10);
}

//color([1, 0, 0, 0.3]) the_ball();
