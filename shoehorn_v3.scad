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


// very hacky post-hoc way to smooth this :)
for (dy = [0:0.1:1])
linear_extrude(4 + dy - 1)
curved_base(expand=7 - dy * dy, inspand=3)
	;


linear_extrude(height * 0.8)
for (sign = [-1, 0, 1])
rotate(30 * sign)
translate([roc + 1, 0])
circle(r=1)
    ;
