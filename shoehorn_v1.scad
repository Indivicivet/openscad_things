$fn = 80;

module wedge(theta, r) {
    rotate(-theta/2)
    polygon(r * [
        [0, 0],
        [1, 0],
        [cos(theta), sin(theta)]
    ])
        ;
}

roc = 27.5;
height = 140;
sphere_vscale = 2;

intersection() {
    linear_extrude(height)
    minkowski() {
        intersection() {
            difference() {
                circle(r=roc + 0.01)
                    ;
                circle(r=roc)
                    ;
            }
                ;
            wedge(130, roc * 10)
                ;
        }
            ;
        circle(r=2)
            ;
    }
        ;
    union() {
        translate([roc, 0, height - roc * sqrt(2) * sphere_vscale])
        scale([1, 1, sphere_vscale])
        sphere(r=roc * sqrt(2))
            ;
        translate([0, -roc * 50, 0])
        cube([roc * 100, roc * 100, height - roc * sqrt(2)])
            ;
    }
}