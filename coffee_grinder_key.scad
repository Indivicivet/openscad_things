// grinder adjust key for Jura X8
// grinder geom - outer d~20mm, inner d~13mm, nobule size~3.5mm, central dowel d~5mm

$fn = 50;

BEANS = true;

KNOB_H = 12;
CLEARANCE = 40;
NCUTS = 5;

OUTER_D = 20;
TOOL_D = OUTER_D - 1.5;
NOBULE_R = 3.5;
NOBULE_CUT = NOBULE_R + 0.8;
NOBULE_ASPECT = 0.75; // kinda fudgey
CENTRAL_DOWEL_D = 5;
DOWEL_CUT_D = CENTRAL_DOWEL_D + 1.5;

difference() {
    union() {
        linear_extrude(KNOB_H)
        scale(1.1)  // I liked the ratios, so being cheeky and just scaling
        minkowski() {
            difference() {
                circle(r=18)
                    ;
                for (i=[0:NCUTS-1])
                rotate((i + 0.5)*360/NCUTS)
                translate([21.5, 0]) // stiffer than beans ergo more incut for grippiness
                circle(r=9)
                    ;
            }
                ;
            circle(r=2)
                ;
        }
            ;
        linear_extrude(KNOB_H + CLEARANCE)
        difference() {
            circle(d=TOOL_D)
                ;
            for (i=[0:5])
            rotate(i * 60)
            translate([OUTER_D / 2, 0])
            scale([1, NOBULE_ASPECT])
            circle(r=NOBULE_CUT)
                ;
            circle(d=DOWEL_CUT_D)
                ;
        }
    }
        ;
    linear_extrude(2, center=true)
    mirror()
    union() {
        rotate(90)
        scale(0.7)
        text("Grinder", halign="center", valign="center")
            ;
    }
}
