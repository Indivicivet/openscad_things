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

roc = 26;
height = 160;
sphere_vscale = 3;

module curved_base (expand=0.01, inspand=0) {
    minkowski() {
        intersection() {
            difference() {
                circle(r=roc + expand)
                    ;
                circle(r=roc - inspand)
                    ;
            }
                ;
            wedge(115, roc * 10)
                ;
        }
            ;
        circle(r=1.33)
            ;
    }
        ;
}

intersection() {
    linear_extrude(height)
    curved_base()
        ;
    union() {
        translate([roc, 0, height - roc * sqrt(2) * sphere_vscale])
        scale([1, 1, sphere_vscale])
        sphere(r=roc * sqrt(2))
            ;
        translate([0, -roc * 50, 0])
        cube([roc * 100, roc * 100, height - roc * sqrt(2) * sphere_vscale])
            ;
    }
}

linear_extrude(4)
curved_base(expand=7, inspand=3)
	;
