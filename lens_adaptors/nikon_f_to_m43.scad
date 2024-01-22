LM_OFFCENTER = 54;  // centering looks very close

M43_FLANGE = 19.25;
NIKON_F_FLANGE = 46.5;
FLANGE_DELTA = NIKON_F_FLANGE - M43_FLANGE;

BARREL_HEIGHT = FLANGE_DELTA; // todo :: probs won't quite be this...

NIKON_F_INNER_R = 23.2 + 0.1;
CYLINDER_WALL_THICK = 3;

ROT_GRIPPER_INSET = 23.2 - 22.0; // from F mount diagram
ROT_GRIPPER_THICK = 3;  // gap is 3.1 mm

$fn = 60;


module centered_lens_mount() {
    translate([-0.5, 0.5, 0] * LM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 lens mount.STL")
        ;
}

OH_INNERMOST = 17.8;
OH_UPPERMOST = 1.3;
// OH_LOWERMOST = -3;
OH_OUTERMOST = NIKON_F_INNER_R + 0.1;
OH_LOWERMOST = (
    (OH_INNERMOST - OH_OUTERMOST) * (BARREL_HEIGHT >= 5 ? 1.5 : 0.75)
    + OH_UPPERMOST
);

module overhang_print_helper(opposite_tri=false) {
    rotate_extrude()
    polygon([
        [OH_OUTERMOST, OH_LOWERMOST],
        (opposite_tri ? [OH_INNERMOST, OH_LOWERMOST] : [OH_OUTERMOST, OH_UPPERMOST]),
        [OH_INNERMOST, OH_UPPERMOST]
    ])
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
        ROT_GRIPPER_THICK + exp(-i / 20) + (i < 90 ? 0 : - 0.4 * ((i-90)/10))
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
union() {
    difference() {
        centered_lens_mount()
            ;
        overhang_print_helper(opposite_tri=true)
            ;
    }
        ;
    color("red", alpha=0.7)
    overhang_print_helper()
        ;
}
    ;

// ruler
translate([28, 0, 0])
cube([1, 1, FLANGE_DELTA])
    ;
