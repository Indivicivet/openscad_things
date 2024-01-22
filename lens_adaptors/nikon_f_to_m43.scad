LM_OFFCENTER = 54;  // centering looks very close

M43_FLANGE = 19.25;
NIKON_F_FLANGE = 46.5;
FLANGE_DELTA = NIKON_F_FLANGE - M43_FLANGE;

BARREL_HEIGHT = FLANGE_DELTA; // todo :: probs won't quite be this...

NIKON_F_INNER_R = 24;
CYLINDER_WALL_THICK = 2.5;

ROT_GRIPPER_INSET = 1;


$fn = 60;


module centered_lens_mount() {
    translate([-0.5, 0.5, 0] * LM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 lens mount.STL")
        ;
}


module rot_stopper() {
    for (i=[0:100])
    rotate([0, 0, -i * 0.5])
    translate([NIKON_F_INNER_R - ROT_GRIPPER_INSET, 0, 0])
    translate([0, -0.5, 0])
    cube([
        ROT_GRIPPER_INSET + 0.1,
        1,
        0.4 * (i < 90 ? 1 : 1 - ((i-90)/10)) + 0.8 + exp(-i / 20)
    ])
        ;
}


module nikon_f_cylinder() {
    linear_extrude(BARREL_HEIGHT + 0.2)
    difference() {
        circle(r=NIKON_F_INNER_R + CYLINDER_WALL_THICK)
            ;
        circle(r=NIKON_F_INNER_R)
            ;
    }
        ;
}


color("red")
for (theta=[9.5, 116, 235])
rotate([0, 0, theta])
rot_stopper()
    ;

nikon_f_cylinder()
    ;

translate([0, 0, BARREL_HEIGHT])
centered_lens_mount()
    ;

// ruler
translate([28, 0, 0])
cube([1, 1, FLANGE_DELTA])
    ;
