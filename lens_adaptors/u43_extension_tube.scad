CM_OFFCENTER = 53;  // centering looks exact?
LM_OFFCENTER = 54;  // centering looks very clclose

SLICE_THICK = 0.05;
SLICE_FROM_H = 2;
TUBE_EXT_NOT_INCLUDING_MOUNTS = 2;  // about 2 looks minimal


module centered_camera_mount() {
    translate([-0.5, 0.5, 0] * CM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 camera mount.STL")
        ;
}


module camera_mount_top_slice(thick=1) {
    scale([1, 1, thick / SLICE_THICK])
    intersection() {
        translate([0, 0, -SLICE_FROM_H])
        centered_camera_mount()
            ;
        cylinder(r=999, h=SLICE_THICK)
            ;
    }
        ;
}


module centered_lens_mount() {
    translate([-0.5, 0.5, 0] * LM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 lens mount.STL")
        ;
}


OH_INNERMOST = 17.8;
OH_UPPERMOST = 1.7;
// OH_LOWERMOST = -3;
OH_OUTERMOST = 21;
OH_LOWERMOST = (
    (OH_INNERMOST - OH_OUTERMOST) * (TUBE_EXT_NOT_INCLUDING_MOUNTS >= 5 ? 1.5 : 0.75)
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
    translate([20, 0, 0])
    translate([-0.5, -0.5, 0])
    cube([1, 1, 0.4 * (i < 90 ? 1 : 1 - ((i-90)/10)) + 0.8 + exp(-i / 20)])
        ;
}


// stick the lens in here
centered_camera_mount()
    ;

color("red")
for (theta=[9.5, 116, 235])
rotate([0, 0, theta])
rot_stopper()
    ;

color("blue")
translate([0, 0, SLICE_FROM_H])
camera_mount_top_slice(thick=TUBE_EXT_NOT_INCLUDING_MOUNTS - SLICE_FROM_H)
    ;

translate([0, 0, TUBE_EXT_NOT_INCLUDING_MOUNTS])
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
