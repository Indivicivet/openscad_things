$fn = 20;

JACK = 1;
CHASSIS = 2;
WHEEL = 3;
AXLEJOIN_GEARED = 41;
AXLEJOIN_SMOOTH = 42;
ASSEMBLED = 5;
ASSEMBLED_MULTIPOS = 6;

RENDERING = ASSEMBLED;

// generic / defaults
g_thick = 2;
my_fav_gear_out = 3;

// all the mounty box stuff
jack_w = 80;
jack_l = 50;
jack_h = 60;
jack_basethick = 3;
jack_sidethick = 2;
jack_sidegap = jack_l - 20;
jack_col = "red";

rack_d = 2;
rack_w = 10;

// todo :: match with gears
racktooth_out = my_fav_gear_out;
racktooth_h = 2.5;
racktooth_count = (jack_h - 15) / racktooth_h;

rackguide_w = 6;
rackguide_d = 5;

// wheels

wheel_thick = 12;
wheel_r = 30;
wheel_fn = 50;
wheel_col = [0.2, 1, 0.3];

treads_n = 30;
treads_d = 0.75;
treads_w = 2.5;

wheelcutouts_n = 6;
wheelcutouts_pos = wheel_r * 0.65;
wheelcutouts_r = wheel_r * 0.225;

// chassis etc

chassis_thick = 5;
chassis_col = [0.3, 0.3, 1];

rackguideslot_w = rackguide_w + 1;
rackguideslot_d = rackguide_d + 1;

jackbox_h = jack_h + 10;
jackbox_tol = 0.9; // 0.8
jackbox_thick = 4;

wheels_gap = 40 + 2 * (3 + 15 + 12); // :)

axlebox_to_wheel = 3;

axle_r = 4;
axle_tol = 0.5;  // for axle <-> axle holder
axle_sticktol = 0.2;  // for axle <-> axle joiner

axlebox_w = 18;
axlebox_thick = 3.5;
axlebox_r = axle_r + axle_tol + axlebox_thick;
axlebox_offsetmex = axle_r;
axlebox_centerz = chassis_thick * 2;

chassis_gap = wheels_gap - 2 * (axlebox_to_wheel + axlebox_w + wheel_thick);

axles_halfgap = 0.5;

axle_endr = 2;
axle_endlen = 4;
axle_len = chassis_gap / 2 + axlebox_w + axlebox_to_wheel - axles_halfgap;

axlenub_len = 5;
axlenub_d = 0.55;

axlebox_to_wheelstub = 1.5;
wheelstub_r = axle_r + axle_tol * 3;

// gearside
chassis_gs_l = 40;
chassis_gs_w = axlebox_w;

// freeside
chassis_fs_l = 35;
chassis_fs_w = axlebox_w;

// axlejoin

axlejoin_col = [1, 0.6, 0.2];
axlejoin_thick = 2.5;
axlejoin_w = (axlenub_len + axle_endlen + axles_halfgap * 1.5) * 2;
axlejoin_r = axle_r + axle_sticktol + axlejoin_thick;

axlejoin_gear_n = 15;
axlejoin_gear_ra = axlejoin_r + 0.5;
axlejoin_gear_rb = axlejoin_gear_ra + my_fav_gear_out;
axlejoin_gear_w = axlejoin_w * 1;  // was <1 but who knows why

axlejoin_gear_flatbuf = axlejoin_w * 0.1;
axlejoin_gear_transbuf = axlejoin_w * 0.1;

axle_thinr = axle_r * 0.75;
axle_thinlen = axlejoin_w / 2 - axles_halfgap;

function xy(r, t) = [r * cos(t), r * sin(t)];

module star(n, rb, ra) {
    circle(ra, $fn=n)
        ;
    dt = 360 / n;
    for (p = [1:n], t = dt * p) {
        polygon([xy(ra, t), xy(rb, t + dt / 2), xy(ra, t + dt)])
            ;
    }
        ;
}

module jack_nocol() {
    // box
    translate([0, -jack_w / 2, 0])
    union() {
        cube([jack_l, jack_w, jack_basethick])
            ;
        linear_extrude(jack_h)
        difference() {
            square([jack_l, jack_w])
                ;
            translate([jack_sidethick, jack_sidethick])
            square([
                jack_l - jack_sidethick * 2,
                jack_w - jack_sidethick * 2
            ])
                ;
            translate([(jack_l - jack_sidegap) / 2, 0])
            square([jack_sidegap, jack_w])
                ;
        }
    }
        ;
    // rack
    rotate([0, 0, 180])
    translate([0, rack_w / 2, 0])
    rotate([90, 0, 0])
    linear_extrude(rack_w)
    union() {
        square([rack_d, jack_h])
            ;
        for (i = [0:racktooth_count]) {
            translate([rack_d, i * racktooth_h])
            polygon([
                [0, 0],
                [racktooth_out, racktooth_h/2],
                [0, racktooth_h]
            ])
                ;
        }
    }
        ;
    // guideline
    translate([jack_l, 0, 0])
    linear_extrude(jack_h)
    intersection() {
        union() {
            translate([0, -rackguide_w/2])
            square([rackguide_d - rackguide_w/2, rackguide_w])
                ;
            translate([rackguide_d - rackguide_w/2, 0])
            circle(rackguide_w / 2)
                ;
        }
            ;
        translate([0, -rackguide_w * 10])
        square([50, rackguide_w * 20])
            ;
    }
        ;
}

