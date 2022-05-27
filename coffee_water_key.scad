// water key for Jura X8

$fn = 50;

TO_EDGE_45 = 30 * sqrt(2);
CATCHER_R = 2;
TO_ROD_45 = (30 + CATCHER_R + 1) * sqrt(2);

KNOB_H = 12;
TOTAL_H = KNOB_H + 9; // hex about 7mm
NCUTS = 5;

difference() {
    union() {
        linear_extrude(KNOB_H)
        minkowski() {
            difference() {
                circle(r=18)
                    ;
                for (i=[0:NCUTS-1])
                rotate(- 45 + (i + 0.5)*360/NCUTS)
                translate([23, 0])
                circle(r=9, h=99)
                    ;
            }
                ;
            circle(r=2)
                ;
        }
            ;
        rotate(-45)
        union() {
            linear_extrude(KNOB_H / 2)
            translate([TO_ROD_45 / 2, 0])
            square([TO_ROD_45, CATCHER_R * 2], center=true)
                ;
            translate([TO_ROD_45, 0])
            cylinder(r=CATCHER_R, h=TOTAL_H)
                ;
        }
            ;
        cylinder(r=10/sqrt(3) - 0.02, h=TOTAL_H, $fn=6)
            ;
    }
        ;
    linear_extrude(2, center=true)
    mirror()
    union() {
        rotate(90)
        union() {
            translate([-7, 0])
            text("H", halign="center", valign="center")
                ;
            translate([7, 0])
            text("O", halign="center", valign="center")
                ;
            translate([0, -5])
            scale(0.7)
            text("2", halign="center", valign="center")
                ;
        }
            ;
        translate([13, 0])
        circle(r=3, $fn=3)
            ;
    }
}
