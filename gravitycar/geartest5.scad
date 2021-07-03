use <simplestar.scad>;

GEAR = 1;
PIN = 2;
HOLDER = 3;
GEARHOLDERALIGNED = 4;

SHOW_PART = 4;

// gearstuff
gear1h = 2;
gear1n = 36;
gear1outer = 36 * 0.6;
gear1inner = gear1outer * 0.95 - 2.5;
buffer0height = 0;
buffer1height = 0.5;
buffer2height = 1;
gear2h = 3;
gear2n = 12;
gear2outer = 12 * 0.7;
gear2inner = gear2outer * 0.95 - 2.5;

gearheighttol = 0.6;

gearsheight = (
    buffer0height
    + gear1h + buffer1height
    + gear2h + buffer2height
    + gearheighttol
);

doubleheight = 2 * gearsheight;

axlerad = 2.5;
axletol = 0.25;
axleslotr = axletol * 4;

// rack stuff
extragears = 1;  // NUMBER OF EXTRA GEARS
postshiftamt = gear1h + buffer1height + 0.5;

axleslottol = 0.45;
axleslotrad = axlerad + axleslottol;
aboveaxle = 2;
bottombuffer = 4;
volheight = gear1outer + axleslotrad * 2 + aboveaxle + bottombuffer;

span = gear1outer + gear2inner + 0.75; // twiddly
ext = (gear1outer - gear2inner) * 0.6;

holderthick = 3.5;
holdermink = 1.5;
holdermink2 = holdermink * 2;

holderbufferthick = 0.6;

minbasesize = gearsheight + holderthick * 2 + extragears * postshiftamt;
baserat = 1.5;
basethick = 3;
basemink = 4;

// pin stuff

rodheight = gearsheight + holderthick * 2 + holderthick;
nobbler = axleslotr * 0.5;
nobbleh = gearsheight * 0.8;
endh = 1;

module gear() {
    difference() {
        union() {
            cylinder(buffer0height, r=gear1outer * 0.9 - 4, $fn=50)
                ;
            translate([0, 0, buffer0height])
            linear_extrude(gear1h)
            star(gear1n, gear1outer, gear1inner)
                ;
            translate([0, 0, buffer0height + gear1h])
            cylinder(buffer1height, r=gear1outer * 0.9 - 4, $fn=50)
                ;
            translate([0, 0, buffer0height + gear1h + buffer1height])
            linear_extrude(gear2h)
            star(gear2n, gear2outer, gear2inner)
                ;
            translate([0, 0, buffer0height + gear1h + buffer1height + gear2h])
            cylinder(buffer2height, r=gear2outer * 0.9 - 2.2, $fn=50)
                ;
        }
            ;
        translate([0, 0, -0.01])
        linear_extrude(doubleheight)
        union() {
            circle(axlerad + axletol, $fn=50)
                ;
            translate([axlerad + axletol, 0])
            circle(axleslotr, $fn=20)
                ;
        }
            ;
    }
        ;
}

module pin() {
    translate([0, 0, -endh])
    cylinder(r=axlerad + axletol * 3, h=endh, $fn=20)
        ;
    cylinder(r=axlerad, h=rodheight, $fn=30)
        ;
    translate([0, 0, rodheight])
    hull() {
        sphere(axlerad, $fn=30)
            ;
        translate([0, 0, axlerad * 0.9])
        sphere(axlerad / 2, $fn = 30)
            ;
    }
        ;
    translate([axlerad + axletol / 2, 0, rodheight / 2])
    union() {
        translate([0, 0, nobbleh * 0.5])
        sphere(nobbler, $fn=20)
            ;
        cylinder(r=nobbler, h=nobbleh, center=true, $fn=20)
            ;
        translate([0, 0, -nobbleh * 0.5])
        sphere(nobbler, $fn=20)
            ;
    }
        ;
}

module holder() {
    linear_extrude(basethick)
    minkowski() {
        translate([-minbasesize * (baserat - 1) / 2, 0])
        square([
            minbasesize * baserat - basemink * 2,
            span * extragears + ext - basemink * 2
        ])
            ;
        translate([basemink, basemink])
        circle(basemink)
            ;
    }
        ;
    
    for (i = [0, 1]) {
        for (j = [0:extragears]) {
            translate([
                (
                    i * (gearsheight + holderthick + holderbufferthick)
                    + j * postshiftamt
                ),
                j * span,
                volheight
            ])
            rotate([0, 90, 0])
            union() {
                linear_extrude(holderthick)
                difference() {
                    translate([holdermink, holdermink])
                    minkowski() {
                        square([
                            volheight - holdermink2,
                            ext - holdermink2
                        ])
                            ;
                        circle(holdermink, $fn=20)
                            ;
                    }
                        ;
                    union() {
                        translate([aboveaxle + axleslotrad, ext / 2])
                        circle(r=axleslotrad, $fn=20)
                            ;
                        translate([aboveaxle / 2, ext / 2])
                        square(
                            [aboveaxle * 1.95, axleslotrad * 1.0],
                            center=true
                        )
                            ;
                    }
                        ;
                }
                    ;
                if (i == 0) {
                    translate([0, 0, holderthick - 0.01])
                    translate([aboveaxle + axleslotrad, ext / 2])
                    linear_extrude(holderbufferthick)
                    difference() {
                        circle(axleslotrad * 1.5, $fn=20)
                            ;
                        union() {
                            circle(axleslotrad, $fn=20)
                                ;
                            translate([-axleslotrad, 0])
                            square(
                                [axleslotrad * 2, axleslotrad * 1.0],
                                center=true
                            )
                                ;
                        }
                            ;
                    }
                        ;
                }
                    ;
            }
                ;
        }
            ;
    }
        ;
}

if (SHOW_PART == GEAR) {
    gear()
        ;
}

if (SHOW_PART == PIN) {
    pin()
        ;
}

if (SHOW_PART == HOLDER) {
    holder()
        ;
}

if (SHOW_PART == GEARHOLDERALIGNED) {
    // just gear but align with rack
    for (i = [0:extragears]) {
        translate([
            holderthick + gearheighttol / 2 + i * postshiftamt + holderbufferthick,
            ext / 2 + i * span,
            volheight - aboveaxle - axleslotrad
        ])
        rotate([5, 0, 0])
        rotate([0, 90, 0])
        union() {
            color([
                0.3,
                1 - 0.7 * i / extragears,
                0.3 * (1 + 2 * i / extragears)
            ], alpha=0.8)
            gear()
                ;
            translate([0, 0, (gearsheight - rodheight) / 2])
            color([0.3, 0.3, 1], alpha=0.6)
            pin()
                ;
        }
    }
    color("red", alpha=0.5)
    holder()
        ;
}