module axlebox() {
    translate([0, 0, axlebox_centerz])
    //union(){
    difference() {
        translate([0, -axlebox_w/2, 0])
        rotate([-90, 0, 0])
        linear_extrude(axlebox_w)
        difference() {
            union() {
                circle(axlebox_r)
                    ;
                translate([-axlebox_r, 0, 0])
                square([axlebox_r * 2, axlebox_centerz])
                    ;
            }
                ;
            union() {
                circle(axle_r + axle_tol)
                    ;
                // being bold with small teardrops; GL printer!
                translate([0, -(axle_r + axle_tol) / sqrt(2) * 0.86])
                rotate(45)
                square(axle_r + axle_tol, center=true)
                    ;
            }
        }
            ;
    }
}

module chassis_nocol() {
    // the chassis, but quite blueprint style!!
    linear_extrude(chassis_thick)
    union() {
        translate([0, -jack_w/2])
        union() {
            // FUNCTIONAL: base
            square([jack_l, jack_w])
                ;
            // blueprint-y: post corners
            for (i = [0, 1], j = [0, 1]) {
                translate([jack_l * i, jack_w * j])
                square((jackbox_thick + jackbox_tol) * 2, center=true)
                    ;
            }
                ;
        }
            ;
        // functional+blueprint-y: rackguide
        translate([jack_l, -rackguide_w / 2])
        square([rackguide_d * 1.5, rackguide_w])
            ;
        // FUNCTIONAL: freeside wheel connectors
        translate([jack_l, 0])
        union() {
            for (i = [0, 1]) {
                translate([
                    0,
                    (
                        -chassis_fs_w / 2
                        + (i - 0.5) * (chassis_gap + chassis_fs_w)
                    )
                ])
                square([chassis_fs_l, chassis_fs_w])
                    ;
            }
                ;
        }
            ;
        // FUNCTIONAL: gearside wheel connectors
        rotate(180)
        union() {
            for (i = [0, 1]) {
                translate([
                    0,
                    (
                        -chassis_gs_w / 2
                        + (i - 0.5) * (chassis_gap + chassis_gs_w)
                    )
                ])
                square([chassis_gs_l, chassis_gs_w])
                    ;
            }
                ;
        }
            ;
    }
        ;
    // rack guide slot
    linear_extrude(jackbox_h)
    translate([jack_l, -rackguideslot_w / 2])
    difference() {
        translate([0, - g_thick])
        square([rackguideslot_d + g_thick, rackguideslot_w + 2 * g_thick])
            ;
        square([rackguideslot_d, rackguideslot_w])
            ;
    }
        ;
    // box supports
    linear_extrude(jackbox_h)
    translate([0, -jack_w / 2])
    for (i = [0, 1], j = [0, 1]) {
        translate([jack_l * i, jack_w * j])
        rotate(90 * i - 90 * j + 180 * i * j)
        difference() {
            square((jackbox_thick + jackbox_tol) * 2, center=true)
                ;
            translate([jackbox_thick, jackbox_thick])
            square((jackbox_thick + jackbox_tol) * 2, center=true)
                ;
        }
    }
        ;
    // axleboxes
    for (
        i = [0, 1],
        j = [0, 1]
    ) {
        translate([
            [
                - chassis_gs_l - axlebox_offsetmex,
                jack_l + chassis_fs_l + axlebox_offsetmex
            ][j],
            (
                chassis_gap + [chassis_gs_w, chassis_fs_w][j]
            ) * (i - 0.5),
            0
        ])
        axlebox()
            ;
    }
}

