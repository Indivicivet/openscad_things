rad = 12;
radinner = 10;
incut = 1.5;
h = 10;

difference() {
    cylinder(h=h, r=rad, $fn=10)
        ;
    translate([0, 0, -1])
    cylinder(h=h+2, r=radinner, $fn=20)
        ;
    for (i = [0:9]) {
        rotate([0, 0, i * 360 / 10])
        translate([0, incut - rad, h / 2])
        rotate([90, 90, 0])
        linear_extrude(height=incut)
        text(str(i), size=rad / 2, halign="center", valign="center")
            ;
    }
        ;
}
    ;
