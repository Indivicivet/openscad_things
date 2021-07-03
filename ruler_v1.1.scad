n = 30;

thick = 2;
high = 18;
length = n * 10;

lower_mink = 5;

module notch(x_scale=1, y_scale=2) {
    translate([0, high + 0.01, -0.01])
    scale([x_scale, y_scale, 1])
    rotate(30)
    cylinder(r=1, h=99, $fn=3)
        ;
}

difference() {
    union() {
        translate([0, lower_mink, 0])
        cube([length, high - lower_mink, thick])
            ;
        minkowski() {
            cube([length - lower_mink * 2, 0.01, thick - 0.01])
                ;
            translate([lower_mink, lower_mink, 0])
            cylinder(h=0.01, r=lower_mink)
                ;
        }
    }
        ;
    for (i = [1:n]) {
        translate([10 * i, 0, 0])
        union() {
            if (i < n) {
                translate([0, high * (0.5 + 0.05 * (-1) ^ i), thick / 2])
                linear_extrude(999)
                text(
                    str(i),
                    size=i < 10 ? high/2 : high * 0.3,
                    halign="center", valign="center"
                )
                    ;
                notch(1.5, 3)
                    ;
            }
                ;
            translate([-5, 0, 0])
            notch(1, 2)
                ;
        }
            ;
    }
        ;
}