module wheel_nocol() {
    linear_extrude(wheel_thick)
    difference() {
        circle(wheel_r, $fn=wheel_fn)
            ;
        union() {
            for (i = [0:treads_n]) {
                rotate(i * 360 / treads_n)
                translate([wheel_r - treads_d, 0])
                square([treads_d + 0.1, treads_w])
                    ;
            }
                ;
            for (j = [0:wheelcutouts_n]) {
                rotate(j * 360 / wheelcutouts_n)
                translate([wheelcutouts_pos, 0])
                circle(wheelcutouts_r)
                    ;
            }
        }
    }
        ;
    // shaft
    translate([0, 0, wheel_thick])
    linear_extrude(axle_len - axle_thinlen)
    circle(axle_r)
        ;
    translate([0, 0, wheel_thick])
    linear_extrude(axlebox_to_wheel - axlebox_to_wheelstub)
    circle(wheelstub_r)
        ;
    translate([0, 0, wheel_thick + axle_len - axle_thinlen])
    linear_extrude(axle_thinlen - axle_endlen)
    circle(axle_thinr)
        ;
    translate([0, 0, wheel_thick + axle_len - axle_endlen])
    hull() {
        sphere(axle_thinr)
            ;
        translate([0, 0, axle_endlen - axle_endr])
        sphere(axle_endr)
            ;
    }
        ;
    translate([
        0,
        axle_thinr,
        wheel_thick + axle_len - axle_endlen * 0.75 - axlenub_len
    ])
    hull() {
        translate([0, 0, axlenub_len - axlenub_d])
        sphere(axlenub_d)
            ;
        sphere(axlenub_d)
            ;
    }
        ;
}

module axlejoin_nocol(geared=true) {
    translate([0, 0, -axlejoin_w/2])
    linear_extrude(axlejoin_w)
    difference() {
        circle(axlejoin_r)
            ;
        union() {
            circle(axle_thinr + axle_sticktol)
                ;
            translate([axle_thinr + axle_sticktol, 0])
            square([axlenub_d * 4, axlenub_d * 3], center=true)
                ;
        }
    }
        ;
    if (geared) {
        translate([0, 0, -axlejoin_w/2])
        union() {
            linear_extrude(axlejoin_gear_w)
            difference() {
                star(axlejoin_gear_n, axlejoin_gear_rb, axlejoin_gear_ra)
                    ;
                // so can cut out nobble path
                circle(axlejoin_r + 0.01)
                    ;
            }
                ;
            // separate difference for better preview
            difference() {
                union() {
                    cylinder(r=axlejoin_gear_rb, h=axlejoin_gear_transbuf)
                        ;
                    translate([0, 0, axlejoin_gear_w - axlejoin_gear_transbuf])
                    cylinder(r=axlejoin_gear_rb, h=axlejoin_gear_transbuf)
                        ;
                    translate([
                        0, 0,
                        axlejoin_gear_w - axlejoin_gear_transbuf * 3
                    ])
                    cylinder(
                        r1=axlejoin_gear_ra,
                        r2=axlejoin_gear_rb,
                        h=axlejoin_gear_transbuf * 2
                    )
                        ;
                }
                    ;
                translate([0, 0, -0.01])
                cylinder(r=axlejoin_r + 0.01, h=axlejoin_gear_w + 0.02)
                    ;
            }
                ;
        }
    }
        ;
}

module chassis() {
    color(chassis_col, 0.7)
    chassis_nocol()
        ;
}

module jack() {
    color(jack_col, 0.7)
    jack_nocol()
        ;
}

module wheel() {
    color(wheel_col, 0.7)
    wheel_nocol()
        ;
}

module axlejoin(geared=true) {
    color(axlejoin_col, 0.7)
    axlejoin_nocol(geared)
        ;
}


module assembled_car(preview_jack_pos=jack_h/2) {
    translate([0, 0, chassis_thick + preview_jack_pos])
    jack()
        ;
    chassis()
        ;
    for(xoffs = [
        - chassis_gs_l - axlebox_offsetmex,
        jack_l + chassis_fs_l + axlebox_offsetmex
    ]) {
        translate([xoffs, 0, axlebox_centerz])
        union() {
            for (dir = [-1, 1]) {
                translate([
                    0,
                    (axle_len + axles_halfgap + wheel_thick) * dir,
                    0
                ])
                rotate([90 * dir, -90 + 90 * dir, 0])
                //translate([0, 0, -5])  // to explode
                wheel()
                    ;
            }
                ;
            rotate([90, -90, 0])
            axlejoin(xoffs < 0) // :)
                ;
        }
            ;
    }
        ;
}


if (RENDERING == JACK) {
    jack_nocol()
        ;
}
if (RENDERING == CHASSIS) {
    chassis_nocol()
        ;
}
if (RENDERING == WHEEL) {
    wheel_nocol()
        ;
}
if (RENDERING == AXLEJOIN_GEARED) {
    axlejoin_nocol(true)
        ;
}
if (RENDERING == AXLEJOIN_SMOOTH) {
    axlejoin_nocol(false)
        ;
}
if (RENDERING == ASSEMBLED) {
    assembled_car()
        ;
}
if (RENDERING == ASSEMBLED_MULTIPOS) {
    for (i = [0:2]) {
        translate([220 * i, 0, 0])
        assembled_car(jack_h * i / 2)
            ;
    }
}
